<?php
$servername = "localhost";
$username = "root"; // Change this
$password = ""; // Change this
$database = "lendingdb"; // Change this

$conn = new mysqli($servername, $username, $password, $database);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
