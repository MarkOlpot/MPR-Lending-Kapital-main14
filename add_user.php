<?php
// Start session
session_start();

// Database connection
$db = new mysqli('localhost', 'root', '', 'lendingdb');

// Check connection
if ($db->connect_error) {
    die(json_encode(['status' => 'error', 'message' => 'Database connection failed.']));
}

// Validate input data
$fullname = trim($_POST['fullname']);
$email = trim($_POST['email']);
$password = trim($_POST['password']);

// Check for empty fields
if (empty($fullname) || empty($email) || empty($password)) {
    echo json_encode(['status' => 'error', 'message' => 'All fields are required.']);
    exit();
}

// Check if email already exists
$checkEmail = $db->prepare("SELECT id FROM users WHERE email = ?");
$checkEmail->bind_param("s", $email);
$checkEmail->execute();
$checkEmail->store_result();
$emailExists = $checkEmail->num_rows > 0;
$checkEmail->close();

if ($emailExists) {
    echo json_encode(['status' => 'error', 'message' => 'Email already exists.']);
    exit();
}

// Hash the password
$hashedPassword = password_hash($password, PASSWORD_BCRYPT);

// Set default profile picture path
$profilePicturePath = 'uploads/defaultprof.jpg';

// Handle profile picture upload
if (!empty($_FILES['profile_picture']['name'])) {
    $safeFullname = preg_replace('/[^a-zA-Z0-9]/', '_', strtolower($fullname)); // Sanitize folder name
    $userDir = "uploads/users/{$safeFullname}/profile/";

    // Create user/profile directory if it doesn't exist
    if (!is_dir($userDir) && !mkdir($userDir, 0777, true) && !is_dir($userDir)) {
        echo json_encode(['status' => 'error', 'message' => 'Failed to create user directory.']);
        exit();
    }

    // Define file path (always named profile.jpg)
    $targetFilePath = $userDir . "profile.jpg";

    // Validate file type
    $fileType = strtolower(pathinfo($_FILES["profile_picture"]["name"], PATHINFO_EXTENSION));
    $allowedTypes = ['jpg', 'jpeg', 'png'];

    if (!in_array($fileType, $allowedTypes)) {
        echo json_encode(['status' => 'error', 'message' => 'Invalid image format (JPG, JPEG, PNG allowed).']);
        exit();
    }

    // Move file and overwrite if exists
    if (move_uploaded_file($_FILES["profile_picture"]["tmp_name"], $targetFilePath)) {
        $profilePicturePath = $targetFilePath;
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to upload image.']);
        exit();
    }
}

// Insert user into database
$insertUser = $db->prepare("INSERT INTO users (fullname, email, password, profile_picture) VALUES (?, ?, ?, ?)");
$insertUser->bind_param("ssss", $fullname, $email, $hashedPassword, $profilePicturePath);

if ($insertUser->execute()) {
    echo json_encode(['status' => 'success', 'message' => 'User added successfully!']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Error adding user.']);
}

// Close connection
$insertUser->close();
$db->close();
?>
