<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="static/css/header.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<!-- Bootstrap Icons CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">


<!-- hidden field for login_status -->
<input type="hidden" id="loginStatus" value="${param.login_status}">

<!-- Modal for login status-->
<div class="modal fade" id="loginStatusModal" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
                <div id="statusAlert" class="alert" role="alert">
                    <h4 class="alert-heading justify-content-center">
                        <span id="statusIcon" class="status-icon"></span>
                        <span id="statusTitle"></span>
                    </h4>
                    <p id="statusMessage"></p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Toast Notification - Centered and Large -->
<c:if test="${not empty param.register}">
    <input type="hidden" id="registerStatus" value="${param.register}" />

    <!-- Success Toast -->
    <div class="notification-toast success" id="successToast">
        <div class="notification-content">
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            <div class="notification-text">
                <div class="notification-title">Registration Successful!</div>
                <p class="notification-message">Your account has been created successfully.</p>
                <a href="login.do" class="action-button">
                    <i class="fas fa-sign-in-alt me-2"></i>
                    Proceed to Login
                </a>
            </div>
            <button class="notification-close" onclick="closeNotification('successToast')">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>

    <!-- Error Toast -->
    <div class="notification-toast error" id="errorToast">
        <div class="notification-content">
            <div class="error-icon">
                <i class="fas fa-exclamation-circle"></i>
            </div>
            <div class="notification-text">
                <div class="notification-title">Registration Failed</div>
                <p class="notification-message">Unable to create account. Please try again.</p>
            </div>
            <button class="notification-close" onclick="closeNotification('errorToast')">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>
</c:if>
<!-- ------------------------------- -->
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
                        <input type="file" class="form-control" id="questionImage" name="images" accept="image/*">
                    </div>

                    <!-- Additional Fields Container -->
                    <div id="additionalFields"></div>

                    <!--Add more  -->
                    <div class="text-end me-4 mb-3">
                        <button type="button" class="btn btn-primary" id="addMore"><i class="fa-solid fa-plus"></i>
                            Add More</button>
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

 <!-- login first modal start -->
<div class="modal fade" id="login_first_modal" tabindex="-1" aria-labelledby="login_first_modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content rounded-4 shadow">

        <div class="modal-header bg-primary text-white rounded-top-4">
        <h5 class="modal-title" id="login_first_modal">Login Required</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body text-center p-4">
        <p class="fs-5 mb-4">You need to <strong>log in</strong> to ask a question.</p>
        <a href="login.jsp" class="btn btn-primary px-4 py-2">Log in now</a>
        </div>

    </div>
    </div>
</div>  

 <!-- login first modal end -->

<!-- Login Modal start -->
<div class="modal fade" id="login_modal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-light">
            <form action="login.do" method="post" id="loginForm">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">
                        <i class="fas fa-sign-in-alt me-2"></i>Login
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid px-3">
                        <div class="mb-4">
                            <label for="uemail" class="form-label fw-bold">
                                <i class="fas fa-envelope me-2"></i>Email
                            </label>
                            <input type="email" class="form-control border-primary" name="uemail" id="uemail">
                            <small class="error-message text-danger" id="uemail-error"></small>
                        </div>
                        <div class="mb-4">
                            <label for="password1" class="form-label fw-bold">
                                <i class="fas fa-lock me-2"></i>Enter Your Password
                            </label>
                            <div class="input-group">
                                <input type="password" class="form-control border-primary" id="password1"
                                    name="upassword">
                                <button class="btn btn-outline-primary toggle-password" type="button"
                                    data-target="password1">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <small class="error-message text-danger" id="password1-error"></small>
                        </div>

                        <!-- Forgot Password Link -->
                        <div class="mb-3 text-end">
                            <a href="#" class="text-primary text-decoration-none">
                                <small><i class="fas fa-key me-1"></i>Forgot Password?</small>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light flex-column w-100">
                    <div class="d-flex justify-content-end w-100">
                        <button type="button" class="btn btn-outline-secondary me-2" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Close
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-sign-in-alt me-2"></i>Login
                        </button>
                    </div>

                    <!-- Registration Link -->
                    <div class="w-100 text-center mt-3 border-top pt-3">
                        <span class="text-muted">Don't have an account?</span>
                        <button type="button" class="btn btn-link text-primary text-decoration-none"
                            data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#register_modal">
                            <i class="fas fa-user-plus me-1"></i>Register Here
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Login Modal end -->

