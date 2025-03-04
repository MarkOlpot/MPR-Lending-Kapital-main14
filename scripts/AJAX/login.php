<?php
session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $email = $_POST['email'];
    $password = $_POST['password'];
    $response = array();

    // Database connection
    $db = new mysqli('localhost', 'root', '', 'lendingdb');

    // Check connection
    if ($db->connect_error) {
        $response['status'] = 'error';
        $response['message'] = 'Connection Failed: ' . $db->connect_error;
        echo json_encode($response);
        exit();
    }

    // Check if email exists
    $sql = "SELECT * FROM users WHERE email = ?";
    $stmt = $db->prepare($sql);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        // Verify password
        if (password_verify($password, $user['password'])) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['fullname'] = $user['fullname'];
            
            // Add audit log for successful login
            $performed_by = $user['fullname'];
            $action = $performed_by . " logged in";
            $category = "Admin Activity Log";
            
            $audit_sql = "INSERT INTO audit_logs (date, time, performed_by, action, category) VALUES (CURRENT_DATE(), CURRENT_TIME(), ?, ?, ?)";
            $audit_stmt = $db->prepare($audit_sql);
            $audit_stmt->bind_param("sss", $performed_by, $action, $category);
            $audit_stmt->execute();
            $audit_stmt->close();
            
            $response['status'] = 'success';
        } else {
            $response['status'] = 'error';
            $response['message'] = 'Invalid email or password';
        }
    } else {
        $response['status'] = 'error';
        $response['message'] = 'Invalid email or password';
    }

    $stmt->close();
    $db->close();

    echo json_encode($response);
    exit();
}
?>