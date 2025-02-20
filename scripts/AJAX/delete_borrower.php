<?php
header('Content-Type: application/json');
session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $response = array();

    if (!isset($_POST['id'])) {
        $response['status'] = 'error';
        $response['message'] = 'No ID provided';
        echo json_encode($response);
        exit();
    }

    $borrowerId = intval($_POST['id']);

    try {
        $db = new mysqli('localhost', 'root', '', 'lendingdb');
        if ($db->connect_error) {
            throw new Exception('Connection Failed: ' . $db->connect_error);
        }

        $db->begin_transaction();

        // Get file paths before deletion
        $filesSql = "SELECT 
            id.id_photo_path,
            ins.insurance_file_path,
            GROUP_CONCAT(cf.file_path) as collateral_files
        FROM borrowers b
        LEFT JOIN identification_documents id ON b.id = id.borrower_id
        LEFT JOIN insurance_details ins ON b.id = ins.borrower_id
        LEFT JOIN collateral_files cf ON b.id = cf.borrower_id
        WHERE b.id = ?
        GROUP BY b.id, id.id_photo_path, ins.insurance_file_path";

        $filesStmt = $db->prepare($filesSql);
        $filesStmt->bind_param("i", $borrowerId);
        $filesStmt->execute();
        $filesResult = $filesStmt->get_result();
        $files = $filesResult->fetch_assoc();

        // Get address IDs before deleting borrower
        $addressSql = "SELECT b.address_id, ed.address_id as employer_address_id 
                      FROM borrowers b
                      LEFT JOIN employment_details ed ON b.id = ed.borrower_id
                      WHERE b.id = ?";
        $addressStmt = $db->prepare($addressSql);
        $addressStmt->bind_param("i", $borrowerId);
        $addressStmt->execute();
        $addressResult = $addressStmt->get_result();
        $addresses = $addressResult->fetch_assoc();

        // Delete records in correct order (respecting foreign key constraints)
        // 1. Delete collateral files
        $sql = "DELETE FROM collateral_files WHERE borrower_id = ?";
        $stmt = $db->prepare($sql);
        $stmt->bind_param("i", $borrowerId);
        $stmt->execute();

        // 2. Delete insurance details
        $sql = "DELETE FROM insurance_details WHERE borrower_id = ?";
        $stmt = $db->prepare($sql);
        $stmt->bind_param("i", $borrowerId);
        $stmt->execute();

        // 3. Delete identification documents
        $sql = "DELETE FROM identification_documents WHERE borrower_id = ?";
        $stmt = $db->prepare($sql);
        $stmt->bind_param("i", $borrowerId);
        $stmt->execute();

        // 4. Delete dependents
        $sql = "DELETE FROM dependents WHERE borrower_id = ?";
        $stmt = $db->prepare($sql);
        $stmt->bind_param("i", $borrowerId);
        $stmt->execute();

        // 5. Delete employment details
        $sql = "DELETE FROM employment_details WHERE borrower_id = ?";
        $stmt = $db->prepare($sql);
        $stmt->bind_param("i", $borrowerId);
        $stmt->execute();

        // 6. Delete borrower
        $sql = "DELETE FROM borrowers WHERE id = ?";
        $stmt = $db->prepare($sql);
        $stmt->bind_param("i", $borrowerId);
        $stmt->execute();

        // 7. Delete addresses
        if ($addresses) {
            if ($addresses['address_id']) {
                $sql = "DELETE FROM addresses WHERE id = ?";
                $stmt = $db->prepare($sql);
                $stmt->bind_param("i", $addresses['address_id']);
                $stmt->execute();
            }

            if ($addresses['employer_address_id']) {
                $sql = "DELETE FROM addresses WHERE id = ?";
                $stmt = $db->prepare($sql);
                $stmt->bind_param("i", $addresses['employer_address_id']);
                $stmt->execute();
            }
        }

        // Delete physical files
        if ($files) {
            if ($files['id_photo_path']) {
                $path = "../../images/uploads/" . $files['id_photo_path'];
                if (file_exists($path)) {
                    unlink($path);
                }
            }

            if ($files['insurance_file_path']) {
                $path = "../../images/uploads/" . $files['insurance_file_path'];
                if (file_exists($path)) {
                    unlink($path);
                }
            }

            if ($files['collateral_files']) {
                $collateralFiles = explode(',', $files['collateral_files']);
                foreach ($collateralFiles as $file) {
                    $path = "../../images/uploads/" . trim($file);
                    if (file_exists($path)) {
                        unlink($path);
                    }
                }
            }
        }

        $db->commit();
        $response['status'] = 'success';
        $response['message'] = 'Borrower and all related records deleted successfully';

    } catch (Exception $e) {
        if (isset($db)) {
            $db->rollback();
        }
        $response['status'] = 'error';
        $response['message'] = $e->getMessage();
    }

    if (isset($db)) {
        $db->close();
    }

    echo json_encode($response);
    exit();
}
?>