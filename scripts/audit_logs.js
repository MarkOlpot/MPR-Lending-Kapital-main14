let profileDropdown = document.querySelector(".profile-dropdown");
let arrowDownIcon = document.querySelector(".arrow-down-icon");
let editProfileButton = document.getElementById("edit-profile-btn");
let saveProfileButton = document.getElementById("save-profile-btn");
const notificationIcon = document.querySelector(".notification-icon");
const notificationDropdown = document.querySelector(".notification-dropdown");

let dashboardHeader = document.querySelector(".dashboard-header-right-content");

profileDropdown.addEventListener("mouseover", function () {
  console.log("hovered");
  arrowDownIcon.style.transform = "rotate(180deg)";
  arrowDownIcon.style.transition = "transform 0.5s ease";
});

profileDropdown.addEventListener("mouseout", function () {
  arrowDownIcon.style.transform = "rotate(0deg)";
  arrowDownIcon.style.transition = "transform 0.5s ease";
});

// Remove or comment out the existing notification click handler
// notificationIcon.addEventListener("click", function () {
//   notificationDropdown.style.display =
//     notificationDropdown.style.display === "block" ? "none" : "block";
// });

dashboardHeader.addEventListener("click", function () {
  window.location.href = "dashboard.php";
});
// Close the dropdown if the user clicks outside of it
window.addEventListener("click", function (event) {
  if (!event.target.closest(".notification")) {
    if (notificationDropdown.style.display === "block") {
      notificationDropdown.style.display = "none";
    }
  }
});
$(document).ready(function() {
    // Add filter dropdown HTML after the filter button
    $('#filter-audit-logs-btn').after(`
        <div class="category-filter-dropdown" style="display: none; position: absolute; background: white; box-shadow: 0 2px 4px rgba(0,0,0,0.2); border-radius: 4px; padding: 8px; z-index: 1000;">
            <select id="categoryFilter" style="width: 200px; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                <option value="">All Categories</option>
                <option value="Admin Activity Log">Admin Activity Log</option>
                <option value="Search Terms">Search Terms</option>
                <option value="Borrower Management Logs">Borrower Management Logs</option>
                <option value="Loan Management Logs">Loan Management Logs</option>
            </select>
        </div>
    `);

    // Initialize DataTable
    const auditTable = $('#auditLogsTable').DataTable({
        ajax: {
            url: 'audit_logs.php',
            dataSrc: 'data'
        },
        columns: [
            { 
                data: 'date',
                render: function(data) {
                    return moment(data).format('MMMM DD, YYYY');
                }
            },
            { 
                data: 'time',
                render: function(data) {
                    return moment(data, 'HH:mm:ss').format('hh:mm:ss A');
                }
            },
            { data: 'performed_by' },
            { data: 'action' },
            { data: 'category' }
        ],
        order: [[0, 'desc'], [1, 'desc']],
        responsive: true,
        pageLength: 10,
        dom: '<"top"<"search-container"f><"button-container">>rt<"bottom"lip>',
        language: {
            search: "_INPUT_",
            searchPlaceholder: "Search audit logs..."
        },
        initComplete: function() {
            // Move the buttons to the custom button container
            $('.button-container').append($('#filter-audit-logs-btn'));
            $('.button-container').append($('#export-audit-logs-btn'));
            $('.button-container').append($('#print-audit-logs-btn'));
            
            // Add custom class to search input
            $('.dataTables_filter input')
                .addClass('audit-search-input')
                .attr('style', 'width: 400px !important; height: 40px !important');
        }
    });

    // Add custom filtering function
    $.fn.dataTable.ext.search.push(
        function(settings, data, dataIndex) {
            const selectedCategory = $('#categoryFilter').val();
            const rowCategory = data[4]; // Category is the 5th column (index 4)
            
            if (!selectedCategory || selectedCategory === '') {
                return true;
            }
            
            return rowCategory === selectedCategory;
        }
    );

    // Toggle filter dropdown
    $('#filter-audit-logs-btn').on('click', function(e) {
        e.stopPropagation();
        $('.category-filter-dropdown').toggle();
    });

    // Handle category filter change
    $('#categoryFilter').on('change', function() {
        auditTable.draw();
    });

    // Close dropdown when clicking outside
    $(document).on('click', function(e) {
        if (!$(e.target).closest('.category-filter-dropdown, #filter-audit-logs-btn').length) {
            $('.category-filter-dropdown').hide();
        }
    });

    // Add some CSS for the dropdown
    $('<style>')
        .text(`
            .category-filter-dropdown {
                margin-top: 40px;
                right: 160px;
            }
            #categoryFilter:focus {
                outline: none;
                border-color: #4CAF50;
            }
        `)
        .appendTo('head');

    // Filter button functionality
    $('#filter-audit-logs-btn').on('click', function() {
        // Implement filter logic here
    });

    // Export button functionality
    $('#export-audit-logs-btn').on('click', function() {
        // Create a CSV export
        let csvContent = "data:text/csv;charset=utf-8,";
        
        // Add headers
        const headers = ['Date', 'Time', 'Performed By', 'Action', 'Category'];
        csvContent += headers.join(",") + "\n";
        
        // Add data
        auditTable.data().each(function(row) {
            const rowData = [
                moment(row.date).format('YYYY-MM-DD'),
                row.time,
                row.performed_by,
                row.action,
                row.category
            ];
            csvContent += rowData.join(",") + "\n";
        });
        
        // Create download link
        const encodedUri = encodeURI(csvContent);
        const link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", "audits.csv");
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    });

    // Print button functionality
    $('#print-audit-logs-btn').on('click', function() {
        window.print();
    });

    // Refresh table every 30 seconds
    setInterval(function() {
        auditTable.ajax.reload(null, false);
    }, 30000);
});
// Add this at the beginning of your file
function fetchNotifications() {
    fetch('scripts/AJAX/notification.php')
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                const notificationDropdown = document.querySelector('.notification-dropdown-content');
                const notificationIcon = document.querySelector('.notification-icon');
                
                // Update notification count
                let countElement = document.querySelector('.notification-count');
                const unreadCount = data.notifications.length; // Changed to total notifications
                
                if (unreadCount > 0) {
                    if (!countElement) {
                        countElement = document.createElement('span');
                        countElement.className = 'notification-count';
                        notificationIcon.appendChild(countElement);
                    }
                    countElement.textContent = unreadCount;
                } else if (countElement) {
                    countElement.remove();
                }

                // Update notification content
                if (data.notifications.length > 0) {
                    notificationDropdown.innerHTML = data.notifications
                        .map(notification => `
                            <div class="notification-item ${notification.days_remaining <= 7 ? 'urgent' : 
                                   notification.days_remaining <= 14 ? 'warning' : ''}">
                                <div class="notification-content">
                                    <p>${notification.message}</p>
                                    <div class="notification-meta">
                                        <span class="notification-type">${notification.type}</span>
                                    </div>
                                </div>
                            </div>
                        `).join('');
                } else {
                    notificationDropdown.innerHTML = '<p class="no-notifications">No new notifications</p>';
                }
            }
        })
        .catch(error => console.error('Error:', error));
}

// Remove or comment out these functions
// function markNotificationAsRead(notificationId) {...}

// Update the DOMContentLoaded event listener
document.addEventListener('DOMContentLoaded', function() {
    const notificationIcon = document.querySelector('.notification-icon');
    
    // Toggle notification dropdown
    notificationIcon.addEventListener('click', function(e) {
        e.stopPropagation();
        const dropdown = document.querySelector('.notification-dropdown');
        dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
    });

    // Close dropdown when clicking outside
    document.addEventListener('click', function(e) {
        if (!e.target.closest('.notification')) {
            document.querySelector('.notification-dropdown').style.display = 'none';
        }
    });

    // Initial load and refresh
    fetchNotifications();
    setInterval(fetchNotifications, 30000); // Refresh every 30 seconds
});