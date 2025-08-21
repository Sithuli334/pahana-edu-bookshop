<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Help & Usage Guide</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
                    rel="stylesheet">
                <style>
                    body {
                        font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial;
                        background: linear-gradient(135deg, #071428 0%, #072f4f 60%);
                        color: #e6f3fb;
                        min-height: 100vh;
                    }

                    .navbar {
                        background: linear-gradient(90deg, #06326b 0%, #046d6e 100%) !important;
                    }

                    .navbar-brand {
                        font-weight: 700;
                        color: #fff !important;
                    }

                    .card-modern {
                        border: 0;
                        border-radius: 12px;
                        box-shadow: 0 8px 28px rgba(2, 6, 23, 0.6);
                        background: rgba(255, 255, 255, 0.02);
                        color: #e6f3fb;
                    }

                    .card,
                    .card-header {
                        background: rgba(255, 255, 255, 0.02) !important;
                        color: #e6f3fb;
                    }

                    .card-body {
                        color: #e6f3fb;
                    }

                    .help-heading {
                        font-weight: 600;
                        color: #dff8fb;
                    }

                    .text-muted {
                        color: rgba(230, 243, 251, 0.7) !important;
                    }

                    .btn-primary {
                        background: #00bfa6;
                        border-color: #00bfa6;
                    }

                    .btn-outline-primary {
                        color: #00bfa6;
                        border-color: rgba(0, 191, 166, 0.12);
                    }

                    .btn-outline-success {
                        color: #7ee6cd;
                        border-color: rgba(126, 230, 205, 0.12);
                    }

                    .btn-outline-warning {
                        color: #ffd166;
                        border-color: rgba(255, 209, 102, 0.12);
                    }

                    a {
                        color: #bfeff0;
                    }
                </style>
            </head>

            <body>
                <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                    <div class="container-fluid px-4">
                        <a class="navbar-brand d-flex align-items-center" href="<c:url value='/dashboard'/>">
                            <span class="me-2"><i class="fas fa-bolt text-primary"></i></span>
                            <span>Dashboard</span>
                        </a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <li class="nav-item"><a class="nav-link" href="<c:url value='/dashboard'/>">Overview</a>
                                </li>
                                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/customers?action=list'/>">Customers</a></li>
                                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/items?action=list'/>">Items</a></li>
                                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/invoices?action=list'/>">Invoices</a></li>
                                <li class="nav-item"><a class="nav-link active"
                                        href="<c:url value='/help.jsp'/>">Help</a></li>
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
                                        <a class="btn btn-primary btn-sm me-2" href="<c:url value='/login'/>">Login</a>
                                        <a class="btn btn-outline-secondary btn-sm"
                                            href="<c:url value='/register'/>">Register</a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </nav>

                <div class="container-fluid px-4 mt-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <h1 class="h4 mb-0 help-heading">Help & Usage Guide</h1>
                            <p class="text-muted small mb-0">Quick orientation to get new users up and running.</p>
                        </div>
                        <div>
                            <a href="<c:url value='/invoices?action=new'/>" class="btn btn-primary btn-sm me-2">New
                                Invoice</a>
                            <a href="<c:url value='/customers?action=new'/>" class="btn btn-outline-primary btn-sm">New
                                Customer</a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-8">
                            <div class="card card-modern p-4 mb-4">
                                <h5 class="mb-3">Getting started</h5>
                                <ol>
                                    <li>Create an account via the "Create New Account" button on the home page or ask an
                                        admin to create one.</li>
                                    <li>Login using the <strong>Login</strong> button. After login you will arrive at
                                        the Dashboard.</li>
                                    <li>If you are evaluating the system, use the demo credentials provided by your
                                        administrator.</li>
                                </ol>

                                <h5 class="mt-3">Navigation overview</h5>
                                <p class="small text-muted">Use the top navigation in the Dashboard to access the core
                                    areas:</p>
                                <ul>
                                    <li><strong>Customers</strong> — Add, view and manage customer records.</li>
                                    <li><strong>Items</strong> — Create and maintain product/item catalog entries.</li>
                                    <li><strong>Invoices</strong> — Create invoices, view, print and track payment
                                        status.</li>
                                </ul>

                                <h5 class="mt-3">Creating a new invoice</h5>
                                <ol>
                                    <li>From Dashboard, click <em>Create Invoice</em> or open <strong>Invoices &rarr;
                                            New</strong>.</li>
                                    <li>Select or create a customer, add items, set quantities and save the invoice.
                                    </li>
                                    <li>Use the print button on the invoice view to generate a printable copy.</li>
                                </ol>

                                <h5 class="mt-3">Tips & best practices</h5>
                                <ul>
                                    <li>Keep item prices and taxes up to date to avoid invoice corrections.</li>
                                    <li>Use meaningful customer names and contact details for faster lookup.</li>
                                    <li>Regularly backup your database using the provided SQL scripts in the
                                        <code>database/</code> folder.
                                    </li>
                                </ul>

                                <h5 class="mt-3">Troubleshooting</h5>
                                <ul>
                                    <li>If you see errors, check server logs and ensure the database is running and
                                        accessible.</li>
                                    <li>For 404 or missing pages, confirm mappings in <code>web.xml</code> and servlet
                                        routes in the controllers.</li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="card card-modern p-3 mb-3">
                                <h6 class="mb-2">Quick Links</h6>
                                <div class="d-grid gap-2">
                                    <a href="<c:url value='/customers?action=list'/>"
                                        class="btn btn-outline-primary btn-sm">Customers</a>
                                    <a href="<c:url value='/items?action=list'/>"
                                        class="btn btn-outline-success btn-sm">Items</a>
                                    <a href="<c:url value='/invoices?action=list'/>"
                                        class="btn btn-outline-warning btn-sm">Invoices</a>
                                </div>
                            </div>

                            <div class="card card-modern p-3">
                                <h6 class="mb-2">Support</h6>
                                <p class="small text-muted mb-1">If you need help beyond this guide, contact your
                                    administrator or check server logs for errors.</p>
                            </div>
                        </div>
                    </div>

                </div>

                <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>

            </body>

            </html>