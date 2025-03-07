<?php
session_start();
header('Content-Type: application/json');

$db = new mysqli('localhost', 'root', '', 'lendingdb');

if ($db->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $db->connect_error]));
}

function addAuditLog($db, $action) {
    $performed_by = $_SESSION['fullname'] ?? 'Unknown User';
    $category = "User Management"; // Set fixed category for user management actions
    
    $sql = "INSERT INTO audit_logs (date, time, performed_by, action, category) 
            VALUES (CURRENT_DATE(), CURRENT_TIME(), ?, ?, ?)";
    $stmt = $db->prepare($sql);
    $stmt->bind_param("sss", $performed_by, $action, $category);
    $stmt->execute();
    $stmt->close();
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    try {
        $db->begin_transaction();
        
        $action = $_POST["action"] ?? '';

        if ($action === "delete") {
            // Delete User
            if (!isset($_POST["user_id"])) {
                throw new Exception("User ID is required");
            }

            $user_id = intval($_POST["user_id"]);
            
            // Get user details before deletion for audit log
            $get_user = $db->prepare("SELECT fullname, profile_picture FROM users WHERE id = ?");
            if (!$get_user) {
                throw new Exception("Database prepare error");
            }

            $get_user->bind_param("i", $user_id);
            $get_user->execute();
            $result = $get_user->get_result();
            $user = $result->fetch_assoc();
            $get_user->close();

            if (!$user) {
                throw new Exception("User not found");
            }

            // Delete the user's profile picture if it exists
            if (!empty($user['profile_picture']) && $user['profile_picture'] !== 'uploads/defaultprof.jpg') {
                if (file_exists($user['profile_picture'])) {
                    unlink($user['profile_picture']);
                }
            }

            // Delete the user
            $stmt = $db->prepare("DELETE FROM users WHERE id = ?");
            if (!$stmt) {
                throw new Exception("Database prepare error");
            }

            $stmt->bind_param("i", $user_id);

            if (!$stmt->execute()) {
                throw new Exception("Error deleting user");
            }

            // Add audit log
            $action_desc = "Deleted user: " . $user['fullname'];
            addAuditLog($db, $action_desc);
            
            $db->commit();
            
            echo json_encode([
                "status" => "success", 
                "message" => "User deleted successfully"
            ]);
            
            $stmt->close();
        } elseif ($action === "edit") {
            // Edit User
            if (!isset($_POST["user_id"], $_POST["fullname"], $_POST["email"])) {
                throw new Exception("Missing required fields");
            }

            $user_id = intval($_POST["user_id"]);
            $fullname = trim($_POST["fullname"]);
            $email = trim($_POST["email"]);

            // Validate inputs
            if (empty($fullname) || empty($email)) {
                throw new Exception("All fields are required");
            }

            if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                throw new Exception("Invalid email format");
            }

            // Get old user details for audit log
            $get_old = $db->prepare("SELECT fullname, email FROM users WHERE id = ?");
            $get_old->bind_param("i", $user_id);
            $get_old->execute();
            $old_user = $get_old->get_result()->fetch_assoc();
            $get_old->close();

            if (!$old_user) {
                throw new Exception("User not found");
            }

            // Check if email exists for another user
            $check_email = $db->prepare("SELECT id FROM users WHERE email = ? AND id != ?");
            $check_email->bind_param("si", $email, $user_id);
            $check_email->execute();
            $check_email->store_result();

            if ($check_email->num_rows > 0) {
                $check_email->close();
                throw new Exception("Email already exists");
            }
            $check_email->close();

            // Update user
            $update = $db->prepare("UPDATE users SET fullname = ?, email = ? WHERE id = ?");
            $update->bind_param("ssi", $fullname, $email, $user_id);

            if (!$update->execute()) {
                throw new Exception("Failed to update user");
            }

            // Add audit log for changes
            $changes = [];
            if ($old_user['fullname'] !== $fullname) {
                $changes[] = "name from '{$old_user['fullname']}' to '{$fullname}'";
            }
            if ($old_user['email'] !== $email) {
                $changes[] = "email from '{$old_user['email']}' to '{$email}'";
            }

            if (!empty($changes)) {
                $action_desc = "Updated user: " . implode(" and ", $changes);
                addAuditLog($db, $action_desc);
            }

            $db->commit();
            
            echo json_encode([
                "status" => "success",
                "message" => "User updated successfully"
            ]);

            $update->close();
        }
    } catch (Exception $e) {
        $db->rollback();
        echo json_encode([
            "status" => "error",
            "message" => $e->getMessage()
        ]);
    } finally {
        $db->close();
    }
}
?>
