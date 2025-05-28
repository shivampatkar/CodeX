<%-- admin-navbar.jsp - Admin-specific vertical navbar component --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Admin Vertical Navbar --%>
<div class="vertical-navbar">
    <div class="nav-section">
        <a href="admin_dashboard.do" class="nav-link active">
            <i class="fas fa-tachometer-alt"></i>
            <span>Admin Dashboard</span>
        </a>
        <a href="admin_analytics.jsp" class="nav-link">
            <i class="fas fa-chart-bar"></i>
            <span>Analytics & Reports</span>
        </a>
    </div>
    
    <div class="section-divider"></div>
    
    <div class="section-header">Management</div>
    <div class="nav-section">
        <a href="user_management.do" class="nav-link">
            <i class="fas fa-users"></i>
            <span>User Management</span>
        </a>
        <a href="content-management.jsp" class="nav-link">
            <i class="fas fa-file-upload"></i>
            <span>Content Management</span>
        </a>
        <a href="category-management.jsp" class="nav-link">
            <i class="fas fa-folder"></i>
            <span>Category Management</span>
        </a>
    </div>
    
    <div class="section-divider"></div>
    
    <div class="section-header">Settings</div>
    <div class="nav-section">
        <a href="website-settings.jsp" class="nav-link">
            <i class="fas fa-cogs"></i>
            <span>Website Settings</span>
        </a>
       
        <a href="system-logs.jsp" class="nav-link">
            <i class="fas fa-clipboard-list"></i>
            <span>System Logs</span>
        </a>
    </div>
</div>

<%-- CSS for the navbar (same as regular navbar) --%>
<style>
    .vertical-navbar {
        width: 220px;
        height: calc(100vh - 126px); /* Adjust based on your header + toolbar height */
        position: fixed;
        left: 0;
        overflow-y: auto;
        background-color: #f8f9fa;
        border-right: 1px solid #dee2e6;
    }
    
    .nav-link {
        color: #495057;
        padding: 10px 20px;
        display: flex;
        align-items: center;
        text-decoration: none;
        border-left: 3px solid transparent;
        transition: all 0.2s ease;
    }
    
    .nav-link:hover {
        background-color: #e9ecef;
        color: #0d6efd;
    }
    
    .nav-link.active {
        background-color: #e7f1ff;
        color: #0d6efd;
        border-left: 3px solid #0d6efd;
        font-weight: 500;
    }
    
    .nav-link i {
        width: 24px;
        margin-right: 10px;
        text-align: center;
    }
    
    .section-header {
        font-size: 12px;
        text-transform: uppercase;
        color: #6c757d;
        font-weight: 600;
        padding: 15px 20px 5px;
    }
    
    .section-divider {
        margin: 10px 0;
        border-top: 1px solid #dee2e6;
    }
    
    /* Main content adjustment */
    .main-content-wrapper {
        margin-left: 240px;
        padding: 20px;
    }
    
    /* Responsive design */
    @media (max-width: 768px) {
        .vertical-navbar {
            width: 60px;
        }
        
        .vertical-navbar .nav-link span,
        .vertical-navbar .section-header {
            display: none;
        }
        
        .main-content-wrapper {
            margin-left: 60px;
        }
    }
</style>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Get the current page URL
        let currentUrl = window.location.pathname.split("/").pop(); // Get only the filename

        // Get all navigation links
        let navLinks = document.querySelectorAll(".nav-link");

        // Variable to track if any link is matched
        let isActiveSet = false;

        // Loop through links
        navLinks.forEach(link => {
            link.classList.remove("active");

            // If link matches current file name, add active class
            if (link.getAttribute("href") === currentUrl) {
                link.classList.add("active");
                isActiveSet = true;
            }
        });

        // If no active link was found, set admin dashboard as default
        if (!isActiveSet) {
            document.querySelector(".nav-link[href='admin-dashboard.do']").classList.add("active");
        }
    });
</script>