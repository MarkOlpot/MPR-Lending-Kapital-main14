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

  const loanAmount = document.getElementById('loanAmount');
  
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
    
    const formData = new FormData(loanForm);
    
    // Get raw value from loan amount
    const loanAmount = document.getElementById('loanAmount');
    if (loanAmount) {
        loanAmount.addEventListener('input', function() {
            formatNumber(this);
        });
    }    const rawValue = loanAmountInput.getAttribute('data-raw-value') || loanAmountInput.value.replace(/,/g, '');
    
    // Replace the formatted value with raw value
    formData.set('loanAmount', rawValue);

    // Validate loan amount
    if (isNaN(parseFloat(rawValue)) || parseFloat(rawValue) <= 0) {
        Swal.fire({
            icon: "error",
            title: "Invalid Amount",
            text: "Please enter a valid loan amount greater than 0"
        });
        return;
    }

    // Rest of your form submission code...
    fetch("scripts/AJAX/add_loan.php", {
        method: "POST",
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            return response.json().then(err => Promise.reject(err));
        }
        return response.json();
    })
    .then(data => {
        if (data.status === "success") {
            Swal.fire({
                icon: "success",
                title: "Success!",
                text: data.message,
                timer: 3000
            }).then(() => {
                loanForm.reset();
                document.getElementById("loanModal").style.display = "none";
                loadLoans(originalValues.id);
            });
        } else {
            throw new Error(data.message || "Failed to add loan");
        }
    })
    .catch(error => {
        console.error("Error:", error);
        Swal.fire({
            icon: "error",
            title: "Error!",
            text: error.message || "Failed to add loan. Please try again."
        });
    });
});
  loanAmount.addEventListener('input', function(e) {
    formatNumber(this);
});

  // Add this to your form submit handler
  loanForm.addEventListener("submit", function (event) {
    event.preventDefault();
    
    // Validate loan date
    const loanDate = document.getElementById('loanDate').value;
    if (!loanDate) {
        Swal.fire({
            icon: "error",
            title: "Invalid Date",
            text: "Please select a valid loan date"
        });
        return;
    }

    // ... rest of your existing form submission code ...
    
    const formData = new FormData(loanForm);
    
    // Log the date being sent
    console.log('Loan Date being sent:', formData.get('loanDate'));
    
    // ... rest of your fetch code ...
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

  // Modify the populateFormFields function to call loadLoans with borrower ID
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
    document.getElementById("insuranceType").value =
      user.insurance_provider || "";
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
      insurance_type: user.insurance_provider || "",
      issued_date: user.issued_date,
      insurance_expiry_date: user.insurance_expiry_date,
      dependent_name: user.dependent_name,
      dependent_contact_no: user.dependent_contact_no,
      collateral_files: user.collateral_files,
      id_photo: user.id_photo_path,
      insurance_file: user.insurance_file_path,
    };

    // Load loans for this specific borrower
    loadLoans(user.id);

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

  const groceryForm = document.getElementById('groceryForm');

  groceryForm.addEventListener('submit', function(event) {
      event.preventDefault();
      
      // Validate borrower selection
      if (!originalValues || !originalValues.id) {
          Swal.fire({
              icon: "error",
              title: "Error!",
              text: "Please select a borrower first."
          });
          return;
      }
  
      // Validate amount
      const amount = parseFloat(document.getElementById('groceryAmount').value);
      if (isNaN(amount) || amount <= 0) {
          Swal.fire({
              icon: "error",
              title: "Invalid Amount",
              text: "Please enter a valid amount greater than 0."
          });
          return;
      }
  
      const formData = new FormData(groceryForm);
      formData.append('borrowerId', originalValues.id);
  
      Swal.fire({
          title: "Are you sure?",
          text: "You want to add this grocery record?",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "Yes, add it!"
      }).then((result) => {
          if (result.isConfirmed) {
              fetch("scripts/AJAX/add_grocery.php", {
                  method: "POST",
                  body: formData
              })
              .then(response => response.json())
              .then(data => {
                  if (data.status === "success") {
                      Swal.fire({
                          icon: "success",
                          title: "Success!",
                          text: data.message,
                          timer: 3000
                      }).then(() => {
                          // Reset form and close modal
                          groceryForm.reset();
                          document.getElementById("groceryModal").style.display = "none";
                          // Update table data
                          loadLoans(originalValues.id);
                      });
                  } else {
                      throw new Error(data.message || "Failed to add grocery");
                  }
              })
              .catch(error => {
                  console.error("Error:", error);
                  Swal.fire({
                      icon: "error",
                      title: "Error!",
                      text: error.message || "Failed to add grocery. Please try again."
                  });
              });
          }
      });
  });
  
  // Add validation for grocery amount
  const groceryAmount = document.getElementById('groceryAmount');
  groceryAmount.addEventListener('input', function() {
      formatNumber(this);
      if (this.value < 0) {
          this.value = 0;
      }
  });
});
document.addEventListener("DOMContentLoaded", function () {
  const customerType = document.getElementById("customerType");
  const interestRate = document.getElementById("interestRate");
  const loanDate = document.getElementById("loanDate");
  const term = document.getElementById("term");
  const repaymentDate = document.getElementById("repaymentDate");
  
  // Enable interest rate input based on customer type
  customerType.addEventListener("change", function () {
      interestRate.disabled = false;
  });

  // Generate unique reference number
  function generateReferenceNo() {
      const timestamp = new Date().getTime();
      return "LN-" + timestamp;
  }

  // Auto-calculate repayment date
  function calculateRepaymentDate() {
      if (loanDate.value && term.value) {
          let loanDateObj = new Date(loanDate.value);
          loanDateObj.setMonth(loanDateObj.getMonth() + parseInt(term.value));
          repaymentDate.value = loanDateObj.toISOString().split("T")[0];
      }
  }

  term.addEventListener("input", calculateRepaymentDate);
  loanDate.addEventListener("input", calculateRepaymentDate);

  // When form submits, attach reference number
  document.querySelector("form").addEventListener("submit", function (e) {
      document.querySelector("form").insertAdjacentHTML(
          "beforeend",
          `<input type="hidden" name="reference_no" value="${generateReferenceNo()}">`
      );
  });

  loanForm.addEventListener("submit", function (event) {
    event.preventDefault();

    hiddenInput.type = 'hidden';
    hiddenInput.name = 'loanAmount';
    hiddenInput.value = rawValue;
    const rawValue = loanAmount.value.replace(/,/g, '');

    loanAmount.name = 'loanAmount_formatted';

    // Add the hidden input to the form
    this.appendChild(hiddenInput);

    // Validate loan date
    const loanDate = document.getElementById('loanDate').value;
    if (!loanDate) {
        Swal.fire({
            icon: "error",
            title: "Invalid Date",
            text: "Please select a valid loan date"
        });
        return;
    }

    // Format the date
    const formattedDate = new Date(loanDate).toISOString().split('T')[0];
    
    const formData = new FormData(loanForm);
    formData.set('loanDate', formattedDate); // Update the date in FormData

    console.log('Sending loan date:', formData.get('loanDate')); // Debug log

    // Rest of your form submission code...
    Swal.fire({
        icon: "warning",
        title: "Are you sure you want to add this loan?",
        // ... existing code ...
    }).then((result) => {
        if (result.isConfirmed) {
            fetch("scripts/AJAX/add_loan.php", {
                method: "POST",
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                console.log('Server response:', data); // Debug log
                // ... rest of your success handling ...
            })
            .catch(error => {
                console.error('Error:', error);
                // ... error handling ...
            });
        }
    });
});
});

