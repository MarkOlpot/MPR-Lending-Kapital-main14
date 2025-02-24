<?php
header('Content-Type: application/json');
session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $searchTerm = $_POST['search'];
    $response = array();

    try {
        // Database connection
        $db = new mysqli('localhost', 'root', '', 'lendingdb');

        if ($db->connect_error) {
            throw new Exception('Connection Failed: ' . $db->connect_error);
        }

        // Search query with JOINs to get all related data
        $sql = "SELECT 
            b.*,
            a.home_no, a.street, a.barangay, a.city, a.province, a.region,
            ed.employer_name, ed.years_with_employer, ed.position, 
            ed.phone_no as employer_phone, ed.salary,
            ea.home_no as employer_home_no, ea.street as employer_street, 
            ea.barangay as employer_barangay, ea.city as employer_city,
            ea.province as employer_province, ea.region as employer_region,
            id.id_type, id.id_no, id.expiry_date, id.id_photo_path,
            ins.insurance_provider, ins.issued_date, ins.expiry_date as insurance_expiry_date,
            ins.insurance_file_path,
            d.name as dependent_name, d.contact_number_dependents as dependent_contact,
            GROUP_CONCAT(cf.file_path) as collateral_files
        FROM borrowers b
        LEFT JOIN addresses a ON b.address_id = a.id
        LEFT JOIN employment_details ed ON b.id = ed.borrower_id
        LEFT JOIN addresses ea ON ed.address_id = ea.id
        LEFT JOIN identification_documents id ON b.id = id.borrower_id
        LEFT JOIN insurance_details ins ON b.id = ins.borrower_id
        LEFT JOIN dependents d ON b.id = d.borrower_id
        LEFT JOIN collateral_files cf ON b.id = cf.borrower_id
        WHERE 
            b.id LIKE ? OR 
            b.first_name LIKE ? OR 
            b.middle_name LIKE ? OR
            b.surname LIKE ?
        GROUP BY b.id";

        $searchPattern = "%$searchTerm%";
        $stmt = $db->prepare($sql);
        $stmt->bind_param(
            "ssss",
            $searchPattern,
            $searchPattern,
            $searchPattern,
            $searchPattern
        );

        $stmt->execute();
        $result = $stmt->get_result();

        $borrowers = array();
        while ($row = $result->fetch_assoc()) {
            // Format dates
            $row['dob'] = date('Y-m-d', strtotime($row['dob']));
            if ($row['expiry_date']) {
                $row['expiry_date'] = date('Y-m-d', strtotime($row['expiry_date']));
            }
            if ($row['insurance_expiry_date']) {
                $row['insurance_expiry_date'] = date('Y-m-d', strtotime($row['insurance_expiry_date']));
            }
            if ($row['issued_date']) {
                $row['issued_date'] = date('Y-m-d', strtotime($row['issued_date']));
            }

            // // Format numbers
            // $row['loan_balance'] = number_format((float) $row['loan_balance'], 2, '.', '');
            // if ($row['salary']) {
            //     $row['salary'] = number_format((float) $row['salary'], 2, '.', '');
            // }

            $borrowers[] = $row;
        }

        $response['status'] = 'success';
        $response['data'] = $borrowers;

    } catch (Exception $e) {
        $response['status'] = 'error';
        $response['message'] = $e->getMessage();
    }

    if (isset($stmt)) {
        $stmt->close();
    }
    if (isset($db)) {
        $db->close();
    }

    echo json_encode($response);
    exit();
}

?>
