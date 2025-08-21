<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page session="true" %>
        <%@ page isELIgnored="false" %>
            <%@ taglib prefix="c" uri="jakarta.tags.core" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Home</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                        rel="stylesheet">
                    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
                        rel="stylesheet">
                    <style>
                        body {
                            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial;
                            background: linear-gradient(135deg, #071428 0%, #072f4f 50%, #064e57 100%);
                            min-height: 100vh;
                            color: #e6f3fb;
                        }

                        .navbar-brand {
                            font-weight: 700;
                            color: #ffffff !important;
                        }

                        .navbar .nav-link,
                        .navbar .nav-link:hover,
                        .navbar .nav-link:focus {
                            color: #ffffff !important;
                        }

                        .navbar .nav-link.active {
                            color: #ffffff !important;
                            font-weight: 600;
                        }

                        .navbar {
                            background: linear-gradient(90deg, #06326b 0%, #046d6e 100%);
                        }

                        .card-modern {
                            border: 0;
                            border-radius: 12px;
                            box-shadow: 0 8px 28px rgba(2, 6, 23, 0.6);
                            background: rgba(255, 255, 255, 0.02);
                            color: #e6f3fb;
                        }

                        .hero-card {
                            background: linear-gradient(180deg, rgba(255, 255, 255, 0.04), rgba(255, 255, 255, 0.02));
                            color: #ecfbff;
                        }

                        .feature-card {
                            border-radius: 10px;
                            background: rgba(255, 255, 255, 0.02);
                            border: 1px solid rgba(255, 255, 255, 0.04);
                            color: #d7eef6;
                        }

                        .btn-primary {
                            background-color: #00bfa6;
                            border-color: #00bfa6;
                            color: #042028;
                        }

                        .btn-primary:hover {
                            background-color: #00a392;
                            border-color: #00917a;
                        }

                        .btn-outline-secondary {
                            color: #e6f3fb;
                            border-color: rgba(255, 255, 255, 0.12);
                        }

                        .btn-outline-info {
                            color: #ffffff;
                            border-color: #7fd3ff;
                            background: rgba(127, 211, 255, 0.04);
                        }

                        .fa-book-open {
                            color: #ffd166;
                        }

                        .text-primary {
                            color: #9be7e7 !important;
                        }

                        /* Improve text contrast for hero and feature cards */
                        .hero-card h1 {
                            color: #e6fbff !important;
                            font-weight: 600;
                        }

                        .hero-card .lead,
                        .hero-card p {
                            color: rgba(230, 243, 251, 0.95) !important;
                        }

                        .feature-card h6,
                        .feature-card p.small {
                            color: rgba(215, 238, 246, 0.95) !important;
                        }

                        /* Navbar contrast */
                        .navbar.bg-white {
                            background: linear-gradient(90deg, #06326b 0%, #046d6e 100%) !important;
                            box-shadow: none !important;
                        }

                        .navbar .nav-link {
                            color: rgba(230, 243, 251, 0.85) !important;
                        }

                        .navbar .nav-link:hover {
                            color: #ffffff !important;
                        }

                        .btn-outline-secondary,
                        .btn-outline-secondary:focus {
                            color: #e6f3fb !important;
                            border-color: rgba(255, 255, 255, 0.12) !important;
                        }

                        /* Right side feature card adjustments */
                        .right-card {
                            background: linear-gradient(180deg, rgba(255, 255, 255, 0.03), rgba(255, 255, 255, 0.02));
                            border: 1px solid rgba(255, 255, 255, 0.04);
                            color: #e6f3fb;
                        }

                        .right-card h5 {
                            color: #e6fbff;
                        }

                        .right-card p.small {
                            color: rgba(230, 243, 251, 0.85);
                        }
                    </style>
                </head>

                <body>
                    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                        <div class="container-fluid px-4">
                            <a class="navbar-brand d-flex align-items-center" href="<c:url value='/'/>">
                                <span class="me-2"><i class="fas fa-bolt text-primary"></i></span>
                                <span>Pahana Edu Billing</span>
                            </a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarNav">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarNav">
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                    <li class="nav-item"><a class="nav-link"
                                            href="<c:url value='/dashboard'/>">Dashboard</a></li>
                                    <li class="nav-item"><a class="nav-link"
                                            href="<c:url value='/customers?action=list'/>">Customers</a></li>
                                    <li class="nav-item"><a class="nav-link"
                                            href="<c:url value='/items?action=list'/>">Items</a></li>
                                    <li class="nav-item"><a class="nav-link"
                                            href="<c:url value='/invoices?action=list'/>">Invoices</a></li>
                                    <li class="nav-item"><a class="nav-link" href="<c:url value='/help.jsp'/>">Help</a>
                                    </li>
                                </ul>

                                <div class="d-flex align-items-center">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.userName}">
                                            <div class="me-3 text-muted small">Welcome,
                                                <strong>${sessionScope.userName}</strong>
                                            </div>
                                            <a class="btn btn-outline-secondary btn-sm"
                                                href="<c:url value='/logout'/>">Logout</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="btn btn-primary btn-sm me-2"
                                                href="<c:url value='/login'/>">Login</a>
                                            <a class="btn btn-outline-secondary btn-sm"
                                                href="<c:url value='/register'/>">Register</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </nav>

                    <main class="container py-5">
                        <div class="row align-items-center">
                            <div class="col-lg-7">
                                <div class="card card-modern hero-card p-5 mb-4">
                                    <h1 class="display-5 text-primary mb-3">Modern billing, built for education
                                        bookstores</h1>
                                    <p class="lead text-muted mb-4">Manage customers, items and invoices with a simple,
                                        fast interface tailored for small shops and institutes.</p>

                                    <div class="d-flex gap-2">
                                        <a href="<c:url value='/login'/>" class="btn btn-primary btn-lg">
                                            <i class="fas fa-sign-in-alt me-2"></i> Login
                                        </a>
                                        <a href="<c:url value='/register'/>" class="btn btn-outline-secondary btn-lg">
                                            <i class="fas fa-user-plus me-2"></i> Register
                                        </a>
                                        <a href="<c:url value='/help.jsp'/>" class="btn btn-outline-info btn-lg">
                                            <i class="fas fa-question-circle me-2"></i> Help
                                        </a>
                                    </div>
                                </div>

                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <div class="card feature-card p-3 text-center">
                                            <i class="fas fa-users fa-2x text-primary mb-2"></i>
                                            <h6 class="mb-0">Customers</h6>
                                            <p class="small text-muted mb-0">Add and manage customers</p>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card feature-card p-3 text-center">
                                            <i class="fas fa-box fa-2x text-success mb-2"></i>
                                            <h6 class="mb-0">Items</h6>
                                            <p class="small text-muted mb-0">Maintain item catalog</p>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card feature-card p-3 text-center">
                                            <i class="fas fa-file-invoice fa-2x text-warning mb-2"></i>
                                            <h6 class="mb-0">Invoices</h6>
                                            <p class="small text-muted mb-0">Create and print invoices</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-5 d-none d-lg-block">
                                <div class="card card-modern p-4 h-100 text-center right-card">
                                    <div class="py-4">
                                        <i class="fas fa-book-open fa-3x mb-3" style="color:#ffd166"></i>
                                        <h5 class="mb-2">Designed for Bookshops</h5>
                                        <p class="small">Quickly create invoices, track payments and manage
                                            stock for academic bookstores.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
                </body>

                </html>