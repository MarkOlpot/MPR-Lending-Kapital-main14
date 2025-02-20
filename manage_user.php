<?php
session_start();
$db = new mysqli('localhost', 'root', '', 'lendingdb');

if ($db->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $db->connect_error]));
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $action = $_POST["action"];

    if ($action === "delete") {
        // Delete User
        $user_id = intval($_POST["user_id"]); // Sanitize input
        $stmt = $db->prepare("DELETE FROM users WHERE id = ?");
        $stmt->bind_param("i", $user_id);

        if ($stmt->execute()) {
            echo json_encode(["status" => "success", "message" => "User deleted successfully"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Error deleting user"]);
        }

        $stmt->close();
    } elseif ($action === "edit") {
        // Edit User
        $user_id = intval($_POST["user_id"]);
        $fullname = trim($_POST["fullname"]);
        $email = trim($_POST["email"]);

        // Check if email already exists for another user
        $stmt = $db->prepare("SELECT id FROM users WHERE email = ? AND id != ?");
        $stmt->bind_param("si", $email, $user_id);
        $stmt->execute();
        $stmt->store_result();

        if ($stmt->num_rows > 0) {
            echo json_encode(["status" => "error", "message" => "Email already exists!"]);
        } else {
            $stmt->close();

            // Proceed with update
            $stmt = $db->prepare("UPDATE users SET fullname = ?, email = ? WHERE id = ?");
            $stmt->bind_param("ssi", $fullname, $email, $user_id);

            if ($stmt->execute()) {
                echo json_encode(["status" => "success", "message" => "User updated successfully"]);
            } else {
                echo json_encode(["status" => "error", "message" => "Error updating user"]);
            }
        }

        $stmt->close();
    }
}

$db->close();
?>