// Add this function to load loans
function loadLoans(borrowerId) {
    if (!borrowerId) return;

    lazyLoadTable(borrowerId);

    fetch(`scripts/AJAX/get_loans.php?borrowerId=${borrowerId}&include_grocery=true`)
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                const tableBody = document.querySelector('#loansTable tbody');
                tableBody.innerHTML = '';

                data.data.forEach(item => {
                    const row = document.createElement('tr');
                    if (item.type === 'grocery') {
                      row.innerHTML = `
                      <td>${formatDate(item.loan_date)}</td>
                      <td>${item.reference_no}</td>
                      <td>${item.customer_type}</td>
                      <td>${formatDate(item.repayment_date)}</td>
                      <td>${formatCurrency(item.loan_amount)}</td>
                      <td>${item.interest_rate}%</td>
                      <td>${item.term_months} months</td>
                      <td><button class="view-button" 
                              onclick="viewPromissoryNote('${item.promissory_file_path}')"
                              ${item.promissory_file_path ? '' : 'disabled'}>
                          View
                      </button></td>
                      <td>${item.remarks || 'No remarks'}</td>
                      <td>${formatCurrency(item.balance)}</td>
                      <td><button onclick="handlePayment('${item.reference_no}')">Pay</button></td>
                  `;
                  
                    } else {
                        // Existing loan row format
                        row.innerHTML = `
                            <td>${formatDate(item.loan_date)}</td>
                            <td>${item.reference_no}</td>
                            <td>${item.customer_type}</td>
                            <td>${formatDate(item.repayment_date)}</td>
                            <td>${formatCurrency(item.loan_amount)}</td>
                            <td>${item.interest_rate}%</td>
                            <td>${item.term_months} months</td>
                            <td><button class="view-button" 
                                    onclick="viewPromissoryNote('${item.promissory_file_path}')"
                                    ${item.promissory_file_path ? '' : 'disabled'}>
                                View
                            </button></td>
                            <td>${item.remarks}</td>
                            <td>${formatCurrency(item.balance)}</td>
                            <td>$
                            <td><button onclick="handlePayment('${item.reference_no}')">Pay</button></td>
                        `;
                    }
                    tableBody.appendChild(row);
                });
            }
        })
        .catch(error => console.error('Error:', error));

    
}

