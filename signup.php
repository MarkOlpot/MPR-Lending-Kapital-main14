<?php
session_start();

if (isset($_POST['signup'])) {
    $fname = trim($_POST['fullname']);
    $email = trim($_POST['email']);
    $password = $_POST['password'];
    $confpass = $_POST['confirm_password'];

    // Database connection
    $db = new mysqli('localhost', 'root', '', 'lendingdb');

    // Check connection
    if ($db->connect_error) {
        die("Connection failed: " . $db->connect_error);
    }

    // Validate inputs
    if ($password !== $confpass) {
        showAlert("Error", "Passwords do not match.", "error");
    } elseif (strlen($password) < 6) {
        showAlert("Error", "Password must be at least 6 characters long.", "error");
    } elseif (empty($fname)) {
        showAlert("Error", "Fullname cannot be blank.", "error");
    } elseif (emailExists($db, $email)) {
        showAlert("Error", "Email is already in use. Please use a different email.", "error");
    } else {
        // Hash the password
        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

        // Handle profile picture upload
        $profilePicture = null;
        if (isset($_FILES['profile_picture']) && $_FILES['profile_picture']['error'] == 0) {
            // Format user folder name (remove special characters and spaces)
            $safeName = preg_replace("/[^a-zA-Z0-9]/", "_", strtolower($fname));
            $targetDir = "uploads/users/{$safeName}/profile/"; // User-specific folder
            
            // Ensure directory exists
            if (!file_exists($targetDir)) {
                mkdir($targetDir, 0777, true);
            }

            // Get file extension
            $imageFileType = strtolower(pathinfo($_FILES["profile_picture"]["name"], PATHINFO_EXTENSION));
            $targetFile = $targetDir . "profile." . $imageFileType; // Rename to `profile.jpg/png`

            // Validate file type (Only allow images)
            $validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
            if (!in_array($imageFileType, $validExtensions)) {
                showAlert("Error", "Only JPG, JPEG, PNG & GIF files are allowed.", "error");
            }

            // Move the uploaded file
            if (move_uploaded_file($_FILES["profile_picture"]["tmp_name"], $targetFile)) {
                $profilePicture = $targetFile;
            } else {
                showAlert("Error", "Sorry, there was an error uploading your file.", "error");
            }
        }

        // Insert user into the database
        $sql = "INSERT INTO users (fullname, email, password, profile_picture) VALUES (?, ?, ?, ?)";
        $stmt = $db->prepare($sql);
        $stmt->bind_param("ssss", $fname, $email, $hashedPassword, $profilePicture);

        if ($stmt->execute()) {
            showAlert("Success", "Sign-up successful! Redirecting to login page.", "success", "index.php");
        } else {
            showAlert("Error", "Error: Unable to sign up. Please try again.", "error");
        }

        $stmt->close();
    }

    $db->close();
}

// Function to check if email already exists in the database
function emailExists($db, $email) {
    $sql = "SELECT * FROM users WHERE email = ?";
    $stmt = $db->prepare($sql);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    $exists = $result->num_rows > 0;
    $stmt->close();
    return $exists;
}

// Function to show SweetAlert messages
function showAlert($title, $message, $icon, $redirect = null) {
    echo "<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>";
    echo "<script>
            document.addEventListener('DOMContentLoaded', function() {
                swal({
                    title: '{$title}',
                    text: '{$message}',
                    icon: '{$icon}',
                    button: 'OK',
                }).then(function() {
                    window.location.href = '{$redirect}';
                });
            });
          </script>";
    exit();
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- CSS -->
    <link rel="stylesheet" href="styles/signup.css">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Source+Serif+4:ital,opsz,wght@0,8..60,200..900;1,8..60,200..900&display=swap" rel="stylesheet">
    <!-- SweetAlert Library -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title>Sign-Up</title>
</head>
<body>

    <div class="signup-container">
        <div class="signup-logo-container">
            <img src="images/logo2.png" alt="">
        </div>
        <div class="signup-form-container">
            <h1 class="signup-header">Sign-up</h1>
            <form action="" method="post" class="signup-form" enctype="multipart/form-data">
    <label for="fullname">Full Name</label>
    <input type="text" id="fullname" name="fullname" placeholder="Enter your full name" required>
    
    <label for="email">Email Address</label>
    <input type="text" name="email" id="email" placeholder="Please enter your email" required>
    
    <label for="password" class="strong">Password</label>
    <input type="password" id="password" name="password" placeholder="Create a password" required>
    
    <label for="confirm_password">Confirm Password</label>
    <input type="password" id="confirm_password" name="confirm_password" placeholder="Confirm your password" required>
    
    <label for="profile_picture">Profile Picture</label>
    <input type="file" name="profile_picture" id="profile_picture" accept="image/*">
    
    <div class="signup-button-container">
        <button type="submit" name="signup" class="signup-button">Sign Up</button>
    </div>
    
    <div class="login-container">
        <p>Already have an account? <a href="index.php">Log-in</a></p>
    </div>
</form>

        </div>
    </div>
</body>
</html>