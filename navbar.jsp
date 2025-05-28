


<div class="vertical-navbar">
    <div class="nav-section">
        <a href="index.do" class="nav-link active">
            <i class="fas fa-home"></i>
            <span>Home</span>
        </a>
        <a href="trending.jsp" class="nav-link">
            <i class="fas fa-chart-line"></i>
            <span>Trending</span>
        </a>
        <a href="popular.jsp" class="nav-link">
            <i class="fas fa-fire"></i>
            <span>Popular</span>
        </a>
        <a href="discover.jsp" class="nav-link">
            <i class="fas fa-compass"></i>
            <span>Discover</span>
        </a>
    </div>

    
    <div class="section-divider"></div>

    <div class="section-header">Topics</div>
    <div class="nav-section">
        <a href="featured.jsp" class="nav-link">
            <i class="fas fa-star"></i>
            <span>Featured</span>
        </a>
        <a href="categories.jsp" class="nav-link">
            <i class="fas fa-th-large"></i>
            <span>Categories</span>
        </a>
        <a href="topics.do" class="nav-link">
            <i class="fas fa-tags"></i>
            <span>Tags</span>
        </a>
    </div>
    
    <div class="section-divider"></div>
    
    <div class="section-header">Library</div>
    <div class="nav-section">
        <a href="saved.jsp" class="nav-link">
            <i class="fas fa-bookmark"></i>
            <span>Saved</span>
        </a>
    </div>
    <div class="section-header">About Us</div>
    <div class="nav-section">
        <a href="about_us.jsp" class="nav-link">
            <i class="fas fa-history"></i>
            <span>CodeX</span>
        </a>
        
    </div>
</div>


<%-- CSS for the navbar --%>
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

    // If no active link was found, set "Home" as active
    if (!isActiveSet) {
        document.querySelector(".nav-link[href='index.do']").classList.add("active");
    }
});

</script>
