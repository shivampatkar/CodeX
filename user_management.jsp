<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
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

        .card-hover:hover {
            transform: translateY(-5px);
            transition: transform 0.3s ease;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .table th {
            background-color: #f8f9fa;
            border-color: #dee2e6;
        }

        .badge-active {
            background-color: #10b981;
        }

        .badge-suspended {
            background-color: #f59e0b;
        }

        .badge-banned {
            background-color: #ef4444;
        }

        .badge-inactive {
            background-color: #6b7280;
            /* Gray */
        }

        .badge-pending {
            background-color: #6366f1;
        }

        .role-admin {
            background-color: #e9d5ff;
            color: #7e22ce;
        }

        .role-moderator {
            background-color: #dbeafe;
            color: #1d4ed8;
        }

        .role-user {
            background-color: #e5e7eb;
            color: #374151;
        }

        .btn-icon {
            width: 32px;
            height: 32px;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            margin-right: 5px;
        }

        .activity-metrics {
            font-size: 0.875rem;
        }

        .criteria-card {
            border-radius: 8px;
            border: 1px solid #e5e7eb;
        }

        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1100;
        }

        /* Add focus styles for better accessibility */
        .btn-icon:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.5);
            /* example focus outline */
        }

        /* Add media query for smaller screens */
        @media (max-width: 576px) {
            .user-avatar {
                width: 30px;
                height: 30px;
            }

            .activity-metrics {
                font-size: 0.75rem;
            }
        }
    </style>

</head>

