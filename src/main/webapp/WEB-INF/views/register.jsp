<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Register - Pahana Edu Billing System</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
                rel="stylesheet">
            <style>
                body {
                    font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Arial;
                    background: linear-gradient(135deg, #071428 0%, #072f4f 50%, #064e57 100%);
                    min-height: 100vh;
                    color: #e6f3fb;
                }

                .navbar-brand {
                    font-weight: 700;
                    color: #ffffff !important;
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

                .register-card {
                    max-width: 520px;
                    margin: 40px auto;
                    background: linear-gradient(180deg, rgba(255, 255, 255, 0.03), rgba(255, 255, 255, 0.02));
                    border: 1px solid rgba(255, 255, 255, 0.04);
                }

                .logo h2 {
                    color: #9be7e7;
                    font-weight: 700;
                }

                .register-card .text-muted,
                .register-card .form-label {
                    color: rgba(230, 243, 251, 0.85);
                }

                .btn-primary {
                    background-color: #00bfa6;
                    border-color: #00bfa6;
                    color: #042028;
                }
            </style>
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                <div class="container-fluid px-4">
                    <a class="navbar-brand d-flex align-items-center" href="<c:url value='/dashboard'/>">
                        <span class="me-2"><i class="fas fa-bolt text-primary"></i></span>
                        <span>Pahana Edu</span>
                    </a>
                </div>
            </nav>

            <div class="container-fluid px-4 mt-4">
                <div class="register-card card card-modern">
                    <div class="card-body p-4">
                        <div class="logo text-center mb-3">
                            <h2>Pahana Edu</h2>
                            <p class="text-muted">Create New Account</p>
                        </div>

                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form method="post" action="<c:url value='/register'/>">
                            <div class="mb-3">
                                <label for="name" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="name" name="name" value="${name}" required>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" value="${email}"
                                    required>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>

                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                                    required>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Register</button>
                            </div>
                        </form>

                        <div class="text-center mt-3">
                            <p>Already have an account? <a href="<c:url value='/login'/>">Login here</a></p>
                        </div>
                    </div>
                </div>
            </div>

            <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
        </body>

        </html>