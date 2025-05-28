<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Codex - Technical Discussion Platform</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="static/css/home.css">
    <link rel="stylesheet" href="static/css/header.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        
        .code-font {
            font-family: 'Source Code Pro', monospace;
        }
        
        .hero-section {
            background: linear-gradient(135deg, #0d47a1, #2196f3);
            color: white;
            padding: 80px 0;
            margin-bottom: 40px;
        }
        
        .section-card {
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            margin-bottom: 30px;
            border-top: 4px solid #2196f3;
        }
        
        .section-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
        }
        
        .icon-box {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2196f3, #0d47a1);
            color: white;
            margin-bottom: 20px;
        }
        
        .team-member {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .team-member img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 15px;
            border: 4px solid #e3f2fd;
        }
        
        .social-links a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background-color: #e3f2fd;
            color: #0d47a1;
            margin: 0 5px;
            transition: all 0.3s ease;
        }
        
        .social-links a:hover {
            background-color: #0d47a1;
            color: white;
        }
        
        .contact-info {
            padding: 20px;
            background-color: #e3f2fd;
            border-radius: 10px;
        }
        
        .contact-info i {
            color: #0d47a1;
            margin-right: 10px;
        }
        
        .faq-item {
            margin-bottom: 20px;
        }
        
        .faq-question {
            font-weight: 600;
            color: #0d47a1;
            margin-bottom: 10px;
        }
        
        .page-section {
            padding: 40px 0;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #2196f3, #0d47a1);
            border: none;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #0d47a1, #1565c0);
        }
        
        .newsletter-form input {
            border-radius: 8px 0 0 8px;
            border: 1px solid #bdbdbd;
        }
        
        .newsletter-form button {
            border-radius: 0 8px 8px 0;
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

            <div class="col px-0">
                <!-- Hero Section -->
                <div class="hero-section">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-lg-8 mx-auto text-center">
                                <h1 class="fw-bold mb-4">Welcome to Codex</h1>
                                <p class="lead mb-4">Your premier platform for technical discussions, knowledge sharing, and community-driven problem solving.</p>
                                <div>
                                    <a href="index.do" class="btn btn-light btn-lg me-2">Join The Community</a>
                                    <a href="#contact" class="btn btn-outline-light btn-lg">Contact Us</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container">
                    <!-- About Section -->
                    <section id="about" class="page-section">
                        <div class="row mb-5">
                            <div class="col-lg-8 mx-auto text-center">
                                <h2 class="fw-bold mb-4">About Codex</h2>
                                <p class="lead text-muted">Codex is a community-driven platform where developers, engineers, and tech enthusiasts come together to discuss, collaborate, and solve technical challenges.</p>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4">
                                <div class="card section-card h-100">
                                    <div class="card-body text-center p-4">
                                        <div class="icon-box">
                                            <i class="fas fa-code fa-2x"></i>
                                        </div>
                                        <h4 class="mb-3">Technical Excellence</h4>
                                        <p class="text-muted">Our platform fosters high-quality technical discussions with a focus on accuracy, clarity, and practical solutions.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card section-card h-100">
                                    <div class="card-body text-center p-4">
                                        <div class="icon-box">
                                            <i class="fas fa-users fa-2x"></i>
                                        </div>
                                        <h4 class="mb-3">Community First</h4>
                                        <p class="text-muted">We believe in the power of community and collaboration to solve complex problems and drive innovation.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card section-card h-100">
                                    <div class="card-body text-center p-4">
                                        <div class="icon-box">
                                            <i class="fas fa-shield-alt fa-2x"></i>
                                        </div>
                                        <h4 class="mb-3">Safe Environment</h4>
                                        <p class="text-muted">We maintain strict moderation standards to ensure a respectful, inclusive, and constructive environment for all members.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Our Team Section -->
                    <section id="team" class="page-section">
                        <div class="row mb-5">
                            <div class="col-lg-8 mx-auto text-center ">
                                <h2 class="fw-bold mb-4">Our Team</h2>
                                <p class="lead text-muted">Meet the dedicated individuals who make Codex possible.</p>
                            </div>
                        </div>
                        
                        <div class="row justify-content-center">
                            <div class="col-md-3 ">
                                <div class="team-member">
                                    <img src="static/media/images/profile-pic.png" alt="Team Member">
                                    <h5 class="mb-1">Shivam Patkar</h5>
                                    <p class="text-muted mb-2">Founder & Lead Developer</p>
                                    <div class="social-links">
                                        <a href="#"><i class="fab fa-twitter"></i></a>
                                        <a href="#"><i class="fab fa-linkedin"></i></a>
                                        <a href="#"><i class="fab fa-github"></i></a>
                                    </div>
                                </div>
                            </div>
                           
                            <div class="col-md-3">
                                <div class="team-member">
                                    <img src="static/media/images/anoop_sir.jpg" alt="Team Member">
                                    <h5 class="mb-1"> Anoop Ingole</h5>
                                    <p class="text-muted mb-2">Instructor</p>
                                    <div class="social-links">
                                        <a href="#"><i class="fab fa-twitter"></i></a>
                                        <a href="#"><i class="fab fa-linkedin"></i></a>
                                        <a href="#"><i class="fab fa-github"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Contact & FAQ Section -->
                    <section class="page-section">
                        <div class="row">
                            <!-- Contact Section -->
                            <div class="col-lg-6" id="contact">
                                <h2 class="fw-bold mb-4">Contact Us</h2>
                                <div class="contact-info mb-4">
                                    <p><i class="fas fa-envelope"></i> contact@codex-platform.com</p>
                                    <p><i class="fas fa-phone"></i> +1 (800) 123-4567</p>
                                    <p><i class="fas fa-map-marker-alt"></i> 123 Tech Street, San Francisco, CA 94105</p>
                                </div>
                                
                                <div class="card section-card">
                                    <div class="card-body p-4">
                                        <h5 class="mb-3">Send us a message</h5>
                                        <form>
                                            <div class="mb-3">
                                                <input type="text" class="form-control" placeholder="Your Name">
                                            </div>
                                            <div class="mb-3">
                                                <input type="email" class="form-control" placeholder="Your Email">
                                            </div>
                                            <div class="mb-3">
                                                <textarea class="form-control" rows="4" placeholder="Your Message"></textarea>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Send Message</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- FAQ Section -->
                            <div class="col-lg-6" id="faq">
                                <h2 class="fw-bold mb-4">Frequently Asked Questions</h2>
                                
                                <div class="card section-card">
                                    <div class="card-body p-4">
                                        <div class="faq-item">
                                            <div class="faq-question">How do I join the Codex community?</div>
                                            <p class="text-muted">Simply click the "Join" button on our homepage, fill out the registration form, and verify your email address to get started.</p>
                                        </div>
                                        
                                        <div class="faq-item">
                                            <div class="faq-question">What topics can I discuss on Codex?</div>
                                            <p class="text-muted">Codex welcomes discussions on programming, software engineering, system architecture, data science, AI, and other tech-related topics.</p>
                                        </div>
                                        
                                        <div class="faq-item">
                                            <div class="faq-question">How does the moderation system work?</div>
                                            <p class="text-muted">Our platform uses a combination of automated tools and human moderators to ensure content quality and community standards are maintained.</p>
                                        </div>
                                        
                                        <div class="faq-item">
                                            <div class="faq-question">Can I contribute to the Codex platform?</div>
                                            <p class="text-muted">Yes! Codex is open-source and we welcome contributions. Check out our GitHub repository for more information.</p>
                                        </div>
                                        
                                        <div class="faq-item">
                                            <div class="faq-question">How can I report inappropriate content?</div>
                                            <p class="text-muted">Each post and comment has a "Report" button that you can use to flag content that violates our community guidelines.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                    
                    <!-- Community Guidelines & Terms -->
                    <section class="page-section">
                        <div class="row">
                            <div class="col-lg-6 mb-4">
                                <h2 class="fw-bold mb-4">Community Guidelines</h2>
                                <div class="card section-card">
                                    <div class="card-body p-4">
                                        <ul class="list-unstyled">
                                            <li class="mb-3"><i class="fas fa-check-circle text-primary me-2"></i> Be respectful and constructive in all discussions</li>
                                            <li class="mb-3"><i class="fas fa-check-circle text-primary me-2"></i> Stay on topic and provide relevant information</li>
                                            <li class="mb-3"><i class="fas fa-check-circle text-primary me-2"></i> Cite sources and respect intellectual property</li>
                                            <li class="mb-3"><i class="fas fa-check-circle text-primary me-2"></i> No spam, offensive content, or self-promotion</li>
                                            <li class="mb-3"><i class="fas fa-check-circle text-primary me-2"></i> Respect privacy and confidentiality</li>
                                        </ul>
                                        <a href="guidelines.do" class="btn btn-outline-primary">Read Full Guidelines</a>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-lg-6 mb-4">
                                <h2 class="fw-bold mb-4">Legal Information</h2>
                                <div class="card section-card">
                                    <div class="card-body p-4">
                                        <p>Access to our important legal documents:</p>
                                        <div class="d-grid gap-2">
                                            <a href="terms.do" class="btn btn-outline-primary text-start">
                                                <i class="fas fa-file-contract me-2"></i> Terms of Service
                                            </a>
                                            <a href="privacy.do" class="btn btn-outline-primary text-start">
                                                <i class="fas fa-shield-alt me-2"></i> Privacy Policy
                                            </a>
                                            <a href="cookies.do" class="btn btn-outline-primary text-start">
                                                <i class="fas fa-cookie-bite me-2"></i> Cookie Policy
                                            </a>
                                            <a href="licensing.do" class="btn btn-outline-primary text-start">
                                                <i class="fas fa-copyright me-2"></i> Content Licensing
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                    
                    <!-- Newsletter & Social Media -->
                    <section class="page-section pb-5">
                        <div class="row">
                            <div class="col-lg-6 mb-4">
                                <h2 class="fw-bold mb-4">Stay Updated</h2>
                                <div class="card section-card">
                                    <div class="card-body p-4">
                                        <p class="mb-3">Subscribe to our newsletter for the latest updates, features, and community news.</p>
                                        <form class="newsletter-form">
                                            <div class="input-group mb-3">
                                                <input type="email" class="form-control" placeholder="Your Email Address">
                                                <button class="btn btn-primary" type="submit">Subscribe</button>
                                            </div>
                                        </form>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="privacyCheck">
                                            <label class="form-check-label small text-muted" for="privacyCheck">
                                                I agree to receive marketing emails and acknowledge the privacy policy.
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-lg-6 mb-4">
                                <h2 class="fw-bold mb-4">Follow Us</h2>
                                <div class="card section-card">
                                    <div class="card-body p-4">
                                        <p class="mb-3">Connect with us on social media for community updates, tech news, and more.</p>
                                        <div class="d-flex flex-wrap">
                                            <a href="#" class="btn btn-outline-primary m-2">
                                                <i class="fab fa-github me-2"></i> GitHub
                                            </a>
                                            <a href="#" class="btn btn-outline-primary m-2">
                                                <i class="fab fa-twitter me-2"></i> Twitter
                                            </a>
                                            <a href="#" class="btn btn-outline-primary m-2">
                                                <i class="fab fa-linkedin me-2"></i> LinkedIn
                                            </a>
                                            <a href="#" class="btn btn-outline-primary m-2">
                                                <i class="fab fa-discord me-2"></i> Discord
                                            </a>
                                            <a href="#" class="btn btn-outline-primary m-2">
                                                <i class="fab fa-stack-overflow me-2"></i> Stack Overflow
                                            </a>
                                            <a href="#" class="btn btn-outline-primary m-2">
                                                <i class="fab fa-dev me-2"></i> Dev.to
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                    
                    <!-- Copyright Section -->
                    <div class="py-4 border-top">
                        <div class="row align-items-center">
                            <div class="col-md-6 text-center text-md-start">
                                <p class="mb-0 text-muted">&copy; 2025 Codex Technical Discussion Platform. All rights reserved.</p>
                            </div>
                            <div class="col-md-6 text-center text-md-end">
                                <p class="mb-0 small text-muted">
                                    <a href="accessibility.do" class="text-muted me-3">Accessibility</a>
                                    <a href="sitemap.do" class="text-muted me-3">Sitemap</a>
                                    <a href="careers.do" class="text-muted">Careers</a>
                                </p>
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