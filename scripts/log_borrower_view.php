<?php
header('Content-Type: application/json');
session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['borrower_name'])) {
    try {
        $db = new mysqli('localhost', 'root', '', 'lendingdb');
        
        if ($db->connect_error) {
            throw new Exception('Connection Failed: ' . $db->connect_error);
        }

        $borrower_name = $db->real_escape_string($_POST['borrower_name']);
        $performed_by = isset($_SESSION['fullname']) ? $_SESSION['fullname'] : 'Unknown User';
        $action = "Viewed borrower profile: $borrower_name";
        $category = "Borrower Search";
        
        $sql = "INSERT INTO audit_logs (date, time, performed_by, action, category) 
                VALUES (CURRENT_DATE(), CURRENT_TIME(), ?, ?, ?)";
        
        $stmt = $db->prepare($sql);
        $stmt->bind_param("sss", $performed_by, $action, $category);
        
        if ($stmt->execute()) {
            echo json_encode(['status' => 'success']);
        } else {
            throw new Exception('Failed to log action');
        }
        
        $stmt->close();
        $db->close();
        
    } catch (Exception $e) {
        echo json_encode([
            'status' => 'error',
            'message' => $e->getMessage()
        ]);
    }
} else {
    echo json_encode([
        'status' => 'error',
        'message' => 'Invalid request'
    ]);
}
?>