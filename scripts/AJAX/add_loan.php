<?php
require 'db_connect.php';
session_start();
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

        // After successful loan insertion, insert or update loan_balance
        $checkBalanceStmt = $conn->prepare("SELECT id FROM loan_balance WHERE borrower_id = ?");
        $checkBalanceStmt->bind_param("i", $borrowerId);
        $checkBalanceStmt->execute();
        $result = $checkBalanceStmt->get_result();

        if ($result->num_rows > 0) {
            // Update existing balance
            $updateBalanceStmt = $conn->prepare("
                UPDATE loan_balance 
                SET loan_balance = loan_balance + ? 
                WHERE borrower_id = ?
            ");
            $updateBalanceStmt->bind_param("di", $loanAmount, $borrowerId);
            
            if (!$updateBalanceStmt->execute()) {
                throw new Exception("Failed to update loan balance: " . $updateBalanceStmt->error);
            }
        } else {
            // Insert new balance record
            $insertBalanceStmt = $conn->prepare("
                INSERT INTO loan_balance (borrower_id, loan_balance) 
                VALUES (?, ?)
            ");
            $insertBalanceStmt->bind_param("id", $borrowerId, $loanAmount);
            
            if (!$insertBalanceStmt->execute()) {
                throw new Exception("Failed to insert loan balance: " . $insertBalanceStmt->error);
            }
        }

        // Insert into transactions table
        $transactionStmt = $conn->prepare("
            INSERT INTO transactions (
                reference_no, 
                transaction_type, 
                transaction_date, 
                amount, 
                borrower_id
            ) VALUES (?, 'loan', NOW(), ?, ?)
        ");
        $transactionStmt->bind_param("sdi", $referenceNo, $loanAmount, $borrowerId);
        
        if (!$transactionStmt->execute()) {
            throw new Exception("Failed to record transaction: " . $transactionStmt->error);
        }

        // Get borrower's name for audit log
        $nameStmt = $conn->prepare("
            SELECT CONCAT(first_name, ' ', COALESCE(middle_name, ''), ' ', surname) as full_name 
            FROM borrowers 
            WHERE id = ?
        ");
        $nameStmt->bind_param("i", $borrowerId);
        $nameStmt->execute();
        $borrowerResult = $nameStmt->get_result();
        $borrowerData = $borrowerResult->fetch_assoc();
        $borrowerName = $borrowerData['full_name'];

        // Commit transaction
        $conn->commit();

        // Add audit log entry
        if (isset($_SESSION['fullname'])) {
            $performed_by = $_SESSION['fullname'];
            $formatted_amount = number_format($loanAmount, 2);
            $audit_action = "$performed_by added new loan (Ref: $referenceNo) worth ₱$formatted_amount for borrower: $borrowerName";
            $audit_category = "Loan Management Logs";
            
            $audit_sql = "INSERT INTO audit_logs (date, time, performed_by, action, category) 
                         VALUES (CURRENT_DATE(), CURRENT_TIME(), ?, ?, ?)";
            $audit_stmt = $conn->prepare($audit_sql);
            $audit_stmt->bind_param("sss", $performed_by, $audit_action, $audit_category);
            $audit_stmt->execute();
            $audit_stmt->close();
        }
        // Add audit log entry
        if (isset($_SESSION['fullname'])) {
            $performed_by = $_SESSION['fullname'];
            $formatted_amount = number_format($loanAmount, 2);
            $audit_action = "$performed_by added new loan (Ref: $referenceNo) worth ₱$formatted_amount for borrower: $borrowerName";
            $audit_category = "New Loan";
            
            $audit_sql = "INSERT INTO audit_logs (date, time, performed_by, action, category) 
                         VALUES (CURRENT_DATE(), CURRENT_TIME(), ?, ?, ?)";
            $audit_stmt = $conn->prepare($audit_sql);
            $audit_stmt->bind_param("sss", $performed_by, $audit_action, $audit_category);
            $audit_stmt->execute();
            $audit_stmt->close();
        }

        echo json_encode([
            "status" => "success",
            "message" => "Loan and balance added successfully",
            "reference_no" => $referenceNo,
            "loan_amount" => $loanAmount,
            "debug_date" => $loanDate
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

    // Close all statements
    if (isset($stmtFile)) $stmtFile->close();
    if (isset($stmt)) $stmt->close();
    if (isset($checkBalanceStmt)) $checkBalanceStmt->close();
    if (isset($updateBalanceStmt)) $updateBalanceStmt->close();
    if (isset($insertBalanceStmt)) $insertBalanceStmt->close();
    if (isset($transactionStmt)) $transactionStmt->close();
    if (isset($nameStmt)) $nameStmt->close();
    $conn->close();
}
?>
