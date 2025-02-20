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

notificationIcon.addEventListener("click", function () {
  notificationDropdown.style.display =
    notificationDropdown.style.display === "block" ? "none" : "block";
});

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
