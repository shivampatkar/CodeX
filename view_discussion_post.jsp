<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Post</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">

    <link rel="stylesheet" href="static/css/home.css">
    <link rel="stylesheet" href="static/css/header.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        .tag-section {
            margin: 1rem 0;
        }

        .reply-header {
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 0.75rem;
            margin-bottom: 1rem;
        }

        .page-topic-header {
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid #e9ecef;
        }

        .simple-nav {
            font-size: 14px;
            color: #6c757d;
        }
    </style>
</head>

<body>

    <c:import url="header.jsp" />

    <div class="container-fluid">
        <div class="row">
            <div class="col-auto bg-light" style="width: 240px;">
                <c:import url="navbar.jsp" />
            </div>

            <div class="col-9 bg-light px-4 py-4">
                <!-- Simple Topic-Focused Header -->
                <div class="page-topic-header">
                    <div class="simple-nav mb-2">
                        <a href="#" class="text-decoration-none text-secondary">Home</a> &gt;
                        <a href="#" class="text-decoration-none text-secondary">Discussion</a>
                    </div>
                </div>

                <!-- Question Post -->
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div class="d-flex align-items-center">
                            <img src="${post.profilePic}" alt="User Avatar" class="user-avatar me-3">
                            <div>
                                <h5 class="mb-0">${post.userName}</h5>
                                <small class="text-muted" id="post_date">${post.postDate}</small>
                            </div>
                        </div>
                        <div>
                            <span class="badge bg-secondary">Open</span>
                        </div>
                    </div>

                    <div class="card-body">
                        <h3 class="card-title mb-3 fw-semibold">${post.title}</h3>

                        <!-- Display Description and Images in Alternating Order -->
                        <c:forEach var="pd" items="${post.postData}">
                            <c:if test="${not empty pd.description}">
                                <p class="">${pd.description}</p>
                            </c:if>

                            <c:if test="${not empty pd.picPath}">
                                <div class="position-relative text-center mb-3">
                                    <!-- Post Image (Centered for Small Images) -->
                                    <img src="${pd.picPath}" alt="Post Image" loading="lazy"
                                        class="img-fluid rounded d-block mx-auto" data-bs-toggle="modal"
                                        data-bs-target="#imageModal" onclick="setImageModal('${pd.picPath}')">
                                    <!-- Maximize Icon -->
                                    <div class="position-absolute top-0 end-0 m-2">
                                        <button class="btn btn-dark btn-sm" data-bs-toggle="modal"
                                            data-bs-target="#imageModal" onclick="setImageModal('${pd.picPath}')">
                                            <i class="bi bi-arrows-fullscreen"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>

                        <!-- Tags -->
                        <div class="tag-section">
                            <span class="badge bg-primary"><i class="fa-solid fa-tags"></i> ${post.topicName}</span>
                        </div>

                        <!-- Vote and Share Buttons -->
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <div class="btn-group" role="group">

                                <button class="btn btn-outline-primary me-2" id="saveButton" onclick="toggleSave(this)">
                                    <i class="far fa-bookmark"></i> Save
                                </button>

                                <button class="btn btn-outline-secondary">
                                    <i class="fas fa-share-alt"></i> Share
                                </button>
                            </div>
                            <small class="text-muted">256 views</small>
                        </div>
                    </div>


                    <!-- Answers Section -->
                    <div class="card mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h3 class="mb-0">Answers (<span id="replyCount">0</span>)</h3>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button"
                                    id="sortDropdown" data-bs-toggle="dropdown">
                                    Sort by: Newest
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#" data-sort="most_liked">Most Liked</a></li>
                                    <li><a class="dropdown-item" href="#" data-sort="newest">Newest</a></li>
                                    <li><a class="dropdown-item" href="#" data-sort="oldest">Oldest</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-body">
                            <div id="repliesContainer">
                                <!-- Content will be loaded dynamically via fetch API -->
                                <div id="noRepliesMessage" class="text-center py-5">
                                    <div class="mb-3">
                                        <i class="fas fa-comments text-muted" style="font-size: 3rem;"></i>
                                    </div>
                                    <h4 class="text-muted mb-3">No answers yet</h4>
                                    <p class="text-muted mb-4">Be the first one to answer this question!</p>
                                    <button class="btn btn-primary"
                                        onclick="document.getElementById('description').focus()">
                                        <i class="fas fa-pen me-2"></i> Write an Answer
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    
                    <!-- Add Your Answer Section -->
                    <div class="card mb-4">
                        <div class="card-header answer-header bg-light">
                            <h4 class="mb-0">Your Answer</h4>
                        </div>
                        <div class="card-body">
                            <form id="replyForm" action="save_reply.do" method="post" enctype="multipart/form-data">
                                <div class="mb-3">
                                    <textarea class="form-control" id="description" name="description" rows="4"
                                        placeholder="Write your answer here..." required></textarea>
                                    <div class="invalid-feedback">
                                        Please write your answer before submitting.
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <!-- Image selection button -->
                                        <label for="image" class="btn btn-outline-secondary me-2">
                                            <i class="fas fa-image"></i> Image
                                        </label>
                                        <input type="file" id="image" name="image" class="d-none" accept="image/*">
                                        
                                        <!-- Display selected filename and clear button -->
                                        <div id="file-info" class="d-none">
                                            <span id="file-name" class="me-2"></span>
                                            <button type="button" id="clear-file" class="btn btn-sm btn-outline-danger">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-paper-plane"></i> Post Answer
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Image Modal -->
                    <div class="modal fade" id="imageModal" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content bg-transparent border-0">
                                <div class="modal-body p-0 text-center">
                                    <img id="modalImage" src="" alt="Fullscreen Post Image" class="img-fluid">
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>

        
<!-- Toast Container -->
<div id="toastContainer" class="toast-container position-fixed bottom-0 end-0 p-3"></div>

<script src="static/js/bootstrap js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="static/js/header.js"></script>
<script>
    var postId = '${post.postId}';
    var userId = '${user.userId}';
    var userRole = '${userRole}';
    var userSession = '${sessionScope.user}';
</script>

<script src="static/js/view_discussion_post.js"></script>
       
</body>

</html>