<body>

    <c:import url="header.jsp" />

    <div class="container-fluid">
        <div class="row">
            <div class="col-auto bg-light" style="width: 240px;">
                <c:import url="admin_navbar.jsp" />
            </div>

            <div class="col bg-light px-4 py-4">
                <div class="row mb-4 align-items-start">
                    <div class="col-md-10 col-sm-5">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h2 class="dashboard-title">User Management</h2>
                                <p class="text-muted">Manage user roles, permissions, and activity</p>
                            </div>
                            <div>
                                <button class="btn btn-primary" id="exportUsersBtn">
                                    <i class="fas fa-download me-2"></i>Export Users
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container py-4">
                    <!-- User Management Section -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="card shadow-sm">
                                <div
                                    class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                                    <h5 class="mb-0">User List</h5>
                                    <div class="d-flex gap-2">
                                        <select class="form-select form-select-sm" id="roleFilter"
                                            style="width: 150px;">
                                            <option value="all">All Users</option>
                                            <option value="admin">Admins</option>
                                            <option value="moderator">Moderators</option>
                                            <option value="user">Regular Users</option>
                                        </select>
                                        <div class="input-group" style="width: 250px;">
                                            <input type="text" class="form-control form-control-sm"
                                                placeholder="Search users..." id="searchInput">
                                            <button class="btn btn-outline-secondary btn-sm" type="button">
                                                <i class="bi bi-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0" id="userTable">
                                            <thead>
                                                <tr>
                                                    <th>User ID</th>
                                                    <th>User Name</th>
                                                    <th>Roles</th>
                                                    <th>Activity</th>
                                                    <th>Actions</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="user" items="${usersList}">
                                                    <tr>
                                                        <td class="align-middle">${user.userId}</td>
                                                        <td class="align-middle">
                                                            <div class="d-flex align-items-center">
                                                                <div class="user-avatar me-3">
                                                                    <i class="bi bi-person"></i>
                                                                </div>
                                                                <div>
                                                                    <div class="fw-medium">${user.name}</div>
                                                                    <div class="small text-secondary"
                                                                        id="formattedDate">Joined ${user.createdAt}
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="align-middle">
                                                            <c:choose>
                                                                <c:when test="${user.userType.userTypeId == 1}">
                                                                    <span
                                                                        class="badge role-admin d-inline-flex align-items-center px-2 py-1">
                                                                        <i class="bi bi-shield-fill me-1"></i>Admin
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${user.userType.userTypeId == 2}">
                                                                    <span
                                                                        class="badge role-moderator d-inline-flex align-items-center px-2 py-1">
                                                                        <i class="bi bi-shield me-1"></i>Moderator
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="badge role-user d-inline-flex align-items-center px-2 py-1">
                                                                        <i class="bi bi-person me-1"></i>User
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="align-middle">
                                                            <div class="activity-metrics">
                                                                <div class="d-flex align-items-center mb-1">
                                                                    <i class="bi bi-chat-square-text me-2"></i>
                                                                    <span>Questions: ${user.questionCount}</span>
                                                                </div>
                                                                <div class="d-flex align-items-center">
                                                                    <i class="bi bi-reply me-2"></i>
                                                                    <span>Replies: ${user.replyCount}</span>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="align-middle">
                                                            <div class="d-flex">
                                                                <button class="btn btn-light btn-icon" title="Edit User"
                                                                    onclick="editUser()">
                                                                    <i class="bi bi-pencil"></i>
                                                                </button>
                                                                <c:if test="${user.status.statusId == 1}">
                                                                    <button class="btn btn-light btn-icon"
                                                                        title="Ban User"
                                                                        onclick="banUser('${user.userId}')">
                                                                        <i class="bi bi-slash-circle"></i>
                                                                    </button>
                                                                </c:if>
                                                                <c:if test="${user.status.statusId == 3}">
                                                                    <button class="btn btn-light btn-icon"
                                                                        title="Unban User"
                                                                        onclick="unbanUser('${user.userId}')">
                                                                        <i class="bi bi-check-circle"></i>
                                                                    </button>
                                                                </c:if>
                                                                <c:if
                                                                    test="${user.userType.userTypeId == 3 && user.status.statusId == 1 && user.questionCount >= 0 && user.replyCount >= 0}">
                                                                    <button class="btn btn-outline-primary btn-icon"
                                                                        title="Promote to Moderator"
                                                                        onclick="openPromoteModal('${user.userId}')"">
                                                                        <i class=" bi bi-award"></i>
                                                                    </button>
                                                                </c:if>
                                                            </div>
                                                        </td>
                                                        <td class="align-middle">
                                                            <c:choose>
                                                                <c:when test="${user.status.statusId == 1}">
                                                                    <span
                                                                        class="badge badge-active rounded-pill px-3 py-1">Active</span>
                                                                </c:when>
                                                                <c:when test="${user.status.statusId == 2}">
                                                                    <span
                                                                        class="badge badge-inactive rounded-pill px-3 py-1">Inactive</span>
                                                                </c:when>
                                                                <c:when test="${user.status.statusId == 3}">
                                                                    <span
                                                                        class="badge badge-banned rounded-pill px-3 py-1">Banned</span>
                                                                </c:when>
                                                                <c:when test="${user.status.statusId == 4}">
                                                                    <span
                                                                        class="badge badge-deactivated rounded-pill px-3 py-1">Deactivated</span>
                                                                </c:when>
                                                                <c:when test="${user.status.statusId == 9}">
                                                                    <span
                                                                        class="badge badge-suspended rounded-pill px-3 py-1">Suspended</span>
                                                                </c:when>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>

                                        </table>
                                    </div>
                                </div>
                                <div class="card-footer bg-white">
                                    <nav aria-label="User pagination">
                                        <ul class="pagination pagination-sm justify-content-end mb-0">
                                            <c:if test="${currentPage != 1}">
                                                <li class="page-item">
                                                    <a class="page-link"
                                                        href="user_management.do?page=${currentPage-1}">Previous</a>
                                                </li>
                                            </c:if>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <c:choose>
                                                    <c:when test="${currentPage == i}">
                                                        <li class="page-item active">
                                                            <a class="page-link" href="#">${i}</a>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="page-item">
                                                            <a class="page-link"
                                                                href="user_management.do?page=${i}">${i}</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>

                                            <c:if test="${currentPage < totalPages}">
                                                <li class="page-item">
                                                    <a class="page-link"
                                                        href="user_management.do?page=${currentPage+1}">Next</a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Promotion Criteria Section -->
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <div class="card shadow-sm">
                                <div class="card-header bg-white">
                                    <h5 class="mb-0">Moderator Promotion Criteria</h5>
                                </div>
                                <div class="card-body">
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item d-flex align-items-center">
                                            <i class="bi bi-check-circle-fill text-success me-3"></i>
                                            <div>
                                                <strong>Minimum 20 Questions</strong>
                                                <p class="mb-0 text-muted small">User must have posted at least 20
                                                    questions
                                                </p>
                                            </div>
                                        </li>
                                        <li class="list-group-item d-flex align-items-center">
                                            <i class="bi bi-check-circle-fill text-success me-3"></i>
                                            <div>
                                                <strong>Minimum 50 Replies</strong>
                                                <p class="mb-0 text-muted small">User must have posted at least 50
                                                    replies
                                                </p>
                                            </div>
                                        </li>
                                        <li class="list-group-item d-flex align-items-center">
                                            <i class="bi bi-check-circle-fill text-success me-3"></i>
                                            <div>
                                                <strong>Active Status</strong>
                                                <p class="mb-0 text-muted small">Account must be in good standing with
                                                    no
                                                    violations</p>
                                            </div>
                                        </li>
                                        <li class="list-group-item d-flex align-items-center">
                                            <i class="bi bi-check-circle-fill text-success me-3"></i>
                                            <div>
                                                <strong>User Confirmation</strong>
                                                <p class="mb-0 text-muted small">User must confirm via email that they
                                                    accept the moderator role</p>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-4">
                            <div class="card shadow-sm">
                                <div class="card-header bg-white">
                                    <h5 class="mb-0">User Activity Summary</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <div class="card bg-light">
                                                <div class="card-body py-3">
                                                    <div class="d-flex align-items-center">
                                                        <div
                                                            class="flex-shrink-0 bg-primary rounded-circle p-3 text-white">
                                                            <i class="bi bi-people-fill"></i>
                                                        </div>
                                                        <div class="ms-3">
                                                            <h6 class="mb-0 text-muted">Total Users</h6>
                                                            <h3 class="mb-0" id="totalUsersCount">${totalUsersCount}
                                                            </h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="card bg-light">
                                                <div class="card-body py-3">
                                                    <div class="d-flex align-items-center">
                                                        <div
                                                            class="flex-shrink-0 bg-success rounded-circle p-3 text-white">
                                                            <i class="bi bi-person-check-fill"></i>
                                                        </div>
                                                        <div class="ms-3">
                                                            <h6 class="mb-0 text-muted">Active Users</h6>
                                                            <h3 class="mb-0" id="activeUsersCount">${activeUsersCount}
                                                            </h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="card bg-light">
                                                <div class="card-body py-3">
                                                    <div class="d-flex align-items-center">
                                                        <div
                                                            class="flex-shrink-0 bg-info rounded-circle p-3 text-white">
                                                            <i class="bi bi-shield"></i>
                                                        </div>
                                                        <div class="ms-3">
                                                            <h6 class="mb-0 text-muted">Moderators</h6>
                                                            <h3 class="mb-0" id="moderatorsCount">${moderatorCount}</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="card bg-light">
                                                <div class="card-body py-3">
                                                    <div class="d-flex align-items-center">
                                                        <div
                                                            class="flex-shrink-0 bg-warning rounded-circle p-3 text-white">
                                                            <i class="bi bi-exclamation-triangle text-white fs-4"></i>
                                                        </div>
                                                        <div class="ms-3">
                                                            <h6 class="mb-0 text-muted">Banned Users</h6>
                                                            <h3 class="mb-0" id="bannedCount">${bannedCount}</h3>
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
                </div>
            </div>
        </div>
    </div>
    </div>

    <!-- Email Preview Modal -->
    <div class="modal fade" id="promoteModal" tabindex="-1" aria-labelledby="promoteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="promoteModalLabel">Moderator Invitation Email</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">To:</label>
                        <input type="email" class="form-control" id="emailTo" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Subject:</label>
                        <input type="text" class="form-control" id="emailSubject"
                            value="Invitation to become a Moderator" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email Body:</label>
                        <div class="card">
                            <div class="card-body">
                                <div id="emailBody">
                                    <h4>Hello <span id="emailUsername"></span>,</h4>
                                    <p>Congratulations! Based on your active participation and valuable
                                        contributions to our community, you've been selected as a potential
                                        moderator.</p>

                                    <p>Your activity metrics:</p>
                                    <ul>
                                        <li>Questions: <span id="emailQuestions"></span></li>
                                        <li>Replies: <span id="emailReplies"></span></li>
                                    </ul>

                                    <p>As a moderator, you'll have additional responsibilities and permissions:</p>
                                    <ul>
                                        <li>Review and approve/reject user content</li>
                                        <li>Handle user reports</li>
                                        <li>Help maintain community guidelines</li>
                                    </ul>

                                    <p>If you're interested in accepting this role, please click the confirmation
                                        button below:</p>

                                    <div style="text-align: center; margin: 20px 0;">
                                        <a href="#"
                                            style="background-color: #0d6efd; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-weight: bold;">
                                            Accept Moderator Role
                                        </a>
                                    </div>

                                    <p>If you have any questions about what this role entails, feel free to reply to
                                        this email.</p>

                                    <p>Thank you for your contributions to our community!</p>

                                    <p>Best regards,<br>The Admin Team</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="sendPromotionBtn">Send Invitation</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="static/js/bootstrap js/bootstrap.bundle.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="static/js/header.js"></script>
    <script src="static/js/user_management.js"></script>

</body>

</html>