let currentSort = "newest";
let post_date = document.getElementById("post_date");
let replyForm = document.querySelector("#replyForm");
let image = document.querySelector("#image");
const noRepliesContainer = document.getElementById("noRepliesMessage");
const loginPrompt = document.getElementById("loginPrompt");

console.log("Post ID:", postId); // Check if it's undefined

function formatDate(dateString) {
  const date = new Date(dateString);

  const options = {
    year: "numeric",
    month: "long",
    day: "numeric",
    hour: "numeric",
    minute: "2-digit",
    hour12: true,
    timeZone: "Asia/Kolkata",
  };

  return date.toLocaleString("en-IN", options).replace(",", " at"); // Proper IST format
}

if (post_date) {
  post_date.textContent = formatDate(post_date.textContent);
}

function setImageModal(imagePath) {
  let modalImage = document.getElementById("modalImage");
  modalImage.src = imagePath;
  new bootstrap.Modal(document.getElementById("imageModal")).show(); // Force modal to open
}

document.getElementById("image").addEventListener("change", function (e) {
  const fileInfo = document.getElementById("file-info");
  const fileName = document.getElementById("file-name");

  if (this.files.length > 0) {
    fileName.textContent = this.files[0].name;
    fileInfo.classList.remove("d-none");
  } else {
    fileInfo.classList.add("d-none");
  }
});

document.getElementById("clear-file").addEventListener("click", function () {
  const fileInput = document.getElementById("image");
  fileInput.value = ""; // Clears file input
  document.getElementById("file-info").classList.add("d-none");
});

function toggleSave(button) {
  const icon = button.querySelector("i");
  if (icon.classList.contains("far")) {
    icon.classList.replace("far", "fas");
    button.innerHTML = '<i class="fas fa-bookmark"></i> Saved';
  } else {
    icon.classList.replace("fas", "far");
    button.innerHTML = '<i class="far fa-bookmark"></i> Save';
  }
}

replyForm.addEventListener("submit", function (e) {
  e.preventDefault();

  if (!postId) {
    showToast("Error: Post ID not found in URL", "danger");
    return;
  }

  let formData = new FormData(this);
  formData.append("post_id", postId);

  if (image.files.length > 0) {
    formData.append("image", image.files[0]);
  }

  fetch("save_reply.do", {
    method: "post",
    body: formData,
  })
    .then((response) => response.text())
    .then((data) => {
      if (data === "true") {
        showToast("Reply saved successfully!", "success");
        replyForm.reset();
        fetchReplies();
      } else if (data === "expired") {
        showToast("Session expired. Please login again.", "warning");
      } else {
        showToast("Error while saving reply. Try again.", "danger");
      }
    })
    .catch((error) => {
      console.error("Error:", error);
      showToast("An error occurred while submitting your reply.", "danger");
    });
});

async function fetchReplies() {
  try {
    document.getElementById("repliesContainer").innerHTML =
      '<div class="text-center py-3">' +
      '<div class="spinner-border text-primary" role="status">' +
      '<span class="visually-hidden">Loading...</span>' +
      "</div>" +
      "</div>";

    const response = await fetch(
      "collect_replies.do?post_id=" + postId + "&sort=" + currentSort
    );
    if (!response.ok) throw new Error("HTTP error! Status: " + response.status);

    const data = await response.text();
    if (data === "expired") {
      window.location.href = "index.do";
      return;
    }
    if (data === "invalid_post_id") {
      showToast("Invalid post ID.", "danger");
      return;
    }

    const responseData = JSON.parse(data);
    document.getElementById("replyCount").textContent =
      responseData.replyCount || 0;
    console.log(responseData.replies);
    displayReplies(responseData.replies);
  } catch (error) {
    console.error("Error fetching replies:", error);
    showToast("Failed to load replies. Please try again later.", "danger");
  }
}
fetchReplies();

function displayReplies(replies) {
  const container = document.getElementById("repliesContainer");
  container.innerHTML = "";

  if (!replies || replies.length === 0) {
    container.appendChild(noRepliesContainer);
    noRepliesContainer.classList.remove("d-none");
    return;
  }
  noRepliesContainer.classList.add("d-none");

  replies.forEach((reply) => {
    const replyElement = createReplyElement(reply);
    container.appendChild(replyElement);
  });
}

