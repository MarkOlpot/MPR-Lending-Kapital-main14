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

        // 1. Insert address
        $addressSql = "INSERT INTO addresses (home_no, street, barangay, city, province, region) 
                      VALUES (?, ?, ?, ?, ?, ?)";
        $addressStmt = $db->prepare($addressSql);
        $addressStmt->bind_param(
            "ssssss",
            $_POST['homeNo'],
            $_POST['street'],
            $_POST['baranggay'],
            $_POST['city'],
            $_POST['province'],
            $_POST['region']
        );
        $addressStmt->execute();
        $addressId = $db->insert_id;

        // 2. Insert borrower
        $borrowerSql = "INSERT INTO borrowers (first_name, middle_name, surname, suffix, sex, 
                        dob, marital_status, contact_number, address_id) 
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            $addressId
        );
        $borrowerStmt->execute();
        $borrowerId = $db->insert_id;

        // 3. Insert employer address
        $empAddressSql = "INSERT INTO addresses (home_no, street, barangay, city, province, region) 
                         VALUES (?, ?, ?, ?, ?, ?)";
        $empAddressStmt = $db->prepare($empAddressSql);
        $empAddressStmt->bind_param(
            "ssssss",
            $_POST['EmployerhomeNo'],
            $_POST['Employerstreet'],
            $_POST['Employerbaranggay'],
            $_POST['Employercity'],
            $_POST['Employerprovince'],
            $_POST['Employerregion']
        );
        $empAddressStmt->execute();
        $empAddressId = $db->insert_id;

        $noOfYearsWorked = intval($_POST['noOfYearsWorked']);
        // 4. Insert employment details
        $employmentSql = "INSERT INTO employment_details (borrower_id, employer_name, years_with_employer, 
                         position, phone_no, salary, address_id) 
                         VALUES (?, ?, ?, ?, ?, ?, ?)";
        $employmentStmt = $db->prepare($employmentSql);
        $employmentStmt->bind_param(
            "isissis",
            $borrowerId,
            $_POST['employerName'],
            $noOfYearsWorked,
            $_POST['position'],
            $_POST['phoneNoEmployer'],
            $_POST['salary'],
            $empAddressId
        );
        $employmentStmt->execute();

        // 5. Insert identification document
        if (isset($_FILES['idPhoto'])) {
            $idPhoto = uploadFile($_FILES['idPhoto'], 'id_photos');
            $idSql = "INSERT INTO identification_documents (borrower_id, id_type, id_no, 
                      expiry_date, id_photo_path) VALUES (?, ?, ?, ?, ?)";
            $idStmt = $db->prepare($idSql);
            $idStmt->bind_param(
                "issss",
                $borrowerId,
                $_POST['idType'],
                $_POST['idNo'],
                $_POST['expiryDate'],
                $idPhoto
            );
            $idStmt->execute();
        }

        // 6. Insert insurance details
        if (isset($_FILES['insurancePhoto'])) {
            $insuranceFile = uploadFile($_FILES['insurancePhoto'], 'insurance_files');
            $insuranceSql = "INSERT INTO insurance_details (borrower_id, insurance_provider, 
                            issued_date, expiry_date, insurance_file_path) 
                            VALUES (?, ?, ?, ?, ?)";
            $insuranceStmt = $db->prepare($insuranceSql);
            $insuranceStmt->bind_param(
                "issss",
                $borrowerId,
                $_POST['insuranceType'],
                $_POST['issuedDate'],
                $_POST['expiryDateInsurance'],
                $insuranceFile
            );
            $insuranceStmt->execute();
        }

        // 7. Insert dependent
        $dependentSql = "INSERT INTO dependents (borrower_id, name, contact_number_dependents) 
                        VALUES (?, ?, ?)";
        $dependentStmt = $db->prepare($dependentSql);
        $dependentStmt->bind_param(
            "iss",
            $borrowerId,
            $_POST['dependentName'],
            $_POST['dependentContactNo']
        );
        $dependentStmt->execute();

        // 8. Insert collateral files
        if (isset($_FILES['collateral'])) {
            foreach ($_FILES['collateral']['tmp_name'] as $key => $tmp_name) {
                if ($_FILES['collateral']['error'][$key] === 0) {
                    $collateralFile = uploadFile([
                        'name' => $_FILES['collateral']['name'][$key],
                        'type' => $_FILES['collateral']['type'][$key],
                        'tmp_name' => $tmp_name,
                        'error' => $_FILES['collateral']['error'][$key],
                        'size' => $_FILES['collateral']['size'][$key]
                    ], 'collateral_files');

                    $collateralSql = "INSERT INTO collateral_files (borrower_id, file_path) 
                                    VALUES (?, ?)";
                    $collateralStmt = $db->prepare($collateralSql);
                    $collateralStmt->bind_param("is", $borrowerId, $collateralFile);
                    $collateralStmt->execute();
                }
            }
        }

        $db->commit();
        $response['status'] = 'success';
        $response['message'] = 'Borrower added successfully';
        $response['borrower_id'] = $borrowerId;

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