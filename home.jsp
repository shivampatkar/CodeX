<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="static/css/bootstrap css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="static/css/home.css">
    <style>
           .welcome-banner {
            background-color: #f8f9fa;
            border-left: 4px solid #0d6efd;
            margin-bottom: 20px;
            margin-left: 15px;
            padding: 15px;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .welcome-banner .username {
            font-weight: 600;
            color: #0d6efd;
        }
       
    </style>
</head>

<body>

    <c:import url="header.jsp" />

    <div class="container-fluid">
        <div class="row" style="background-color: #f0f2f5;">
            <div class="col-auto" style="width: 240px; padding: 0%;">
                <c:import url="navbar.jsp" />
            </div>

            <div class="col-md-7 d-flex flex-column align-items-start mt-3">
                <c:if test="${not empty user}">
                    <div class="welcome-banner d-flex justify-content-between align-items-center ml-4">
                        <div>
                            <h5 class="mb-0">Welcome back, <span class="username">${user.name}</span>!</h5>
                            <p class="text-muted mb-0">We have new questions that might interest you</p>
                        </div>
                    </div>
                </c:if>
                <div class="container">
                    <h2 class="fw-semibold mb-3 text-start fs-1">Recently Posted</h2>
                </div>


                <div id="postsContainer" class="overflow-y mt-2 justify-content-start">

                </div>
            </div>
            <!-- Quick Reference Sidebar - Add this after your col-md-8 div -->
            <div class="col-md-3 mt-3 d-none d-lg-block">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h4 class="fw-bold mb-4">Quick Reference</h4>

                        <!-- Code Snippets Section -->
                        <div class="mb-4">
                            <h5 class="fw-semibold mb-3">Common Code Snippets</h5>
                            <div class="card mb-2 border-0 bg-light">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-primary text-white rounded p-1 me-2 text-center"
                                            style="width: 30px; height: 30px;">
                                            <i class="fa-solid fa-terminal"></i>
                                        </div>
                                        <div>
                                            <strong class="d-block text-dark">Fetch API (JavaScript)</strong>
                                            <code class="small">fetch(url).then(res => res.json())</code>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mb-2 border-0 bg-light">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-success text-white rounded p-1 me-2 text-center"
                                            style="width: 30px; height: 30px;">
                                            <i class="fa-solid fa-code"></i>
                                        </div>
                                        <div>
                                            <strong class="d-block text-dark">Array Methods</strong>
                                            <code class="small">.map() .filter() .reduce()</code>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mb-2 border-0 bg-light">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-warning text-white rounded p-1 me-2 text-center"
                                            style="width: 30px; height: 30px;">
                                            <i class="fa-solid fa-brackets-curly "></i>
                                        </div>
                                        <div>
                                            <strong class="d-block text-dark">Try-Catch Block</strong>
                                            <code class="small">try {} catch(err) {}</code>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Keyboard Shortcuts -->
                        <div class="mb-4">
                            <h5 class="fw-semibold mb-3">Keyboard Shortcuts</h5>
                            <div class="card mb-2 border-0 bg-light">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-info text-white rounded p-1 me-2 text-center"
                                            style="width: 30px; height: 30px;">
                                            <i class="fa-solid fa-keyboard"></i>
                                        </div>
                                        <div>
                                            <strong class="d-block text-dark">Copy/Paste</strong>
                                            <small class="text-muted">Ctrl+C / Ctrl+V (Win)</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mb-2 border-0 bg-light">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-info text-white rounded p-1 me-2 text-center"
                                            style="width: 30px; height: 30px;">
                                            <i class="fa-solid fa-keyboard"></i>
                                        </div>
                                        <div>
                                            <strong class="d-block text-dark">Find</strong>
                                            <small class="text-muted">Ctrl+F (Win) </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Useful Resources -->
                        <div class="mb-4">
                            <h5 class="fw-semibold mb-3">Useful Resources</h5>
                            <div class="card mb-2 border-0 bg-light">
                                <div class="card-body p-3">
                                    <a href="https://www.geeksforgeeks.org/"
                                        class="text-decoration-none d-flex align-items-center">
                                        <div class="bg-success text-white rounded p-1 me-2 text-center"
                                            style="width: 30px; height: 30px;">
                                            <i class="fa-solid fa-laptop-code"></i>
                                        </div>
                                        <div>
                                            <strong class="d-block text-dark">GeeksforGeeks</strong>
                                            <small class="text-muted">Computer science tutorials & articles</small>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <div class="card mb-2 border-0 bg-light">
                                <div class="card-body p-3">
                                    <a href="https://www.w3schools.com/"
                                        class="text-decoration-none d-flex align-items-center">
                                        <div class="bg-primary text-white rounded p-1 me-2 text-center"
                                            style="width: 30px; height: 30px;">
                                            <i class="fa-solid fa-globe"></i>
                                        </div>
                                        <div>
                                            <strong class="d-block text-dark">W3Schools</strong>
                                            <small class="text-muted">Web development tutorials</small>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Tip of the Day -->
                        <div class="mb-3">
                            <h5 class="fw-semibold mb-3">Tip of the Day</h5>
                            <div class="card mb-2 border-0 bg-light">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-primary text-white rounded p-1 me-2 text-center"
                                            style="width: 30px; height: 30px;">
                                            <i class="fa-solid fa-lightbulb"></i>
                                        </div>
                                        <div>
                                            <strong class="d-block text-dark">Use Descriptive Variable Names</strong>
                                            <small class="text-muted">Makes code more readable and easier to
                                                maintain.</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="static/js/bootstrap js/bootstrap.bundle.min.js"></script>
    <script src="static/js/header.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        var userId = '${user.userId}';
        var userRole = '${userRole}';
    </script>
    <script src="static/js/home.js"></script>

</body>

</html>