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
                        <c:when test="${isEdit}">Edit Invoice</c:when>
                        <c:otherwise>New Invoice</c:otherwise>
                    </c:choose>
                </title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
                    rel="stylesheet">
                <style>
                    body {
                        font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Arial;
                        background: linear-gradient(135deg, #071428 0%, #042a3e 60%);
                        color: #e6f3fb;
                        min-height: 100vh;
                    }

                    .navbar-brand {
                        font-weight: 700;
                        color: #fff !important;
                    }

                    .navbar .nav-link {
                        color: #ffffff !important;
                    }

                    .navbar .nav-link:hover,
                    .navbar .nav-link:focus {
                        color: #ffffff !important;
                    }

                    .navbar .nav-link.active {
                        color: #ffffff !important;
                        font-weight: 600;
                    }

                    .navbar {
                        background: linear-gradient(90deg, #06326b 0%, #046d6e 100%) !important;
                    }

                    .card-modern {
                        border: 0;
                        border-radius: 12px;
                        box-shadow: 0 8px 24px rgba(2, 6, 23, 0.6);
                        background: rgba(255, 255, 255, 0.02);
                        color: #e6f3fb;
                    }

                    .card,
                    .card-header {
                        background: rgba(255, 255, 255, 0.02) !important;
                        color: #e6f3fb;
                        border: none;
                    }

                    .card-body {
                        color: #e6f3fb;
                    }

                    .form-label {
                        color: #cfeef7;
                    }

                    .form-control,
                    .form-select {
                        background: rgba(255, 255, 255, 0.03);
                        color: #e6f3fb;
                        border: 1px solid rgba(255, 255, 255, 0.06);
                    }

                    .form-control::placeholder {
                        color: rgba(230, 243, 251, 0.5);
                    }

                    .btn-primary {
                        background: #00bfa6;
                        border-color: #00bfa6;
                    }

                    .btn-secondary {
                        background: transparent;
                        border-color: rgba(255, 255, 255, 0.12);
                        color: #e6f3fb;
                    }

                    .form-control:focus,
                    .form-select:focus {
                        background: rgba(255, 255, 255, 0.05);
                        color: #fff;
                        border-color: rgba(0, 191, 166, 0.4);
                        box-shadow: 0 0 0 0.25rem rgba(0, 191, 166, 0.15);
                    }

                    .text-muted {
                        color: rgba(230, 243, 251, 0.65) !important;
                    }
                </style>
            </head>

            <body>
                <nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
                    <div class="container-fluid px-4">
                        <a class="navbar-brand" href="<c:url value='/dashboard'/>"><i
                                class="fas fa-file-invoice text-primary me-2"></i>Invoices</a>
                        <div class="d-flex ms-auto align-items-center">
                            <div class="me-3 text-light small">Welcome, <strong>${sessionScope.userName}</strong></div>
                            <a class="btn btn-outline-secondary btn-sm" href="<c:url value='/logout'/>">Logout</a>
                        </div>
                    </div>
                </nav>

                <div class="container-fluid px-4 mt-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <h1 class="h5 mb-0"><i class="fas fa-file-invoice me-1"></i>
                                <c:choose>
                                    <c:when test="${isEdit}">Edit Invoice</c:when>
                                    <c:otherwise>New Invoice</c:otherwise>
                                </c:choose>
                            </h1>
                            <p class="small text-muted mb-0">Create or modify invoices.</p>
                        </div>
                        <div>
                            <a href="<c:url value='/invoices?action=list'/>" class="btn btn-secondary btn-sm"><i
                                    class="fas fa-arrow-left me-1"></i> Back to Invoices</a>
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

                    <!-- Invoice Form -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Invoice Information</h5>
                        </div>
                        <div class="card-body">
                            <form method="post" action="<c:url value='/invoices'/>">
                                <input type="hidden" name="action" value="save">
                                <c:if test="${isEdit}">
                                    <input type="hidden" name="invoiceId" value="${invoice.id}">
                                </c:if>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="customerId" class="form-label">Customer <span
                                                    class="text-danger">*</span></label>
                                            <select class="form-select" id="customerId" name="customerId" required>
                                                <option value="">Select a customer...</option>
                                                <c:forEach var="customer" items="${customers}">
                                                    <option value="${customer.id}" <c:if
                                                        test="${invoice.customerId == customer.id}">selected
                                                        </c:if>>
                                                        ${customer.name} - ${customer.email}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="invoiceNumber" class="form-label">Invoice Number</label>
                                            <input type="text" class="form-control" id="invoiceNumber"
                                                name="invoiceNumber" value="${invoice.invoiceNumber}" readonly
                                                placeholder="Auto-generated">
                                            <div class="form-text">Invoice number will be auto-generated</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="invoiceDate" class="form-label">Invoice Date <span
                                                    class="text-danger">*</span></label>
                                            <input type="date" class="form-control" id="invoiceDate" name="invoiceDate"
                                                value="${invoice.invoiceDate}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="dueDate" class="form-label">Due Date <span
                                                    class="text-danger">*</span></label>
                                            <input type="date" class="form-control" id="dueDate" name="dueDate"
                                                value="${invoice.dueDate}" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="paymentTerms" class="form-label">Payment Terms</label>
                                            <select class="form-select" id="paymentTerms" name="paymentTerms">
                                                <option value="Net 30" <c:if
                                                    test="${invoice.paymentTerms == 'Net 30' or empty invoice.paymentTerms}">
                                                    selected</c:if>>Net 30</option>
                                                <option value="Net 15" <c:if test="${invoice.paymentTerms == 'Net 15'}">
                                                    selected</c:if>
                                                    >Net 15</option>
                                                <option value="Net 45" <c:if test="${invoice.paymentTerms == 'Net 45'}">
                                                    selected</c:if>
                                                    >Net 45</option>
                                                <option value="Due on Receipt" <c:if
                                                    test="${invoice.paymentTerms == 'Due on Receipt'}">selected
                                                    </c:if>>Due on Receipt</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="paymentStatus" class="form-label">Payment Status</label>
                                            <select class="form-select" id="paymentStatus" name="paymentStatus">
                                                <option value="PENDING" <c:if
                                                    test="${invoice.paymentStatus == 'PENDING' or empty invoice.paymentStatus}">
                                                    selected</c:if>>Pending</option>
                                                <option value="PAID" <c:if test="${invoice.paymentStatus == 'PAID'}">
                                                    selected</c:if>
                                                    >Paid</option>
                                                <option value="OVERDUE" <c:if
                                                    test="${invoice.paymentStatus == 'OVERDUE'}">selected</c:if>
                                                    >Overdue</option>
                                                <option value="CANCELLED" <c:if
                                                    test="${invoice.paymentStatus == 'CANCELLED'}">selected
                                                    </c:if>>Cancelled</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="notes" class="form-label">Notes</label>
                                    <textarea class="form-control" id="notes" name="notes" rows="3"
                                        placeholder="Additional notes or comments">${invoice.notes}</textarea>
                                </div>

                                <div class="d-flex justify-content-between">
                                    <a href="<c:url value='/invoices?action=list'/>" class="btn btn-secondary">
                                        <i class="fas fa-times"></i> Cancel
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save"></i>
                                        <c:choose>
                                            <c:when test="${isEdit}">Update Invoice</c:when>
                                            <c:otherwise>Create Invoice</c:otherwise>
                                        </c:choose>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    // Set default due date to 30 days from invoice date
                    document.getElementById('invoiceDate').addEventListener('change', function () {
                        const invoiceDate = new Date(this.value);
                        const dueDate = new Date(invoiceDate);
                        dueDate.setDate(dueDate.getDate() + 30);

                        // Format the date as YYYY-MM-DD
                        const year = dueDate.getFullYear();
                        const month = String(dueDate.getMonth() + 1).padStart(2, '0');
                        const day = String(dueDate.getDate()).padStart(2, '0');

                        document.getElementById('dueDate').value = year + '-' + month + '-' + day;
                    });

                    // Set default dates if creating new invoice
                    var IS_EDIT = <c:choose><c:when test="${isEdit}">true</c:when><c:otherwise>false</c:otherwise></c:choose>;
                    document.addEventListener('DOMContentLoaded', function () {
                        if (!IS_EDIT) {
                            const today = new Date();
                            const invoiceDateField = document.getElementById('invoiceDate');
                            const dueDateField = document.getElementById('dueDate');

                            // Set today as invoice date if not set
                            if (invoiceDateField && !invoiceDateField.value) {
                                const year = today.getFullYear();
                                const month = String(today.getMonth() + 1).padStart(2, '0');
                                const day = String(today.getDate()).padStart(2, '0');
                                invoiceDateField.value = year + '-' + month + '-' + day;
                            }

                            // Set due date to 30 days from today if not set
                            if (dueDateField && !dueDateField.value) {
                                const dueDate = new Date(today);
                                dueDate.setDate(dueDate.getDate() + 30);
                                const year = dueDate.getFullYear();
                                const month = String(dueDate.getMonth() + 1).padStart(2, '0');
                                const day = String(dueDate.getDate()).padStart(2, '0');
                                dueDateField.value = year + '-' + month + '-' + day;
                            }
                        }
                    });
                </script>
            </body>

            </html>