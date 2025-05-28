<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">

    <link rel="stylesheet" href="static/css/home.css">
    <link rel="stylesheet" href="static/css/header.css">
    <style>
         :root {
            --primary: #1a73e8;
            --primary-dark: #0d47a1;
            --primary-light: #e8f0fe;
            --secondary: #f8f9fa;
            --text-dark: #202124;
            --text-medium: #5f6368;
            --text-light: #80868b;
            --success: #34a853;
            --danger: #ea4335;
            --warning: #fbbc04;
            --border-radius: 8px;
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 6px rgba(0,0,0,0.1);
            --transition: all 0.3s ease;
        }
        
        body {
            font-family: 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            background-color: #f5f7fa;
            color: var(--text-dark);
            line-height: 1.5;
        }
        
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: white;
        }
        
        .navbar-brand i {
            margin-right: 0.5rem;
        }
        
        .top-navbar {
            background-color: var(--primary);
            padding: 10px 20px;
        }
        
        .sidebar {
            background-color: white;
            height: calc(100vh - 60px);
            border-right: 1px solid #e6e6e6;
            position: sticky;
            top: 60px;
        }
        
        .sidebar-link {
            display: flex;
            align-items: center;
            padding: 12px 16px;
            color: var(--text-medium);
            text-decoration: none;
            border-radius: var(--border-radius);
            margin: 2px 8px;
            transition: var(--transition);
        }
        
        .sidebar-link:hover {
            background-color: var(--primary-light);
            color: var(--primary);
        }
        
        .sidebar-link.active {
            background-color: var(--primary-light);
            color: var(--primary);
            font-weight: 500;
        }
        
        .sidebar-link i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .sidebar-heading {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 16px 16px 8px;
            color: var(--text-light);
            font-weight: 500;
        }
        
        .page-title {
            font-size: 1.75rem;
            font-weight: 500;
            color: var(--text-dark);
            margin-bottom: 1.5rem;
            border-bottom: 2px solid var(--primary);
            padding-bottom: 0.5rem;
            display: inline-block;
        }
        
        .profile-card {
            background-color: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
        }
        
        .profile-header {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 16px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .profile-header h5 {
            font-weight: 500;
            margin: 0;
        }
        
        .user-id-badge {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            border-radius: 30px;
            padding: 4px 12px;
            font-size: 0.8rem;
        }
        
        .profile-tabs {
            display: flex;
            border-bottom: 1px solid #e6e6e6;
            background-color: var(--secondary);
        }
        
        .tab-link {
            padding: 16px 20px;
            font-weight: 500;
            color: var(--text-medium);
            cursor: pointer;
            border-bottom: 3px solid transparent;
            transition: var(--transition);
        }
        
        .tab-link.active {
            color: var(--primary);
            border-bottom: 3px solid var(--primary);
        }
        
        .tab-link:hover:not(.active) {
            color: var(--text-dark);
            background-color: rgba(0, 0, 0, 0.03);
        }
        
        .tab-content {
            padding: 24px;
        }
        
        .profile-section {
            display: none;
        }
        
        .profile-section.active {
            display: block;
        }
        
        .profile-image-container {
            position: relative;
            width: 150px;
            height: 150px;
            margin: 0 auto 1rem;
        }
        
        .profile-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid white;
            box-shadow: var(--shadow-sm);
        }
        
        .image-upload-btn {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: var(--primary);
            color: white;
            border-radius: 50%;
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }
        
        .image-upload-btn:hover {
            background: var(--primary-dark);
            transform: scale(1.1);
        }
        
        .profile-name {
            font-size: 1.5rem;
            font-weight: 500;
            margin-bottom: 0.25rem;
        }
        
        .profile-email {
            color: var(--text-light);
            margin-bottom: 1rem;
        }
        
        .profile-badge {
            background-color: var(--secondary);
            color: var(--text-medium);
            border-radius: 20px;
            padding: 8px 16px;
            margin: 0 5px;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
        }
        
        .profile-badge i {
            margin-right: 6px;
        }
        
        .stats-box {
            background-color: var(--secondary);
            border-radius: var(--border-radius);
            padding: 16px;
            text-align: center;
            transition: var(--transition);
        }
        
        .stats-box:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-sm);
        }
        
        .stats-number {
            font-size: 1.75rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 0.25rem;
        }
        
        .stats-label {
            color: var(--text-light);
            font-size: 0.85rem;
        }
        
        .about-section {
            background-color: var(--secondary);
            border-radius: var(--border-radius);
            padding: 16px;
            position: relative;
            margin-bottom: 1.5rem;
        }
        
        .section-title {
            font-size: 1rem;
            font-weight: 500;
            color: var(--primary);
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
        }
        
        .section-title i {
            margin-right: 8px;
        }
        
        .edit-button {
            position: absolute;
            top: 12px;
            right: 12px;
            background-color: white;
            color: var(--primary);
            border-radius: 50%;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }
        
        .edit-button:hover {
            background-color: var(--primary-light);
            transform: scale(1.1);
        }
        
        .info-row {
            margin-bottom: 1.25rem;
        }
        
        .info-label {
            color: var(--text-light);
            font-size: 0.85rem;
            margin-bottom: 0.25rem;
            display: flex;
            align-items: center;
        }
        
        .info-label i {
            margin-right: 8px;
            width: 16px;
        }
        
        .info-value {
            font-weight: 500;
            color: var(--text-dark);
        }
        
        .form-label {
            font-weight: 500;
            color: var(--text-medium);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
        }
        
        .form-label i {
            margin-right: 8px;
            color: var(--primary);
        }
        
        .form-control {
            border-radius: var(--border-radius);
            padding: 12px 16px;
            border: 1px solid #ddd;
            transition: var(--transition);
        }
        
        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(26, 115, 232, 0.1);
        }
        
        .form-control.readonly {
            background-color: var(--secondary);
            border-color: #e6e6e6;
        }
        
        .form-text {
            color: var(--text-light);
            font-size: 0.75rem;
            margin-top: 0.25rem;
        }
        
        .btn {
            border-radius: var(--border-radius);
            padding: 10px 20px;
            font-weight: 500;
            transition: var(--transition);
        }
        
        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        
        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            transform: translateY(-2px);
        }
        
        .btn-light {
            background-color: var(--secondary);
            border-color: #ddd;
            color: var(--text-medium);
        }
        
        .btn-light:hover {
            background-color: #e6e6e6;
            transform: translateY(-2px);
        }
        
        .btn i {
            margin-right: 8px;
        }
        
        .status-badge {
            background-color: var(--success);
            color: white;
            border-radius: 4px;
            padding: 6px 12px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .search-container {
            position: relative;
            width: 100%;
        }
        
        .search-input {
            border-radius: 24px;
            padding: 10px 20px;
            border: 1px solid #ddd;
            width: 100%;
            padding-right: 40px;
        }
        
        .search-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
        }
        
        .ask-btn {
            background-color: #f44336;
            color: white;
            border-radius: 24px;
            padding: 10px 20px;
            border: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            transition: var(--transition);
        }
        
        .ask-btn:hover {
            background-color: #d32f2f;
            transform: translateY(-2px);
        }
        
        .ask-btn i {
            margin-right: 8px;
        }
        
        .notifications-badge {
            position: relative;
        }
        
        .notification-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: #f44336;
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 0.7rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
        
        /* Responsive adjustments */
        @media (max-width: 991.98px) {
            .sidebar {
                height: auto;
                position: static;
            }
            
            .sidebar-link span {
                display: none;
            }
            
            .sidebar-link i {
                margin-right: 0;
                font-size: 1.25rem;
            }
            
            .sidebar-heading {
                text-align: center;
                padding: 8px 0;
            }
            
            .sidebar-link {
                justify-content: center;
            }
        }
        
        @media (max-width: 767.98px) {
            .profile-tabs {
                flex-wrap: wrap;
            }
            
            .tab-link {
                flex: 1 0 auto;
                text-align: center;
                padding: 12px;
            }
            
            .profile-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .user-id-badge {
                margin-top: 8px;
            }
        }

        
        @media (max-width: 767.98px) {
            .profile-tabs .nav-link {
                padding: 10px 15px;
                font-size: 0.9rem;
            }
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
            <div class="col-lg-10 col-md-9 col-sm-12 py-4 px-4">
                
                <h2 class="page-title">Edit Your Profile</h2>
                
                <!-- Profile Card -->
                <div class="profile-card">
                    <div class="profile-header">
                        <h5><i class="fas fa-user me-2"></i>Profile Settings</h5>
                        <div class="user-id-badge">User ID: ${user.userId}</div>
                    </div>
                    
                    <!-- Profile Navigation Tabs -->
                    <div class="profile-tabs">
                        <div class="tab-link active" data-tab="overview">Overview</div>
                        <div class="tab-link" data-tab="edit-details">Edit Details</div>
                    </div>
                    
                    <div class="tab-content">
                        <!-- Overview Tab -->
                        <div class="profile-section active" id="overview">
                            <div class="row">
                                <div class="col-md-4 text-center mb-4">
                                    <div class="profile-image-container">
                                        <img src="<c:out value='${user.picPath}'/>" alt="Profile" id="profile-image" class="profile-image">
                                        <label for="profile_pic_upload" class="image-upload-btn">
                                            <i class="fas fa-camera"></i>
                                        </label>
                                        <input type="file" id="profile_pic_upload" accept="image/*" hidden>
                                    </div>
                                    
                                    <h2 class="profile-name">${user.name}</h2>
                                    <div class="profile-email">${user.email}</div>
                                    
                                    <div class="d-flex justify-content-center flex-wrap gap-2 mb-4">
                                        <div class="profile-badge">
                                            <i class="fas fa-venus-mars"></i>${user.gender}
                                        </div>
                                        <div class="profile-badge">
                                            <i class="fas fa-globe"></i>${user.country.name}
                                        </div>
                                    </div>
                                    
                                    <div class="row g-3">
                                        <div class="col-6">
                                            <div class="stats-box">
                                                <div class="stats-number">${user.questionCount}</div>
                                                <div class="stats-label">Questions</div>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="stats-box">
                                                <div class="stats-number">${user.replyCount}</div>
                                                <div class="stats-label">Replies</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-8">
                                    <div class="about-section">
                                        <div class="section-title">
                                            <i class="fas fa-info-circle"></i>About Me
                                        </div>
                                        <c:choose>
                                            <c:when test="${not empty user.aboutMe}">
                                                <p>${user.aboutMe}</p>
                                            </c:when>
                                            <c:otherwise>
                                                <p>Tell us about yourself...</p>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="edit-button" data-bs-toggle="modal" data-bs-target="#aboutMeModal">
                                            <i class="fas fa-pen"></i>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="info-row">
                                                <div class="info-label">
                                                    <i class="fas fa-birthday-cake"></i>Date of Birth
                                                </div>
                                                <div class="info-value">${user.dob}</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="info-row">
                                                <div class="info-label">
                                                    <i class="fas fa-phone"></i>Contact
                                                </div>
                                                <div class="info-value">1234567890</div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="info-row">
                                        <div class="info-label">
                                            <i class="fas fa-clock"></i>Member Since
                                        </div>
                                        <div class="info-value">January 15, 2023</div>
                                    </div>
                                    
                                    <div class="mt-4">
                                        <span class="status-badge">
                                            <i class="fas fa-check-circle me-1"></i>${user.status.statusId} Account
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Edit Details Tab -->
                        <div class="profile-section" id="edit-details">
                            <form id="profileEditForm">
                                <div class="row g-4 mb-4">
                                    <div class="col-md-6">
                                        <label for="name" class="form-label">
                                            <i class="fas fa-user"></i>Full Name
                                        </label>
                                        <input type="text" class="form-control" id="name" value="${user.name}" placeholder="Your full name" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="email" class="form-label">
                                            <i class="fas fa-envelope"></i>Email Address
                                        </label>
                                        <input type="email" class="form-control readonly" id="email" value="${user.email}" readonly>
                                        <div class="form-text">Email address cannot be changed</div>
                                    </div>
                                </div>
                                
                                <div class="row g-4 mb-4">
                                    <div class="col-md-6">
                                        <label for="dob" class="form-label">
                                            <i class="fas fa-birthday-cake"></i>Date of Birth
                                        </label>
                                        <input type="date" class="form-control" id="dob" value="${user.dob}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="gender" class="form-label">
                                            <i class="fas fa-venus-mars"></i>Gender
                                        </label>
                                        <select class="form-select" id="gender" required>
                                            <option value="">Select gender</option>
                                            <option value="M" selected>Male</option>
                                            <option value="F">Female</option>
                                            <option value="O">Other</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="row g-4 mb-4">
                                   
                                    <div class="col-md-6">
                                        <label for="country" class="form-label">
                                            <i class="fas fa-globe"></i>Country
                                        </label>
                                        <select class="form-select" id="country" required>
                                            <option value="">Select country</option>
                                            <option value="1" selected>United States</option>
                                            <option value="2">Canada</option>
                                            <option value="3">United Kingdom</option>
                                            <option value="4">Australia</option>
                                            <option value="5">India</option>
                                            <option value="6">Germany</option>
                                            <option value="7">France</option>
                                            <option value="8">Japan</option>
                                            <option value="9">Brazil</option>
                                            <option value="10">South Africa</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="about_me" class="form-label">
                                        <i class="fas fa-comment"></i>About Me
                                    </label>
                                    <textarea class="form-control" id="about_me" rows="4" maxlength="2000">Hi there! I'm a software developer with over 5 years of experience in web technologies. I love solving complex problems and sharing knowledge with the community.</textarea>
                                    <div class="d-flex justify-content-between mt-1">
                                        <div class="form-text">Max 2000 characters</div>
                                        <div class="form-text" id="charCount">94/2000</div>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="profile_pic" class="form-label">
                                        <i class="fas fa-image"></i>Profile Picture
                                    </label>
                                    <input type="file" class="form-control" id="profile_pic" accept="image/*">
                                </div>
                                
                                <div class="d-flex justify-content-end gap-3">
                                    <button type="button" class="btn btn-light">
                                        <i class="fas fa-undo"></i>Reset
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save"></i>Save Changes
                                    </button>
                                </div>
                            </form>
                        </div>
                        
                        
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- About Me Modal -->
    <div class="modal fade" id="aboutMeModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Edit About Me</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="quickAboutMeForm">
                        <div class="mb-3">
                            <label for="modal_about_me" class="form-label">About Me</label>
                            <textarea class="form-control" id="modal_about_me" rows="5" maxlength="2000">Hi there! I'm a software developer with over 5 years of experience in web technologies. I love solving complex problems and sharing knowledge with the community.</textarea>
                            <div class="d-flex justify-content-between mt-1">
                                <div class="form-text">Max 2000 characters</div>
                                <div class="form-text" id="modalCharCount">94/2000</div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="saveAboutMe">Save Changes</button>
                </div>
            </div>
        </div>
    </div>

   
    <script src="static/js/bootstrap js/bootstrap.bundle.min.js"></script>
    <script src="static/js/header.js"></script>
    <script>
        let profile_pic_upload = document.getElementById("profile_pic_upload");

        profile_pic_upload.addEventListener("change", async function(){
            let file = this.files[0];

            if(!file) return;
           
            let formData = new FormData();
            formData.append("profile_pic", file);

            try{
                let response = await fetch("update_profile_pic.do",{
                    method:"POST",
                    body: formData
                });

                let result = await response.text();

                console.log(result)

                if(result.trim() === "updated"){
                    let profileImg = document.getElementById("profile-image");
                    let timestamp = new Date().getTime(); // Generate new timestamp
                    profileImg.src = profileImg.src.split('?')[0] + "?t=" + timestamp; // Force refresh

                }
            }catch(error) {
            }

        })

        // Tab navigation
        document.querySelectorAll('.tab-link').forEach(tab => {
            tab.addEventListener('click', function() {
                // Remove active class from all tabs
                document.querySelectorAll('.tab-link').forEach(t => {
                    t.classList.remove('active');
                });
                
                // Add active class to clicked tab
                this.classList.add('active');
                
                // Hide all sections
                document.querySelectorAll('.profile-section').forEach(section => {
                    section.classList.remove('active');
                });
                
                // Show corresponding section
                const tabId = this.getAttribute('data-tab');
                document.getElementById(tabId).classList.add('active');
            });
        });
        
 // Character counter for About Me
 const aboutMeTextarea = document.getElementById('about_me');
        const charCountDisplay = document.getElementById('charCount');
        
        aboutMeTextarea.addEventListener('input', function() {
            const currentLength = this.value.length;
            charCountDisplay.textContent = `${currentLength}/2000`;
        });
        
        // Character counter for modal About Me
        const modalAboutMe = document.getElementById('modal_about_me');
        const modalCharCount = document.getElementById('modalCharCount');
        
        if (modalAboutMe) {
            modalAboutMe.addEventListener('input', function() {
                const currentLength = this.value.length;
                modalCharCount.textContent = `${currentLength}/2000`;
            });
        }
        
        // Save About Me from modal
        const saveAboutMeBtn = document.getElementById('saveAboutMe');
        
        if (saveAboutMeBtn) {
            saveAboutMeBtn.addEventListener('click', function() {
                const modalText = document.getElementById('modal_about_me').value;
                document.getElementById('about_me').value = modalText;
                
                // Update character count in main form
                const currentLength = modalText.length;
                document.getElementById('charCount').textContent = `${currentLength}/2000`;
                
                // Close modal
                const modal = bootstrap.Modal.getInstance(document.getElementById('aboutMeModal'));
                modal.hide();
            });
        }
    </script>

</body>

</html>