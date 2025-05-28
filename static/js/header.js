const countryInput = document.querySelector('#country');
const countryList = document.getElementById("country_list");
const countryIdField = document.getElementById("country_id");
const flagImage = document.getElementById("flagImage");
const successToast = document.getElementById("successToast");
const errorToast = document.getElementById("errorToast");

const toggleButtons = document.querySelectorAll(".toggle-password");

const registerStatus = document.getElementById("registerStatus");

const loginStatusField = document.getElementById("loginStatus");


// Initialize modal
const statusModal = new bootstrap.Modal(
  document.getElementById("loginStatusModal")
);

function showLoginStatus(status) {
  const statusAlert = document.getElementById("statusAlert");
  const statusTitle = document.getElementById("statusTitle");
  const statusMessage = document.getElementById("statusMessage");
  const statusIcon = document.getElementById("statusIcon");

  // Reset the classes
  statusAlert.className = "alert";

  // Configuring modal based on status
  switch (status) {
    case "error":
      statusAlert.classList.add("alert-danger");
      statusIcon.className = "status-icon fas fa-circle-xmark";
      statusTitle.textContent = "Login Error";
      statusMessage.textContent =
        "Invalid credentials or account error. Please check your email and password.";
      break;

    case "inactive":
      statusAlert.classList.add("alert-warning");
      statusIcon.className = "status-icon fas fa-clock";
      statusTitle.textContent = "Account Inactive";
      statusMessage.textContent =
        "Your account is currently inactive. Please contact support for assistance.";
      break;

    case "suspended":
      statusAlert.classList.add("alert-danger");
      statusIcon.className = "status-icon fas fa-ban";
      statusTitle.textContent = "Account Suspended";
      statusMessage.textContent =
        "Your account has been suspended. Please contact administration for more information.";
      break;

    case "failed":
      statusAlert.classList.add("alert-danger");
      statusIcon.className = "status-icon fas fa-triangle-exclamation";
      statusTitle.textContent = "Login Failed";
      statusMessage.textContent =
        "An unexpected error occurred. Please try again later.";
      break;

    default:
      return; // Don't show modal for unknown status
  }

  // Show modal
  statusModal.show();

  setTimeout(() => {
    statusModal.hide();
  }, 5000);
}

// Check for login status
const statusOfUser = loginStatusField.value;
if (statusOfUser && statusOfUser !== "") {
  showLoginStatus(statusOfUser);
}

// for pw showing
toggleButtons.forEach((button) => {
  button.addEventListener("click", function () {
    const passwordInput = document.getElementById(
      this.getAttribute("data-target")
    );
    const icon = this.querySelector("i");

    if (passwordInput.type === "password") {
      passwordInput.type = "text";
      icon.classList.replace("fa-eye", "fa-eye-slash");
    } else {
      passwordInput.type = "password";
      icon.classList.replace("fa-eye-slash", "fa-eye");
    }
  });
});

// for showing the flags
if (countryInput && countryList && countryIdField && flagImage) {
  countryInput.addEventListener("input", function () {
    let inputVal = this.value.toLowerCase().trim();
    let options = countryList.options;
    let found = false;

    for (let option of options) {
      if (option.value.toLowerCase() === inputVal) {
        countryIdField.value = option.getAttribute("data-id"); // Store country ID
        flagImage.src = option.getAttribute("data-flag"); // Set flag image
        flagImage.classList.remove("d-none"); // Show flag using Bootstrap class
        found = true;
        break;
      }
    }

    if (!found) {
      countryIdField.value = ""; // Reset if no match
      flagImage.classList.add("d-none"); // Hide flag
    }
  });
}

// For showing notification if registration status is set
if (registerStatus) {
  if (registerStatus.value === "true") {
    showNotification(successToast);
  } else if (registerStatus.value === "false") {
    showNotification(errorToast);
  }
}

// Function to show notifications
function showNotification(toast) {
  if (toast) {
    toast.classList.add("show");
    setTimeout(() => closeNotification(toast), 5000); // Auto-hide after 5s
  }
}

// Function to close notifications
function closeNotification(toast) {
  if (toast) {
    toast.classList.remove("show");
  }
}


