<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User DashBoard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="static/css/bootstrap css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="static/css/home.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        .btn-filter {
            background-color: #1abc9c !important;
            /* Light Teal */
            color: white !important;
        }

        .btn-filter:hover {
            background-color: #16a085 !important;
            /* Darker Teal on hover */
        }

        .btn-sort {
            background-color: #f39c12 !important;
            /* Warm Amber/Orange */
            color: white !important;
        }

        .btn-sort:hover {
            background-color: #e67e22 !important;
            /* Darker Orange on hover */
        }

        .btn-search {
            background-color: #2ecc71 !important;
            /* Fresh Green */
            color: white !important;
        }

        .btn-ask {
            background-color: #9b59b6 !important;
            /* Purple */
            color: white !important;
        }

        /* Hover effect */
        .btn-ask:hover {
            background-color: #8e44ad !important;
            /* Darker Purple on hover */
        }


        /* .posts */
        .post-excerpt {
        display: -webkit-box;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .card-hover {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }


    .badge-tag {
        transition: all 0.2s ease;
    }

    .badge-tag:hover {
        background-color: #0d6efd !important;
        color: white !important;
    }

    .dropdown-item {
        display: flex;
        align-items: center;
        padding: 0.5rem 1rem;
    }

    .dropdown-item i {
        margin-right: 0.5rem;
        width: 1.2rem;
        text-align: center;
    }

    .rounded-pill {
        border-radius: 50rem !important;
    }

    </style>
</head>

<body>


    <!-- Ask a question modal start-->
    <div class="modal fade" id="question_modal" tabindex="-1" aria-labelledby="askQuestionLabel" aria-hidden="true">
        <div class="modal-dialog" style="max-width: 600px;">
            <div class="modal-content">
                <form id="questionForm" method="post" action="save_post.do" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h5 class="modal-title" id="askQuestionLabel">Ask a Question</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="max-height: 500px; overflow-y: auto;">

                        <!-- Title -->
                        <div class="mb-3">
                            <label for="questionTitle" class="form-label">Title</label>
                            <input type="text" class="form-control" id="questionTitle" name="questionTitle" required>
                        </div>

                        <!-- Topic Selection -->
                        <div class="mb-3">
                            <label for="topicSelect" class="form-label">Topic</label>
                            <select class="form-select" id="topicSelect" name="topicSelect" required>
                                <option value="" disabled selected>Select a topic</option>
                                <c:forEach var="topic" items="${topics}">
                                    <option value="${topic.topicId}">${topic.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Description -->
                        <div class="mb-3">
                            <label for="questionDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="questionDescription" name="descriptions" rows="3"
                                required></textarea>
                        </div>

                        <!-- Image Upload -->
                        <div class="mb-3">
                            <label for="questionImage" class="form-label">Upload an Image (Optional)</label>
                            <input type="file" class="form-control" id="questionImage" name="images"
                                accept="image/*">
                        </div>

                        <!-- Additional Fields Container -->
                        <div id="additionalFields"></div>

                        <!--Add more  -->
                        <div class="text-end me-4 mb-3">
                            <button type="button" class="btn btn-primary" id="addMore"><i class="fa-solid fa-plus"></i> Add More</button>
                        </div>

                        
                    </div>
                    <!-- Submit Button (Inside Form) -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"> <i
                                class="fa-solid fa-xmark"></i>Cancel</button>
                        <button type="submit" class="btn btn-success" id="uploadPost"><i
                                class="fa-solid fa-arrow-up-from-bracket"></i> Upload Post</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- modal end  -->

    <c:import url="header.jsp" />

    <div class="container-fluid">
        <div class="row" style="background-color: #f0f2f5;">
            <div class="col-auto" style="width: 240px;">
                <c:import url="navbar.jsp" />
            </div>

            <div class="col-md-8 d-flex flex-column align-items-start mt-3">
                <div class="container">
                    <h2 class="fw-bold mb-3 text-start fs-1">Recently Posted</h2>
                </div>
        
                <div id="postsContainer" class="overflow-y mt-2 justify-content-start">
                    
                </div>
            </div>
        </div>
    </div>



    <script>
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
                            "<img src=\"" + format(post.profilePic) + "\" class=\"rounded-circle me-3\" width=\"36\" height=\"36\" alt=\"User avatar\">" +
                            "<div>" +
                                "<div class=\"fw-bold fs-6\">" + format(post.userName) + 
                                " <i class=\"fas fa-check-circle text-primary\" style=\"font-size: 12px;\"></i></div>" +
                                "<div class=\"text-muted small\">" + formatDate(post.postDate) + "</div>" +
                            "</div>" +
                            "<div class=\"ms-auto\">" +
                                "<button class=\"btn btn-sm p-0 text-muted\">" +
                                    "<i class=\"fas fa-ellipsis-h\"></i>" +
                                "</button>" +
                            "</div>" +
                        "</div>" +
                        
                        // Post Body
                        "<div class=\"card-body p-3\">" +
                            "<h5 class=\"fw-bold mb-2\">" + format(post.title) + "</h5>" +
                            "<p class=\"text-secondary mb-3\">" + format(description) + "</p>" +
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


    </script>
    <script src="static/js/bootstrap js/bootstrap.bundle.min.js"></script>
    <script src="static/js/header.js"></script>

</body>

</html>