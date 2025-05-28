<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Moderator Role Accepted | Codex</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <style>
        .blue-gradient {
            background: linear-gradient(135deg, #0d47a1, #1976d2, #2196f3);
        }
        .blue-gradient-light {
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
        }
        .privilege-item {
            transition: all 0.3s ease;
            border-radius: 10px;
        }
        .privilege-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(33, 150, 243, 0.3);
        }
        .logo-font {
            font-family: 'Courier New', monospace;
            font-weight: 800;
        }
        .card-custom {
            border-radius: 20px;
            overflow: hidden;
        }
        .btn-blue-gradient {
            background: linear-gradient(to right, #1565c0, #0d47a1);
            border: none;
            transition: all 0.3s ease;
        }
        .btn-blue-gradient:hover {
            background: linear-gradient(to right, #0d47a1, #1565c0);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(13, 71, 161, 0.4);
        }
        .check-animation {
            animation: pulse 1.5s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        .card-header-custom {
            padding: 2rem;
        }
        .badge-moderator {
            background: linear-gradient(to right, #1565c0, #0d47a1);
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 3px 8px rgba(13, 71, 161, 0.3);
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card border-0 shadow-lg card-custom">
                    <!-- Header with logo -->
                    <div class="card-header blue-gradient text-white card-header-custom">
                        <div class="d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center">
                                <div class="display-6 me-2 logo-font">&lt;/&gt;</div>
                                <h3 class="mb-0 fw-bold">Codex</h3>
                            </div>
                            <span class="badge-moderator">
                                <i class="bi bi-shield-fill me-1"></i> Moderator
                            </span>
                        </div>
                    </div>
                    
                    <!-- Success icon -->
                    <div class="text-center pt-5">
                        <div class="display-1 text-primary check-animation">
                            <i class="bi bi-check-circle-fill"></i>
                        </div>
                    </div>
                    
                    <!-- Card content -->
                    <div class="card-body p-5">
                        <h4 class="card-title text-center fw-bold mb-4" style="color: #0d47a1;">Moderator Role Accepted!</h4>
                        
                        <div class="alert border-start border-4 mb-4" style="border-color: #1976d2; background-color: rgba(33, 150, 243, 0.1);">
                            <p class="mb-0">Thank you for accepting the moderator role. You now have access to additional features and responsibilities on our platform.</p>
                        </div>
                        
                        <h5 class="mt-4 mb-3 fw-bold" style="color: #0d47a1;">Your new moderator privileges include:</h5>
                        
                        <div class="row g-3 mb-4">
                            <div class="col-12">
                                <div class="privilege-item d-flex align-items-center p-3 blue-gradient-light">
                                    <div class="flex-shrink-0 me-3">
                                        <i class="bi bi-shield-check fs-3" style="color: #0d47a1;"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0 fw-bold" style="color: #0d47a1;">Review and manage content</h6>
                                        <small class="text-muted">Monitor and approve/reject submissions</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-12">
                                <div class="privilege-item d-flex align-items-center p-3 blue-gradient-light">
                                    <div class="flex-shrink-0 me-3">
                                        <i class="bi bi-flag fs-3" style="color: #0d47a1;"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0 fw-bold" style="color: #0d47a1;">Handle user reports</h6>
                                        <small class="text-muted">Address community concerns and issues</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-12">
                                <div class="privilege-item d-flex align-items-center p-3 blue-gradient-light">
                                    <div class="flex-shrink-0 me-3">
                                        <i class="bi bi-gear fs-3" style="color: #0d47a1;"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0 fw-bold" style="color: #0d47a1;">Access to moderator dashboard</h6>
                                        <small class="text-muted">View analytics and management tools</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <p class="card-text">To get started with your new role, please login to your account and explore the moderator dashboard.</p>
                        
                        <div class="d-grid gap-2 mt-4">
                            <a href="index.do" class="btn btn-blue-gradient btn-lg fw-bold text-white py-3">
                                Go to Moderator Dashboard <i class="bi bi-arrow-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                    
                    <!-- Footer -->
                    <div class="card-footer text-center text-muted p-4 border-top-0">
                        <small>&copy; 2025 Codex. All rights reserved.</small>
                        <div class="mt-2">
                            <a href="#" class="text-decoration-none me-2" style="color: #1976d2;">
                                <i class="bi bi-question-circle"></i> Help
                            </a>
                            <a href="#" class="text-decoration-none" style="color: #1976d2;">
                                <i class="bi bi-book"></i> Guidelines
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>