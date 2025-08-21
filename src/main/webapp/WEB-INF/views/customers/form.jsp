<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>
                    <c:choose>
                        <c:when test="${isEdit}">Edit Customer</c:when>
                        <c:otherwise>New Customer</c:otherwise>
                    </c:choose>
                </title>
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

                    .form-label,
                    .form-text {
                        color: rgba(230, 243, 251, 0.9);
                    }

                    .text-muted {
                        color: rgba(230, 243, 251, 0.78) !important;
                    }

                    .btn-primary {
                        background-color: #00bfa6;
                        border-color: #00bfa6;
                        color: #042028;
                    }

                    .btn-secondary,
                    .btn-outline-secondary {
                        color: #e6f3fb;
                        border-color: rgba(255, 255, 255, 0.08);
                    }

                    .table-modern thead {
                        background: rgba(255, 255, 255, 0.02);
                        color: #e6f3fb;
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
                                <li class="nav-item"><a class="nav-link" href="<c:url value='/dashboard'/>">Overview</a>
                                </li>
                                <li class="nav-item"><a class="nav-link active"
                                        href="<c:url value='/customers?action=list'/>">Customers</a></li>
                                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/items?action=list'/>">Items</a></li>
                                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/invoices?action=list'/>">Invoices</a></li>
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
                            <h1 class="h5 mb-0">
                                <c:choose>
                                    <c:when test="${isEdit}">Edit Customer</c:when>
                                    <c:otherwise>New Customer</c:otherwise>
                                </c:choose>
                            </h1>
                            <p class="small text-muted mb-0">Enter customer details below.</p>
                        </div>
                        <div>
                            <a href="<c:url value='/customers?action=list'/>" class="btn btn-secondary btn-sm"><i
                                    class="fas fa-arrow-left me-1"></i> Back to List</a>
                        </div>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">${errorMessage}</div>
                    </c:if>

                    <div class="card card-modern">
                        <div class="card-body">
                            <form method="post" action="<c:url value='/customers'/>">
                                <input type="hidden" name="action" value="${isEdit ? 'update' : 'save'}">
                                <c:if test="${isEdit}">
                                    <input type="hidden" name="id" value="${customer.id}">
                                </c:if>

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="name" class="form-label">Customer Name *</label>
                                        <input type="text" class="form-control" id="name" name="name"
                                            value="${customer.name}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="email" class="form-label">Email Address</label>
                                        <input type="email" class="form-control" id="email" name="email"
                                            value="${customer.email}">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="phone" class="form-label">Phone Number</label>
                                        <input type="text" class="form-control" id="phone" name="phone"
                                            value="${customer.phone}">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="telephoneNumber" class="form-label">Telephone Number</label>
                                        <input type="text" class="form-control" id="telephoneNumber"
                                            name="telephoneNumber" value="${customer.telephoneNumber}">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="accountNumber" class="form-label">Account Number</label>
                                        <input type="text" class="form-control" id="accountNumber" name="accountNumber"
                                            value="${customer.accountNumber}"
                                            placeholder="Leave empty to auto-generate">
                                        <div class="form-text">Leave empty to auto-generate account number</div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="customerType" class="form-label">Customer Type *</label>
                                        <select class="form-select" id="customerType" name="customerType" required>
                                            <option value="RESIDENTIAL" <c:if
                                                test="${customer.customerType == 'RESIDENTIAL'}">selected</c:if>
                                                >Residential</option>
                                            <option value="COMMERCIAL" <c:if
                                                test="${customer.customerType == 'COMMERCIAL'}">selected</c:if>
                                                >Commercial</option>
                                            <option value="INDUSTRIAL" <c:if
                                                test="${customer.customerType == 'INDUSTRIAL'}">selected</c:if>
                                                >Industrial</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="unitsConsumed" class="form-label">Units Consumed</label>
                                        <input type="number" step="0.01" class="form-control" id="unitsConsumed"
                                            name="unitsConsumed" value="${customer.unitsConsumed}">
                                        <div class="form-text">Total units consumed by the customer</div>
                                    </div>
                                    <div class="col-12">
                                        <label for="address" class="form-label">Address</label>
                                        <textarea class="form-control" id="address" name="address"
                                            rows="3">${customer.address}</textarea>
                                    </div>
                                    <div class="col-12">
                                        <label for="notes" class="form-label">Notes</label>
                                        <textarea class="form-control" id="notes" name="notes"
                                            rows="3">${customer.notes}</textarea>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-end gap-2 mt-3">
                                    <a href="<c:url value='/customers?action=list'/>"
                                        class="btn btn-secondary">Cancel</a>
                                    <button type="submit" class="btn btn-primary">
                                        <c:choose>
                                            <c:when test="${isEdit}">Update Customer</c:when>
                                            <c:otherwise>Create Customer</c:otherwise>
                                        </c:choose>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
            </body>

            </html>