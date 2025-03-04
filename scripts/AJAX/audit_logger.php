function insertAuditLog($conn, $performed_by, $action, $category) {
    try {
        $stmt = $conn->prepare("
            INSERT INTO audit_logs 
            (date, time, performed_by, action, category) 
            VALUES 
            (CURDATE(), CURTIME(), ?, ?, ?)
        ");
        
        $stmt->bind_param("sss", 
            $performed_by,
            $action,
            $category
        );
        
        if (!$stmt->execute()) {
            throw new Exception("Failed to log audit: " . $stmt->error);
        }
        
        $stmt->close();
        return true;
        
    } catch (Exception $e) {
        error_log("Audit Log Error: " . $e->getMessage());
        return false;
    }
}