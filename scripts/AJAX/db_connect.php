<?php
// Create connection
$conn = new mysqli('localhost', 'root', '', 'lendingdb');

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Set charset to utf8mb4
$conn->set_charset("utf8mb4");

// Set timezone
date_default_timezone_set('Asia/Manila');

// Enable error reporting for debugging
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
?>
