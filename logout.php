<?php
session_start();

// Database connection
$db = new mysqli('localhost', 'root', '', 'lendingdb');

if ($db->connect_error) {
    http_response_code(500);
    exit();
}

// Add audit log for logout
if (isset($_SESSION['user_id']) && isset($_SESSION['fullname'])) {
    $performed_by = $_SESSION['fullname'];
    $action = $_SESSION['fullname'] . " logged out";
    $category = "Admin Activity Log";
    
    $audit_sql = "INSERT INTO audit_logs (date, time, performed_by, action, category) VALUES (CURRENT_DATE(), CURRENT_TIME(), ?, ?, ?)";
    $audit_stmt = $db->prepare($audit_sql);
    $audit_stmt->bind_param("sss", $performed_by, $action, $category);
    $audit_stmt->execute();
    $audit_stmt->close();
}

$db->close();

// Clear session and destroy
session_unset();
session_destroy();

// Redirect to index.php
header("Location: index.php");
exit();
?>
