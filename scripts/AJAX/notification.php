<?php
require 'db_connect.php';
header('Content-Type: application/json');

try {
    // Set notification threshold (30 days before expiry)
    $threshold_date = date('Y-m-d', strtotime('+30 days'));
    $today = date('Y-m-d');
    $notifications = [];

    // Check ID documents expiring soon
    $id_query = "
        SELECT 
            b.first_name,
            b.middle_name,
            b.surname,
            i.id_type,
            i.expiry_date,
            DATEDIFF(i.expiry_date, CURRENT_DATE) as days_remaining
        FROM identification_documents i
        JOIN borrowers b ON i.borrower_id = b.id
        WHERE i.expiry_date BETWEEN CURRENT_DATE AND ?
        ORDER BY i.expiry_date ASC
    ";

    $stmt = $conn->prepare($id_query);
    $stmt->bind_param("s", $threshold_date);
    $stmt->execute();
    $result = $stmt->get_result();

    while ($row = $result->fetch_assoc()) {
        $fullname = trim($row['first_name'] . ' ' . ($row['middle_name'] ? $row['middle_name'] . ' ' : '') . $row['surname']);
        $notifications[] = [
            'type' => 'ID',
            'message' => sprintf(
                "%s's %s is expiring in %d days (on %s)",
                $fullname,
                $row['id_type'],
                $row['days_remaining'],
                date('M d, Y', strtotime($row['expiry_date']))
            ),
            'days_remaining' => $row['days_remaining'],
            'expiry_date' => $row['expiry_date']
        ];
    }

    // Check insurance documents expiring soon
    $insurance_query = "
        SELECT 
            b.first_name,
            b.middle_name,
            b.surname,
            i.insurance_provider,
            i.expiry_date,
            DATEDIFF(i.expiry_date, CURRENT_DATE) as days_remaining
        FROM insurance_details i
        JOIN borrowers b ON i.borrower_id = b.id
        WHERE i.expiry_date BETWEEN CURRENT_DATE AND ?
        ORDER BY i.expiry_date ASC
    ";

    $stmt = $conn->prepare($insurance_query);
    $stmt->bind_param("s", $threshold_date);
    $stmt->execute();
    $result = $stmt->get_result();

    while ($row = $result->fetch_assoc()) {
        $fullname = trim($row['first_name'] . ' ' . ($row['middle_name'] ? $row['middle_name'] . ' ' : '') . $row['surname']);
        $notifications[] = [
            'type' => 'Insurance',
            'message' => sprintf(
                "%s's %s insurance is expiring in %d days (on %s)",
                $fullname,
                $row['insurance_provider'],
                $row['days_remaining'],
                date('M d, Y', strtotime($row['expiry_date']))
            ),
            'days_remaining' => $row['days_remaining'],
            'expiry_date' => $row['expiry_date']
        ];
    }

    // Sort notifications by days remaining
    usort($notifications, function($a, $b) {
        return $a['days_remaining'] - $b['days_remaining'];
    });

    // Insert notifications into the database
    foreach ($notifications as $notification) {
        $insert_query = "
            INSERT INTO notification (notif_content, status, created_at)
            VALUES (?, 0, NOW())
            ON DUPLICATE KEY UPDATE status = 0
        ";
        
        $stmt = $conn->prepare($insert_query);
        $stmt->bind_param("s", $notification['message']);
        $stmt->execute();
    }

    // Return notifications
    echo json_encode([
        'status' => 'success',
        'count' => count($notifications),
        'notifications' => $notifications
    ]);

} catch (Exception $e) {
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}

$conn->close();
?>