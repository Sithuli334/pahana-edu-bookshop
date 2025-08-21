<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Edit Invoice</title>
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
                        box-shadow: 0 8px 28px rgba(2, 6, 23, 0.6);
                        background: linear-gradient(180deg, rgba(255, 255, 255, 0.02), rgba(255, 255, 255, 0.01));
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

                    .form-label {
                        color: #cfeef7;
                    }

                    .form-control,
                    .form-select {
                        background: rgba(255, 255, 255, 0.03);
                        color: #e6f3fb;
                        border: 1px solid rgba(255, 255, 255, 0.06);
                    }

                    .btn-primary {
                        background: #00bfa6;
                        border-color: #00bfa6;
                    }

                    /* Preserve and adjust print rules to remain printable */
                    @media print {

                        .no-print,
                        .navbar,
                        .btn,
                        .card-header,
                        .alert {
                            display: none !important;
                        }

                        .container,
                        .container-fluid {
                            max-width: none !important;
                            margin: 0 !important;
                            padding: 20px !important;
                        }

                        .card {
                            border: none !important;
                            box-shadow: none !important;
                        }

                        .card-body {
                            padding: 0 !important;
                        }

                        body {
                            font-size: 12px;
                            color: #000;
                            background: #fff !important;
                        }

                        .table {
                            font-size: 11px;
                        }

                        h2 {
                            font-size: 18px;
                            margin-bottom: 20px;
                        }

                        .company-header {
                            text-align: center;
                            margin-bottom: 30px;
                            border-bottom: 2px solid #333;
                            padding-bottom: 10px;
                            display: block !important;
                        }
                    }

                    .company-header {
                        display: none;
                    }

                    .table thead th {
                        background-color: #06326b;
                        color: #e6f3fb;
                    }

                    .table tbody td {
                        color: #d8f1f8;
                    }

                    .text-muted {
                        color: rgba(230, 243, 251, 0.65) !important;
                    }

                    .table-modern {
                        background-color: #06326b;
                    }
                </style>
            </head>

            <body>
                <nav class="navbar navbar-expand-lg navbar-dark shadow-sm no-print">
                    <div class="container-fluid px-4">
                        <a class="navbar-brand" href="<c:url value='/invoices'/>"><i
                                class="fas fa-file-invoice text-primary me-2"></i>Invoices</a>
                        <div class="d-flex ms-auto align-items-center">
                            <div class="me-3 text-light small">Welcome, <strong>${sessionScope.userName}</strong></div>
                            <a class="btn btn-outline-secondary btn-sm" href="<c:url value='/logout'/>">Logout</a>
                        </div>
                    </div>
                </nav>

                <div class="container-fluid px-4 mt-4">
                    <!-- Print-only company header -->
                    <div class="company-header">
                        <h2>Pahana Edu Billing System</h2>
                        <p>Educational Services & Billing Solutions</p>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center mb-3 no-print">
                                <div>
                                    <h1 class="h5 mb-0">Edit Invoice <small
                                            class="text-muted">${invoice.invoiceNumber}</small></h1>
                                    <p class="small text-muted mb-0">Modify items, dates, and totals for this invoice.
                                    </p>
                                </div>
                                <div>
                                    <!-- <button onclick="printInvoice()" class="btn btn-outline-success btn-sm me-2"><i
                                            class="fas fa-print"></i></button> -->
                                    <a href="<c:url value='/invoices?action=view&id=${invoice.id}'/>"
                                        class="btn btn-outline-info btn-sm me-2"><i class="fas fa-eye"></i></a>
                                    <a href="<c:url value='/invoices?action=list'/>"
                                        class="btn btn-outline-secondary btn-sm"><i class="fas fa-arrow-left"></i></a>
                                </div>
                            </div>

                            <!-- Print-only invoice header -->
                            <div class="d-none d-print-block mb-4">
                                <h2>INVOICE: ${invoice.invoiceNumber}</h2>
                                <div class="row">
                                    <div class="col-6">
                                        <p><strong>Invoice Date:</strong> ${invoice.invoiceDate}</p>
                                        <p><strong>Due Date:</strong> ${invoice.dueDate}</p>
                                        <p><strong>Payment Status:</strong> ${invoice.paymentStatus}</p>
                                    </div>
                                    <div class="col-6">
                                        <p><strong>Bill To:</strong></p>
                                        <p>${invoice.customer.name}</p>
                                        <c:if test="${not empty invoice.customer.email}">
                                            <p>${invoice.customer.email}</p>
                                        </c:if>
                                        <c:if test="${not empty invoice.customer.phone}">
                                            <p>${invoice.customer.phone}</p>
                                        </c:if>
                                    </div>
                                </div>
                                <hr>
                            </div>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <c:if test="${param.success == 'updated'}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    Invoice updated successfully!
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <!-- Editable Invoice Information -->
                            <div class="card card-modern mb-4">
                                <div class="card-header bg-white border-0">
                                    <h5 class="mb-0">Invoice Information</h5>
                                </div>
                                <div class="card-body">
                                    <form method="post" action="<c:url value='/invoices'/>">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="invoiceId" value="${invoice.id}">

                                        <div class="row">
                                            <div class="col-md-6">
                                                <p><strong>Invoice Number:</strong> ${invoice.invoiceNumber}</p>
                                                <p><strong>Customer:</strong> ${invoice.customer.name}</p>
                                                <c:if test="${not empty invoice.customer.accountNumber}">
                                                    <p><strong>Account Number:</strong>
                                                        ${invoice.customer.accountNumber}</p>
                                                </c:if>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="invoiceDate" class="form-label">Invoice Date</label>
                                                    <input type="date" class="form-control" id="invoiceDate"
                                                        name="invoiceDate" value="${invoice.invoiceDate}" required>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="dueDate" class="form-label">Due Date</label>
                                                    <input type="date" class="form-control" id="dueDate" name="dueDate"
                                                        value="${invoice.dueDate}" required>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="paymentStatus" class="form-label">Payment Status</label>
                                                    <select class="form-select" id="paymentStatus" name="paymentStatus">
                                                        <option value="PENDING" <c:if
                                                            test="${invoice.paymentStatus == 'PENDING'}">selected</c:if>
                                                            >Pending</option>
                                                        <option value="PAID" <c:if
                                                            test="${invoice.paymentStatus == 'PAID'}">selected</c:if>
                                                            >Paid</option>
                                                        <option value="OVERDUE" <c:if
                                                            test="${invoice.paymentStatus == 'OVERDUE'}">selected</c:if>
                                                            >Overdue</option>
                                                        <option value="CANCELLED" <c:if
                                                            test="${invoice.paymentStatus == 'CANCELLED'}">selected
                                                            </c:if>>Cancelled</option>
                                                    </select>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="paymentTerms" class="form-label">Payment Terms</label>
                                                    <select class="form-select" id="paymentTerms" name="paymentTerms">
                                                        <option value="Net 30" <c:if
                                                            test="${invoice.paymentTerms == 'Net 30'}">selected</c:if>
                                                            >Net 30</option>
                                                        <option value="Net 15" <c:if
                                                            test="${invoice.paymentTerms == 'Net 15'}">selected</c:if>
                                                            >Net 15</option>
                                                        <option value="Net 45" <c:if
                                                            test="${invoice.paymentTerms == 'Net 45'}">selected</c:if>
                                                            >Net 45</option>
                                                        <option value="Due on Receipt" <c:if
                                                            test="${invoice.paymentTerms == 'Due on Receipt'}">selected
                                                            </c:if>>Due on Receipt</option>
                                                    </select>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="notes" class="form-label">Notes</label>
                                                    <textarea class="form-control" id="notes" name="notes"
                                                        rows="2">${invoice.notes}</textarea>
                                                </div>
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-save"></i> Update Invoice
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Add Item Form - CORE FUNCTIONALITY -->
                            <div class="card card-modern mb-4">
                                <div class="card-header bg-white border-0">
                                    <h5 class="mb-0">Add Item to Invoice</h5>
                                </div>
                                <div class="card-body">
                                    <form method="post" action="<c:url value='/invoices'/>">
                                        <input type="hidden" name="action" value="addItem">
                                        <input type="hidden" name="invoiceId" value="${invoice.id}">

                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="mb-3">
                                                    <label for="itemId" class="form-label">Item *</label>
                                                    <select class="form-select" id="itemId" name="itemId" required>
                                                        <option value="">Select an item...</option>
                                                        <c:forEach var="item" items="${items}">
                                                            <option value="${item.id}">
                                                                ${item.name} (${item.code}) - Rs.
                                                                <fmt:formatNumber value="${item.price}"
                                                                    pattern="#,##0.00" />
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="mb-3">
                                                    <label for="quantity" class="form-label">Quantity *</label>
                                                    <input type="number" step="0.01" class="form-control" id="quantity"
                                                        name="quantity" required min="0.01">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="mb-3">
                                                    <label for="discount" class="form-label">Discount (Rs.)</label>
                                                    <input type="number" step="0.01" class="form-control" id="discount"
                                                        name="discount" min="0" value="0">
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="mb-3">
                                                    <label class="form-label">&nbsp;</label>
                                                    <button type="submit" class="btn btn-success d-block w-100">
                                                        <i class="fas fa-plus"></i> Add Item
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Invoice Items List -->
                            <div class="card card-modern mb-4">
                                <div class="card-header bg-white border-0">
                                    <h5 class="mb-0">Invoice Items</h5>
                                </div>
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${empty invoiceItems}">
                                            <div class="text-center py-4">
                                                <p class="text-muted">No items added to this invoice yet.</p>
                                                <p class="small">Use the form above to add items to the invoice.</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="table-responsive">
                                                <table class="table table-hover align-middle">
                                                    <thead class="table-modern">
                                                        <tr>
                                                            <th>Item</th>
                                                            <th>Code</th>
                                                            <th>Quantity</th>
                                                            <th>Unit Price</th>
                                                            <th>Discount</th>
                                                            <th>Line Total</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="invoiceItem" items="${invoiceItems}">
                                                            <tr>
                                                                <td>${invoiceItem.item.name}</td>
                                                                <td>${invoiceItem.item.code}</td>
                                                                <td>
                                                                    <fmt:formatNumber value="${invoiceItem.quantity}"
                                                                        pattern="#,##0.00" />
                                                                </td>
                                                                <td>Rs.
                                                                    <fmt:formatNumber value="${invoiceItem.unitPrice}"
                                                                        pattern="#,##0.00" />
                                                                </td>
                                                                <td>Rs.
                                                                    <fmt:formatNumber value="${invoiceItem.discount}"
                                                                        pattern="#,##0.00" />
                                                                </td>
                                                                <td><strong>Rs.
                                                                        <fmt:formatNumber
                                                                            value="${invoiceItem.lineTotal}"
                                                                            pattern="#,##0.00" />
                                                                    </strong></td>
                                                                <td>
                                                                    <form method="post"
                                                                        action="<c:url value='/invoices'/>"
                                                                        style="display: inline;">
                                                                        <input type="hidden" name="action"
                                                                            value="removeItem">
                                                                        <input type="hidden" name="invoiceId"
                                                                            value="${invoice.id}">
                                                                        <input type="hidden" name="invoiceItemId"
                                                                            value="${invoiceItem.id}">
                                                                        <button type="submit"
                                                                            class="btn btn-sm btn-outline-danger"
                                                                            onclick="return confirm('Remove this item from the invoice?')">
                                                                            <i class="fas fa-trash"></i>
                                                                        </button>
                                                                    </form>
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

                            <!-- Invoice Totals -->
                            <div class="card card-modern">
                                <div class="card-header bg-white border-0">
                                    <h5 class="mb-0">Invoice Totals</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6 offset-md-6">
                                            <table class="table table-borderless">
                                                <tr>
                                                    <td><strong>Subtotal:</strong></td>
                                                    <td class="text-end">Rs.
                                                        <fmt:formatNumber value="${invoice.subtotal}"
                                                            pattern="#,##0.00" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Discount:</strong></td>
                                                    <td class="text-end">-Rs.
                                                        <fmt:formatNumber value="${invoice.discountAmount}"
                                                            pattern="#,##0.00" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Tax (15%):</strong></td>
                                                    <td class="text-end">Rs.
                                                        <fmt:formatNumber value="${invoice.taxAmount}"
                                                            pattern="#,##0.00" />
                                                    </td>
                                                </tr>
                                                <tr class="table-active">
                                                    <td><strong>Total Amount:</strong></td>
                                                    <td class="text-end"><strong>Rs.
                                                            <fmt:formatNumber value="${invoice.totalAmount}"
                                                                pattern="#,##0.00" />
                                                        </strong></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
                <script>
                    function printInvoice() {
                        // Hide any alerts or messages before printing
                        const alerts = document.querySelectorAll('.alert');
                        alerts.forEach(alert => alert.style.display = 'none');

                        // Print the page
                        window.print();

                        // Show alerts again after printing
                        setTimeout(() => {
                            alerts.forEach(alert => alert.style.display = 'block');
                        }, 100);
                    }

                    // Optional: Add keyboard shortcut for printing (Ctrl+P)
                    document.addEventListener('keydown', function (e) {
                        if (e.ctrlKey && e.key === 'p') {
                            e.preventDefault();
                            printInvoice();
                        }
                    });
                </script>
            </body>

            </html>