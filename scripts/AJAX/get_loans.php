<?php
require 'db_connect.php';

header('Content-Type: application/json');

try {
    $borrowerId = isset($_GET['borrowerId']) ? intval($_GET['borrowerId']) : null;

    if (!$borrowerId) {
        throw new Exception("Borrower ID is required");
    }

    $stmt = $conn->prepare("
        SELECT 
            l.created_at,
            l.loan_date,
            l.reference_no,
            l.customer_type,
            l.repayment_date,
            l.loan_amount,
            l.interest_rate,
            l.term_months,
            p.promissory_file_path,
            l.remarks,
            COALESCE(lb.loan_balance, l.loan_amount) as balance
        FROM loan l
        LEFT JOIN promissory_files p ON l.promissory_id = p.id
        LEFT JOIN loan_balance lb ON l.borrower_id = lb.borrower_id
        WHERE l.borrower_id = ?
        ORDER BY l.loan_date DESC
    ");

    $stmt->bind_param("i", $borrowerId);
    $stmt->execute();
    $result = $stmt->get_result();
    $loans = $result->fetch_all(MYSQLI_ASSOC);

    echo json_encode([
        'status' => 'success',
        'data' => $loans
    ]);

} catch (Exception $e) {
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}

$stmt->close();
$conn->close();
?>