function createReplyElement(reply) {
  const replyDiv = document.createElement("div");
  replyDiv.className = "reply-item mb-4 pb-3 border-bottom";
  replyDiv.dataset.replyId = reply.reply_id;

  let replyHTML =
    '<div class="d-flex justify-content-between align-items-start mb-3">' +
    '<div class="d-flex align-items-center">' +
    '<img src="' +
    (reply.user_profile_pic || "static/images/avatars/default.jpg") +
    '" alt="User Avatar" class="user-avatar me-3">' +
    "<div>" +
    '<div class="fw-bold fs-6">' +
    reply.username +
    ' <i class="fas fa-check-circle text-primary" style="font-size: 12px;"></i></div>' +
    '<div class="text-muted small">' +
    formatDate(reply.post_date) +
    "</div>" +
    "</div>" +
    "</div>" +
    '<div class="dropdown">' +
    '<button class="btn btn-sm p-0 text-muted dropdown-toggle no-caret" type="button" id="replyOptions' +
    reply.reply_id +
    '" data-bs-toggle="dropdown" style="transition:none;">' +
    '<i class="fas fa-ellipsis-v"></i>' +
    "</button>" +
    '<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="replyOptions' +
    reply.reply_id +
    '">';

  if (userId == reply.user_id || userRole === "moderator") {
    replyHTML +=
      '<li><button class="dropdown-item" onclick="deleteReply(' +
      reply.reply_id +
      ')"><i class="fas fa-trash-alt me-2 text-danger"></i>Delete</button></li>';
  }

  replyHTML +=
    '<li><button class="dropdown-item" onclick="reportSpam(' +
    reply.reply_id +
    ')"><i class="fas fa-flag me-2 text-warning"></i>Mark As Spam</button></li>' +
    "</ul>" +
    "</div>" +
    "</div>" +
    '<div class="reply-content mb-3">' +
    "<p>" +
    reply.description +
    "</p>" +
    "</div>" +
    (reply.reply_pic
      ? '<div class="reply-image mb-3 text-center">' +
        '<img src="' +
        reply.reply_pic +
        '" alt="Reply Image" class="img-fluid rounded" style="max-height: 300px;">' +
        "</div>"
      : "") +
    '<div class="d-flex justify-content-between align-items-center">' +
    '<div class="btn-group">' +
    '<button class="btn btn-sm btn-outline-success" onclick="checkSessionAndVote(' +
    reply.reply_id +
    ", 'up', this)\">" +
    '<i class="fas fa-thumbs-up"></i> <span class="vote-count">' +
    (reply.like_count || 0) +
    "</span>" +
    "</button>" +
    '<button class="btn btn-sm btn-outline-danger" onclick="checkSessionAndVote(' +
    reply.reply_id +
    ", 'down', this)\">" +
    '<i class="fas fa-thumbs-down"></i> <span class="vote-count">' +
    (reply.dislike_count || 0) +
    "</span>" +
    "</button>" +
    "</div>" +
    "</div>";

  replyDiv.innerHTML = replyHTML;

  return replyDiv;
}
async function voteReply(reply_id, voteType, buttonElement) {
  try {
    buttonElement.disabled = true;

    const response = await fetch(
      "vote_reply.do?reply_id=" + reply_id + "&voteType=" + voteType,
      {
        method: "post",
      }
    );

    const newCount = await response.text();

    if (newCount !== "error") {
      // Update the vote count display
      const voteCountSpan = buttonElement.querySelector(".vote-count");
      voteCountSpan.textContent = newCount;
    } else {
      // Handle any error case (e.g., log or show a message)
      console.error("Failed to update vote count.");
    }
  } catch (error) {
    console.error("Error:", error);
  } finally {
    // Re-enable the button after 2 seconds
    setTimeout(() => {
      buttonElement.disabled = false;
    }, 2000);
  }
}

function checkSessionAndVote(reply_id, voteType, button) {
    if (userSession && userSession.trim() !== '') {
        voteReply(reply_id, voteType, button);
    } else {
        Swal.fire({
            title: "Login Required",
            text: "Please login to vote on replies",
            icon: "warning",
            timer:3000,
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Login Now",
            cancelButtonText: "Cancel"
        }).then((result) => {
            if (result.isConfirmed) {
                const loginModalElement = document.getElementById("login_modal");
                const loginModal = new bootstrap.Modal(loginModalElement);
                if (loginModal) {
                    loginModal.show;
                }
            }
        });
    }
}
function setupSortDropdown() {
  const sortItems = document.querySelectorAll(".dropdown-item[data-sort]");
  const sortButton = document.getElementById("sortDropdown");

  sortItems.forEach((item) => {
    item.addEventListener("click", function (e) {
      e.preventDefault();

      currentSort = this.getAttribute("data-sort");
      let sortText = "Newest";
      if (currentSort === "oldest") sortText = "Oldest";
      if (currentSort === "most_liked") sortText = "Most Liked";

      sortButton.innerHTML = "Sort by: " + sortText;
      fetchReplies();
    });
  });
}

setupSortDropdown();

function showToast(message, type) {
  const toastContainer = document.getElementById("toastContainer");

  const toast = document.createElement("div");
  toast.className = "toast align-items-center text-bg-" + type + " border-0";
  toast.setAttribute("role", "alert");
  toast.setAttribute("aria-live", "assertive");
  toast.setAttribute("aria-atomic", "true");

  toast.innerHTML =
    '<div class="d-flex">' +
    '<div class="toast-body">' +
    message +
    "</div>" +
    '<button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>' +
    "</div>";

  toastContainer.appendChild(toast);

  const bsToast = new bootstrap.Toast(toast);
  bsToast.show();

  setTimeout(() => {
    toast.remove();
  }, 3000);
}

