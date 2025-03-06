<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Set headers and error reporting before any output
header('Content-Type: application/json');
error_reporting(0);
ini_set('display_errors', 0);

require_once 'scripts/check_admin.php';

try {
    checkAdminAccess();

    // Database connection
    $db = new mysqli('localhost', 'root', '', 'lendingdb');
    if ($db->connect_error) {
        throw new Exception('Database connection failed');
    }

    $db->begin_transaction();

    try {
        // Validate input
        $fullname = trim($_POST['fullname'] ?? '');
        $email = trim($_POST['email'] ?? '');
        $password = trim($_POST['password'] ?? '');
        $role = trim($_POST['role'] ?? 'user');

        if (empty($fullname) || empty($email) || empty($password)) {
            throw new Exception('All fields are required');
        }

        // Check email exists
        $stmt = $db->prepare("SELECT COUNT(*) as count FROM users WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $stmt->close();

        if ($row['count'] > 0) {
            throw new Exception('Email already exists');
        }

        // Hash password
        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

        // Handle profile picture
        $profilePicturePath = 'uploads/defaultprof.jpg';
        if (!empty($_FILES['profile_picture']['name'])) {
            $safeFullname = preg_replace('/[^a-zA-Z0-9]/', '_', strtolower($fullname));
            $userDir = "uploads/users/{$safeFullname}/profile/";
            
            if (!is_dir($userDir)) {
                mkdir($userDir, 0777, true);
            }

            $targetFilePath = $userDir . "profile.jpg";
            $fileType = strtolower(pathinfo($_FILES['profile_picture']['name'], PATHINFO_EXTENSION));
            
            if (!in_array($fileType, ['jpg', 'jpeg', 'png'])) {
                throw new Exception('Invalid image format (JPG, JPEG, PNG allowed)');
            }

            if (move_uploaded_file($_FILES['profile_picture']['tmp_name'], $targetFilePath)) {
                $profilePicturePath = $targetFilePath;
            }
        }

        // Insert user
        $stmt = $db->prepare("INSERT INTO users (fullname, email, password, profile_picture, role) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("sssss", $fullname, $email, $hashedPassword, $profilePicturePath, $role);
        
        if (!$stmt->execute()) {
            throw new Exception('Failed to add user');
        }

        $db->commit();

        echo json_encode([
            'status' => 'success',
            'message' => 'User added successfully'
        ]);

    } catch (Exception $e) {
        $db->rollback();
        throw $e;
    }

} catch (Exception $e) {
    http_response_code(400);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
} finally {
    if (isset($stmt)) $stmt->close();
    if (isset($db)) $db->close();
}
?>
