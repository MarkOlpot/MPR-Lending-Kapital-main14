<?php
// Start the session to access user data
session_start();

// Database connection
$db = new mysqli('localhost', 'root', '', 'lendingdb');

// Check connection
if ($db->connect_error) {
    die("Connection failed: " . $db->connect_error);
}
 
// Fetch the profile picture path and user details for the logged-in user
$user_id = $_SESSION['user_id'];
$sql = "SELECT profile_picture, fullname, email, password FROM users WHERE id = ?";
$stmt = $db->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

// Set the profile picture path
$profilePicturePath = isset($user['profile_picture']) && !empty($user['profile_picture']) ? $user['profile_picture'] : 'uploads/defaultprof.jpg';

// Fetch user's personal info
$fullname = $user['fullname'];
$email = $user['email'];
$password = $user['password']; // Store hashed password in the database for security

$stmt->close();
$db->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- CSS -->
    <link rel="stylesheet" href="styles/profile.css">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Source+Serif+4:ital,opsz,wght@0,8..60,200..900;1,8..60,200..900&display=swap" rel="stylesheet">
    <!-- SweetAlert2 -->
    <script src="node_modules/sweetalert2/dist/sweetalert2.all.min.js"></script>
    <!-- Zooming -->
    <script src="node_modules/zooming/build/zooming.min.js"></script>

    <title>Profile</title>
</head>
<body>
<nav>
    <div class="dashboard-container">
        <div class="dashboard-header">
            <div class="logo-container">
                <img src="images/dashboard.png" alt="Dashboard Logo">
            </div>
            <div class="dashboard-header-right">
            <div class="dashboard-header-right-content">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                            <path fill="currentColor" d="M3 13h8V3H3zm0 8h8v-6H3zm10 0h8V11h-8zm0-18v6h8V3z" />
                        </svg>
                        <p>Dashboard</p>
                    </div>
                <div class="notification">
                    <div class="notification-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                            <path fill="currentColor" d="M12 22c1.1 0 2-.9 2-2h-4a2 2 0 0 0 2 2m6-6v-5c0-3.07-1.64-5.64-4.5-6.32V4c0-.83-.67-1.5-1.5-1.5s-1.5.67-1.5 1.5v.68C7.63 5.36 6 7.92 6 11v5l-2 2v1h16v-1z" />
                        </svg>
                        <p>Notification</p>
                    </div>
                    <div class="notification-dropdown">
                        <div class="notification-dropdown-content">
                            <p>No new notifications</p>
                            <a href="#">View all notifications</a>
                        </div>
                    </div>
                </div>
                <div class="profile">
                    <img src="<?php echo $profilePicturePath; ?>" alt="Profile Picture">
                    <div class="profile-dropdown">
                        <p>Welcome, <?php echo $fullname; ?></p>
                        <div class="profile-dropdown-content">
                            <a href="profile.php">Profile</a>
                            <a href="manage_user_access.php">Manage User Access</a>
                            <a href="audit_logs.php">Audit Logs</a>
                            <a href="logout.php">Logout</a>
                        </div>
                    </div>
                    <svg class="arrow-down-icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                        <path fill="currentColor" d="M7.41 8.59L12 13.17l4.59-4.58L18 10l-6 6l-6-6z" />
                    </svg>
                </div>
            </div>
        </div>
    </div>
</nav>

<div class="profile-container">
    <h1>Profile</h1>
    <div class="profile-content">
        <div class="profile-picture">
            <h1>Profile Picture</h1>
            <form action="update_profile.php" method="post" enctype="multipart/form-data">
                <div class="upload-profile-picture-container">
                    <img src="<?php echo $profilePicturePath; ?>" id="profile-picture-preview" alt="Profile Picture">
                    <div class="upload-profile-picture-btn-container">
                        <p>Upload a new profile picture</p>
                        <input type="file" name="profile_picture" id="profile-picture-upload" accept="image/*" onchange="previewImage(event)">
                    </div>
                </div>
                <div class="confirm-upload-profile-btn-container" disabled>
                    <button type="button" id="cancel-upload-profile-btn">Cancel</button>
                    <button type="submit" id="upload-profile-btn" name="update_profile">Confirm</button disabled>
                </div>
            </form>
        </div>

        <div class="profile-info">
            <h1>Personal Information</h1>
            <!-- Add 'Enable editing' functionality -->
            <form action="update_profile.php" method="post" enctype="multipart/form-data" id="profile-form">
    <label for="Name">Full Name</label><br>
    <input type="text" id="Name" class="inputs" name="fullname" value="<?php echo $fullname; ?>" disabled><br>

    <label for="Email">Email</label><br>
    <input type="email" id="Email" class="inputs" name="email" value="<?php echo $email; ?>" disabled><br>

    <label for="Password">Password</label><br>
    <input type="password" id="Password" class="inputs" name="password" disabled><br>

    <label for="Confirm Password">Confirm Password</label><br>
    <input type="password" id="ConfirmPassword" class="inputs" name="confirm_password" disabled><br>

    <div class="profile-button-container">
        <button type="button" id="edit-profile-btn">Edit Profile</button>
        <button type="submit" id="save-profile-btn" name="update_details" disabled>Save Profile</button>
    </div>
</form>



        </div>
    </div>
</div>

<script src="scripts/profile.js"></script>
</body>
</html>
