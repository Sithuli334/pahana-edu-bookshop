<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Customers</title>
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
                        color: #fff !important;
                    }

                    .navbar.bg-white {
                        background: linear-gradient(90deg, #06326b 0%, #046d6e 100%) !important;
                    }

                    .card-modern {
                        border: 0;
                        border-radius: 12px;
                        box-shadow: 0 8px 28px rgba(2, 6, 23, 0.6);
                        background: linear-gradient(180deg, rgba(255, 255, 255, 0.02), rgba(255, 255, 255, 0.01));
                        color: #e6f3fb;
                    }

                    .table-modern thead {
                        background: rgba(255, 255, 255, 0.02);
                        color: #e6f3fb;
                    }

                    .small-muted,
                    .text-muted {
                        color: rgba(230, 243, 251, 0.78) !important;
                    }

                    .btn-primary {
                        background-color: #00bfa6;
                        border-color: #00bfa6;
                        color: #042028;
                    }

                    .btn-outline-primary {
                        color: #e6f3fb;
                        border-color: rgba(255, 255, 255, 0.08);
                    }

                    .badge.bg-info {
                        background: linear-gradient(135deg, #0288a7, #00b8d4);
                    }
                </style>
            </head>

            <body>
                <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                    <div class="container-fluid px-4">
                        <a class="navbar-brand d-flex align-items-center" href="<c:url value='/dashboard'/>">
                            <span class="me-2"><i class="fas fa-users text-primary"></i></span>
                            <span>Customers</span>
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
                                    <a class="nav-link active"
                                        href="<c:url value='/customers?action=list'/>">Customers</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/items?action=list'/>">Items</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/invoices?action=list'/>">Invoices</a>
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
                            <h1 class="h5 mb-0">Customer Management</h1>
                            <p class="small text-muted mb-0">Manage customer records and accounts.</p>
                        </div>
                        <div>
                            <a href="<c:url value='/customers?action=new'/>" class="btn btn-primary btn-sm">
                                <i class="fas fa-plus me-1"></i> New Customer
                            </a>
                        </div>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">${errorMessage}</div>
                    </c:if>

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success" role="alert">${successMessage}</div>
                    </c:if>

                    <!-- Search -->
                    <div class="card card-modern mb-4">
                        <div class="card-body">
                            <form method="get" action="<c:url value='/customers'/>" class="row g-3 align-items-center">
                                <input type="hidden" name="action" value="search">
                                <div class="col-md-9">
                                    <input type="text" class="form-control" name="searchTerm"
                                        placeholder="Search customers by name..." value="${searchTerm}">
                                </div>
                                <div class="col-md-3 d-flex gap-2">
                                    <button type="submit" class="btn btn-outline-primary w-50">Search</button>
                                    <a href="<c:url value='/customers?action=list'/>"
                                        class="btn btn-outline-secondary w-50">Clear</a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Customer list -->
                    <div class="card card-modern">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h5 class="mb-0">Customers <small
                                        class="text-muted">(<span>${customers.size()}</span>)</small></h5>
                                <div class="small text-muted">&nbsp;</div>
                            </div>

                            <c:choose>
                                <c:when test="${empty customers}">
                                    <div class="text-center py-4">
                                        <p class="text-muted">No customers found.</p>
                                        <a href="<c:url value='/customers?action=new'/>" class="btn btn-primary">Create
                                            Your First Customer</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle">
                                            <thead class="table-modern">
                                                <tr>
                                                    <th>Account #</th>
                                                    <th>Name</th>
                                                    <th>Email</th>
                                                    <th>Phone</th>
                                                    <th>Type</th>
                                                    <th>Units</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="customer" items="${customers}">
                                                    <tr>
                                                        <td><strong>${customer.accountNumber}</strong></td>
                                                        <td>${customer.name}</td>
                                                        <td>${customer.email}</td>
                                                        <td>${customer.phone}</td>
                                                        <td><span class="badge bg-info">${customer.customerType}</span>
                                                        </td>
                                                        <td>
                                                            <fmt:formatNumber value="${customer.unitsConsumed}"
                                                                pattern="#,##0.00" />
                                                        </td>
                                                        <td>
                                                            <div class="btn-group" role="group">
                                                                <a href="<c:url value='/customers?action=view&id=${customer.id}'/>"
                                                                    class="btn btn-sm btn-outline-info" title="View"><i
                                                                        class="fas fa-eye"></i></a>
                                                                <a href="<c:url value='/customers?action=edit&id=${customer.id}'/>"
                                                                    class="btn btn-sm btn-outline-warning"
                                                                    title="Edit"><i class="fas fa-edit"></i></a>
                                                                <button type="button"
                                                                    class="btn btn-sm btn-outline-danger"
                                                                    data-id="${customer.id}"
                                                                    data-name="${customer.name}"
                                                                    onclick="confirmDeleteFromButton(this)"
                                                                    title="Delete"><i class="fas fa-trash"></i></button>
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

                <!-- Delete Confirmation Modal -->
                <div class="modal fade" id="deleteModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Confirm Delete</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                Are you sure you want to delete customer <strong id="customerName"></strong>? This
                                action cannot be undone.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <form id="deleteForm" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" id="customerId">
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
                <script>
                    function confirmDeleteFromButton(btn) {
                        confirmDelete(btn.dataset.id, btn.dataset.name);
                    }

                    function confirmDelete(id, name) {
                        document.getElementById('customerId').value = id;
                        document.getElementById('customerName').textContent = name;
                        document.getElementById('deleteForm').action = '<c:url value="/customers"/>';
                        new bootstrap.Modal(document.getElementById('deleteModal')).show();
                    }
                </script>
            </body>

            </html>