document.addEventListener('DOMContentLoaded', function() {
  // Form validation functions
  function validateEmail(email) {
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      return emailRegex.test(email);
  }

  function validatePassword(password) {
      // At least 6 characters (letters or numbers)
      return password.length >= 3;
  }

  function validateRequired(value) {
      return value.trim() !== '';
  }

  function validateDOB(dob) {
      if (!dob) return false;
      const dobDate = new Date(dob);
      const today = new Date();
      return dobDate < today;
  }

  // Show error function
  function showError(field, message) {
    const errorElement = document.getElementById(field + '-error');
    const fieldElement = document.getElementById(field);
    if (errorElement) {
        errorElement.textContent = message;
        if (fieldElement) {
            fieldElement.classList.add('is-invalid');
            fieldElement.classList.remove('is-valid');
        } else if (field === 'gender') {
            document.querySelectorAll('input[name="gender"]').forEach(radio => {
                radio.classList.add('is-invalid');
                radio.classList.remove('is-valid');
            });
        }
    }
}


  function showSuccess(field) {
    const errorElement = document.getElementById(field + '-error');
    const fieldElement = document.getElementById(field);
    if (errorElement) {
        errorElement.textContent = '';
        if (fieldElement) {
            fieldElement.classList.remove('is-invalid');
            fieldElement.classList.add('is-valid');
        } else if (field === 'gender') {
            document.querySelectorAll('input[name="gender"]').forEach(radio => {
                radio.classList.remove('is-invalid');
                radio.classList.add('is-valid');
            });
        }
    }
}


  function setupFieldValidation(fieldId, validationFn, errorMsg) {
      const field = document.getElementById(fieldId);
      if (!field) return;

      // Clear error when user clicks into the field
      field.addEventListener('focus', function() {
          document.getElementById(fieldId + '-error').textContent = '';
          field.classList.remove('is-invalid');
      });

      // Validate when user clicks outside the field
      field.addEventListener('blur', function() {
          const isValid = validationFn(field.value);
          if (!isValid && field.value.trim() !== '') {
              showError(fieldId, errorMsg);
          } else if (field.value.trim() !== '') {
              showSuccess(fieldId);
          } else {
              document.getElementById(fieldId + '-error').textContent = '';
              field.classList.remove('is-invalid');
              field.classList.remove('is-valid');
          }
      });
  }

 
  // Login form validation
  const loginForm = document.getElementById('loginForm');
  if (loginForm) {
      setupFieldValidation('uemail', validateEmail, 'Please enter a valid email address');
      setupFieldValidation('password1', validatePassword, 'Password must be at least 3 characters');

      loginForm.addEventListener('submit', function(e) {
          e.preventDefault();
          let isValid = true;

          // Validate email
          const email = document.getElementById('uemail').value;
          if (!validateRequired(email)) {
              showError('uemail', 'Email is required');
              isValid = false;
          } else if (!validateEmail(email)) {
              showError('uemail', 'Please enter a valid email address');
              isValid = false;
          } else {
              showSuccess('uemail');
          }

          // Validate password
          const password = document.getElementById('password1').value;
          if (!validateRequired(password)) {
              showError('password1', 'Password is required');
              isValid = false;
          } else if (!validatePassword(password)) {
              showError('password1', 'Password must be at least 6 characters');
              isValid = false;
          } else {
              showSuccess('password1');
          }

          if (isValid) {
              // Form is valid, submit it
              this.submit();
          }
      });
  }

  // Registration form validation
  const registerForm = document.getElementById('registerForm');
  if (registerForm) {
      setupFieldValidation('name', validateRequired, 'Name is required');
      setupFieldValidation('email', validateEmail, 'Please enter a valid email address');
      setupFieldValidation('password2', validatePassword, 'Password must be at least 6 characters');
      setupFieldValidation('dob', validateDOB, 'Please enter a valid date of birth');
      setupFieldValidation('country', validateRequired, 'Country is required');

      // Handle country selection and flag display
      const countryInput = document.getElementById('country');
      const flagImage = document.getElementById('flagImage');
      const countryIdInput = document.getElementById('country_id');
      
      if (countryInput) {
          countryInput.addEventListener('input', function() {
              const selectedOption = Array.from(document.querySelectorAll('#country_list option'))
                  .find(option => option.value === this.value);
              
              if (selectedOption) {
                  const flagUrl = selectedOption.getAttribute('data-flag');
                  const countryId = selectedOption.getAttribute('data-id');
                  
                  if (flagUrl) {
                      flagImage.src = flagUrl;
                      flagImage.classList.remove('d-none');
                  } else {
                      flagImage.classList.add('d-none');
                  }
                  
                  if (countryId) {
                      countryIdInput.value = countryId;
                  }
                  
                  showSuccess('country');
              } else {
                  flagImage.classList.add('d-none');
                  countryIdInput.value = '';
              }
          });
      }

      registerForm.addEventListener('submit', function(e) {
          e.preventDefault();
          let isValid = true;

          // Validate name
          const name = document.getElementById('name').value;
          if (!validateRequired(name)) {
              showError('name', 'Name is required');
              isValid = false;
          } else {
              showSuccess('name');
          }

          // Validate email
          const email = document.getElementById('email').value;
          if (!validateRequired(email)) {
              showError('email', 'Email is required');
              isValid = false;
          } else if (!validateEmail(email)) {
              showError('email', 'Please enter a valid email address');
              isValid = false;
          } else {
              showSuccess('email');
          }

          // Validate password
          const password = document.getElementById('password2').value;
          if (!validateRequired(password)) {
              showError('password2', 'Password is required');
              isValid = false;
          } else if (!validatePassword(password)) {
              showError('password2', 'Password must be at least 6 characters');
              isValid = false;
          } else {
              showSuccess('password2');
          }

          // Validate DOB
          const dob = document.getElementById('dob').value;
          if (!validateRequired(dob)) {
              showError('dob', 'Date of birth is required');
              isValid = false;
          } else if (!validateDOB(dob)) {
              showError('dob', 'Please enter a valid date of birth');
              isValid = false;
          } else {
              showSuccess('dob');
          }

          // Validate gender
          const genderSelected = document.querySelector('input[name="gender"]:checked');
          if (!genderSelected) {
              showError('gender', 'Please select your gender');
              isValid = false;
          } else {
              showSuccess('gender');
          }

          // Validate country
          const country = document.getElementById('country').value;
          const countryId = document.getElementById('country_id').value;
          if (!validateRequired(country) || !validateRequired(countryId)) {
              showError('country', 'Please select a valid country');
              isValid = false;
          } else {
              showSuccess('country');
          }

          if (isValid) {
              // Form is valid, submit it
              this.submit();
          }
      });
  }

  // Add CSS for improved validation visual feedback
  const style = document.createElement('style');
  style.textContent = `
      .is-invalid {
          border-color: #dc3545 !important;
          background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' width='12' height='12' fill='none' stroke='%23dc3545'%3e%3ccircle cx='6' cy='6' r='4.5'/%3e%3cpath stroke-linejoin='round' d='M5.8 3.6h.4L6 6.5z'/%3e%3ccircle cx='6' cy='8.2' r='.6' fill='%23dc3545' stroke='none'/%3e%3c/svg%3e");
          background-repeat: no-repeat;
          background-position: right calc(0.375em + 0.1875rem) center;
          background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
          padding-right: calc(1.5em + 0.75rem) !important;
      }
      
      .is-valid {
          border-color: #198754 !important;
          background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3e%3cpath fill='%23198754' d='M2.3 6.73L.6 4.53c-.4-1.04.46-1.4 1.1-.8l1.1 1.4 3.4-3.8c.6-.63 1.6-.27 1.2.7l-4 4.6c-.43.5-.8.4-1.1.1z'/%3e%3c/svg%3e");
          background-repeat: no-repeat;
          background-position: right calc(0.375em + 0.1875rem) center;
          background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
          padding-right: calc(1.5em + 0.75rem) !important;
      }
      
      .error-message {
          display: block;
          margin-top: 0.25rem;
          font-size: 0.875em;
          transition: all 0.3s ease;
      }
      
      .form-control:focus {
          box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
      }
      
      .form-control.is-invalid:focus {
          box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);
      }
      
      .form-control.is-valid:focus {
          box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);
      }
      
      /* Smooth transitions */
      .form-control {
          transition: border-color 0.3s ease, box-shadow 0.3s ease, background-image 0.3s ease;
      }
  `;
  document.head.appendChild(style);
});
