<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Moderator Dashboard</title>
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
        .stat-card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        .activity-item {
            border-left: 3px solid #3b82f6;
            padding-left: 15px;
            margin-bottom: 15px;
        }
        .chart-container {
            height: 300px;
            margin-bottom: 20px;
        }
        .report-badge {
            position: absolute;
            top: 10px;
            right: 10px;
        }
        .priority-high {
            background-color: #dc3545;
        }
        .priority-medium {
            background-color: #fd7e14;
        }
        .priority-low {
            background-color: #0dcaf0;
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
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h2 class="dashboard-title">Moderator Dashboard</h2>
                                <p class="text-muted">Welcome, ${user.name}! You have <span class="text-danger fw-bold">8</span> pending reports to review.</p>
                            </div>
                            <div>
                                <button class="btn btn-outline-secondary">
                                    <i class="fas fa-history me-2"></i>Activity Log
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Moderator Stats -->
                <div class="row mb-4">
                    <div class="col-md-4">
                        <div class="card stat-card bg-danger text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5 class="card-title">Pending Reports</h5>
                                        <h2 class="mb-0">8</h2>
                                    </div>
                                    <div>
                                        <i class="fas fa-flag fa-2x"></i>
                                    </div>
                                </div>
                                <p class="mt-2 mb-0">3 high priority reports</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card bg-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5 class="card-title">Posts Moderated</h5>
                                        <h2 class="mb-0">31</h2>
                                    </div>
                                    <div>
                                        <i class="fas fa-check-circle fa-2x"></i>
                                    </div>
                                </div>
                                <p class="mt-2 mb-0">Today: 7 posts</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card bg-info text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5 class="card-title">Resolution Time</h5>
                                        <h2 class="mb-0">43m</h2>
                                    </div>
                                    <div>
                                        <i class="fas fa-clock fa-2x"></i>
                                    </div>
                                </div>
                                <p class="mt-2 mb-0">Average response time</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <a href="reported_posts.do" class="card card-hover text-decoration-none text-dark">
                                            <div class="card-body text-center">
                                                <i class="fas fa-flag fa-3x text-danger mb-3"></i>
                                                <h5>View Reported Posts</h5>
                                                <p class="text-muted mb-0">Review and manage reported content</p>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <a href="index.do" class="card card-hover text-decoration-none text-dark">
                                            <div class="card-body text-center">
                                                <i class="fas fa-trash-alt fa-3x text-warning mb-3"></i>
                                                <h5>Delete Posts</h5>
                                                <p class="text-muted mb-0">Remove inappropriate content</p>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Reports -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Recent Reports</h5>
                                <a href="all_reports.do" class="text-primary">View All Reports</a>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Type</th>
                                                <th>Content</th>
                                                <th>Reported By</th>
                                                <th>Date</th>
                                                <th>Priority</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>#1482</td>
                                                <td>Post</td>
                                                <td>How to bypass security measures...</td>
                                                <td>user1234</td>
                                                <td>10 min ago</td>
                                                <td><span class="badge bg-danger">High</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary me-1"><i class="fas fa-eye"></i></button>
                                                    <button class="btn btn-sm btn-outline-danger"><i class="fas fa-trash-alt"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>#1481</td>
                                                <td>Comment</td>
                                                <td>This is completely wrong information...</td>
                                                <td>techexpert</td>
                                                <td>35 min ago</td>
                                                <td><span class="badge bg-warning text-dark">Medium</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary me-1"><i class="fas fa-eye"></i></button>
                                                    <button class="btn btn-sm btn-outline-danger"><i class="fas fa-trash-alt"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>#1480</td>
                                                <td>Post</td>
                                                <td>Need help with personal information...</td>
                                                <td>moderator2</td>
                                                <td>1 hour ago</td>
                                                <td><span class="badge bg-danger">High</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary me-1"><i class="fas fa-eye"></i></button>
                                                    <button class="btn btn-sm btn-outline-danger"><i class="fas fa-trash-alt"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>#1479</td>
                                                <td>Comment</td>
                                                <td>Check out my website at http://suspicious-link...</td>
                                                <td>newuser99</td>
                                                <td>3 hours ago</td>
                                                <td><span class="badge bg-info">Low</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary me-1"><i class="fas fa-eye"></i></button>
                                                    <button class="btn btn-sm btn-outline-danger"><i class="fas fa-trash-alt"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>#1478</td>
                                                <td>Post</td>
                                                <td>Offensive content about minority groups...</td>
                                                <td>community_helper</td>
                                                <td>5 hours ago</td>
                                                <td><span class="badge bg-danger">High</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary me-1"><i class="fas fa-eye"></i></button>
                                                    <button class="btn btn-sm btn-outline-danger"><i class="fas fa-trash-alt"></i></button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Your Recent Activity</h5>
                                <a href="#" class="text-primary">View All</a>
                            </div>
                            <div class="card-body">
                                <div class="activity-item">
                                    <p class="mb-1 fw-bold">Post Deleted</p>
                                    <p class="text-muted mb-0">You removed a post that violated community guidelines</p>
                                    <small class="text-muted">10 minutes ago</small>
                                </div>
                                <div class="activity-item">
                                    <p class="mb-1 fw-bold">Report Resolved</p>
                                    <p class="text-muted mb-0">You marked report #1477 as resolved</p>
                                    <small class="text-muted">35 minutes ago</small>
                                </div>
                                <div class="activity-item">
                                    <p class="mb-1 fw-bold">Comment Deleted</p>
                                    <p class="text-muted mb-0">You removed a comment that contained personal information</p>
                                    <small class="text-muted">1 hour ago</small>
                                </div>
                                <div class="activity-item">
                                    <p class="mb-1 fw-bold">Login</p>
                                    <p class="text-muted mb-0">You logged in to the moderator dashboard</p>
                                    <small class="text-muted">3 hours ago</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Moderation Guidelines</h5>
                            </div>
                            <div class="card-body">
                                <div class="alert alert-info" role="alert">
                                    <i class="fas fa-info-circle me-2"></i>
                                    <span>Remember to review the full context before taking action on any report.</span>
                                </div>
                                <p><strong>High Priority Reports:</strong> These require immediate attention and should be addressed within 1 hour.</p>
                                <p><strong>Medium Priority Reports:</strong> Should be addressed within 4 hours.</p>
                                <p><strong>Low Priority Reports:</strong> Should be addressed within 24 hours.</p>
                                <p>If you're unsure about any report, please consult with a senior moderator before taking action.</p>
                                <div class="mt-3">
                                    <a href="moderation_guidelines.do" class="btn btn-outline-primary">
                                        <i class="fas fa-book me-2"></i>Full Guidelines
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="static/js/header.js"></script>
   
</body>
</html>