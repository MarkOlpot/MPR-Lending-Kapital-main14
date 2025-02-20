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
