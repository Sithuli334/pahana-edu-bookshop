<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Invoices</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
                    rel="stylesheet">
                <style>
                    body {
                        font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Arial;
                        background: linear-gradient(135deg, #071428 0%, #072f4f 60%);
                        color: #e6f3fb;
                    }

                    .navbar-brand {
                        font-weight: 700;
                        color: #fff !important;
                    }

                    .navbar {
                        background: linear-gradient(90deg, #06326b 0%, #046d6e 100%) !important;
                    }

                    .nav-link {
                        color: rgba(255, 255, 255, 0.85) !important;
                    }

                    .nav-link.active {
                        color: #fff !important;
                        font-weight: 600;
                    }

                    .card-modern {
                        border: 0;
                        border-radius: 12px;
                        box-shadow: 0 8px 28px rgba(2, 6, 23, 0.6);
                        background: rgba(255, 255, 255, 0.02);
                        color: #e6f3fb;
                    }

                    .card-header {
                        background: rgba(255, 255, 255, 0.02) !important;
                        color: #e6f3fb;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                    }

                    .card-body {
                        color: #e6f3fb;
                    }

                    .table-modern thead {
                        background: linear-gradient(90deg, #06326b, #046d6e);
                        color: #fff;
                    }

                    .table thead th {
                        color: #e6f3fb;
                    }

                    .table tbody td {
                        color: #d8f1f8;
                    }

                    .badge.bg-info {
                        background: #00bfa6;
                        color: #042028;
                    }

                    .btn-outline-info {
                        color: #00bfa6;
                        border-color: rgba(0, 191, 166, 0.18);
                    }

                    .btn-outline-success {
                        color: #7ee6cd;
                        border-color: rgba(126, 230, 205, 0.12);
                    }

                    .btn-primary {
                        background: #00bfa6;
                        border-color: #00bfa6;
                    }

                    .text-muted {
                        color: rgba(230, 243, 251, 0.65) !important;
                    }
                </style>
            </head>

            <body>
                <nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
                    <div class="container-fluid px-4">
                        <a class="navbar-brand d-flex align-items-center" href="<c:url value='/dashboard'/>">
                            <span class="me-2"><i class="fas fa-file-invoice text-primary me-2"></i></span>
                            <span>Invoices</span>
                        </a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/dashboard'/>">Overview</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/customers?action=list'/>">Customers</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/items?action=list'/>">Items</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active"
                                        href="<c:url value='/invoices?action=list'/>">Invoices</a>
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
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <h1 class="h5 mb-0">Invoices</h1>
                            <p class="small text-muted mb-0">Manage invoices and billing records.</p>
                        </div>
                        <div>
                            <a href="<c:url value='/invoices?action=new'/>" class="btn btn-primary btn-sm"><i
                                    class="fas fa-plus me-1"></i> New Invoice</a>
                        </div>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Invoice List -->
                    <div class="card card-modern">
                        <div class="card-header border-0">
                            <h5 class="mb-0">Invoices</h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${empty invoices}">
                                    <div class="text-center py-4">
                                        <p class="text-muted">No invoices found.</p>
                                        <a href="<c:url value='/invoices?action=new'/>" class="btn btn-primary">
                                            Create Your First Invoice
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle">
                                            <thead class="table-modern">
                                                <tr>
                                                    <th>Invoice #</th>
                                                    <th>Customer</th>
                                                    <th>Invoice Date</th>
                                                    <th>Due Date</th>
                                                    <th>Status</th>
                                                    <th>Total Amount</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="invoice" items="${invoices}">
                                                    <tr>
                                                        <td><strong>${invoice.invoiceNumber}</strong></td>
                                                        <td>${invoice.customer.name}</td>
                                                        <td>
                                                            ${invoice.invoiceDate}
                                                        </td>
                                                        <td>
                                                            ${invoice.dueDate}
                                                        </td>
                                                        <td>
                                                            <span class="badge bg-info">${invoice.paymentStatus}</span>
                                                        </td>
                                                        <td>Rs.
                                                            <fmt:formatNumber value="${invoice.totalAmount}"
                                                                pattern="#,##0.00" />
                                                        </td>
                                                        <td>
                                                            <div class="btn-group" role="group">
                                                                <a href="<c:url value='/invoices?action=view&id=${invoice.id}'/>"
                                                                    class="btn btn-sm btn-outline-info" title="View">
                                                                    <i class="fas fa-eye"></i>
                                                                </a>
                                                                <a href="<c:url value='/invoices?action=print&id=${invoice.id}'/>"
                                                                    class="btn btn-sm btn-outline-success" title="Print"
                                                                    target="_blank">
                                                                    <i class="fas fa-print"></i>
                                                                </a>
                                                                <a href="<c:url value='/invoices?action=edit&id=${invoice.id}'/>"
                                                                    class="btn btn-sm btn-outline-warning" title="Edit">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
                                                                <form method="post" action="<c:url value='/invoices'/>"
                                                                    style="display: inline;">
                                                                    <input type="hidden" name="action" value="delete">
                                                                    <input type="hidden" name="id"
                                                                        value="${invoice.id}">
                                                                    <button type="submit"
                                                                        class="btn btn-sm btn-outline-danger"
                                                                        onclick="return confirm('Delete this invoice?')">
                                                                        <i class="fas fa-trash"></i>
                                                                    </button>
                                                                </form>
                                                            </div>
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
                </div>

                <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
            </body>

            </html>