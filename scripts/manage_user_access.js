let profileDropdown = document.querySelector(".profile-dropdown");
let arrowDownIcon = document.querySelector(".arrow-down-icon");
let editProfileButton = document.getElementById("edit-profile-btn");
let saveProfileButton = document.getElementById("save-profile-btn");
let inputs = document.querySelectorAll(".inputs");
const zooming = new Zooming();
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
document.addEventListener("DOMContentLoaded", function () {
    // Handle Delete Button
    document.querySelectorAll(".delete-button").forEach(button => {
        button.addEventListener("click", function () {
            const userId = this.getAttribute("data-id");

            Swal.fire({
                title: "Are you sure?",
                text: "You won't be able to revert this!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#d33",
                cancelButtonColor: "#3085d6",
                confirmButtonText: "Yes, delete it!"
            }).then((result) => {
                if (result.isConfirmed) {
                    fetch("manage_user.php", {
                        method: "POST",
                        headers: { "Content-Type": "application/x-www-form-urlencoded" },
                        body: `action=delete&user_id=${userId}`
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.status === "success") {
                                Swal.fire("Deleted!", "User has been deleted.", "success")
                                    .then(() => location.reload());
                            } else {
                                Swal.fire("Error!", data.message, "error");
                            }
                        });
                }
            });
        });
    });

    // Handle Edit Button
    document.querySelectorAll(".edit-button").forEach(button => {
        button.addEventListener("click", function () {
            const row = this.closest("tr");
            const userId = this.getAttribute("data-id");
            const fullname = row.querySelector(".fullname").textContent;
            const email = row.querySelector(".email").textContent;

            Swal.fire({
                title: "Edit User",
                html: `
                    <input type="text" id="editFullname" class="swal2-input" value="${fullname}">
                    <input type="email" id="editEmail" class="swal2-input" value="${email}">
                `,
                showCancelButton: true,
                confirmButtonText: "Save Changes",
                preConfirm: () => {
                    const newFullname = document.getElementById("editFullname").value;
                    const newEmail = document.getElementById("editEmail").value;

                    return fetch("manage_user.php", {
                        method: "POST",
                        headers: { "Content-Type": "application/x-www-form-urlencoded" },
                        body: `action=edit&user_id=${userId}&fullname=${newFullname}&email=${newEmail}`
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.status === "success") {
                                Swal.fire("Updated!", "User details have been updated.", "success")
                                    .then(() => location.reload());
                            } else {
                                Swal.fire("Error!", data.message, "error");
                            }
                        });
                }
            });
        });
    });
});
document.addEventListener("DOMContentLoaded", function () {
    const addUserForm = document.getElementById("addUserForm");

    addUserForm.addEventListener("submit", function (e) {
        e.preventDefault();

        const formData = new FormData(addUserForm);

        fetch("add_user.php", {
            method: "POST",
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === "success") {
                Swal.fire({
                    title: "Success!",
                    text: data.message,
                    icon: "success"
                }).then(() => {
                    location.reload(); // Refresh the page to show the new user
                });
            } else {
                Swal.fire({
                    title: "Error!",
                    text: data.message,
                    icon: "error"
                });
            }
        })
        .catch(error => {
            Swal.fire({
                title: "Error!",
                text: "Something went wrong.",
                icon: "error"
            });
            console.error("Error:", error);
        });
    });
});
document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById("addUserModal");
    const openModalBtn = document.querySelector(".addbutton");
    const closeModalBtn = document.querySelector("#addUserModal .close");
    const form = document.getElementById("addUserForm");

    // Open modal
    openModalBtn.addEventListener("click", function () {
        modal.style.display = "block";
    });

    // Close modal when clicking "×"
    closeModalBtn.addEventListener("click", function () {
        modal.style.display = "none";
    });

    // Close modal when clicking outside of it
    window.addEventListener("click", function (event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });

    // Handle form submission (Prevent default)
    form.addEventListener("submit", function (event) {
        event.preventDefault();

        const formData = new FormData(form);

        fetch("add_user.php", {
            method: "POST",
            body: formData,
        })
            .then(response => response.json())
            .then(data => {
                if (data.status === "success") {
                    Swal.fire("Success", data.message, "success");
                    modal.style.display = "none";
                    form.reset();
                    setTimeout(() => location.reload(), 1000);
                } else {
                    Swal.fire("Error", data.message, "error");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                Swal.fire("Error", "Something went wrong!", "error");
            });
    });
});
document.addEventListener("DOMContentLoaded", function () {
    const searchInput = document.querySelector(".search-input");
    const searchResults = document.querySelector(".search-results-dropdown");

    function performSearch() {
        const searchTerm = searchInput.value.trim();
        if (searchTerm.length < 1) {
            searchResults.style.display = "none";
            return;
        }

        fetch("scripts/AJAX/search.php", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: `search=${encodeURIComponent(searchTerm)}`
        })
        .then(response => response.json())
        .then(data => {
            searchResults.innerHTML = "";
            if (data.status === "success" && data.data.length > 0) {
                data.data.forEach(user => {
                    const resultItem = document.createElement("div");
                    resultItem.className = "search-result-item";
                    resultItem.textContent = user.fullname;
                    resultItem.addEventListener("click", () => {
                        searchInput.value = user.fullname;
                        searchResults.style.display = "none";
                    });
                    searchResults.appendChild(resultItem);
                });
                searchResults.style.display = "block";
            } else {
                searchResults.innerHTML = '<div class="search-result-item">No results found</div>';
                searchResults.style.display = "block";
            }
        })
        .catch(error => console.error("Search error:", error));
    }

    searchInput.addEventListener("input", performSearch);
    document.addEventListener("click", (e) => {
        if (!searchResults.contains(e.target) && e.target !== searchInput) {
            searchResults.style.display = "none";
        }
    });
});