// Helper function to handle lazy loading of table data
function lazyLoadTable(borrowerId) {
  if (!borrowerId) return;

  const tableBody = document.querySelector('#loansTable tbody');
  const loadingRow = document.createElement('tr');
  loadingRow.innerHTML = `
      <td colspan="11" class="text-center">
          <div class="loading-spinner">Loading...</div>
      </td>
  `;
  tableBody.appendChild(loadingRow);

  // Add debouncing to prevent multiple rapid requests
  clearTimeout(window.lazyLoadTimeout);
  window.lazyLoadTimeout = setTimeout(() => {
      fetch(`scripts/AJAX/get_loans.php?borrowerId=${borrowerId}&include_grocery=true`)
          .then(response => response.json())
          .then(data => {
              if (data.status === 'success') {
                  // Clear existing table content
                  tableBody.innerHTML = '';

                  // Populate with new data
                  data.data.forEach(item => {
                      const row = document.createElement('tr');
                      if (item.type === 'grocery') {
                          row.innerHTML = `
                              <td>${formatDate(item.grocery_date)}</td>
                              <td>${item.reference_no}</td>
                              <td>Grocery</td>
                              <td>N/A</td>
                              <td>${formatCurrency(item.grocery_amount)}</td>
                              <td>N/A</td>
                              <td>N/A</td>
                              <td>N/A</td>
                              <td>${item.remarks}</td>
                              <td>${formatCurrency(item.grocery_amount)}</td>
                              <td>
                                  <button class="pay-button" onclick="handlePayment('${item.reference_no}')">
                                      Pay
                                  </button>
                              </td>
                          `;
                      } else {
                          row.innerHTML = `
                              <td>${(item.created_at)}</td>
                              <td>${item.reference_no}</td>
                              <td>${item.customer_type}</td>
                              <td>${formatDate(item.repayment_date)}</td>
                              <td>${formatCurrency(item.loan_amount)}</td>
                              <td>${item.interest_rate}%</td>
                              <td>${item.term_months} months</td>
                              <td>
                                  <button class="view-button" onclick="viewPromissoryNote('${item.promissory_file_path}')"
                                  ${item.promissory_file_path ? '' : 'disabled'}>
                                      View
                                  </button>
                              </td>
                              <td>${item.remarks}</td>
                              <td>${formatCurrency(item.balance)}</td>
                              <td>
                                  <button class="pay-button" onclick="handlePayment('${item.reference_no}')">
                                      Pay
                                  </button>
                              </td>
                          `;
                      }
                      // Add fade-in animation
                      row.style.opacity = '0';
                      tableBody.appendChild(row);
                      setTimeout(() => {
                          row.style.transition = 'opacity 0.3s ease-in';
                          row.style.opacity = '1';
                      }, 10);
                  });
              }
          })
          .catch(error => {
              console.error('Error:', error);
              tableBody.innerHTML = `
                  <tr>
                      <td colspan="11" class="text-center text-danger">
                          Error loading data. Please try again.
                      </td>
                  </tr>
              `;
          });
  }, 300); // 300ms debounce delay
}