<!-- Registration Modal -->
<div class="modal fade" id="register_modal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-light">
            <form action="register.do" method="post" id="registerForm">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">
                        <i class="fas fa-user-plus me-2"></i>Register Yourself!
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
                </div>

                <!-- Scrollable content area with fixed height -->
                <div class="modal-body" style="height: 60vh; overflow-y: auto;">
                    <div class="container-fluid px-3">
                        <div class="mb-3">
                            <label for="name" class="form-label fw-bold">
                                <i class="fas fa-user me-2"></i>Name
                            </label>
                            <input type="text" class="form-control border-primary" name="name" id="name">
                            <small class="error-message text-danger" id="name-error"></small>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label fw-bold">
                                <i class="fas fa-envelope me-2"></i>Email
                            </label>
                            <input type="email" class="form-control border-primary" name="email" id="email">
                            <small class="error-message text-danger" id="email-error"></small>
                        </div>

                        <div class="mb-3">
                            <label for="password2" class="form-label fw-bold">
                                <i class="fas fa-lock me-2"></i>Enter Your Password
                            </label>
                            <div class="input-group">
                                <input type="password" class="form-control border-primary" id="password2"
                                    name="password">
                                <button class="btn btn-outline-primary toggle-password" type="button"
                                    data-target="password2">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <small class="error-message text-danger" id="password2-error"></small>
                        </div>
                        <div class="mb-3">
                            <label for="dob" class="form-label fw-bold">
                                <i class="fas fa-calendar me-2"></i>Date Of Birth
                            </label>
                            <input type="date" class="form-control border-primary" name="dob" id="dob">
                            <small class="error-message text-danger" id="dob-error"></small>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">
                                <i class="fas fa-venus-mars me-2"></i>Gender
                            </label>
                            <div class="d-flex gap-4">
                                <div class="form-check">
                                    <input class="form-check-input border-primary" type="radio" name="gender" id="male"
                                        value="M">
                                    <label class="form-check-label" for="male">
                                        <i class="fas fa-male text-primary me-1"></i>Male
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input border-primary" type="radio" name="gender"
                                        id="female" value="F">
                                    <label class="form-check-label" for="female">
                                        <i class="fas fa-female text-primary me-1"></i>Female
                                    </label>
                                </div>
                            </div>
                            <small class="error-message text-danger" id="gender-error"></small>
                        </div>

                        <div class="mb-3">
                            <label for="country" class="form-label fw-bold">
                                <i class="fas fa-globe me-2"></i>Select Your Country
                            </label>
                            <div class="d-flex align-items-center">
                                <img id="flagImage" src="" alt="Flag" width="40" class="me-2 p-1 bg-light d-none">
                                <input list="country_list" autocomplete="off" type="text"
                                    class="form-control border-primary" name="country" id="country">
                                <input type="hidden" name="country_id" id="country_id">
                            </div>
                            <small class="error-message text-danger" id="country-error"></small>
                            <datalist id="country_list">
                                <c:forEach var="ct" items="${countries}">
                                    <option value="${ct.name}" data-id="${ct.countryId}" data-flag="${ct.flag}">
                                </c:forEach>
                            </datalist>
                        </div>
                    </div>
                </div>

                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Close
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-check me-2"></i>Register
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal for register new user *end -->

<!-- offcanvas for user profiel start -->
<div class="offcanvas offcanvas-end" aria-labelledby="offcanvasLabel" id="profilePanel">
    <div class="offcanvas-header border-bottom">
        <h5 class="offcanvas-title fw-bold"><i class="fas fa-user-circle me-2"></i>${user.name}</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <!-- Profile Section -->
        <div class="text-center mb-4">
            <div class="position-relative d-inline-block mb-3">
                <img src="${user.picPath}" alt="Profile" class="rounded-circle border border-3 border-primary shadow" 
                    width="100" height="100" style="object-fit: cover;">
            </div>
            <h5 class="fw-bold mb-1">${user.name}</h5>
            <p class="text-muted mb-2">${user.email}</p>
            <span class="badge bg-primary rounded-pill px-3 py-2">${userRole}</span>
        </div>
        
        <!-- Main Actions -->
        <div class="d-grid gap-3 mb-4">
            <!-- For regular users -->
            <c:if test="${userRole == 'user'}">
                <a href="my_dashboard.jsp" class="btn btn-primary btn-lg">
                    <i class="fas fa-columns me-2"></i> My Dashboard
                    <small class="d-block mt-1">View and manage your posts</small>
                </a>
            </c:if>

            <!-- For admins -->
            <c:if test="${userRole == 'admin'}">
                <!-- Admin Dashboard -->
                <a href="admin_dashboard.do" class="btn btn-primary btn-lg">
                    <i class="fas fa-tools me-2"></i> Admin Dashboard
                    <small class="d-block mt-1">Manage users and settings</small>
                </a>
                <!-- View As User button, only for admins -->
                <a href="index.do" class="btn btn-outline-secondary btn-lg">
                    <i class="fas fa-user me-2"></i> View As User
                    <small class="d-block mt-1">See the forum as a regular user</small>
                </a>
            </c:if>

            <!-- Edit Profile (visible to both) -->
            <a href="edit_profile.do" class="btn btn-outline-primary btn-lg">
                <i class="fas fa-user-edit me-2"></i> Edit Profile
                <small class="d-block mt-1">Update your information</small>
            </a>
        </div>


        <!-- Additional Options -->
        <div class="list-group list-group-flush border-top pt-3">
            <a href="settings.jsp" class="list-group-item list-group-item-action d-flex align-items-center border-0 py-3">
                <i class="fas fa-cog text-secondary me-3 fs-5"></i>
                <div>
                    <strong>Settings</strong>
                    <small class="d-block text-muted">Account preferences</small>
                </div>
                <i class="fas fa-chevron-right ms-auto"></i>
            </a>
           
        </div>
        
        <!-- Logout -->
        <div class="mt-4 pt-3 border-top">
            <a href="logout.do" class="btn btn-danger w-100">
                <i class="fas fa-sign-out-alt me-2"></i> Logout
            </a>
        </div>
    </div>
