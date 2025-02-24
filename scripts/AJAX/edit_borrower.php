<?php
header('Content-Type: application/json');
session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $response = array();

    try {
        $db = new mysqli('localhost', 'root', '', 'lendingdb');
        if ($db->connect_error) {
            throw new Exception('Connection Failed: ' . $db->connect_error);
        }

        $db->begin_transaction();

        // Get borrower's current address_id and employer's address_id
        $addressSql = "SELECT b.address_id, ed.address_id as employer_address_id 
                      FROM borrowers b
                      LEFT JOIN employment_details ed ON b.id = ed.borrower_id
                      WHERE b.id = ?";
        $addressStmt = $db->prepare($addressSql);
        $addressStmt->bind_param("i", $_POST['id']);
        $addressStmt->execute();
        $addressResult = $addressStmt->get_result();
        $addresses = $addressResult->fetch_assoc();

        // Update borrower's address
        $addressSql = "UPDATE addresses SET 
            home_no = ?, street = ?, barangay = ?, city = ?, province = ?, region = ?
            WHERE id = ?";
        $addressStmt = $db->prepare($addressSql);
        $addressStmt->bind_param(
            "ssssssi",
            $_POST['homeNo'],
            $_POST['street'],
            $_POST['baranggay'],
            $_POST['city'],
            $_POST['province'],
            $_POST['region'],
            $addresses['address_id']
        );
        $addressStmt->execute();

        // Update employer's address
        $empAddressSql = "UPDATE addresses SET 
            home_no = ?, street = ?, barangay = ?, city = ?, province = ?, region = ?
            WHERE id = ?";
        $empAddressStmt = $db->prepare($empAddressSql);
        $empAddressStmt->bind_param(
            "ssssssi",
            $_POST['EmployerhomeNo'],
            $_POST['Employerstreet'],
            $_POST['Employerbaranggay'],
            $_POST['Employercity'],
            $_POST['Employerprovince'],
            $_POST['Employerregion'],
            $addresses['employer_address_id']
        );
        $empAddressStmt->execute();

        // Update borrower's basic information
        $borrowerSql = "UPDATE borrowers SET 
            first_name = ?, middle_name = ?, surname = ?, suffix = ?, 
            sex = ?, dob = ?, marital_status = ?, contact_number = ?
            WHERE id = ?";
        $borrowerStmt = $db->prepare($borrowerSql);
        $borrowerStmt->bind_param(
            "ssssssssi",
            $_POST['fName'],
            $_POST['mName'],
            $_POST['surname'],
            $_POST['suffix'],
            $_POST['sex'],
            $_POST['DOB'],
            $_POST['maritalStatus'],
            $_POST['contactNo'],
            $_POST['id']
        );
        $borrowerStmt->execute();

        // Update employment details
        $employmentSql = "UPDATE employment_details SET 
            employer_name = ?, years_with_employer = ?, position = ?, 
            phone_no = ?, salary = ?
            WHERE borrower_id = ?";

        $noOfYearsWorked = intval($_POST['noOfYearsWorked']);
        $employmentStmt = $db->prepare($employmentSql);
        $employmentStmt->bind_param(
            "sissdi",
            $_POST['employerName'],
            $noOfYearsWorked,
            $_POST['position'],
            $_POST['phoneNoEmployer'],
            $_POST['salary'],
            $_POST['id']
        );
        $employmentStmt->execute();

        // Handle ID document update
        if (isset($_FILES['idPhoto']) || isset($_POST['idType'])) {
            $idPhoto = $_POST['existing_id_photo'];
            if (isset($_FILES['idPhoto']) && $_FILES['idPhoto']['error'] === 0) {
                $idPhoto = uploadFile($_FILES['idPhoto'], 'id_photos');
            }

            $idSql = "UPDATE identification_documents SET 
                id_type = ?, id_no = ?, expiry_date = ?, id_photo_path = ?
                WHERE borrower_id = ?";
            $idStmt = $db->prepare($idSql);
            $idStmt->bind_param(
                "ssssi",
                $_POST['idType'],
                $_POST['idNo'],
                $_POST['expiryDate'],
                $idPhoto,
                $_POST['id']
            );
            $idStmt->execute();
        }

        // Handle insurance update
        if (isset($_FILES['insurancePhoto']) || isset($_POST['insuranceType'])) {
            $insuranceFile = $_POST['existing_insurance_file'];
            if (isset($_FILES['insurancePhoto']) && $_FILES['insurancePhoto']['error'] === 0) {
                $insuranceFile = uploadFile($_FILES['insurancePhoto'], 'insurance_files');
            }

            $insuranceSql = "UPDATE insurance_details SET 
                insurance_provider = ?, issued_date = ?, expiry_date = ?, insurance_file_path = ?
                WHERE borrower_id = ?";
            $insuranceStmt = $db->prepare($insuranceSql);
            $insuranceStmt->bind_param(
                "ssssi",
                $_POST['insuranceType'],
                $_POST['issuedDate'],
                $_POST['expiryDateInsurance'],
                $insuranceFile,
                $_POST['id']
            );
            $insuranceStmt->execute();
        }

        // Update dependent information
        $dependentSql = "UPDATE dependents SET 
            name = ?, contact_number_dependents = ?
            WHERE borrower_id = ?";
        $dependentStmt = $db->prepare($dependentSql);
        $dependentStmt->bind_param(
            "ssi",
            $_POST['dependentName'],
            $_POST['dependentContactNo'],
            $_POST['id']
        );
        $dependentStmt->execute();

        // Handle collateral files
        if (isset($_FILES['collateral'])) {
            // Delete existing collateral files
            $deleteSql = "DELETE FROM collateral_files WHERE borrower_id = ?";
            $deleteStmt = $db->prepare($deleteSql);
            $deleteStmt->bind_param("i", $_POST['id']);
            $deleteStmt->execute();

            // Insert new collateral files
            foreach ($_FILES['collateral']['tmp_name'] as $key => $tmp_name) {
                if ($_FILES['collateral']['error'][$key] === 0) {
                    $collateralFile = uploadFile([
                        'name' => $_FILES['collateral']['name'][$key],
                        'type' => $_FILES['collateral']['type'][$key],
                        'tmp_name' => $tmp_name,
                        'error' => $_FILES['collateral']['error'][$key],
                        'size' => $_FILES['collateral']['size'][$key]
                    ], 'collateral_files');

                    $collateralSql = "INSERT INTO collateral_files (borrower_id, file_path) VALUES (?, ?)";
                    $collateralStmt = $db->prepare($collateralSql);
                    $collateralStmt->bind_param("is", $_POST['id'], $collateralFile);
                    $collateralStmt->execute();
                }
            }
        }

        $db->commit();
        $response['status'] = 'success';
        $response['message'] = 'Borrower updated successfully';

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

function uploadFile($file, $directory)
{
    $target_dir = "../../images/uploads/" . $directory . "/";
    if (!is_dir($target_dir)) {
        mkdir($target_dir, 0777, true);
    }

    $file_extension = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    $new_filename = uniqid() . '.' . $file_extension;
    $target_file = $target_dir . $new_filename;

    if (move_uploaded_file($file['tmp_name'], $target_file)) {
        return $directory . '/' . $new_filename;
    }

    throw new Exception("Failed to upload file");
}
?>