let profileDropdown = document.querySelector('.profile-dropdown');
let arrowDownIcon = document.querySelector('.arrow-down-icon'); 
let editProfileButton = document.getElementById('edit-profile-btn');
let saveProfileButton = document.getElementById('save-profile-btn');
let inputs = document.querySelectorAll('.inputs');
const zooming = new Zooming();
const notificationIcon = document.querySelector('.notification-icon');
const notificationDropdown = document.querySelector('.notification-dropdown');
let dashboardHeader = document.querySelector(".dashboard-header-right-content");

let profilePicturePreview = document.getElementById('profile-picture-preview');
let profilePictureUpload = document.getElementById('profile-picture-upload');
let uploadConfirmBtn = document.getElementById('upload-profile-btn');
let uploadCancelBtn = document.getElementById('cancel-upload-profile-btn');

// Handle profile dropdown interaction
profileDropdown.addEventListener('mouseover', function(){
    arrowDownIcon.style.transform = 'rotate(180deg)';
    arrowDownIcon.style.transition = 'transform 0.5s ease';
});

profileDropdown.addEventListener('mouseout', function(){
    arrowDownIcon.style.transform = 'rotate(0deg)';
    arrowDownIcon.style.transition = 'transform 0.5s ease';
});

// Toggle notification dropdown
notificationIcon.addEventListener('click', function() {
    notificationDropdown.style.display = notificationDropdown.style.display === 'block' ? 'none' : 'block';
});

// Close the notification dropdown when clicking outside
window.addEventListener('click', function(event) {
    if (!event.target.closest('.notification')) {
        if (notificationDropdown.style.display === 'block') {
            notificationDropdown.style.display = 'none';
        }
    }
});

// Zooming for profile picture
zooming.listen('#profile-picture-preview');

// Handle profile picture upload and preview
profilePictureUpload.addEventListener('change', function() {
    const file = profilePictureUpload.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            profilePicturePreview.src = e.target.result;
        };
        reader.readAsDataURL(file);
        zooming.listen('#profile-picture-preview');
    }

    uploadConfirmBtn.disabled = false;
    uploadConfirmBtn.style.backgroundColor = '#1E3E62';
    uploadCancelBtn.style.display = 'block';
});

// Cancel the profile picture upload
uploadCancelBtn.addEventListener('click', function() {
    profilePicturePreview.src = '';
    uploadConfirmBtn.disabled = true;
    uploadConfirmBtn.style.backgroundColor = '#c1c1c1';
    uploadCancelBtn.style.display = 'none';
});

// Enable edit profile form
editProfileButton.addEventListener('click', function() {
    editProfileButton.innerHTML = editProfileButton.innerHTML === 'Edit Profile' ? 'Cancel' : 'Edit Profile';
    editProfileButton.style.backgroundColor = (editProfileButton.innerHTML === 'Cancel') ? '#FF0000' : '#1E3E62';
    saveProfileButton.disabled = (editProfileButton.innerHTML !== 'Cancel');
    saveProfileButton.style.backgroundColor = (editProfileButton.innerHTML === 'Cancel') ? '#1E3E62' : '#c1c1c1';
    inputs.forEach(input => input.disabled = (editProfileButton.innerHTML !== 'Cancel'));
});

// Save profile changes
saveProfileButton.addEventListener('click', function() {
    // Submit the form when saving profile
    document.getElementById('profile-form').submit();
});

dashboardHeader.addEventListener("click", function () {
    window.location.href = "dashboard.php";
});

function fetchNotifications(showAll = false) {
    fetch('scripts/AJAX/notification.php')
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                const notificationDropdown = document.querySelector('.notification-dropdown-content');
                
                if (data.count > 0) {
                    // Update notification icon to show count
                    const notificationCount = document.createElement('span');
                    notificationCount.className = 'notification-count';
                    notificationCount.textContent = data.count;
                    document.querySelector('.notification-icon').appendChild(notificationCount);

                    // Clear existing notifications
                    notificationDropdown.innerHTML = '';

                    // Determine how many notifications to show
                    const notificationsToShow = showAll ? data.notifications : data.notifications.slice(0, 3);

                    // Add notifications
                    notificationsToShow.forEach(notification => {
                        const notifItem = document.createElement('div');
                        notifItem.className = 'notification-item';
                        
                        // Add urgency class based on days remaining
                        if (notification.days_remaining <= 7) {
                            notifItem.classList.add('urgent');
                        } else if (notification.days_remaining <= 14) {
                            notifItem.classList.add('warning');
                        }
                        
                        notifItem.innerHTML = `
                            <p>${notification.message}</p>
                            <small>${notification.type}</small>
                        `;
                        notificationDropdown.appendChild(notifItem);
                    });

                    // Add "View More" button if there are more than 3 notifications
                    if (!showAll && data.notifications.length > 3) {
                        const viewMoreBtn = document.createElement('div');
                        viewMoreBtn.className = 'view-more-btn';
                        viewMoreBtn.innerHTML = `
                            <button>
                                View More (${data.notifications.length - 3} more)
                            </button>
                        `;
                        viewMoreBtn.addEventListener('click', () => {
                            fetchNotifications(true);
                        });
                        notificationDropdown.appendChild(viewMoreBtn);
                    }

                    // Add "Show Less" button when showing all notifications
                    if (showAll && data.notifications.length > 3) {
                        const showLessBtn = document.createElement('div');
                        showLessBtn.className = 'view-more-btn';
                        showLessBtn.innerHTML = '<button>Show Less</button>';
                        showLessBtn.addEventListener('click', () => {
                            fetchNotifications(false);
                        });
                        notificationDropdown.appendChild(showLessBtn);
                    }
                } else {
                    notificationDropdown.innerHTML = '<p>No new notifications</p>';
                }
            }
        })
        .catch(error => console.error('Error:', error));
}

// Call fetchNotifications when page loads and every 5 minutes
document.addEventListener('DOMContentLoaded', function() {
    fetchNotifications();
    setInterval(fetchNotifications, 300000); // 5 minutes
});