</div>

<!-- offcanvas for user profiel end -->

<div class="sticky-top">
    <!-- Header -->
    <header class="site-header" style="background-color: #0d6efd; padding: 12px 20px; color: white; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
        <a href="home.jsp" class="logo" style="font-size: 26px; font-weight: bold; color: white; text-decoration: none; display: flex; align-items: center;">
            <span class="logo-icon" style="margin-right: 10px;"><i class="fas fa-code"></i></span>
            <span style="font-family: 'Source Code Pro', monospace;">CodeX</span>
        </a>
        
        <c:choose>
            <c:when test="${not empty user}">
                <div class="user-actions" style="display: flex; align-items: center; gap: 18px;">
                    <div class="notification-bell" style="position: relative; cursor: pointer;">
                        <i class="fas fa-bell fa-lg"></i>
                        <span class="notification-count" style="position: absolute; top: -8px; right: -8px; background-color: #ff3e3e; color: white; border-radius: 50%; width: 22px; height: 22px; font-size: 12px; display: flex; align-items: center; justify-content: center; box-shadow: 0 2px 4px rgba(0,0,0,0.2);">3</span>
                    </div>
                    <button class="avatar" style="width: 42px; height: 42px; border-radius: 50%; background-color: transparent; border: 2px solid white; cursor: pointer; padding: 0; transition: transform 0.2s; box-shadow: 0 2px 5px rgba(0,0,0,0.2);" data-bs-toggle="offcanvas" data-bs-target="#profilePanel">
                        <img src="${user.picPath}" alt="Profile" style="width: 39px; height: 40px; border-radius: 50%; object-fit: cover;">
                    </button>
                </div>
            </c:when>
            <c:otherwise>
                <div class="user-actions" style="display: flex; align-items: center; gap: 12px;">
                    <button class="btn" style="background-color: transparent; border: 1px solid rgba(255,255,255,0.8); color: white; border-radius: 20px; padding: 6px 16px; transition: all 0.2s;" data-bs-toggle="modal" data-bs-target="#login_modal">
                        <i class="fas fa-sign-in-alt me-1"></i> Login
                    </button>
                    <button class="btn" style="background-color: white; color: #0d6efd; border: none; border-radius: 20px; padding: 6px 16px; font-weight: 500; transition: all 0.2s; box-shadow: 0 2px 4px rgba(0,0,0,0.1);" data-bs-toggle="modal" data-bs-target="#register_modal">
                        <i class="fas fa-user-plus me-1"></i> Register
                    </button>
                </div>
            </c:otherwise>
        </c:choose>
    </header>
    
    <!-- Toolbar -->
    <div class="toolbar" style="padding: 10px 20px; background-color: #f8f9fa; border-bottom: 1px solid #e2e8f0; display: flex; gap: 10px; flex-wrap: wrap;">
        <button class="btn" style="background-color: #4CAF50; color: white; border: none; border-radius: 6px; padding: 8px 16px; font-weight: 500; box-shadow: 0 2px 4px rgba(0,0,0,0.1); transition: all 0.2s;">
            <i class="fas fa-filter me-1"></i> Filter
        </button>
        <button class="btn" style="background-color: #FF9800; color: white; border: none; border-radius: 6px; padding: 8px 16px; font-weight: 500; box-shadow: 0 2px 4px rgba(0,0,0,0.1); transition: all 0.2s;">
            <i class="fas fa-sort me-1"></i> Sort
        </button>
        <div class="flex-grow-1">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Search questions..." style="border-radius: 6px 0 0 6px; border: 1px solid #ced4da; padding: 8px 12px;" oninput="filterPosts()">
                <button class="btn btn-primary" style="border-radius: 0 6px 6px 0; border: none; padding: 8px 16px;">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
        
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <button class="btn" style="background-color: #F44336; color: white; border: none; border-radius: 6px; padding: 8px 16px; font-weight: 500; box-shadow: 0 2px 4px rgba(0,0,0,0.1); transition: all 0.2s;" data-bs-toggle="modal" data-bs-target="#question_modal">
                    <i class="fas fa-question-circle me-1"></i> Ask a question
                </button>
            </c:when>
            <c:otherwise>
                <button class="btn" style="background-color: #F44336; color: white; border: none; border-radius: 6px; padding: 8px 16px; font-weight: 500; box-shadow: 0 2px 4px rgba(0,0,0,0.1); transition: all 0.2s;" data-bs-toggle="modal" data-bs-target="#login_first_modal">
                    <i class="fas fa-question-circle me-1"></i> Ask a question
                </button>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<style>
     .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    }
    
    
    
    @media (max-width: 768px) {
        .toolbar {
            flex-direction: column;
        }
        
        .toolbar .flex-grow-1 {
            order: -1;
            margin-bottom: 10px;
            width: 100%;
        }
        
        .btn {
            width: 100%;
        }
    }
</style>


