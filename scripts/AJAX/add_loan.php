<?php
require 'db_connect.php';

header('Content-Type: application/json');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    try {
        // Start transaction
        $conn->begin_transaction();

        // Get form data with debug logging
        $customerType = $_POST['customerType'];
        $loanAmount = $_POST['loanAmount'];
        $interestRate = $_POST['interestRate'];
        $loanDate = $_POST['loanDate'];
        $term = $_POST['term'];
        $borrowerId = $_POST['borrowerId'];
        $remarks = trim($_POST['remarks']); // Get remarks from form

        // Sanitize remarks
        $remarks = htmlspecialchars($remarks);
        if (empty($remarks)) {
            $remarks = "Loan added successfully"; // Default value if empty
        }

        // Debug logging
        error_log("Raw loan date: " . $loanDate);

        // Format the date
        $formattedLoanDate = date('Y-m-d');
        error_log("Formatted loan date: " . $formattedLoanDate);

        // Debug log
        error_log("Loan Date received: " . $_POST['loanDate']);
        error_log("Formatted Loan Date: " . $loanDate);
        
        // Generate reference number
        $referenceNo = "LN-" . strtoupper(substr(uniqid(), -6));
        
        // Calculate repayment date
        $repaymentDate = date('Y-m-d', strtotime("+$term months", strtotime($loanDate)));

        // Handle promissory note upload
        if (!isset($_FILES["promissoryNote"])) {
            throw new Exception("Promissory note file is required");
        }

        $uploadDir = "../../images/uploads/promissory_notes/";
        if (!file_exists($uploadDir)) {
            mkdir($uploadDir, 0777, true);
        }

        $fileName = $_FILES["promissoryNote"]["name"];
        $fileTmp = $_FILES["promissoryNote"]["tmp_name"];
        $fileExt = pathinfo($fileName, PATHINFO_EXTENSION);
        $newFileName = time() . "_" . uniqid() . "." . $fileExt;
        $filePath = $uploadDir . $newFileName;

        // Upload file
        if (!move_uploaded_file($fileTmp, $filePath)) {
            throw new Exception("Failed to upload promissory note");
        }

        // Insert promissory file record
        $stmtFile = $conn->prepare("INSERT INTO promissory_files (promissory_file_path) VALUES (?)");
        $stmtFile->bind_param("s", $newFileName);
        
        if (!$stmtFile->execute()) {
            throw new Exception("Failed to save promissory file record: " . $stmtFile->error);
        }
        
        // Get the promissory file ID
        $promissoryId = $conn->insert_id;
        
        if (!$promissoryId) {
            throw new Exception("Failed to get promissory file ID");
        }

        // Insert loan record with formatted date
        $stmt = $conn->prepare("INSERT INTO loan (reference_no, borrower_id, customer_type, loan_amount, interest_rate, loan_date, term_months, repayment_date, promissory_id, remarks) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        
        // Update the bind_param statement
        $stmt->bind_param("sisdisssis", 
            $referenceNo, 
            $borrowerId, 
            $customerType, 
            $loanAmount, 
            $interestRate, 
            $loanDate,  // Use the formatted date here
            $term, 
            $repaymentDate, 
            $promissoryId, 
            $remarks  // Use the sanitized remarks
        );

        if (!$stmt->execute()) {
            throw new Exception("Failed to save loan record: " . $stmt->error);
        }

        // Commit transaction
        $conn->commit();

        echo json_encode([
            "status" => "success",
            "message" => "Loan added successfully".$loanDate,
            "reference_no" => $referenceNo,
            "debug_date" => $loanDate // Add this for debugging
        ]);

    } catch (Exception $e) {
        // Rollback transaction on error
        $conn->rollback();
        
        // Delete uploaded file if exists
        if (isset($filePath) && file_exists($filePath)) {
            unlink($filePath);
        }
        
        echo json_encode([
            "status" => "error",
            "message" => $e->getMessage()
        ]);
    }

    // Close statements
    if (isset($stmtFile)) $stmtFile->close();
    if (isset($stmt)) $stmt->close();
    $conn->close();
}
?>
