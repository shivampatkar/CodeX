let addMore = document.querySelector('#addMore');
let additionalFields = document.querySelector('#additionalFields');

addMore.addEventListener('click', () => {
    let addFields = document.createElement("div");
    addFields.classList.add("mb-3", "extra-field");

    addFields.innerHTML = `
            <label class="form-label">Additional Description</label>
            <textarea class="form-control mb-2" rows="3" name="descriptions" placeholder="Add more details"></textarea>
            <input type="file" class="form-control mb-2" name="images" accept="image/*">
            <button type="button" class="btn btn-danger btn-sm removeField">Remove</button>
        `;
        
    additionalFields.appendChild(addFields);
    
    addFields.querySelector('.removeField').addEventListener('click', () => {
        addFields.remove();
    })
})

function showToast(message) {
    let toast = document.createElement("div");
    toast.className = "toast-message alert alert-warning position-fixed bottom-0 start-50 translate-middle-x p-2";
    toast.innerText = message;
    document.body.appendChild(toast);

    setTimeout(() => {
        toast.style.opacity = "0";
        setTimeout(() => document.body.removeChild(toast), 500);
    }, 2000);
}

const collectAllPosts = async () => {
    let response = await fetch("collect_posts.do");
    let result = await response.json();
    return result;
};

const format = (str) => {
    return str ? str.replace(/</g, "&lt;").replace(/>/g, "&gt;") : ""; // Escaping HTML tags
};

// Function to format date in Indian Standard Time (IST) without weekday
const formatDate = (dateStr) => {
    if (!dateStr) return "Unknown Date";

    return new Date(dateStr).toLocaleString("en-IN", {
        year: 'numeric', month: 'short', day: 'numeric',
        hour: '2-digit', minute: '2-digit',
        hour12: true, timeZone: "Asia/Kolkata"
    });
};

const showAllPosts = () => {
    let container = document.getElementById("postsContainer");
    container.innerHTML = ""; // Clear previous content
    
    collectAllPosts()
    .then(data => {
        data.forEach((post, index) => {
            // Extract the first valid description
                let description = "";
                if (post.postDataList && post.postDataList.length > 0) {
                    for (let pd of post.postDataList) {
                        if (pd.description && pd.description.trim() !== "") {
                            description = pd.description;
                            break;
                        }
                    }
                }

                // Generate tag HTML using Bootstrap
                let tagHTML = "";
                if (post.topicName) {
                    tagHTML = "<span class=\"badge bg-light text-primary border border-primary-subtle px-2 py-1 mb-3\">" +
                        "<i class=\"fas fa-hashtag me-1\" style=\"font-size: 11px;\"></i> " +
                        format(post.topicName) + "</span>";
                }
                
                // Status badge using Bootstrap
                let statusBadge = post.solved
                    ? "<span class=\"badge rounded-pill bg-success px-3 py-2\">" +
                    "<i class=\"fas fa-check-circle me-1\"></i> Solved</span>"
                    : "<span class=\"badge rounded-pill status-unsolved px-3 py-2\">" +
                    "<i class=\"fas fa-times-circle me-1\"></i> Unsolved</span>";
                    
                // Post card HTML using Bootstrap classes
                let postCard =
                "<div class=\"container\" style=\"max-width: 900px;\">" +
                "<div class=\"card border-0 shadow-sm mb-4\">" +
                // Post Header
                "<div class=\"card-header bg-white py-3 d-flex align-items-center border-bottom border-light\">" +
                "<img src=\"" + format(post.profilePic) + "\" class=\"rounded-circle me-3\" width=\"43\" height=\"43\" alt=\"User avatar\">" +
                "<div>" +
                "<div class=\"fw-bold fs-6\">" + format(post.userName) +
                " <i class=\"fas fa-check-circle text-primary\" style=\"font-size: 12px;\"></i></div>" +
                "<div class=\"text-muted small\">" + formatDate(post.postDate) + "</div>" +
                "</div>" +
                "<div class=\"ms-auto\">" +
                "<div class=\"dropdown\">" +
                "<button class=\"btn btn-sm p-0 text-muted dropdown-toggle no-caret\" data-bs-toggle=\"dropdown\" style=\"transition:none;\">" +
                "<i class=\"fas fa-ellipsis-h\"></i>" +
                "</button>" +
                "<ul class=\"dropdown-menu\">" ;
                
                if (userId == post.userId || userRole === 'moderator') {
                    postCard +=  "<li><button class=\"dropdown-item text-danger\" onclick=\"deletePost("+ post.postId +")\"><i class=\"fas fa-trash-alt me-2\"></i>Delete</button></li>";
                }
                
                
                postCard +="<li><a class=\"dropdown-item\" href=\"#\"><i class=\"fas fa-flag me-2 text-warning\"></i>Report/Spam</a></li>" +
                "</ul>" +
                "</div>" +
                "</div>" +
                "</div>" +
                
                // Post Body
                "<div class=\"card-body p-3\">" +
                "<h5 class=\"fw-bold mb-2\">" + format(post.title) + "</h5>" +
                "<p class=\"text-secondary mb-3 text-truncate-lines \">" + format(description) + "</p>" +
                tagHTML +
                "</div>" +
                
                // Post Actions
                "<div class=\"card-footer d-flex justify-content-between bg-light border-0 p-3\">" +
                "<button class=\"btn btn-outline-secondary\">" +
                "<i class=\"fas fa-share-alt me-1\"></i> Share" +
                "</button>" +
                "<button class=\"btn btn-primary rounded-pill\" " +
                "onclick=\"window.location.href='view_discussion_post.do?postId=" + (post.postId || 0) + "'\">" +
                "<i class=\"fas fa-eye me-1\"></i> View Discussion" +
                "</button>" +
                "</div>" +
                "</div>" +
                "</div>";
                
                container.innerHTML += postCard;
                
            });
        })
        .catch(error => console.error("Error fetching posts:", error));
};

showAllPosts();

async function deletePost(postId) {
    // Show confirmation using SweetAlert
    const result = await Swal.fire({
        title: 'Are you sure?',
        text: "Do you want to delete this post?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'No, cancel!',
    });

    if (result.isConfirmed) {
        try {
            // Use Fetch API to send the delete request
            const response = await fetch('delete_post.do?postId='+postId, {
                method: 'post',
               
            });

            // Handle the response from the server
            const data = await response.json();

            if (data.success) {
                // Show success message if post is deleted
                Swal.fire('Deleted!', data.message, 'success');

                showAllPosts();
            } else {
                // Show error message if there was an issue
                Swal.fire('Error!', data.message, 'error');
            }
        } catch (error) {
            console.error("Error:", error);
            Swal.fire('Error!', 'An unexpected error occurred.', 'error');
        }
    }
}