// Helper function to format dates
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
        month: '2-digit',
        day: '2-digit',
        year: 'numeric'
    });
}

// Helper function to format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-PH', {
        style: 'currency',
        currency: 'PHP'
    }).format(amount);
}

// Function to handle viewing promissory note
function viewPromissoryNote(filePath) {
    if (!filePath) {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'No promissory note file found'
        });
        return;
    }

    const modal = document.getElementById('promissoryNoteModal');
    const previewContainer = document.getElementById('promissoryNotePreview');
    const fileExtension = filePath.split('.').pop().toLowerCase();

    // Clear previous content
    previewContainer.innerHTML = '';

    // Create preview based on file type
    if (fileExtension === 'pdf') {
        previewContainer.innerHTML = `
             <div class="pdf-container">
                <iframe
                    src="images/uploads/promissory_notes/${filePath}"
                    type="application/pdf"
                    width="100%"
                    height="600px"
                    style="border: none;"
                ></iframe>
                <div class="pdf-controls">
                    <a href="images/uploads/promissory_notes/${filePath}" 
                       target="_blank" 
                       class="download-button">
                        Open in New Tab
                    </a>
                </div>
            </div>
        `;
    } else if (['jpg', 'jpeg', 'png'].includes(fileExtension)) {
        const img = document.createElement('img');
        img.src = `images/uploads/promissory_notes/${filePath}`;
        img.className = 'zoomable';
        previewContainer.appendChild(img);
        
        // Initialize zooming for images
        const zooming = new Zooming({
            bgColor: '#000',
            bgOpacity: 0.8,
            customSize: '100%'
        });
        zooming.listen(img);
    } else {
        previewContainer.innerHTML = `
            <div style="text-align: center; padding: 20px;">
                <p>File type not supported for preview.</p>
                <a href="${filePath}" 
                   target="_blank" 
                   class="view-button">
                    Download file instead
                </a>
            </div>
        `;
    }

    // Show the modal
    modal.style.display = 'block';

    // Close modal functionality
    const closeModal = () => {
        modal.style.display = 'none';
        previewContainer.innerHTML = ''; // Clear content when closing
    };

    // Close button handler
    const closeButton = modal.querySelector('.close-modal');
    closeButton.onclick = closeModal;

    // Debug logging
    console.log('Opening file:', filePath);
    console.log('File extension:', fileExtension);
}

// Function to handle payment
function handlePayment(referenceNo) {
    // Implement payment logic here
    console.log('Payment for loan:', referenceNo);
}


    
// Update loadLoans when a new loan is added
function updateTableData() {
    loadLoans();
}
function formatNumber(input) {
  // Remove existing commas and non-numeric characters (except decimal point)
  let value = input.value.replace(/[^\d.]/g, '');
  
  // Ensure only one decimal point
  let parts = value.split('.');
  if (parts.length > 2) {
      parts = [parts[0], parts.slice(1).join('')];
  }
  
  // Format whole number part with commas
  parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');
  
  // Limit decimal places to 2
  if (parts[1]) {
      parts[1] = parts[1].substring(0, 2);
  }
  
  // Update input value
  input.value = parts.join('.');
  
  // Store raw value in data attribute
  input.setAttribute('data-raw-value', value.replace(/,/g, ''));
}

