document.addEventListener("DOMContentLoaded", function () {
  // Scroll to top of page
  window.scrollTo({ top: 0, behavior: "smooth" });

  const addbtn = document.getElementById("add-btn");
  let editbtn = document.getElementById("edit-btn");
  let deletebtn = document.getElementById("delete-btn");
  let inputText = document.querySelectorAll(".input-text");
  let confirmBtn = document.querySelector(".confirmBtn");
  let updateBtn = document.querySelector(".updateBtn");
  let collateralInput = document.getElementById("collateral");
  let collateralPreview = document.getElementById("collateral-preview");
  let radioBtn = document.querySelectorAll(".input-radio");
  let idPhotoInput = document.getElementById("idPhoto");
  let idPhotoPreview = document.getElementById("idPhotoPreview");
  let insurancePhotoInput = document.getElementById("insurancePhoto");
  let insurancePhotoPreview = document.getElementById("insurancePhotoPreview");
  let imgInput = document.querySelectorAll(".img-input");
  let profileDropdown = document.querySelector(".profile-dropdown");
  let arrowDownIcon = document.querySelector(".arrow-down-icon");
  const notificationIcon = document.querySelector(".notification-icon");
  const notificationDropdown = document.querySelector(".notification-dropdown");

  let transaction_table = document.querySelector(".table-container");
  const borrowerForm = document.querySelector(".form-container form");

  const zooming = new Zooming();
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
  // Close the dropdown if the user clicks outside of it
  window.addEventListener("click", function (event) {
    if (!event.target.closest(".notification")) {
      if (notificationDropdown.style.display === "block") {
        notificationDropdown.style.display = "none";
      }
    }
  });

  addbtn.addEventListener("click", function () {
    console.log("clicked add button");
    addbtn.innerText = addbtn.innerText === "Add" ? "Cancel" : "Add";
    inputText.forEach(
      (input) => (input.disabled = input.disabled ? false : true)
    );
    radioBtn.forEach(
      (input) => (input.disabled = input.disabled ? false : true)
    );
    imgInput.forEach(
      (input) => (input.disabled = input.disabled ? false : true)
    );
    inputText.forEach((input) => (input.value = ""));
    searchInput.value = "";
    radioBtn.forEach((input) => (input.checked = false));
    imgInput.forEach((input) => (input.value = ""));
    collateralPreview.innerHTML = "";
    idPhotoPreview.innerHTML = "";
    insurancePhotoPreview.innerHTML = "";
    confirmBtn.style.display =
      confirmBtn.style.display === "block" ? "none" : "block";
    console.log(addbtn.innerText);
    deletebtn.disabled = true;
    deletebtn.style = "background-color: #ccc; color: #fff;";
    editbtn.disabled = true;
    editbtn.style = "background-color: #ccc; color: #fff;";
  });

  // confirmBtn.addEventListener("click", function () {
  //   // Validation code here
  // });

  borrowerForm.addEventListener("submit", function (e) {
    e.preventDefault();
    console.log();
    Swal.fire({
      title: "Are you sure?",
      text: "You want to add this borrower?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, add it!",
    }).then((result) => {
      if (result.isConfirmed) {
        console.log("Adding borrower...");
        const formData = new FormData(borrowerForm);

        // Add files to FormData
        const idPhotoInput = document.getElementById("idPhoto");
        const insurancePhotoInput = document.getElementById("insurancePhoto");
        const collateralInput = document.getElementById("collateral");

        if (idPhotoInput.files[0]) {
          formData.append("idPhoto", idPhotoInput.files[0]);
        }

        if (insurancePhotoInput.files[0]) {
          formData.append("insurancePhoto", insurancePhotoInput.files[0]);
        }

        if (collateralInput.files.length > 0) {
          for (let i = 0; i < collateralInput.files.length; i++) {
            formData.append("collateral[]", collateralInput.files[i]);
          }
        }

        fetch("scripts/AJAX/add_borrower.php", {
          method: "POST",
          body: formData,
        })
          .then((response) => response.json())
          .then((data) => {
            if (data.status === "success") {
              Swal.fire({
                title: "Added!",
                text: "Borrower has been added successfully.",
                icon: "success",
                timer: 3000,
                didClose: () => {
                  // Scroll after the alert is closed
                  window.requestAnimationFrame(() => {
                    window.scrollTo({
                      top: 0,
                      behavior: "smooth",
                      duration: 2000,
                    });
                  });
                },
              }).then(() => {
                // Reset form
                borrowerForm.reset();

                // Scroll to top of page
                window.scrollTo({ top: 0, behavior: "smooth" });
                if (window.scrollY != 0) {
                  window.scrollTo({ top: 0 });
                }

                // Clear previews
                document.getElementById("idPhotoPreview").innerHTML = "";
                document.getElementById("insurancePhotoPreview").innerHTML = "";
                document.getElementById("collateral-preview").innerHTML = "";

                // Disable inputs
                const inputs = document.querySelectorAll(
                  ".input-text, .input-radio, .img-input, select"
                );
                inputs.forEach((input) => (input.disabled = true));

                // Reset buttons
                document.getElementById("add-btn").innerHTML = "Add";
                document.getElementById("edit-btn").disabled = true;
                document.getElementById("delete-btn").disabled = true;
                confirmBtn.style.display = "none";

                exit();
                // Scroll to top of page
                window.scrollTo({ top: 0, behavior: "smooth" });
              });
            } else {
              console.error("Error:", data.message);
              Swal.fire("Error!", data.message, "error");
            }
          })
          .catch((error) => {
            console.error("Error:", error);
            Swal.fire(
              "Error!",
              "An error occurred while adding the borrower.",
              "error"
            );
          });
      }
    });
  });

  idPhotoInput.addEventListener("change", function () {
    idPhotoPreview.innerHTML = "";
    const file = idPhotoInput.files[0];
    const reader = new FileReader();
    reader.onload = function (e) {
      const img = document.createElement("img");
      img.src = e.target.result;
      img.style.maxWidth = "200px";
      img.style.margin = "10px";
      img.classList.add("zoomable");
      idPhotoPreview.appendChild(img);
      zooming.listen(img);
    };
    reader.readAsDataURL(file);
  });

  insurancePhotoInput.addEventListener("change", function () {
    insurancePhotoPreview.innerHTML = "";
    const file = insurancePhotoInput.files[0];
    const reader = new FileReader();
    reader.onload = function (e) {
      const img = document.createElement("img");
      img.src = e.target.result;
      img.style.maxWidth = "200px";
      img.style.margin = "10px";
      img.classList.add("zoomable");
      insurancePhotoPreview.appendChild(img);
      zooming.listen(img);
    };
    reader.readAsDataURL(file);
  });

  collateralInput.addEventListener(
    "change",
    function () {
      collateralPreview.innerHTML = ""; // Clear previous previews
      const files = collateralInput.files;
      for (let i = 0; i < files.length; i++) {
        const file = files[i];
        const reader = new FileReader();
        reader.onload = function (e) {
          const img = document.createElement("img");
          img.src = e.target.result;
          img.style.maxWidth = "200px";
          img.style.margin = "10px";
          img.classList.add("zoomable");
          collateralPreview.appendChild(img);
          zooming.listen(img);
        };
        reader.readAsDataURL(file);
      }
    },
    false
  );

  // Javascript for the table
  const tableAllBtn = document.getElementById("tblAllBtn");
  let tableAddBtn = document.getElementById("addBtn");
  const tablePaymentBtn = document.getElementById("tblPaymentBtn");
  const tableLoanBtn = document.getElementById("tblLoanBtn");
  const tableGroceryBtn = document.getElementById("tblGroceryBtn");

  // Modals for Payment, Loan, and Grocery
  const paymentModal = document.getElementById("paymentModal");
  const loanModal = document.getElementById("loanModal");
  const groceryModal = document.getElementById("groceryModal");
  const closeModalButtons = document.querySelectorAll(".close-modal");
  const today = new Date().toISOString().split("T")[0];

  const customerType = document.getElementById("customerType");
  let interestRate = document.getElementById("interestRate");

  tableAllBtn.addEventListener("click", function () {
    tableAddBtn.style.display = "none";
    tableAllBtn.classList.add("active");
    tableLoanBtn.classList.remove("active");
    tableGroceryBtn.classList.remove("active");
    tablePaymentBtn.classList.remove("active");
  });
  tablePaymentBtn.addEventListener("click", function () {
    tableAddBtn.style.display = "block";
    tableAddBtn.innerHTML = "Add New Payment";
    tablePaymentBtn.classList.add("active");
    tableLoanBtn.classList.remove("active");
    tableGroceryBtn.classList.remove("active");
    tableAllBtn.classList.remove("active");
  });
  tableLoanBtn.addEventListener("click", function () {
    tableAddBtn.style.display = "block";
    tableAddBtn.innerHTML = "Add New Loan";
    tableLoanBtn.classList.add("active");
    tableGroceryBtn.classList.remove("active");
    tablePaymentBtn.classList.remove("active");
    tableAllBtn.classList.remove("active");
  });
  tableGroceryBtn.addEventListener("click", function () {
    tableAddBtn.style.display = "block";
    tableAddBtn.innerHTML = "Add New Grocery";
    tableGroceryBtn.classList.add("active");
    tableLoanBtn.classList.remove("active");
    tablePaymentBtn.classList.remove("active");
    tableAllBtn.classList.remove("active");
  });

  tableAddBtn.addEventListener("click", function () {
    console.log("Add new item");
    if (tableAddBtn.innerHTML === "Add New Payment") {
      paymentModal.style.display = "block";
    } else if (tableAddBtn.innerHTML === "Add New Loan") {
      loanModal.style.display = "block";
    } else if (tableAddBtn.innerHTML === "Add New Grocery") {
      groceryModal.style.display = "block";
    }
  });

  closeModalButtons.forEach((button) => {
    button.addEventListener("click", function () {
      console.log("Close modal");
      const modalId = button.getAttribute("data-modal");
      document.getElementById(modalId).style.display = "none";

      // Clear all inputs except submit and clear buttons
      const modalInputs = document.querySelectorAll(
        `#${modalId} input:not([type="submit"]):not([type="reset"]):not([type="date"])`
      );
      modalInputs.forEach((input) => (input.value = ""));

      // Reset select elements if any
      const modalSelects = document.querySelectorAll(`#${modalId} select`);
      modalSelects.forEach((select) => (select.selectedIndex = 0));
    });
  });

  customerType.addEventListener("change", function () {
    if (customerType.value === "Regular") {
      interestRate.disabled = true;
      interestRate.value = "7";
    } else if (customerType.value === "VIP") {
      interestRate.disabled = true;
      interestRate.value = "5";
    } else if (customerType.value === "Other") {
      interestRate.value = "";
      interestRate.placeholder = "Enter interest rate";
      interestRate.disabled = false;
    } else {
      interestRate.value = "0";
      interestRate.disabled = true;
    }
  });
  // Move the interest rate validation outside the change event
  interestRate.addEventListener("input", function () {
    const value = parseFloat(this.value);
    if (value > 100) {
      this.value = 100;
    } else if (value < 0) {
      this.value = 0;
    }
  });

  // Form validation
  const loanForm = document.querySelector("#loanModal form");
  // Update the loan form submission handler
  loanForm.addEventListener("submit", function (event) {
    event.preventDefault();
    const value = parseFloat(interestRate.value);

    if (value < 0 || value > 100) {
      Swal.fire({
        icon: "error",
        title: "Invalid Interest Rate",
        text: "Interest rate must be between 0% and 100%",
      });
      return;
    }
    console.log(originalValues);
    Swal.fire({
      icon: "warning",
      title: "Are you sure you want to add this loan?",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, add it!",
    }).then((result) => {
      if (result.isConfirmed) {
        const formData = new FormData(loanForm);

        // Add borrower ID from the search/selection
        if (originalValues && originalValues.id) {
          formData.append("borrowerId", originalValues.id);
        } else {
          Swal.fire({
            icon: "error",
            title: "Error!",
            text: "Please select a borrower first.",
          });
          return;
        }

        // Add promissory note if exists
        const promissoryNote = document.getElementById("promissoryNote");
        if (promissoryNote && promissoryNote.files[0]) {
          formData.append("promissoryNote", promissoryNote.files[0]);
        }

        fetch("scripts/AJAX/add_loan.php", {
          method: "POST",
          body: formData,
        })
          .then((response) => {
            if (!response.ok) throw new Error("Network response was not ok");
            return response.json();
          })
          .then((data) => {
            if (data.status === "success") {
              Swal.fire({
                icon: "success",
                title: "Success!",
                text: "Loan has been successfully added.",
                timer: 3000,
              }).then(() => {
                // Clear form and close modal
                loanForm.reset();
                document.getElementById("loanModal").style.display = "none";

                // Reset interest rate field
                interestRate.value = "";
                interestRate.disabled = true;

                // Reload table data without refreshing page
                // You'll need to implement this function
                updateTableData();
              });
            } else {
              throw new Error(data.message || "Failed to add loan");
            }
          })
          .catch((error) => {
            console.error("Error:", error);
            Swal.fire({
              icon: "error",
              title: "Error!",
              text: "An error occurred while adding the loan.",
            });
          });
      }
    });
  });

  // Set default date value to today
  document.getElementById("paymentDate").value = today;
  document.getElementById("loanDate").value = today;
  document.getElementById("groceryDate").value = today;

  // Start of AJAX Requests

  const searchInput = document.querySelector(".search-input");
  const searchBtn = document.querySelector(".search-btn");
  let searchResults = null;

  function createSearchResultsDropdown() {
    if (!searchResults) {
      searchResults = document.createElement("div");
      searchResults.className = "search-results-dropdown";
      document.querySelector(".search-container").appendChild(searchResults);
    }
    return searchResults;
  }

  function performSearch() {
    const searchTerm = searchInput.value.trim();
    if (searchTerm.length < 1) {
      if (searchResults) searchResults.style.display = "none";
      return;
    }

    fetch("scripts/AJAX/search.php", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: `search=${encodeURIComponent(searchTerm)}`,
    })
      .then((response) => response.json())
      .then((data) => {
        const dropdown = createSearchResultsDropdown();
        dropdown.innerHTML = "";

        if (data.status === "success" && data.data.length > 0) {
          data.data.forEach((user) => {
            const resultItem = document.createElement("div");
            resultItem.className = "search-result-item";
            resultItem.textContent = `${user.first_name} ${user.middle_name} ${user.surname}`;
            resultItem.addEventListener("click", () => {
              populateFormFields(user);
              addbtn.innerHTML = "Add";
              editbtn.innerHTML = "Edit";
              deletebtn.disabled = false;
              deletebtn.style = "color: white; background-color:red;";
              searchResults.style.display = "none";
              transaction_table.style.display = "block";
              searchInput.value = `${user.first_name} ${user.middle_name} ${user.surname}`;
            });
            dropdown.appendChild(resultItem);
          });
          dropdown.style.display = "block";
        } else {
          dropdown.innerHTML =
            '<div class="search-result-item">No results found</div>';
          dropdown.style.display = "block";
        }
      })
      .catch((error) => {
        console.error("Search error:", error);
      });
  }

  function populateFormFields(user) {
    // Populate personal information
    document.getElementById("fName").value = user.first_name;
    document.getElementById("mName").value = user.middle_name;
    document.getElementById("surname").value = user.surname;
    document.getElementById("suffix").value = user.suffix || "";

    // Set radio button for sex
    const sexRadio = document.querySelector(
      `input[name="sex"][value="${user.sex}"]`
    );
    if (sexRadio) sexRadio.checked = true;

    document.getElementById("DOB").value = user.dob;
    document.getElementById("maritalStatus").value = user.marital_status;
    document.getElementById("contactNo").value = user.contact_number;

    // Populate address
    document.getElementById("homeNo").value = user.home_no;
    document.getElementById("street").value = user.street;
    document.getElementById("baranggay").value = user.barangay;
    document.getElementById("city").value = user.city;
    document.getElementById("province").value = user.province;
    document.getElementById("region").value = user.region;

    // Populate identity
    document.getElementById("idType").value = user.id_type || "";
    document.getElementById("idNo").value = user.id_no;
    document.getElementById("expiryDate").value = user.expiry_date;
    if (user.id_photo_path) {
      const idPhotoPreview = document.getElementById("idPhotoPreview");
      idPhotoPreview.innerHTML = `<img src="images/uploads/${user.id_photo_path}" style="max-width: 200px; margin: 10px;" class="zoomable">`;
      const zoomable = idPhotoPreview.querySelector(".zoomable");
      if (zoomable) {
        zooming.listen(zoomable);
      }
    }

    // Populate Employer information
    document.getElementById("employerName").value = user.employer_name;
    document.getElementById("noOfYearsWorked").value = user.years_with_employer;
    document.getElementById("position").value = user.position;
    document.getElementById("phoneNoEmployer").value = user.employer_phone;
    document.getElementById("salary").value = user.salary;

    // Populate Employer Address
    document.getElementById("EmployerhomeNo").value = user.employer_home_no;
    document.getElementById("Employerstreet").value = user.employer_street;
    document.getElementById("Employerbaranggay").value = user.employer_barangay;
    document.getElementById("Employercity").value = user.employer_city;
    document.getElementById("Employerprovince").value = user.employer_province;
    document.getElementById("Employerregion").value = user.employer_region;

    // Populate Insurance Details
    document.getElementById("insuranceType").value = user.insurance_type || "";
    document.getElementById("issuedDate").value = user.issued_date;
    document.getElementById("expiryDateInsurance").value =
      user.insurance_expiry_date;
    if (user.insurance_file_path) {
      const insurancePhotoPreview = document.getElementById(
        "insurancePhotoPreview"
      );
      insurancePhotoPreview.innerHTML = `<img src="images/uploads/${user.insurance_file_path}" style="max-width: 200px; margin: 10px;" class="zoomable">`;
      const zoomable = insurancePhotoPreview.querySelector(".zoomable");
      if (zoomable) {
        zooming.listen(zoomable);
      }
    }
    document.getElementById("dependentName").value = user.dependent_name;
    document.getElementById("dependentContactNo").value =
      user.dependent_contact;

    // Populate Collateral Details

    if (user.collateral_files) {
      const collateralPreview = document.getElementById("collateral-preview");
      collateralPreview.innerHTML = ""; // Clear previous previews

      // Split the comma-separated string of file paths
      const collateralFiles = user.collateral_files.split(",");

      // Create image elements for each collateral file
      collateralFiles.forEach((filePath) => {
        const img = document.createElement("img");
        img.src = "images/uploads/" + filePath;
        img.style.maxWidth = "200px";
        img.style.margin = "10px";
        img.classList.add("zoomable");
        collateralPreview.appendChild(img);
        zooming.listen(img);
      });
    }

    //Disable all form inputs after population
    const inputs = document.querySelectorAll(
      ".input-text, .input-radio, .img-input"
    );
    inputs.forEach((input) => (input.disabled = true));

    // Store original values after populating
    originalValues = {
      id: user.id,
      fName: user.first_name,
      mName: user.middle_name,
      surname: user.surname,
      suffix: user.suffix || "",
      sex: user.sex,
      DOB: user.dob,
      maritalStatus: user.marital_status,
      contactNo: user.contact_number,
      home_no: user.home_no,
      street: user.street,
      baranggay: user.baranggay,
      city: user.city,
      province: user.province,
      region: user.region,
      idType: user.id_type || "",
      idNo: user.id_no,
      expiryDate: user.expiry_date,
      employer_name: user.employer_name,
      years_with_employer: user.years_with_employer,
      position: user.position,
      phone_no_employer: user.phone_no_employer,
      salary: user.salary,
      employer_home_no: user.employer_home_no,
      employer_street: user.employer_street,
      employer_baranggay: user.employer_barangay,
      employer_city: user.employer_city,
      employer_province: user.employer_province,
      employer_region: user.employer_region,
      insurance_type: user.insurance_type || "",
      issued_date: user.issued_date,
      insurance_expiry_date: user.insurance_expiry_date,
      dependent_name: user.dependent_name,
      dependent_contact_no: user.dependent_contact_no,
      collateral_files: user.collateral_files,
      id_photo: user.id_photo_path,
      insurance_file: user.insurance_file_path,
    };
    // Remove any existing event listeners from the edit button
    editbtn.removeEventListener("click", handleEditClick);

    // Add new event listener
    editbtn.addEventListener("click", handleEditClick);

    // Enable edit button
    editbtn.disabled = false;
    editbtn.style = "cursor:pointer; background-color: #4CAF50; color: white;";
    editbtn.innerHTML = "Edit";
  }

  function handleEditClick() {
    if (editbtn.innerHTML === "Edit") {
      // Enable all form inputs for editing
      const inputs = document.querySelectorAll(
        ".input-text, .input-radio, .img-input, select"
      );
      inputs.forEach((input) => (input.disabled = false));

      editbtn.innerHTML = "Cancel";
      editbtn.style =
        "cursor:pointer; background-color: #f44336; color: white;";
      addbtn.disabled = true;
      addbtn.style = "cursor:pointer; background-color: #ccc; color: white;";
      deletebtn.disabled = true;
      deletebtn.style = "cursor:pointer; background-color: #ccc; color: white;";
      updateBtn.style.display = "block";
    } else if (editbtn.innerHTML === "Cancel") {
      // Restore all original values
      Object.keys(originalValues).forEach((key) => {
        const element = document.getElementById(key);
        if (element) {
          if (element.type === "radio") {
            const radio = document.querySelector(
              `input[name="${key}"][value="${originalValues[key]}"]`
            );
            if (radio) radio.checked = true;
          } else if (element.tagName === "SELECT") {
            element.value = originalValues[key] || "";
          } else {
            element.value = originalValues[key] || "";
          }
        }
      });

      // Handle sex radio button specifically
      if (originalValues.sex) {
        const sexRadio = document.querySelector(
          `input[name="sex"][value="${originalValues.sex}"]`
        );
        if (sexRadio) sexRadio.checked = true;
      }

      // Restore photo previews
      if (originalValues.id_photo) {
        const idPhotoPreview = document.getElementById("idPhotoPreview");
        idPhotoPreview.innerHTML = `<img src="images/uploads/${originalValues.id_photo}" style="max-width: 200px; margin: 10px;" class="zoomable">`;
        const zoomable = idPhotoPreview.querySelector(".zoomable");
        if (zoomable) zooming.listen(zoomable);
      }

      if (originalValues.insurance_file) {
        const insurancePhotoPreview = document.getElementById(
          "insurancePhotoPreview"
        );
        insurancePhotoPreview.innerHTML = `<img src="images/uploads/${originalValues.insurance_file}" style="max-width: 200px; margin: 10px;" class="zoomable">`;
        const zoomable = insurancePhotoPreview.querySelector(".zoomable");
        if (zoomable) zooming.listen(zoomable);
      }

      if (originalValues.collateral_files) {
        const collateralPreview = document.getElementById("collateral-preview");
        collateralPreview.innerHTML = ""; // Clear previous previews

        // Split the comma-separated string of file paths
        const collateralFiles = originalValues.collateral_files.split(",");
        // Create image elements for each collateral file
        collateralFiles.forEach((filePath) => {
          const img = document.createElement("img");
          img.src = "images/uploads/" + filePath;
          img.style.maxWidth = "200px";
          img.style.margin = "10px";
          img.classList.add("zoomable");
          collateralPreview.appendChild(img);
          zooming.listen(img);
        });
      }

      console.log(originalValues);
      // Disable all inputs
      const inputs = document.querySelectorAll(
        ".input-text, .input-radio, .img-input, select"
      );
      inputs.forEach((input) => (input.disabled = true));

      // Reset edit button
      editbtn.innerHTML = "Edit";
      editbtn.style =
        "cursor:pointer; background-color: #4CAF50; color: white;";
      addbtn.disabled = false;
      addbtn.style = "cursor:pointer; background-color: #1E3E62; color: white;";
      deletebtn.disabled = false;
      deletebtn.style =
        "cursor:pointer; background-color: #f44336; color: white;";
      updateBtn.style.display = "none";
    }
  }
  // Update the updateBtn click handler:

  updateBtn.addEventListener("click", function (e) {
    e.preventDefault();

    Swal.fire({
      title: "Are you sure?",
      text: "You want to update this borrower's information?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, update it!",
    }).then((result) => {
      if (result.isConfirmed) {
        const formData = new FormData(borrowerForm);

        // Add existing file paths and ID
        formData.append("id", originalValues.id);
        formData.append("existing_id_photo", originalValues.id_photo || "");
        formData.append(
          "existing_insurance_file",
          originalValues.insurance_file || ""
        );
        formData.append(
          "existing_collateral_files",
          originalValues.collateral_files || ""
        );

        // Add new files if selected
        const idPhotoInput = document.getElementById("idPhoto");
        const insurancePhotoInput = document.getElementById("insurancePhoto");
        const collateralInput = document.getElementById("collateral");

        if (idPhotoInput.files[0]) {
          formData.append("idPhoto", idPhotoInput.files[0]);
        }

        if (insurancePhotoInput.files[0]) {
          formData.append("insurancePhoto", insurancePhotoInput.files[0]);
        }

        if (collateralInput.files.length > 0) {
          for (let i = 0; i < collateralInput.files.length; i++) {
            formData.append("collateral[]", collateralInput.files[i]);
          }
        }

        fetch("scripts/AJAX/edit_borrower.php", {
          method: "POST",
          body: formData,
        })
          .then((response) => {
            if (!response.ok) {
              throw new Error("Network response was not ok");
            }
            return response.json();
          })
          .then((data) => {
            if (data.status === "success") {
              Swal.fire({
                icon: "success",
                title: "Updated!",
                text: "Borrower information has been updated successfully.",
                timer: 3000,
                willClose: () => {
                  window.scrollTo({
                    top: 0,
                  });
                },
                didClose: () => {
                  // Scroll after the alert is closed
                  window.requestAnimationFrame(() => {
                    window.scrollTo({
                      top: 0,
                      behavior: "smooth",
                      duration: 2000,
                    });
                  });
                },
              }).then(() => {
                // Update originalValues with new data
                if (idPhotoInput.files[0]) {
                  originalValues.id_photo_path = data.id_photo_path;
                }
                if (insurancePhotoInput.files[0]) {
                  originalValues.insurance_file_path = data.insurance_file_path;
                }
                if (collateralInput.files.length > 0) {
                  originalValues.collateral_files = data.collateral_files;
                }

                // Disable inputs and reset buttons
                const inputs = document.querySelectorAll(
                  ".input-text, .input-radio, .img-input, select"
                );
                inputs.forEach((input) => (input.disabled = true));

                editbtn.innerHTML = "Edit";
                editbtn.style =
                  "cursor:pointer; background-color: #4CAF50; color: white;";
                addbtn.disabled = false;
                addbtn.style =
                  "cursor:pointer; background-color: #1E3E62; color: white;";
                deletebtn.disabled = false;
                deletebtn.style =
                  "cursor:pointer; background-color: #f44336; color: white;";
                updateBtn.style.display = "none";
              });
            } else {
              throw new Error(data.message || "Update failed");
            }
          })
          .catch((error) => {
            console.error("Error:", error);
            Swal.fire({
              icon: "error",
              title: "Error!",
              text: "An error occurred while updating the borrower information.",
            });
          });
      }
    });
  });

  // Add debounce to search
  function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
      const later = () => {
        clearTimeout(timeout);
        func(...args);
      };
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
    };
  }

  // Event listeners
  searchInput.addEventListener("input", debounce(performSearch, 300));
  searchBtn.addEventListener("click", performSearch);

  // Close search results when clicking outside
  document.addEventListener("click", (e) => {
    if (!e.target.closest(".search-container") && searchResults) {
      searchResults.style.display = "none";
    }
  });

  // Add delete button functionality
  deletebtn.addEventListener("click", function () {
    Swal.fire({
      title: "Are you sure?",
      text: "You won't be able to revert this!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#d33",
      cancelButtonColor: "#3085d6",
      confirmButtonText: "Yes, delete it!",
    }).then((result) => {
      if (result.isConfirmed) {
        // Get the selected user's ID from the originalValues
        const userId = originalValues.id;

        // Send delete request to server
        fetch("scripts/AJAX/delete_borrower.php", {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: `id=${userId}`,
        })
          .then((response) => response.json())
          .then((data) => {
            if (data.status === "success") {
              Swal.fire(
                "Deleted!",
                "User has been deleted.",
                "success",
                3000
              ).then(() => {
                // Clear form
                const form = document.querySelector("form");
                form.reset();

                // Clear previews
                document.getElementById("idPhotoPreview").innerHTML = "";
                document.getElementById("insurancePhotoPreview").innerHTML = "";
                document.getElementById("collateral-preview").innerHTML = "";

                // Disable buttons
                editbtn.disabled = true;
                deletebtn.disabled = true;
                deletebtn.style = "background-color: #ccc; color: #fff;";
                editbtn.style = "background-color: #ccc; color: #fff;";

                // Clear search input
                document.querySelector(".search-input").value = "";

                // Disable all inputs
                const inputs = document.querySelectorAll(
                  ".input-text, .input-radio, .img-input, select"
                );
                inputs.forEach((input) => (input.disabled = true));
              });
            } else {
              Swal.fire("Error!", "Failed to delete user.", "error");
            }
          })
          .catch((error) => {
            console.error("Delete error:", error);
            Swal.fire("Error!", "An error occurred while deleting.", "error");
          });
      }
    });
  });
});
