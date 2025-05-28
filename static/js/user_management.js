const promoteModal = new bootstrap.Modal(document.getElementById("promoteModal"));
const toastMessage = document.getElementById('toastMessage');

const searchInput = document.getElementById("searchInput");
const roleFilter = document.getElementById("roleFilter");

const sendPromotionBtn = document.getElementById("sendPromotionBtn");

function filterUsers() {
    const searchTerm = searchInput.value.toLowerCase();
    const roleValue = roleFilter.value;

    const rows = document.querySelectorAll("#userTable tbody tr");

    rows.forEach((row) => {
        const name = row
            .querySelector("td:nth-child(2)")
            .textContent.toLocaleLowerCase();
        const role = row
            .querySelector("td:nth-child(3)")
            .textContent.toLocaleLowerCase();

        let roleMatch = true;
        if (roleValue != "all") {
            roleMatch = role.includes(roleValue.toLowerCase());
        }

        const nameMatch = name.includes(searchTerm);

        if (nameMatch && roleMatch) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });
}
searchInput.addEventListener("input", filterUsers);
roleFilter.addEventListener("change", filterUsers);

// Format date helper
function formatDate(dateString) {
    const options = { year: "numeric", month: "short", day: "numeric" };
    return new Date(dateString).toLocaleDateString(undefined, options);
}

// Update activity summary
function updateActivitySummary() {
    const totalUsers = users.length;
    const activeUsers = users.filter((u) => u.status === "Active").length;
    const moderators = users.filter((u) => u.role === "Moderator").length;
    const pending = users.filter((u) => u.status === "Pending").length;

    document.getElementById("totalUsersCount").textContent = totalUsers;
    document.getElementById("activeUsersCount").textContent = activeUsers;
    document.getElementById("moderatorsCount").textContent = moderators;
    document.getElementById("pendingCount").textContent = pending;
}

// Open Promote Modal
function openPromoteModal(userId) {
    fetch("getUserDetails.do?userId=" + userId)
        .then((response) => response.json())
        .then((user) => {
            if (user.error) {
                alert(user.error);
                return;
            }

            // Continue populating modal if user is valid
            document.getElementById("emailTo").value = user.email;
            document.getElementById("emailUsername").innerText = user.name;
            document.getElementById("emailQuestions").innerText = user.questionCount;
            document.getElementById("emailReplies").innerText = user.replyCount;
            sendPromotionBtn.setAttribute("data-user-id", userId);
            promoteModal.show();
        });
};


// returns a Promise<boolean>
function showConfirm(message) {
    return new Promise((resolve) => {
      Swal.fire({
        title: '<i class="fas fa-question-circle me-2"></i>Please Confirm',
        html: `<p class="mb-0 text-dark">${message}</p>`,
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: '<i class="fas fa-check me-1"></i>Yes',
        cancelButtonText: '<i class="fas fa-times me-1"></i>Cancel',
        confirmButtonColor: '#2563eb', // bg-blue-600
        cancelButtonColor: '#f8f9fa', // btn-light
        cancelButtonTextColor: '#212529',
        customClass: {
          popup: 'shadow-lg rounded-lg',
          header: 'border-0',
          confirmButton: 'bg-blue-600 hover:bg-blue-700 border-0',
          cancelButton: 'text-dark'
        },
        buttonsStyling: true,
        reverseButtons: true,
        focusConfirm: false,
        focusCancel: true,
        backdrop: true,
        allowOutsideClick: () => !Swal.isLoading()
      }).then((result) => {
        resolve(result.isConfirmed);
      });
    });
}
  
async function banUser(userId) {
    if (!await showConfirm('Are you sure you want to ban this user?')) return;

    try {
        const res = await fetch(`user_action.do?action=ban&userId=${userId}`, { method:'POST' });
        const data = await res.json();
        if (data.success) {
            // Store the message in sessionStorage before reload
            sessionStorage.setItem('actionMessage', 'User has been banned successfully');
            location.reload();
        } else {
            // Use SweetAlert for errors instead of alert()
            Swal.fire('Error', 'Failed to ban user: ' + (data.error || 'Unknown error'), 'error');
        }
    } catch (e) {
        console.error(e);
        Swal.fire('Error', 'Error banning user.', 'error');
    }
}

