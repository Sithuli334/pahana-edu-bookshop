<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page session="true" %>
        <%@ page isELIgnored="false" %>
            <%@ taglib prefix="c" uri="jakarta.tags.core" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Login - Pahana Edu Billing System</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                        rel="stylesheet">
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

                        .login-card {
                            max-width: 480px;
                            margin: 40px auto;
                            background: linear-gradient(180deg, rgba(255, 255, 255, 0.03), rgba(255, 255, 255, 0.02));
                            border: 1px solid rgba(255, 255, 255, 0.04);
                        }

                        .login-card h2 {
                            color: #e6fbff;
                        }

                        .login-card .text-muted,
                        .login-card p.text-muted,
                        .login-card .form-label {
                            color: rgba(230, 243, 251, 0.85);
                        }

                        .btn-primary {
                            background-color: #00bfa6;
                            border-color: #00bfa6;
                            color: #042028;
                        }

                        .btn-outline-secondary {
                            color: #e6f3fb;
                            border-color: rgba(255, 255, 255, 0.12);
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
                        <div class="login-card card card-modern">
                            <div class="card-body p-4">
                                <div class="text-center mb-3">
                                    <h2 class="mb-0">Pahana Edu</h2>
                                    <p class="text-muted">Billing System</p>
                                </div>

                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        ${errorMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <form method="post" action="${pageContext.request.contextPath}/login">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email Address</label>
                                        <input type="email" class="form-control" id="email" name="email"
                                            value="${email}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password</label>
                                        <input type="password" class="form-control" id="password" name="password"
                                            required>
                                    </div>

                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-primary">Login</button>
                                    </div>
                                </form>

                                <div class="text-center mt-3">
                                    <p>Don't have an account? <a
                                            href="${pageContext.request.contextPath}/register">Register here</a></p>
                                </div>

                                <div class="text-center mt-3">
                                    <small class="text-muted">Demo credentials: admin@gmail.com / admin123</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
                </body>

                </html>