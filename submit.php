<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Database connection
    $conn = new mysqli("localhost", "root", "", "lendingdb");

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Capture and escape form data to prevent SQL injection
    $fName = mysqli_real_escape_string($conn, $_POST['fName']);
    $mName = mysqli_real_escape_string($conn, $_POST['mName']);
    $surname = mysqli_real_escape_string($conn, $_POST['surname']);
    $suffix = mysqli_real_escape_string($conn, $_POST['suffix']);
    $sex = mysqli_real_escape_string($conn, $_POST['sex']);
    $DOB = mysqli_real_escape_string($conn, $_POST['DOB']);
    $maritalStatus = mysqli_real_escape_string($conn, $_POST['maritalStatus']);
    $contactNo = mysqli_real_escape_string($conn, $_POST['contactNo']);
    $homeNo = mysqli_real_escape_string($conn, $_POST['homeNo']);
    $street = mysqli_real_escape_string($conn, $_POST['street']);
    $baranggay = mysqli_real_escape_string($conn, $_POST['baranggay']);
    $city = mysqli_real_escape_string($conn, $_POST['city']);
    $province = mysqli_real_escape_string($conn, $_POST['province']);
    $region = mysqli_real_escape_string($conn, $_POST['region']);
    $idType = mysqli_real_escape_string($conn, $_POST['idType']);
    $idNo = mysqli_real_escape_string($conn, $_POST['idNo']);
    $expiryDate = mysqli_real_escape_string($conn, $_POST['expiryDate']);
    $employerName = mysqli_real_escape_string($conn, $_POST['employerName']);
    $noOfYearsWorked = mysqli_real_escape_string($conn, $_POST['noOfYearsWorked']);
    $position = mysqli_real_escape_string($conn, $_POST['position']);
    $phoneNoEmployer = mysqli_real_escape_string($conn, $_POST['phoneNoEmployer']);
    $salary = mysqli_real_escape_string($conn, $_POST['salary']);

    // Employer Address
    $employerHomeNo = mysqli_real_escape_string($conn, $_POST['homeNo']);
    $employerStreet = mysqli_real_escape_string($conn, $_POST['street']);
    $employerBaranggay = mysqli_real_escape_string($conn, $_POST['baranggay']);
    $employerCity = mysqli_real_escape_string($conn, $_POST['city']);
    $employerProvince = mysqli_real_escape_string($conn, $_POST['province']);
    $employerRegion = mysqli_real_escape_string($conn, $_POST['region']);

    // Insurance Details
    $insuranceType = mysqli_real_escape_string($conn, $_POST['insuranceType']);
    $issuedDate = mysqli_real_escape_string($conn, $_POST['issuedDate']);
    $insuranceExpiryDate = mysqli_real_escape_string($conn, $_POST['expiryDate']);

    // Dependent Details
    $dependentName = mysqli_real_escape_string($conn, $_POST['dependentName']);
    $dependentContactNo = mysqli_real_escape_string($conn, $_POST['dependentContactNo']);

    // Format customer name for folder naming (sanitize to avoid invalid characters)
    $customerFolder = preg_replace("/[^a-zA-Z0-9]/", "_", $fName . "_" . $surname);
    $customerDir = "uploads/$customerFolder/";

    // Create customer folder if it doesn't exist
    if (!file_exists($customerDir)) {
        mkdir($customerDir, 0777, true);
    }

    // Function to handle file uploads
    function uploadFile($file, $prefix, $customerDir)
    {
        if ($file['error'] === UPLOAD_ERR_OK) {
            $fileName = $prefix . "_" . basename($file['name']); // Append prefix to file name
            $filePath = $customerDir . $fileName;
            move_uploaded_file($file['tmp_name'], $filePath);
            return $filePath; // Return the saved file path
        }
        return "";
    }

    // Handle ID photo upload
    $idPhotoPath = isset($_FILES['idPhoto']) ? uploadFile($_FILES['idPhoto'], "ID", $customerDir) : "";

    // Handle insurance file upload
    $insuranceFilePath = isset($_FILES['uploadInsurance']) ? uploadFile($_FILES['uploadInsurance'], "Insurance", $customerDir) : "";

    // Handle collateral file uploads (multiple files)
    $collateralFiles = [];
    if (isset($_FILES['collateral'])) {
        foreach ($_FILES['collateral']['name'] as $key => $filename) {
            $collateralFile = [
                'name' => $filename,
                'tmp_name' => $_FILES['collateral']['tmp_name'][$key],
                'error' => $_FILES['collateral']['error'][$key]
            ];
            $collateralFilePath = uploadFile($collateralFile, "Collateral_" . ($key + 1), $customerDir);
            if ($collateralFilePath) {
                $collateralFiles[] = $collateralFilePath;
            }
        }
    }

    // Insert data into the database
    $sql = "INSERT INTO borrowers (first_name, middle_name, surname, suffix, sex, dob, marital_status, contact_number, home_no, street, baranggay, city, province, region, id_type, id_no, expiry_date, id_photo, employer_name, years_with_employer, position, phone_no_employer, salary, employer_home_no, employer_street, employer_baranggay, employer_city, employer_province, employer_region, insurance_type, insurance_issued_date, insurance_expiry_date, insurance_file, dependent_name, dependent_contact_no, collateral_files)
            VALUES ('$fName', '$mName', '$surname', '$suffix', '$sex', '$DOB', '$maritalStatus', '$contactNo', '$homeNo', '$street', '$baranggay', '$city', '$province', '$region', '$idType', '$idNo', '$expiryDate', '$idPhotoPath', '$employerName', '$noOfYearsWorked', '$position', '$phoneNoEmployer', '$salary', '$employerHomeNo', '$employerStreet', '$employerBaranggay', '$employerCity', '$employerProvince', '$employerRegion', '$insuranceType', '$issuedDate', '$insuranceExpiryDate', '$insuranceFilePath', '$dependentName', '$dependentContactNo', '" . implode(',', $collateralFiles) . "')";

    if ($conn->query($sql) === TRUE) {
        echo "<script type='text/javascript'>
                if (confirm('New customer added successfully! Would you like to add another customer?')) {
                    window.location.href = 'dashboard.php';
                } else {
                    window.location.href = 'dashboard.php';
                }
              </script>";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    // Close the connection
    $conn->close();
}
?>