async function unbanUser(userId) {
    if (!await showConfirm('Are you sure you want to unban this user?')) return;

    try {
        const res = await fetch(`user_action.do?action=unban&userId=${userId}`, { method:'POST' });
        const data = await res.json();
        if (data.success) {
            // Store the message in sessionStorage before reload
            sessionStorage.setItem('actionMessage', 'User has been unbanned successfully');
            location.reload();
        } else {
            // Use SweetAlert for errors instead of alert()
            Swal.fire('Error', 'Failed to unban user: ' + (data.error || 'Unknown error'), 'error');
        }
    } catch (e) {
        console.error(e);
        Swal.fire('Error', 'Error unbanning user.', 'error');
    }
}

function checkForActionMessages() {
    const actionMessage = sessionStorage.getItem('actionMessage');
    if (actionMessage) {
        sessionStorage.removeItem('actionMessage');

        // Show SweetAlert2 toast
        Swal.fire({
            toast: true,
            position: 'top-end', // top-end is nice for action toasts
            icon: 'success',
            title: actionMessage,
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer);
                toast.addEventListener('mouseleave', Swal.resumeTimer);
            }
        });
    }
}


// Make sure to call this when the page loads
document.addEventListener('DOMContentLoaded', checkForActionMessages);

sendPromotionBtn.addEventListener("click", async function () {
    const userId = this.getAttribute("data-user-id");

    // Close the modal immediately
    const promoteModal = bootstrap.Modal.getInstance(
        document.getElementById("promoteModal")
    );
    promoteModal.hide();

    // Show loading SweetAlert
    Swal.fire({
        title: 'Sending Invitation...',
        text: 'Please wait while we send the promotion invite.',
        allowOutsideClick: false,
        allowEscapeKey: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });

    try {
        // Send AJAX request
        const response = await fetch(`user_action.do?action=promote&userId=${userId}`, {
            method: "POST",
        });

        const data = await response.json();

        if (data.success) {
            // Find the user row
            let userRow = document.querySelector(`tr[data-user-id="${userId}"]`);

            if (!userRow) {
                const allRows = document.querySelectorAll("table tbody tr");
                allRows.forEach((row) => {
                    const firstCell = row.querySelector("td:first-child");
                    if (firstCell && firstCell.textContent.trim() === userId) {
                        userRow = row;
                    }
                });
            }

            if (userRow) {
                // Update only the status cell
                const statusCell = userRow.querySelector("td:last-child");
                if (statusCell) {
                    statusCell.innerHTML =
                        '<span class="badge badge-pending rounded-pill px-3 py-1">Pending Promotion</span>';
                }
            }

            // Show success SweetAlert
            Swal.fire({
                icon: 'success',
                title: 'Invitation Sent!',
                text: 'The user has been invited for promotion.',
                showConfirmButton: true,
                confirmButtonColor: '#3085d6',
                confirmButtonText: 'OK'
            });

        } else {
            // Show error SweetAlert
            Swal.fire({
                icon: 'error',
                title: 'Failed!',
                text: data.message || 'Could not send the invitation. Please try again.',
                showConfirmButton: true,
                confirmButtonColor: '#d33',
                confirmButtonText: 'OK'
            });
        }
    } catch (error) {
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: 'Something went wrong. Please check your connection and try again.',
            showConfirmButton: true,
            confirmButtonColor: '#d33',
            confirmButtonText: 'OK'
        });
    }
});

// Function to handle resending invitation
function resendInvitation(userId) {
    fetch("user_action.do?action=resendPromote&userId=" + userId, {
        method: "POST",
    })
        .then((response) => response.json())
        .then((data) => {
            if (data.success) {
                // Show success message
                document.getElementById("toastMessage").innerText =
                    "Promotion invitation resent successfully";
                const actionToast = bootstrap.Toast.getInstance(
                    document.getElementById("actionToast")
                );
                actionToast.show();
            }
        });
}