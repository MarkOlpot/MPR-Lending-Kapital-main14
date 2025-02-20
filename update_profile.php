<?php
session_start();

// Database connection
$db = new mysqli('localhost', 'root', '', 'lendingdb');

// Check connection
if ($db->connect_error) {
    die("Connection failed: " . $db->connect_error);
}

// Ensure user is logged in
if (!isset($_SESSION['user_id']) || !isset($_SESSION['fullname'])) {
    $_SESSION['message'] = "Unauthorized access!";
    header("Location: login.php");
    exit;
}

$user_id = $_SESSION['user_id'];
$currentFullname = $_SESSION['fullname'];

// Fetch existing profile picture and email
$query = $db->prepare("SELECT profile_picture, email FROM users WHERE id = ?");
$query->bind_param("i", $user_id);
$query->execute();
$result = $query->get_result();
$userData = $result->fetch_assoc();
$query->close();

$existingProfilePicture = $userData['profile_picture'] ?? "";
$currentEmail = $userData['email'];

// Initialize SweetAlert message
$sweetAlert = "";

if (isset($_POST['update_details'])) {
    $newFullname = htmlspecialchars(trim($_POST['fullname']));
    $newEmail = filter_var(trim($_POST['email']), FILTER_SANITIZE_EMAIL);
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];

    // Check if the email already exists for another user
    $emailCheckQuery = $db->prepare("SELECT id FROM users WHERE email = ? AND id != ?");
    $emailCheckQuery->bind_param("si", $newEmail, $user_id);
    $emailCheckQuery->execute();
    $emailCheckResult = $emailCheckQuery->get_result();
    
    if ($emailCheckResult->num_rows > 0) {
        $sweetAlert = "Swal.fire({
            icon: 'error',
            title: 'Email Already Exists!',
            text: 'Please use a different email.',
            confirmButtonText: 'OK'
        }).then(() => { window.location.href = 'profile.php'; });";
    } else {
        $emailCheckQuery->close();

        // Handle folder renaming if the fullname has changed
        if ($newFullname !== $currentFullname) {
            $oldFolderName = preg_replace("/[^a-zA-Z0-9]/", "_", strtolower($currentFullname));
            $newFolderName = preg_replace("/[^a-zA-Z0-9]/", "_", strtolower($newFullname));
            
            $oldFolderPath = "uploads/users/{$oldFolderName}/";
            $newFolderPath = "uploads/users/{$newFolderName}/";

            if (file_exists($oldFolderPath)) {
                rename($oldFolderPath, $newFolderPath);
            }

            if (!empty($existingProfilePicture)) {
                $existingProfilePicture = str_replace($oldFolderName, $newFolderName, $existingProfilePicture);
            }
        }

        // Update profile with or without password
        if (!empty($password)) {
            if ($password === $confirm_password) {
                $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
                $sql = "UPDATE users SET fullname = ?, email = ?, password = ?, profile_picture = ? WHERE id = ?";
                $stmt = $db->prepare($sql);
                $stmt->bind_param("ssssi", $newFullname, $newEmail, $hashedPassword, $existingProfilePicture, $user_id);
            } else {
                $sweetAlert = "Swal.fire({
                    icon: 'error',
                    title: 'Error!',
                    text: 'Passwords do not match.',
                    confirmButtonText: 'OK'
                }).then(() => { window.location.href = 'profile.php'; });";
            }
        } else {
            $sql = "UPDATE users SET fullname = ?, email = ?, profile_picture = ? WHERE id = ?";
            $stmt = $db->prepare($sql);
            $stmt->bind_param("sssi", $newFullname, $newEmail, $existingProfilePicture, $user_id);
        }

        if ($stmt->execute()) {
            $_SESSION['fullname'] = $newFullname; // Update session name
            $sweetAlert = "Swal.fire({
                icon: 'success',
                title: 'Success!',
                text: 'Profile updated successfully!',
                confirmButtonText: 'OK'
            }).then(() => { window.location.href = 'profile.php'; });";
        } else {
            $sweetAlert = "Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: 'Error updating profile: " . $stmt->error . "',
                confirmButtonText: 'OK'
            }).then(() => { window.location.href = 'profile.php'; });";
        }
        $stmt->close();
    }
}

// Handle Profile Picture Upload
if (isset($_FILES['profile_picture']) && $_FILES['profile_picture']['error'] === UPLOAD_ERR_OK) {
    $safeName = preg_replace("/[^a-zA-Z0-9]/", "_", strtolower($_SESSION['fullname']));
    $targetDir = "uploads/users/{$safeName}/profile/";

    if (!file_exists($targetDir)) {
        mkdir($targetDir, 0777, true);
    }

    $fileName = basename($_FILES["profile_picture"]["name"]);
    $targetFilePath = $targetDir . $fileName;
    $fileType = mime_content_type($_FILES['profile_picture']['tmp_name']);
    $allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];

    if (in_array($fileType, $allowedTypes)) {
        if (move_uploaded_file($_FILES["profile_picture"]["tmp_name"], $targetFilePath)) {
            $sql = "UPDATE users SET profile_picture = ? WHERE id = ?";
            $stmt = $db->prepare($sql);
            $stmt->bind_param("si", $targetFilePath, $user_id);
            if ($stmt->execute()) {
                $sweetAlert = "Swal.fire({
                    icon: 'success',
                    title: 'Success!',
                    text: 'Profile picture updated successfully!',
                    confirmButtonText: 'OK'
                }).then(() => { window.location.href = 'profile.php'; });";
            } else {
                $sweetAlert = "Swal.fire({
                    icon: 'error',
                    title: 'Error!',
                    text: 'Error updating profile picture.',
                    confirmButtonText: 'OK'
                }).then(() => { window.location.href = 'profile.php'; });";
            }
            $stmt->close();
        } else {
            $sweetAlert = "Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: 'Error uploading image.',
                confirmButtonText: 'OK'
            }).then(() => { window.location.href = 'profile.php'; });";
        }
    } else {
        $sweetAlert = "Swal.fire({
            icon: 'error',
            title: 'Invalid File Type!',
            text: 'Only JPG, PNG, and GIF are allowed.',
            confirmButtonText: 'OK'
        }).then(() => { window.location.href = 'profile.php'; });";
    }
}

$db->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Update</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <script>
        <?php echo $sweetAlert; ?>
    </script>
</body>
</html>
