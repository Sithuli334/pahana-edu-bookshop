<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Item Details</title>
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

                    .table-borderless td {
                        color: rgba(230, 243, 251, 0.95);
                    }

                    .text-muted {
                        color: rgba(230, 243, 251, 0.78) !important;
                    }

                    .badge.bg-primary {
                        background: linear-gradient(135deg, #046d6e, #06326b);
                    }

                    .badge.bg-warning {
                        background-color: #ffb020;
                        color: #072028;
                    }

                    .badge.bg-success {
                        background-color: #1ec07a;
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
                </style>
            </head>

            <body>
                <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                    <div class="container-fluid px-4">
                        <a class="navbar-brand" href="<c:url value='/dashboard'/>">Items</a>
                        <div class="d-flex ms-auto align-items-center">
                            <div class="me-3 text-muted small">Welcome, <strong>${sessionScope.userName}</strong></div>
                            <a class="btn btn-outline-secondary btn-sm" href="<c:url value='/logout'/>">Logout</a>
                        </div>
                    </div>
                </nav>

                <div class="container-fluid px-4 mt-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <h1 class="h5 mb-0"><i class="fas fa-box me-1"></i> Item Details</h1>
                            <p class="small text-muted mb-0">Detailed information about the selected item.</p>
                        </div>
                        <div>
                            <a href="<c:url value='/items?action=edit&id=${item.id}'/>"
                                class="btn btn-primary btn-sm me-2"><i class="fas fa-edit me-1"></i> Edit Item</a>
                            <a href="<c:url value='/items?action=list'/>" class="btn btn-secondary btn-sm"><i
                                    class="fas fa-arrow-left me-1"></i> Back to Items</a>
                        </div>
                    </div>

                    <c:if test="${not empty item}">
                        <div class="card card-modern mb-4">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>Item Code:</strong></td>
                                                <td><span class="badge bg-primary fs-6">${item.code}</span></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Name:</strong></td>
                                                <td>${item.name}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Unit:</strong></td>
                                                <td>${item.unit}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Price:</strong></td>
                                                <td><strong class="text-success">Rs.
                                                        <fmt:formatNumber value="${item.price}" pattern="#,##0.00" />
                                                    </strong></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>Stock Quantity:</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${item.stockQuantity <= 10}">
                                                            <span
                                                                class="badge bg-warning fs-6">${item.stockQuantity}</span>
                                                            <small class="text-muted">(Low Stock)</small>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                class="badge bg-success fs-6">${item.stockQuantity}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Status:</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${item.active}">
                                                            <span class="badge bg-success fs-6">Active</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary fs-6">Inactive</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Created:</strong></td>
                                                <td>
                                                    <c:if test="${not empty item.createdAt}">${item.createdAt}</c:if>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Last Updated:</strong></td>
                                                <td>
                                                    <c:if test="${not empty item.updatedAt}">${item.updatedAt}</c:if>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                                <c:if test="${not empty item.description}">
                                    <div class="row mt-3">
                                        <div class="col-12">
                                            <h6><strong>Description:</strong></h6>
                                            <p class="text-muted">${item.description}</p>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <div class="card card-modern">
                            <div class="card-body">
                                <div class="d-flex gap-2">
                                    <a href="<c:url value='/items?action=edit&id=${item.id}'/>"
                                        class="btn btn-primary btn-sm"><i class="fas fa-edit me-1"></i> Edit Item</a>
                                    <form method="post" action="<c:url value='/items'/>" class="d-inline">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${item.id}">
                                        <button type="submit" class="btn btn-danger btn-sm"
                                            onclick="return confirm('Are you sure you want to delete this item? This action cannot be undone.')"><i
                                                class="fas fa-trash me-1"></i> Delete Item</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${empty item}">
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle"></i>
                            Item not found.
                        </div>
                    </c:if>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>