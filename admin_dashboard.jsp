<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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
                    <div class="col-md-10 col-sm-5 ">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h2 class="dashboard-title">Admin Dashboard</h2>
                                <p class="text-muted">Welcome back, ${user.name}! Here's what's happening today.</p>
                            </div>
                            <div>
                                <button class="btn btn-primary">
                                    <i class="fas fa-download me-2"></i>Download Report
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Dashboard Stats -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card stat-card bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5 class="card-title">Total Users</h5>
                                        <h2 class="mb-0">1,254</h2>
                                    </div>
                                    <div>
                                        <i class="fas fa-users fa-2x"></i>
                                    </div>
                                </div>
                                <p class="mt-2 mb-0"><i class="fas fa-arrow-up"></i> 12% from last month</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card bg-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5 class="card-title">Questions</h5>
                                        <h2 class="mb-0">842</h2>
                                    </div>
                                    <div>
                                        <i class="fas fa-question-circle fa-2x"></i>
                                    </div>
                                </div>
                                <p class="mt-2 mb-0"><i class="fas fa-arrow-up"></i> 8% from last month</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card bg-warning text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5 class="card-title">Open Tickets</h5>
                                        <h2 class="mb-0">14</h2>
                                    </div>
                                    <div>
                                        <i class="fas fa-ticket-alt fa-2x"></i>
                                    </div>
                                </div>
                                <p class="mt-2 mb-0"><i class="fas fa-arrow-down"></i> 3% from last month</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card bg-info text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5 class="card-title">Active Users</h5>
                                        <h2 class="mb-0">128</h2>
                                    </div>
                                    <div>
                                        <i class="fas fa-user-check fa-2x"></i>
                                    </div>
                                </div>
                                <p class="mt-2 mb-0"><i class="fas fa-arrow-up"></i> 5% from last month</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Access -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Quick Access</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <a href="user_management.do" class="card card-hover text-decoration-none text-dark">
                                            <div class="card-body text-center">
                                                <i class="fas fa-users fa-3x text-primary mb-3"></i>
                                                <h5>User Management</h5>
                                                <p class="text-muted mb-0">Manage all user accounts</p>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="analytics-reports.jsp" class="card card-hover text-decoration-none text-dark">
                                            <div class="card-body text-center">
                                                <i class="fas fa-chart-line fa-3x text-success mb-3"></i>
                                                <h5>Analytics & Reports</h5>
                                                <p class="text-muted mb-0">View site performance data</p>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="content-management.jsp" class="card card-hover text-decoration-none text-dark">
                                            <div class="card-body text-center">
                                                <i class="fas fa-file-alt fa-3x text-warning mb-3"></i>
                                                <h5>Content Management</h5>
                                                <p class="text-muted mb-0">Manage all site content</p>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="category-management.jsp" class="card card-hover text-decoration-none text-dark">
                                            <div class="card-body text-center">
                                                <i class="fas fa-tag fa-3x text-info mb-3"></i>
                                                <h5>Category Management</h5>
                                                <p class="text-muted mb-0">Organize question categories</p>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity and User Stats -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Recent Activity</h5>
                                <a href="#" class="text-primary">View All</a>
                            </div>
                            <div class="card-body">
                                <div class="activity-item">
                                    <p class="mb-1 fw-bold">New user registered</p>
                                    <p class="text-muted mb-0">Sarah Johnson just created an account</p>
                                    <small class="text-muted">10 minutes ago</small>
                                </div>
                                <div class="activity-item">
                                    <p class="mb-1 fw-bold">Question reported</p>
                                    <p class="text-muted mb-0">A question was flagged for inappropriate content</p>
                                    <small class="text-muted">35 minutes ago</small>
                                </div>
                                <div class="activity-item">
                                    <p class="mb-1 fw-bold">New answer posted</p>
                                    <p class="text-muted mb-0">Mark Zhang answered a trending question</p>
                                    <small class="text-muted">1 hour ago</small>
                                </div>
                                <div class="activity-item">
                                    <p class="mb-1 fw-bold">Category added</p>
                                    <p class="text-muted mb-0">New "Machine Learning" subcategory created</p>
                                    <small class="text-muted">3 hours ago</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">System Status</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-4">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>Server Load</span>
                                        <span>42%</span>
                                    </div>
                                    <div class="progress">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 42%" aria-valuenow="42" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </div>
                                <div class="mb-4">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>Database Usage</span>
                                        <span>67%</span>
                                    </div>
                                    <div class="progress">
                                        <div class="progress-bar bg-warning" role="progressbar" style="width: 67%" aria-valuenow="67" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </div>
                                <div>
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>Storage Space</span>
                                        <span>28%</span>
                                    </div>
                                    <div class="progress">
                                        <div class="progress-bar bg-info" role="progressbar" style="width: 28%" aria-valuenow="28" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </div>
                                <div class="mt-4">
                                    <div class="alert alert-success d-flex align-items-center" role="alert">
                                        <i class="fas fa-check-circle me-2"></i>
                                        <div>All systems operational</div>
                                    </div>
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