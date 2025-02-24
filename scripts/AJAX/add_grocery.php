<?php
require 'db_connect.php';

header('Content-Type: application/json');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    try {
        // Start transaction
        $conn->begin_transaction();

        // Get form data
        $groceryDate = $_POST['groceryDate'];
        $groceryAmount = floatval($_POST['groceryAmount']); // Convert to float
        $borrowerId = $_POST['borrowerId'];
        
        // Validate amount
        if ($groceryAmount <= 0) {
            throw new Exception("Grocery amount must be greater than 0");
        }
        
        // Generate reference number
        $referenceNo = "GR-" . strtoupper(substr(uniqid(), -6));
        
        // Insert grocery record
        $stmt = $conn->prepare("INSERT INTO grocery (reference_no, borrower_id, grocery_amount, grocery_date, remarks) VALUES (?, ?, ?, ?, ?)");
        
        $remarks = "Grocery added successfully";
        
        $stmt->bind_param("sidss", 
            $referenceNo,
            $borrowerId,
            $groceryAmount,
            $groceryDate,
            $remarks
        );

        if (!$stmt->execute()) {
            throw new Exception("Failed to save grocery record: " . $stmt->error);
        }

        // Insert into transactions table
        $stmtTrans = $conn->prepare("INSERT INTO transactions (reference_no, transaction_type, transaction_date, amount, borrower_id) VALUES (?, 'grocery', ?, ?, ?)");
        
        $stmtTrans->bind_param("ssdi", 
            $referenceNo,
            $groceryDate,
            $groceryAmount,
            $borrowerId
        );

        if (!$stmtTrans->execute()) {
            throw new Exception("Failed to save transaction record: " . $stmtTrans->error);
        }

        // Commit transaction
        $conn->commit();

        echo json_encode([
            "status" => "success",
            "message" => "Grocery has been successfully added",
            "reference_no" => $referenceNo,
            "amount" => $groceryAmount
        ]);

    } catch (Exception $e) {
        // Rollback transaction on error
        $conn->rollback();
        
        echo json_encode([
            "status" => "error",
            "message" => $e->getMessage()
        ]);
    }

    // Close statements
    if (isset($stmt)) $stmt->close();
    if (isset($stmtTrans)) $stmtTrans->close();
    $conn->close();
}
?>