const loanForm = document.querySelector("#loanForm");
const loanAmount = document.getElementById('loanAmount');

loanForm.addEventListener("submit", function(event) {
    event.preventDefault();
    
    // Validate borrower selection
    if (!originalValues || !originalValues.id) {
        Swal.fire({
            icon: "error",
            title: "Error!",
            text: "Please select a borrower first."
        });
        return;
    }

    const formData = new FormData(loanForm);
    formData.append('borrowerId', originalValues.id);

    // Get raw value from loan amount
    const rawValue = loanAmount.getAttribute('data-raw-value') || loanAmount.value.replace(/,/g, '');
    formData.set('loanAmount', rawValue);

    Swal.fire({
        title: "Are you sure?",
        text: "You want to add this loan?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, add it!"
    }).then((result) => {
        if (result.isConfirmed) {
            fetch("scripts/AJAX/add_loan.php", {
                method: "POST",
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(err => Promise.reject(err));
                }
                return response.json();
            })
            .then(data => {
                if (data.status === "success") {
                    Swal.fire({
                        icon: "success",
                        title: "Success!",
                        text: data.message,
                        timer: 3000
                    }).then(() => {
                        loanForm.reset();
                        document.getElementById("loanModal").style.display = "none";
                        loadLoans(originalValues.id);
                    });
                } else {
                    throw new Error(data.message || "Failed to add loan");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                Swal.fire({
                    icon: "error",
                    title: "Error!",
                    text: error.message || "Failed to add loan. Please try again."
                });
            });
        }
    });
});

// Format loan amount as user types
loanAmount.addEventListener('input', function() {
    formatNumber(this);
});

// Handle customer type change
customerType.addEventListener("change", function() {
    if (customerType.value === "Regular") {
        interestRate.disabled = true;
        interestRate.value = "7";
    } else if (customerType.value === "VIP") {
        interestRate.disabled = true;
        interestRate.value = "5";
    } else if (customerType.value === "Other") {
        interestRate.disabled = false;
        interestRate.value = "";
    }
});

// Add grocery amount formatting
const groceryAmount = document.getElementById('groceryAmount');
groceryAmount.addEventListener('input', function() {
    formatNumber(this);
});

// Update the grocery form submission
const groceryForm = document.getElementById('groceryForm');

groceryForm.addEventListener('submit', function(event) {
    event.preventDefault();
    
    // Validate borrower selection
    if (!originalValues || !originalValues.id) {
        Swal.fire({
            icon: "error",
            title: "Error!",
            text: "Please select a borrower first."
        });
        return;
    }

    // Get raw value from grocery amount
    const groceryAmountInput = document.getElementById('groceryAmount');
    const rawValue = groceryAmountInput.getAttribute('data-raw-value') || groceryAmountInput.value.replace(/,/g, '');

    if (isNaN(parseFloat(rawValue)) || parseFloat(rawValue) <= 0) {
        Swal.fire({
            icon: "error",
            title: "Invalid Amount",
            text: "Please enter a valid amount greater than 0."
        });
        return;
    }

    const formData = new FormData(groceryForm);
    formData.set('groceryAmount', rawValue); // Use raw value without commas
    formData.append('borrowerId', originalValues.id);

    Swal.fire({
        title: "Are you sure?",
        text: "You want to add this grocery record?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, add it!"
    }).then((result) => {
        if (result.isConfirmed) {
            fetch("scripts/AJAX/add_grocery.php", {
                method: "POST",
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === "success") {
                    Swal.fire({
                        icon: "success",
                        title: "Success!",
                        text: data.message,
                        timer: 3000
                    }).then(() => {
                        groceryForm.reset();
                        document.getElementById("groceryModal").style.display = "none";
                        loadLoans(originalValues.id);
                    });
                } else {
                    throw new Error(data.message || "Failed to add grocery");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                Swal.fire({
                    icon: "error",
                    title: "Error!",
                    text: error.message || "Failed to add grocery. Please try again."
                });
            });
        }
    });
});
// Replace the fetchNotifications function with this updated version

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