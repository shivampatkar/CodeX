<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Topics</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="static/css/home.css">
    <link rel="stylesheet" href="static/css/header.css">
    <style>
        body{
            font-family: 'Poppins', sans-serif;
        }
        .card-hover:hover {
            transform: translateY(-5px);
            transition: transform 0.3s ease;
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

            <div class="col bg-light px-4 py-4">
                <div class="row mb-4 align-items-start">
                    <div class="col-md-10 col-sm-5 ">
                        <h1 class="display-6 mb-0 fw-semibold">Explore Topics</h1>
                        <p class="text-muted mt-2">Discover communities and topics that spark your curiosity</p>
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <input type="text" id="topicSearch" class="form-control" 
                                   placeholder="Search topics..." 
                                   oninput="filterTopics()">
                        </div>
                    </div>
                </div>
            
                <div class="row row-cols-1 row-cols-md-3 g-3">
                    <c:forEach items="${topics}" var="topic" varStatus="status">
                        <div class="col topic-card">
                            <div class="card shadow-sm card-hover">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h5 class="card-title mb-0 text-primary"><i class="fas fa-tags"></i> ${topic.name}</h5>
                                        <span class="badge bg-secondary">Total Questions ${topic.questionCount}</span>
                                    </div>
                                    
                                    <p class="card-text text-muted mb-3 text-start">${topic.description}</p>
                                    
                                    <div class="row">
                                        <div class="col-5">
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-question-circle me-2 text-info"></i>
                                                <small class="text-muted">
                                                    <strong class="me-1">Questions Asked:</strong>
                                                    ${topic.openQuestions}
                                                </small>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-clock me-2 text-warning"></i>
                                                <small class="text-muted">
                                                    <strong class="me-1">Last Post:</strong>
                                                    <c:choose>
                                                        <c:when test="${empty topic.lastPost}">
                                                            No posts yet
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatDate value="${topic.lastPost}" pattern="dd MMM yyyy" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </small>
                                                
                                            </div>
                                        </div>                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="static/js/header.js"></script>
    <script>
         function filterTopics() {
            const searchInput = document.getElementById('topicSearch').value.toLowerCase();
            const topicCards = document.querySelectorAll('.topic-card');
            
            topicCards.forEach(card => {
                const topicName = card.querySelector('.card-title').textContent.toLowerCase();
                
                if (topicName.includes(searchInput)) {
                    card.style.display = ''; 
                } else {
                    card.style.display = 'none'; 
                }
            });
        }

        const formatDate = (dateStr) => {
            if (!dateStr) return "Unknown Date";

            return new Date(dateStr).toLocaleString("en-IN", { 
                year: 'numeric', month: 'short', day: 'numeric', 
                hour: '2-digit', minute: '2-digit', 
                hour12: true, timeZone: "Asia/Kolkata" 
            });
        };
    </script>

</body>
</html>