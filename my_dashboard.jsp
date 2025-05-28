<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="static/css/home.css">
    <link rel="stylesheet" href="static/css/header.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .card-hover:hover {
            transform: translateY(-5px);
            transition: transform 0.3s ease;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
        }
        .stat-card {
            border-radius: 10px;
            border: none;
            transition: all 0.3s;
        }
        .stat-icon {
            width: 48px;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
        }
        .nav-pills .nav-link.active {
            background-color: #3a86ff;
        }
        .nav-pills .nav-link {
            color: #495057;
            font-weight: 500;
        }
        .dashboard-header {
            background: linear-gradient(135deg, #3a86ff 0%, #8338ec 100%);
            color: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 25px;
        }
        .table-hover tbody tr:hover {
            background-color: rgba(58, 134, 255, 0.05);
        }
        .action-btn {
            width: 32px;
            height: 32px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
            margin-right: 5px;
        }
        .post-content {
            max-height: 80px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
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

            <div class="container-fluid">
                <div class="row">
                    <div class="col-auto bg-light" style="width: 240px;">
                        <c:import url="navbar.jsp" />
                    </div>
        
                    <div class="col bg-light px-4 py-4">
                        <div class="dashboard-header shadow-sm">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h1 class="display-6 mb-0 fw-semibold">My Dashboard</h1>
                                    <p class="mt-2 mb-0">Manage your posts and track your activity</p>
                                </div>
                                <div>
                                    <button class="btn btn-light d-flex align-items-center" data-bs-toggle="modal" data-bs-target="#newPostModal">
                                        <i class="bi bi-plus-circle me-2"></i> New Post
                                    </button>
                                </div>
                            </div>
                        </div>
        
                        <!-- Sample data for user stats -->
                        <div class="row mb-4">
                            <div class="col-md-3">
                                <div class="card stat-card shadow-sm card-hover">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <div class="stat-icon bg-primary-subtle me-3">
                                                <i class="bi bi-file-earmark-text fs-4 text-primary"></i>
                                            </div>
                                            <div>
                                                <h6 class="mb-0 text-muted">Total Posts</h6>
                                                <h4 class="mb-0">12</h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card stat-card shadow-sm card-hover">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <div class="stat-icon bg-success-subtle me-3">
                                                <i class="bi bi-eye fs-4 text-success"></i>
                                            </div>
                                            <div>
                                                <h6 class="mb-0 text-muted">Views</h6>
                                                <h4 class="mb-0">1,453</h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card stat-card shadow-sm card-hover">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <div class="stat-icon bg-warning-subtle me-3">
                                                <i class="bi bi-reply fs-4 text-warning"></i>
                                            </div>
                                            <div>
                                                <h6 class="mb-0 text-muted">Responses</h6>
                                                <h4 class="mb-0">87</h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card stat-card shadow-sm card-hover">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <div class="stat-icon bg-danger-subtle me-3">
                                                <i class="bi bi-heart fs-4 text-danger"></i>
                                            </div>
                                            <div>
                                                <h6 class="mb-0 text-muted">Likes</h6>
                                                <h4 class="mb-0">219</h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
        
                        <div class="card shadow-sm mb-4">
                            <div class="card-body">
                                <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="pills-all-tab" data-bs-toggle="pill" data-bs-target="#pills-all" type="button" role="tab" aria-controls="pills-all" aria-selected="true">All Posts</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="pills-published-tab" data-bs-toggle="pill" data-bs-target="#pills-published" type="button" role="tab" aria-controls="pills-published" aria-selected="false">Published</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="pills-draft-tab" data-bs-toggle="pill" data-bs-target="#pills-draft" type="button" role="tab" aria-controls="pills-draft" aria-selected="false">Drafts</button>
                                    </li>
                                </ul>
                                
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div class="input-group" style="max-width: 300px;">
                                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                                        <input type="text" id="postSearch" class="form-control" placeholder="Search posts..." oninput="filterPosts()">
                                    </div>
                                    <div class="dropdown">
                                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                            <i class="bi bi-sort-down me-1"></i> Sort by
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="sortDropdown">
                                            <li><a class="dropdown-item" href="#" onclick="sortPosts('newest')">Newest</a></li>
                                            <li><a class="dropdown-item" href="#" onclick="sortPosts('oldest')">Oldest</a></li>
                                            <li><a class="dropdown-item" href="#" onclick="sortPosts('popular')">Most Popular</a></li>
                                        </ul>
                                    </div>
                                </div>
        
                                <div class="tab-content" id="pills-tabContent">
                                    <div class="tab-pane fade show active" id="pills-all" role="tabpanel" aria-labelledby="pills-all-tab">
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle">
                                                <thead>
                                                    <tr>
                                                        <th>Title</th>
                                                        <th>Topic</th>
                                                        <th>Date</th>
                                                        <th>Status</th>
                                                        <th>Stats</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- Sample data for posts -->
                                                    <tr class="post-row">
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <div>
                                                                    <h6 class="mb-1">Understanding React Hooks in 2025</h6>
                                                                    <p class="text-muted mb-0 post-content">React Hooks have revolutionized how we write React components. In this post, I'll cover the latest updates and best practices for using React Hooks effectively. We'll explore useEffect, useState, and custom hooks with practical examples.</p>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td><span class="badge bg-primary-subtle text-primary">React</span></td>
                                                        <td><small class="text-muted">Mar 28, 2025</small></td>
                                                        <td>
                                                            <span class="badge bg-success">Published</span>
                                                        </td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <span class="me-2"><i class="bi bi-eye text-muted"></i> 423</span>
                                                                <span class="me-2"><i class="bi bi-reply text-muted"></i> 24</span>
                                                                <span><i class="bi bi-heart text-muted"></i> 68</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-sm btn-outline-primary action-btn" title="Edit">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-danger action-btn" title="Delete">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-success action-btn" title="View">
                                                                <i class="bi bi-eye"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr class="post-row">
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <div>
                                                                    <h6 class="mb-1">Top 10 Machine Learning Algorithms You Should Know</h6>
                                                                    <p class="text-muted mb-0 post-content">Machine learning is continuously evolving, but some algorithms remain fundamental. In this comprehensive guide, I'll walk through the top 10 algorithms that every data scientist should master, with code examples and use cases.</p>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td><span class="badge bg-primary-subtle text-primary">Machine Learning</span></td>
                                                        <td><small class="text-muted">Mar 15, 2025</small></td>
                                                        <td>
                                                            <span class="badge bg-success">Published</span>
                                                        </td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <span class="me-2"><i class="bi bi-eye text-muted"></i> 512</span>
                                                                <span class="me-2"><i class="bi bi-reply text-muted"></i> 38</span>
                                                                <span><i class="bi bi-heart text-muted"></i> 91</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-sm btn-outline-primary action-btn" title="Edit">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-danger action-btn" title="Delete">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-success action-btn" title="View">
                                                                <i class="bi bi-eye"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr class="post-row">
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <div>
                                                                    <h6 class="mb-1">Microservices vs Monoliths: Which Architecture is Right for You?</h6>
                                                                    <p class="text-muted mb-0 post-content">The debate between microservices and monolithic architectures continues. This post explores the pros and cons of each approach, helping you decide which is best for your specific project requirements.</p>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td><span class="badge bg-primary-subtle text-primary">Architecture</span></td>
                                                        <td><small class="text-muted">Mar 10, 2025</small></td>
                                                        <td>
                                                            <span class="badge bg-success">Published</span>
                                                        </td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <span class="me-2"><i class="bi bi-eye text-muted"></i> 389</span>
                                                                <span class="me-2"><i class="bi bi-reply text-muted"></i> 15</span>
                                                                <span><i class="bi bi-heart text-muted"></i> 43</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-sm btn-outline-primary action-btn" title="Edit">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-danger action-btn" title="Delete">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-success action-btn" title="View">
                                                                <i class="bi bi-eye"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr class="post-row">
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <div>
                                                                    <h6 class="mb-1">The Future of Blockchain in Software Development</h6>
                                                                    <p class="text-muted mb-0 post-content">Blockchain technology is expanding beyond cryptocurrencies. I'll explore emerging use cases in software development, from smart contracts to decentralized applications.</p>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td><span class="badge bg-primary-subtle text-primary">Blockchain</span></td>
                                                        <td><small class="text-muted">Mar 5, 2025</small></td>
                                                        <td>
                                                            <span class="badge bg-secondary">Draft</span>
                                                        </td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <span class="me-2"><i class="bi bi-eye text-muted"></i> 0</span>
                                                                <span class="me-2"><i class="bi bi-reply text-muted"></i> 0</span>
                                                                <span><i class="bi bi-heart text-muted"></i> 0</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-sm btn-outline-primary action-btn" title="Edit">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-danger action-btn" title="Delete">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-success action-btn" title="View">
                                                                <i class="bi bi-eye"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr class="post-row">
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <div>
                                                                    <h6 class="mb-1">Optimizing PostgreSQL Performance: Advanced Techniques</h6>
                                                                    <p class="text-muted mb-0 post-content">Database performance can make or break your application. This post dives into advanced techniques for optimizing PostgreSQL, including indexing strategies, query optimization, and server tuning.</p>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td><span class="badge bg-primary-subtle text-primary">Database</span></td>
                                                        <td><small class="text-muted">Feb 28, 2025</small></td>
                                                        <td>
                                                            <span class="badge bg-success">Published</span>
                                                        </td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <span class="me-2"><i class="bi bi-eye text-muted"></i> 129</span>
                                                                <span class="me-2"><i class="bi bi-reply text-muted"></i> 10</span>
                                                                <span><i class="bi bi-heart text-muted"></i> 17</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-sm btn-outline-primary action-btn" title="Edit">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-danger action-btn" title="Delete">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-success action-btn" title="View">
                                                                <i class="bi bi-eye"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="pills-published" role="tabpanel" aria-labelledby="pills-published-tab">
                                        <div class="alert alert-info">
                                            <i class="bi bi-info-circle me-2"></i> Filter applied: Published posts only
                                        </div>
                                        <!-- Would contain filtered published posts -->
                                    </div>
                                    <div class="tab-pane fade" id="pills-draft" role="tabpanel" aria-labelledby="pills-draft-tab">
                                        <div class="alert alert-info">
                                            <i class="bi bi-info-circle me-2"></i> Filter applied: Draft posts only
                                        </div>
                                        <!-- Would contain filtered draft posts -->
                                    </div>
                                </div>
                            </div>
                        </div>
        
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title mb-3">Recent Activity</h5>
                                <ul class="list-group list-group-flush">
                                    <!-- Sample data for recent activity -->
                                    <li class="list-group-item px-0">
                                        <div class="d-flex align-items-center">
                                            <div class="me-3">
                                                <div class="bg-info-subtle rounded-circle p-2">
                                                    <i class="bi bi-chat-text text-info"></i>
                                                </div>
                                            </div>
                                            <div>
                                                <p class="mb-0">John Doe commented on your post "<a href="#">Understanding React Hooks in 2025</a>"</p>
                                                <small class="text-muted">Today at 10:45 AM</small>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item px-0">
                                        <div class="d-flex align-items-center">
                                            <div class="me-3">
                                                <div class="bg-danger-subtle rounded-circle p-2">
                                                    <i class="bi bi-heart text-danger"></i>
                                                </div>
                                            </div>
                                            <div>
                                                <p class="mb-0">Sara Miller liked your post "<a href="#">Top 10 Machine Learning Algorithms You Should Know</a>"</p>
                                                <small class="text-muted">Yesterday at 8:30 PM</small>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item px-0">
                                        <div class="d-flex align-items-center">
                                            <div class="me-3">
                                                <div class="bg-primary-subtle rounded-circle p-2">
                                                    <i class="bi bi-file-earmark-text text-primary"></i>
                                                </div>
                                            </div>
                                            <div>
                                                <p class="mb-0">You published a new post "<a href="#">Microservices vs Monoliths: Which Architecture is Right for You?</a>"</p>
                                                <small class="text-muted">Mar 10, 2025</small>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item px-0">
                                        <div class="d-flex align-items-center">
                                            <div class="me-3">
                                                <div class="bg-info-subtle rounded-circle p-2">
                                                    <i class="bi bi-chat-text text-info"></i>
                                                </div>
                                            </div>
                                            <div>
                                                <p class="mb-0">Mike Johnson commented on your post "<a href="#">Optimizing PostgreSQL Performance: Advanced Techniques</a>"</p>
                                                <small class="text-muted">Mar 1, 2025</small>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item px-0">
                                        <div class="d-flex align-items-center">
                                            <div class="me-3">
                                                <div class="bg-danger-subtle rounded-circle p-2">
                                                    <i class="bi bi-heart text-danger"></i>
                                                </div>
                                            </div>
                                            <div>
                                                <p class="mb-0">Emily Chen and 3 others liked your post "<a href="#">Optimizing PostgreSQL Performance: Advanced Techniques</a>"</p>
                                                <small class="text-muted">Feb 28, 2025</small>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
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