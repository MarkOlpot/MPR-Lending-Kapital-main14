<?php
session_start();

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    echo json_encode(['status' => 'error', 'message' => 'Unauthorized access']);
    exit();
}

// Include database connection
require_once 'scripts/AJAX/db_connect.php';

// Fetch the profile picture path for the logged-in user
$user_id = $_SESSION['user_id'];
$sql = "SELECT profile_picture FROM users WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

// Check if the user has a profile picture
$profilePicturePath = isset($user['profile_picture']) && !empty($user['profile_picture']) 
    ? $user['profile_picture'] 
    : 'uploads/defaultprof.jpg';

$stmt->close();

// Fetch audit logs
try {
    $category = isset($_GET['category']) ? $_GET['category'] : '';
    
    $sql = "SELECT 
            id,
            DATE_FORMAT(date, '%Y-%m-%d') as date,
            TIME_FORMAT(time, '%H:%i:%s') as time,
            performed_by,
            action,
            category,
            DATE_FORMAT(created_at, '%Y-%m-%d %H:%i:%s') as created_at
        FROM audit_logs";
    
    if (!empty($category)) {
        $sql .= " WHERE category = ?";
    }
    
    $sql .= " ORDER BY date DESC, time DESC";

    $stmt = $conn->prepare($sql);
    
    if (!empty($category)) {
        $stmt->bind_param("s", $category);
    }
    
    $stmt->execute();
    $result = $stmt->get_result();
    $logs = array();

    while ($row = $result->fetch_assoc()) {
        $logs[] = array(
            'id' => $row['id'],
            'date' => $row['date'],
            'time' => $row['time'],
            'performed_by' => $row['performed_by'],
            'action' => $row['action'],
            'category' => $row['category']
        );
    }

    if (isset($_SERVER['HTTP_X_REQUESTED_WITH'])) {
        header('Content-Type: application/json');
        echo json_encode([
            'status' => 'success',
            'data' => $logs
        ]);
        exit;
    }

} catch (Exception $e) {
    if (isset($_SERVER['HTTP_X_REQUESTED_WITH'])) {
        header('Content-Type: application/json');
        echo json_encode([
            'status' => 'error',
            'message' => 'Error fetching audit logs',
            'debug' => $e->getMessage()
        ]);
        exit;
    }
}

// Close the connection before HTML output
$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- CSS -->
    <link rel="stylesheet" href="styles/audit_logs.css">
    <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  
     <!-- Google Fonts -->
     <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Source+Serif+4:ital,opsz,wght@0,8..60,200..900;1,8..60,200..900&display=swap" rel="stylesheet">
    <!-- SweetAlert2 -->
     <script src="node_modules/sweetalert2/dist/sweetalert2.all.min.js"></script>
     <!-- Zooming -->
     <script src="node_modules/zooming/build/zooming.min.js"></script>
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

    <title>Dashboard</title>
</head>
<body>
<nav>
        <div class="dashboard-container">

            <div class="dashboard-header">
                <div class="logo-container">
                    <img src="images/dashboard.png" alt="Dashboard Logo">
                </div>
                <div class="dashboard-header-right">
                <div class="dashboard-header-right-content">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                            <path fill="currentColor" d="M3 13h8V3H3zm0 8h8v-6H3zm10 0h8V11h-8zm0-18v6h8V3z" />
                        </svg>
                        <p>Dashboard</p>
                    </div>
                    <div class="notification">
                    <div class="notification-icon">
                        <svg  xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                            <path fill="currentColor"
                                d="M12 22c1.1 0 2-.9 2-2h-4a2 2 0 0 0 2 2m6-6v-5c0-3.07-1.64-5.64-4.5-6.32V4c0-.83-.67-1.5-1.5-1.5s-1.5.67-1.5 1.5v.68C7.63 5.36 6 7.92 6 11v5l-2 2v1h16v-1z" />
                        </svg>
                        <p>Notification</p>
                    </div>
                    <div class="notification-dropdown">
                        <div class="notification-dropdown-content">
                            <p>No new notifications</p>
                            <a href="#">View all notifications</a>
                        </div>
                            
                    </div>
                </div>
                    <div class="profile">
                    <img src="<?php echo $profilePicturePath; ?>" alt="Profile Picture">
                        <div class="profile-dropdown">
                        <p>Welcome, <?php echo $_SESSION['fullname']; ?></p>
                        <div class="profile-dropdown-content">
                            <a href="profile.php">Profile</a>
                            <a href="manage_user_access.php">Manage User Access</a>
                            <a href="audit_logs.php">Audit Logs</a>
                            <a href="logout.php">Logout</a>

                        </div>
                    </div>
                    <svg class="arrow-down-icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                            <path fill="currentColor" d="M7.41 8.59L12 13.17l4.59-4.58L18 10l-6 6l-6-6z" />
                        </svg>
                </div>
            </div>
    </nav>


        

    <div class="audit-logs-header">
        <h1>Audit Logs</h1>
    </div>

    <div class="audit-logs-container">
        <div class="audit-logs-controls">
            <div class="dataTables_filter">
                <!-- DataTables search will be automatically inserted here -->
            </div>
            <div class="control-buttons">
                <button id="filter-audit-logs-btn" class="control-btn">
                    <i class="fas fa-filter"></i> Filter
                </button>
                <button id="export-audit-logs-btn" class="control-btn">
                    <i class="fas fa-file-export"></i> Export
                </button>
                <button id="print-audit-logs-btn" class="control-btn">
                    <i class="fas fa-print"></i> Print
                </button>
            </div>
        </div>
        <div class="audit-logs-table">
            <table id="auditLogsTable" class="display">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Performed By</th>
                        <th>Action</th>
                        <th>Category</th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>
    <script src="scripts/audit_logs.js"></script>
</body>

</html>