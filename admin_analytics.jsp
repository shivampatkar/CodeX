<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - User Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="static/css/home.css">
    <link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .dashboard-card {
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            margin-bottom: 1.5rem;
        }
        .stat-card {
            border-left: 4px solid;
            padding: 1rem;
            transition: transform 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-card.primary {
            border-left-color: #0d6efd;
        }
        .stat-card.success {
            border-left-color: #198754;
        }
        .stat-card.warning {
            border-left-color: #ffc107;
        }
        .stat-card.info {
            border-left-color: #0dcaf0;
        }
        .card-icon {
            font-size: 2rem;
            opacity: 0.7;
        }
        .badge-active {
            background-color: #198754;
            color: white;
        }
        .badge-suspended {
            background-color: #dc3545;
            color: white;
        }
        .badge-pending {
            background-color: #ffc107;
            color: #212529;
        }
        .badge-blocked {
            background-color: #6c757d;
            color: white;
        }
        .role-admin {
            background-color: #dc3545;
            color: white;
        }
        .role-moderator {
            background-color: #0d6efd;
            color: white;
        }
        .role-user {
            background-color: #6c757d;
            color: white;
        }
        .nav-pills .nav-link.active {
            background-color: #0d6efd;
        }
        .date-range-selector {
            border-radius: 20px;
            padding: 0.5rem 1rem;
            border: 1px solid #dee2e6;
            cursor: pointer;
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

            <!-- Main Content -->
            <div class="col-lg-10 p-4 bg-light">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Reports & Analytics</h2>
                    <div class="date-range-selector" id="dateRangeSelector">
                        <i class="bi bi-calendar3 me-2"></i>
                        <span id="selectedDateRange">Last 30 Days</span>
                        <i class="bi bi-chevron-down ms-2"></i>
                    </div>
                </div>

                <!-- Overview Cards -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card dashboard-card stat-card primary">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-subtitle text-muted">Total Users</h6>
                                        <h2 class="card-title mb-0" id="totalUsers">2,543</h2>
                                        <small class="text-success"><i class="bi bi-arrow-up"></i> 12.5% vs previous period</small>
                                    </div>
                                    <div class="card-icon text-primary">
                                        <i class="bi bi-people-fill"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card dashboard-card stat-card success">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-subtitle text-muted">Total Posts</h6>
                                        <h2 class="card-title mb-0" id="totalPosts">15,872</h2>
                                        <small class="text-success"><i class="bi bi-arrow-up"></i> 8.3% vs previous period</small>
                                    </div>
                                    <div class="card-icon text-success">
                                        <i class="bi bi-chat-square-text-fill"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card dashboard-card stat-card warning">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-subtitle text-muted">Active Users</h6>
                                        <h2 class="card-title mb-0" id="activeUsers">1,287</h2>
                                        <small class="text-danger"><i class="bi bi-arrow-down"></i> 3.2% vs previous period</small>
                                    </div>
                                    <div class="card-icon text-warning">
                                        <i class="bi bi-person-check-fill"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card dashboard-card stat-card info">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-subtitle text-muted">Content Reports</h6>
                                        <h2 class="card-title mb-0" id="contentReports">47</h2>
                                        <small class="text-success"><i class="bi bi-arrow-down"></i> 5.1% vs previous period</small>
                                    </div>
                                    <div class="card-icon text-info">
                                        <i class="bi bi-flag-fill"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="row mb-4">
                    <div class="col-md-8">
                        <div class="card dashboard-card">
                            <div class="card-header bg-white">
                                <h5 class="card-title mb-0">User Engagement Trends</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="engagementChart" height="300"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card dashboard-card">
                            <div class="card-header bg-white">
                                <h5 class="card-title mb-0">User Status Distribution</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="userStatusChart" height="300"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Content Performance & User Activity -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card dashboard-card">
                            <div class="card-header bg-white d-flex justify-content-between">
                                <h5 class="card-title mb-0">Content Performance</h5>
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="contentTypeDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                        All Categories
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="contentTypeDropdown">
                                        <li><a class="dropdown-item" href="#">All Categories</a></li>
                                        <li><a class="dropdown-item" href="#">General Discussion</a></li>
                                        <li><a class="dropdown-item" href="#">Technical Support</a></li>
                                        <li><a class="dropdown-item" href="#">Feature Requests</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover" id="contentTable">
                                        <thead>
                                            <tr>
                                                <th>Topic</th>
                                                <th>Category</th>
                                                <th>Replies</th>
                                                <th>Views</th>
                                                <th>Engagement</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Welcome to our community</td>
                                                <td>General Discussion</td>
                                                <td>124</td>
                                                <td>2,450</td>
                                                <td>
                                                    <div class="progress" style="height: 8px;">
                                                        <div class="progress-bar bg-success" role="progressbar" style="width: 85%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>How to use the new features</td>
                                                <td>Technical Support</td>
                                                <td>87</td>
                                                <td>1,850</td>
                                                <td>
                                                    <div class="progress" style="height: 8px;">
                                                        <div class="progress-bar bg-success" role="progressbar" style="width: 70%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Request: Dark mode option</td>
                                                <td>Feature Requests</td>
                                                <td>56</td>
                                                <td>980</td>
                                                <td>
                                                    <div class="progress" style="height: 8px;">
                                                        <div class="progress-bar bg-info" role="progressbar" style="width: 55%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Troubleshooting login issues</td>
                                                <td>Technical Support</td>
                                                <td>42</td>
                                                <td>760</td>
                                                <td>
                                                    <div class="progress" style="height: 8px;">
                                                        <div class="progress-bar bg-info" role="progressbar" style="width: 45%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Community guidelines update</td>
                                                <td>General Discussion</td>
                                                <td>28</td>
                                                <td>520</td>
                                                <td>
                                                    <div class="progress" style="height: 8px;">
                                                        <div class="progress-bar bg-warning" role="progressbar" style="width: 35%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card dashboard-card">
                            <div class="card-header bg-white d-flex justify-content-between">
                                <h5 class="card-title mb-0">User Activity</h5>
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="userActivityDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                        Last 7 Days
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="userActivityDropdown">
                                        <li><a class="dropdown-item" href="#">Last 7 Days</a></li>
                                        <li><a class="dropdown-item" href="#">Last 30 Days</a></li>
                                        <li><a class="dropdown-item" href="#">Last 90 Days</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover" id="userActivityTable">
                                        <thead>
                                            <tr>
                                                <th>User</th>
                                                <th>Role</th>
                                                <th>Posts</th>
                                                <th>Comments</th>
                                                <th>Last Active</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="user-avatar me-2">
                                                            <i class="bi bi-person-circle"></i>
                                                        </div>
                                                        <span>Emily Johnson</span>
                                                    </div>
                                                </td>
                                                <td><span class="badge role-moderator">Moderator</span></td>
                                                <td>32</td>
                                                <td>87</td>
                                                <td>2 hours ago</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="user-avatar me-2">
                                                            <i class="bi bi-person-circle"></i>
                                                        </div>
                                                        <span>Michael Smith</span>
                                                    </div>
                                                </td>
                                                <td><span class="badge role-user">User</span></td>
                                                <td>24</td>
                                                <td>56</td>
                                                <td>5 hours ago</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="user-avatar me-2">
                                                            <i class="bi bi-person-circle"></i>
                                                        </div>
                                                        <span>Jessica Brown</span>
                                                    </div>
                                                </td>
                                                <td><span class="badge role-admin">Admin</span></td>
                                                <td>18</td>
                                                <td>42</td>
                                                <td>1 day ago</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="user-avatar me-2">
                                                            <i class="bi bi-person-circle"></i>
                                                        </div>
                                                        <span>Robert Davis</span>
                                                    </div>
                                                </td>
                                                <td><span class="badge role-user">User</span></td>
                                                <td>15</td>
                                                <td>29</td>
                                                <td>2 days ago</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="user-avatar me-2">
                                                            <i class="bi bi-person-circle"></i>
                                                        </div>
                                                        <span>Sarah Wilson</span>
                                                    </div>
                                                </td>
                                                <td><span class="badge role-moderator">Moderator</span></td>
                                                <td>12</td>
                                                <td>35</td>
                                                <td>3 days ago</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- User Retention Chart and Geographic Distribution -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="card dashboard-card">
                            <div class="card-header bg-white">
                                <h5 class="card-title mb-0">User Retention</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="retentionChart" height="300"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card dashboard-card">
                            <div class="card-header bg-white">
                                <h5 class="card-title mb-0">Geographic Distribution</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover" id="geoDistributionTable">
                                        <thead>
                                            <tr>
                                                <th>Country</th>
                                                <th>Users</th>
                                                <th>% of Total</th>
                                                <th>Distribution</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>United States</td>
                                                <td>923</td>
                                                <td>36.3%</td>
                                                <td>
                                                    <div class="progress" style="height: 8px;">
                                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 36.3%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>United Kingdom</td>
                                                <td>412</td>
                                                <td>16.2%</td>
                                                <td>
                                                    <div class="progress" style="height: 8px;">
                                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 16.2%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Canada</td>
                                                <td>287</td>
                                                <td>11.3%</td>
                                                <td>
                                                    <div class="progress" style="height: 8px;">
                                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 11.3%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Australia</td>
                                                <td>245</td>
                                                <td>9.6%</td>
                                                <td>
                                                    <div class="progress" style="height: 8px;">
                                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 9.6%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Germany</td>
                                                <td>178</td>
                                                <td>7.0%</td>
                                                <td>
                                                    <div class="progress" style="height: 8px;">
                                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 7.0%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Other Countries</td>
                                                <td>498</td>
                                                <td>19.6%</td>
                                                <td>
                                                    <div class="progress" style="height: 8px;">
                                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 19.6%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
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
    <script>
        // User Engagement Chart
        document.addEventListener('DOMContentLoaded', function() {
            var engagementCtx = document.getElementById('engagementChart').getContext('2d');
            var engagementChart = new Chart(engagementCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'New Users',
                        data: [65, 82, 78, 95, 120, 132, 145, 150, 142, 160, 175, 182],
                        borderColor: '#0d6efd',
                        backgroundColor: 'rgba(13, 110, 253, 0.1)',
                        tension: 0.4,
                        fill: true
                    }, {
                        label: 'Posts',
                        data: [150, 175, 200, 220, 270, 310, 350, 375, 390, 420, 450, 490],
                        borderColor: '#198754',
                        backgroundColor: 'rgba(25, 135, 84, 0.1)',
                        tension: 0.4,
                        fill: true
                    }, {
                        label: 'Comments',
                        data: [320, 350, 380, 410, 480, 520, 580, 610, 650, 690, 730, 780],
                        borderColor: '#ffc107',
                        backgroundColor: 'rgba(255, 193, 7, 0.1)',
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'top'
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            // User Status Chart
            var statusCtx = document.getElementById('userStatusChart').getContext('2d');
            var statusChart = new Chart(statusCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Active', 'Pending', 'Suspended', 'Blocked'],
                    datasets: [{
                        data: [1287, 352, 68, 89],
                        backgroundColor: [
                            '#198754',
                            '#ffc107',
                            '#dc3545',
                            '#6c757d'
                        ],
                        hoverOffset: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });

            // Retention Chart
            var retentionCtx = document.getElementById('retentionChart').getContext('2d');
            var retentionChart = new Chart(retentionCtx, {
                type: 'bar',
                data: {
                    labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Month 2', 'Month 3'],
                    datasets: [{
                        label: 'User Retention Rate (%)',
                        data: [100, 87, 75, 68, 54, 42],
                        backgroundColor: [
                            'rgba(13, 110, 253, 0.8)',
                            'rgba(13, 110, 253, 0.7)',
                            'rgba(13, 110, 253, 0.6)',
                            'rgba(13, 110, 253, 0.5)',
                            'rgba(13, 110, 253, 0.4)',
                            'rgba(13, 110, 253, 0.3)'
                        ],
                        borderColor: [
                            'rgba(13, 110, 253, 1)',
                            'rgba(13, 110, 253, 1)',
                            'rgba(13, 110, 253, 1)',
                            'rgba(13, 110, 253, 1)',
                            'rgba(13, 110, 253, 1)',
                            'rgba(13, 110, 253, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 100
                        }
                    }
                }
            });

            // Date Range Selector Functionality
            document.getElementById('dateRangeSelector').addEventListener('click', function() {
                // This would typically trigger a dropdown or date picker
                alert('Date range selector clicked. In a real implementation, this would open a date picker.');
            });
        });
    </script>
   
    
</body>
</html>