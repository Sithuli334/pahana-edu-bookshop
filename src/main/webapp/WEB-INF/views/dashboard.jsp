<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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

                    .navbar.bg-white {
                        background: linear-gradient(90deg, #06326b 0%, #046d6e 100%) !important;
                        box-shadow: none !important;
                    }

                    .navbar .nav-link {
                        color: rgba(230, 243, 251, 0.85) !important;
                    }

                    .navbar .nav-link.active {
                        color: #ffffff !important;
                        font-weight: 600
                    }

                    .card-modern {
                        border: 0;
                        border-radius: 12px;
                        box-shadow: 0 8px 28px rgba(2, 6, 23, 0.6);
                        background: linear-gradient(180deg, rgba(255, 255, 255, 0.02), rgba(255, 255, 255, 0.01));
                        color: #e6f3fb;
                    }

                    /* Stat icon with subtle gradient and lift */
                    .stat-icon {
                        width: 56px;
                        height: 56px;
                        border-radius: 12px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: #fff;
                        box-shadow: 0 6px 18px rgba(2, 6, 23, 0.45);
                    }

                    .stat-icon.bg-primary {
                        background: linear-gradient(135deg, #046d6e, #06326b);
                    }

                    .stat-icon.bg-success {
                        background: linear-gradient(135deg, #007a4f, #00bfa6);
                    }

                    .stat-icon.bg-info {
                        background: linear-gradient(135deg, #0288a7, #00b8d4);
                    }

                    .stat-icon.bg-warning {
                        background: linear-gradient(135deg, #ffd166, #ff8a00);
                    }

                    .stat-icon.bg-danger {
                        background: linear-gradient(135deg, #ff6b6b, #d7263d);
                    }

                    .stat-value {
                        font-size: 1.6rem;
                        font-weight: 700;
                        color: #e6fbff;
                    }

                    .stat-label {
                        color: rgba(230, 243, 251, 0.8);
                        font-size: 0.9rem;
                    }

                    /* Quick action buttons - make them more visible on dark bg */
                    .quick-btn {
                        border-radius: 10px;
                        padding: 0.6rem 1rem;
                        background: rgba(255, 255, 255, 0.02);
                        color: #e6f3fb;
                        border: 1px solid rgba(255, 255, 255, 0.04);
                    }

                    .quick-btn:hover {
                        background: rgba(255, 255, 255, 0.04);
                        color: #ffffff;
                    }

                    /* Dashboard headings and text */
                    h1.h4,
                    h5.mb-0 {
                        color: #e6fbff;
                    }

                    .text-muted,
                    .small.text-muted {
                        color: rgba(230, 243, 251, 0.78) !important;
                    }

                    /* Table adjustments for better contrast */
                    .table thead {
                        background: rgba(255, 255, 255, 0.02);
                        color: #e6f3fb;
                    }

                    .table-hover tbody tr:hover {
                        background: rgba(255, 255, 255, 0.01);
                    }

                    .text-decoration-none.small {
                        color: rgba(230, 243, 251, 0.85);
                    }

                    /* Make badges slightly brighter on dark background */
                    .badge.bg-success {
                        background-color: #1ec07a;
                    }

                    .badge.bg-warning {
                        background-color: #ffb020;
                        color: #072028;
                    }

                    .badge.bg-danger {
                        background-color: #ff6b6b;
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
                                <li class="nav-item">
                                    <a class="nav-link active" href="<c:url value='/dashboard'/>">Overview</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/customers?action=list'/>">Customers</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/items?action=list'/>">Items</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/invoices?action=list'/>">Invoices</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/help.jsp'/>">Help</a>
                                </li>
                            </ul>

                            <div class="d-flex align-items-center">
                                <div class="me-3 text-muted small">Welcome, <strong>${sessionScope.userName}</strong>
                                </div>
                                <a class="btn btn-outline-secondary btn-sm" href="<c:url value='/logout'/>">Logout</a>
                            </div>
                        </div>
                    </div>
                </nav>

                <div class="container-fluid px-4 mt-4">
                    <!-- Header Section -->
                    <div class="row mb-4">
                        <div class="col-lg-8">
                            <h1 class="h3 mb-2">Welcome back, ${sessionScope.userName}!</h1>
                            <p class="text-muted mb-0">Here's what's happening with your business today.</p>
                        </div>
                        <div class="col-lg-4 text-lg-end">
                            <a href="<c:url value='/invoices?action=new'/>" class="btn btn-primary me-2">
                                <i class="fas fa-plus me-2"></i>Create Invoice
                            </a>
                            <a href="<c:url value='/customers?action=new'/>" class="btn btn-outline-info">
                                <i class="fas fa-user-plus me-2"></i>Add Customer
                            </a>
                        </div>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">${errorMessage}</div>
                    </c:if>

                    <!-- Main Stats Cards - Featured Layout -->
                    <div class="row g-4 mb-4">
                        <!-- Revenue Highlight -->
                        <div class="col-lg-6">
                            <div class="card card-modern p-4 h-100">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div>
                                        <div class="text-muted mb-1">Total Revenue</div>
                                        <div class="display-6 fw-bold text-warning">Rs.
                                            <fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00" />
                                        </div>
                                    </div>
                                    <div class="stat-icon bg-warning">
                                        <i class="fas fa-indian-rupee-sign fa-lg"></i>
                                    </div>
                                </div>
                                <div class="row text-center">
                                    <div class="col-6">
                                        <div class="border-end border-secondary border-opacity-25">
                                            <div class="h5 mb-0 text-info">Rs.
                                                <fmt:formatNumber value="${monthlyRevenue}" pattern="#,##0" />
                                            </div>
                                            <small class="text-muted">This Month</small>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="h5 mb-0 text-success">
                                            <c:choose>
                                                <c:when test="${totalInvoices > 0}">
                                                    <fmt:formatNumber value="${(paidInvoices / totalInvoices) * 100}"
                                                        pattern="##.#" />%
                                                </c:when>
                                                <c:otherwise>0%</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <small class="text-muted">Payment Rate</small>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Business Overview -->
                        <div class="col-lg-6">
                            <div class="card card-modern p-4 h-100">
                                <div class="mb-3">
                                    <div class="text-muted mb-1">Business Overview</div>
                                    <div class="h5 mb-0">Core Metrics</div>
                                </div>
                                <div class="row g-3">
                                    <div class="col-4">
                                        <div class="text-center">
                                            <div class="stat-icon bg-primary mx-auto mb-2"
                                                style="width: 48px; height: 48px;">
                                                <i class="fas fa-users"></i>
                                            </div>
                                            <div class="h4 mb-0">${totalCustomers}</div>
                                            <small class="text-muted">Customers</small>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="text-center">
                                            <div class="stat-icon bg-success mx-auto mb-2"
                                                style="width: 48px; height: 48px;">
                                                <i class="fas fa-file-invoice"></i>
                                            </div>
                                            <div class="h4 mb-0">${totalInvoices}</div>
                                            <small class="text-muted">Invoices</small>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="text-center">
                                            <div class="stat-icon bg-info mx-auto mb-2"
                                                style="width: 48px; height: 48px;">
                                                <i class="fas fa-box"></i>
                                            </div>
                                            <div class="h4 mb-0">${totalItems}</div>
                                            <small class="text-muted">Items</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Invoice Status Cards -->
                    <div class="row g-3 mb-4">
                        <div class="col-lg-4">
                            <div class="card card-modern p-3 text-center">
                                <div class="stat-icon bg-danger mx-auto mb-2">
                                    <i class="fas fa-clock fa-lg"></i>
                                </div>
                                <div class="h3 mb-1">${pendingInvoices}</div>
                                <div class="text-muted mb-2">Pending Invoices</div>
                                <a href="<c:url value='/invoices?action=list&status=PENDING'/>"
                                    class="btn btn-sm btn-outline-danger">View Pending</a>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="card card-modern p-3 text-center">
                                <div class="stat-icon bg-success mx-auto mb-2">
                                    <i class="fas fa-check-circle fa-lg"></i>
                                </div>
                                <div class="h3 mb-1">${paidInvoices}</div>
                                <div class="text-muted mb-2">Paid Invoices</div>
                                <a href="<c:url value='/invoices?action=list&status=PAID'/>"
                                    class="btn btn-sm btn-outline-success">View Paid</a>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="card card-modern p-3 text-center">
                                <div class="stat-icon bg-primary mx-auto mb-2">
                                    <i class="fas fa-plus-circle fa-lg"></i>
                                </div>
                                <div class="h3 mb-1">Quick</div>
                                <div class="text-muted mb-2">Create New</div>
                                <a href="<c:url value='/invoices?action=new'/>" class="btn btn-sm btn-primary">New
                                    Invoice</a>
                            </div>
                        </div>
                    </div>

                    <!-- Content Section -->
                    <div class="row g-4">
                        <!-- Recent Invoices - Full Width -->
                        <div class="col-12">
                            <div class="card card-modern">
                                <div class="card-header d-flex justify-content-between align-items-center"
                                    style="background: rgba(255,255,255,0.02); border-bottom: 1px solid rgba(255,255,255,0.04);">
                                    <div>
                                        <h5 class="mb-1">Recent Invoices</h5>
                                        <small class="text-muted">Latest transactions and their status</small>
                                    </div>
                                    <a href="<c:url value='/invoices?action=list'/>"
                                        class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-external-link-alt me-1"></i>View All
                                    </a>
                                </div>
                                <div class="card-body p-0">
                                    <c:choose>
                                        <c:when test="${empty recentInvoices}">
                                            <div class="text-center py-5">
                                                <div class="stat-icon bg-info mx-auto mb-3"
                                                    style="width: 64px; height: 64px;">
                                                    <i class="fas fa-file-invoice fa-2x"></i>
                                                </div>
                                                <h5 class="mb-2">No invoices yet</h5>
                                                <p class="text-muted mb-3">Get started by creating your first invoice
                                                </p>
                                                <a href="<c:url value='/invoices?action=new'/>" class="btn btn-primary">
                                                    <i class="fas fa-plus me-2"></i>Create Invoice
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="table-responsive">
                                                <table class="table table-hover mb-0">
                                                    <thead>
                                                        <tr>
                                                            <th class="border-0 ps-4">Invoice #</th>
                                                            <th class="border-0">Customer</th>
                                                            <th class="border-0">Date</th>
                                                            <th class="border-0">Amount</th>
                                                            <th class="border-0">Status</th>
                                                            <th class="border-0 pe-4">Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="invoice" items="${recentInvoices}">
                                                            <tr>
                                                                <td class="ps-4">
                                                                    <a href="<c:url value='/invoices?action=view&id=${invoice.id}'/>"
                                                                        class="text-decoration-none fw-bold text-info">${invoice.invoiceNumber}</a>
                                                                </td>
                                                                <td>
                                                                    <div class="d-flex align-items-center">
                                                                        <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-2"
                                                                            style="width: 32px; height: 32px; font-size: 12px;">
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${not empty invoice.customer}">
                                                                                    ${invoice.customer.name.substring(0,1).toUpperCase()}
                                                                                </c:when>
                                                                                <c:otherwise>?</c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                        <div>
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${not empty invoice.customer}">
                                                                                    ${invoice.customer.name}
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <span class="text-muted">Customer
                                                                                        ID: ${invoice.customerId}</span>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                                <td class="text-muted">${invoice.invoiceDate}</td>
                                                                <td>
                                                                    <span class="fw-bold">Rs.
                                                                        <fmt:formatNumber value="${invoice.totalAmount}"
                                                                            pattern="#,##0.00" />
                                                                    </span>
                                                                </td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${invoice.paymentStatus == 'PAID'}">
                                                                            <span
                                                                                class="badge bg-success px-3">Paid</span>
                                                                        </c:when>
                                                                        <c:when
                                                                            test="${invoice.paymentStatus == 'PENDING'}">
                                                                            <span
                                                                                class="badge bg-warning px-3">Pending</span>
                                                                        </c:when>
                                                                        <c:when
                                                                            test="${invoice.paymentStatus == 'OVERDUE'}">
                                                                            <span
                                                                                class="badge bg-danger px-3">Overdue</span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span
                                                                                class="badge bg-secondary px-3">${invoice.paymentStatus}</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td class="pe-4">
                                                                    <a href="<c:url value='/invoices?action=view&id=${invoice.id}'/>"
                                                                        class="btn btn-sm btn-outline-info">
                                                                        <i class="fas fa-eye"></i>
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions Footer -->
                    <div class="row g-3 mt-2">
                        <div class="col-12">
                            <div class="card card-modern p-3">
                                <div class="row text-center g-3">
                                    <div class="col-lg-3 col-md-6">
                                        <a href="<c:url value='/customers?action=new'/>"
                                            class="btn btn-outline-primary w-100 quick-btn">
                                            <i class="fas fa-user-plus fa-lg mb-2 d-block"></i>
                                            <span>Add Customer</span>
                                        </a>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <a href="<c:url value='/items?action=new'/>"
                                            class="btn btn-outline-success w-100 quick-btn">
                                            <i class="fas fa-box fa-lg mb-2 d-block"></i>
                                            <span>Add Item</span>
                                        </a>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <a href="<c:url value='/invoices?action=new'/>"
                                            class="btn btn-outline-warning w-100 quick-btn">
                                            <i class="fas fa-file-invoice fa-lg mb-2 d-block"></i>
                                            <span>Create Invoice</span>
                                        </a>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <a href="<c:url value='/invoices?action=list'/>"
                                            class="btn btn-outline-info w-100 quick-btn">
                                            <i class="fas fa-list fa-lg mb-2 d-block"></i>
                                            <span>View All</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
            </body>

            </html>