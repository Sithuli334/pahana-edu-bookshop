<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Invoice Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Arial;
                background: linear-gradient(135deg, #071428 0%, #072f4f 60%);
                color: #e6f3fb;
            }

            .card-modern {
                border: 0;
                border-radius: 12px;
                box-shadow: 0 8px 28px rgba(2, 6, 23, 0.6);
                background: rgba(255, 255, 255, 0.02);
                color: #e6f3fb;
            }

            .card-body {
                color: #e6f3fb;
            }

            .navbar {
                background: linear-gradient(90deg, #06326b 0%, #046d6e 100%) !important;
            }

            .navbar-brand,
            .navbar a {
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

            .btn-outline-secondary {
                color: rgba(255, 255, 255, 0.8);
                border-color: rgba(255, 255, 255, 0.2);
            }

            @media print {

                .no-print,
                .navbar,
                .btn,
                .mt-3 {
                    display: none !important;
                }

                .container {
                    max-width: none !important;
                    margin: 0 !important;
                    padding: 20px !important;
                }

                .invoice-header {
                    border-bottom: 2px solid #333;
                    margin-bottom: 20px;
                    padding-bottom: 10px;
                }

                .table {
                    font-size: 12px;
                }

                body {
                    font-size: 12px;
                    color: #000;
                    background: #fff !important;
                }

                .company-info {
                    text-align: center;
                    margin-bottom: 30px;
                }
            }

            .invoice-header {
                display: flex;
                justify-content: space-between;
                align-items: start;
                margin-bottom: 30px;
            }

            .company-info h2 {
                margin-bottom: 5px;
                color: #00bfa6;
            }

            .invoice-number {
                color: #ffd166;
                font-weight: 700;
            }

            .badge.bg-info {
                background: #00bfa6;
                color: #042028;
            }

            .table thead th {
                background-color: #06326b;
                color: #e6f3fb;
            }

            .table tbody td {
                color: #d8f1f8;
            }
        </style>
    </head>

    <body>
        <nav class="navbar navbar-expand-lg navbar-dark shadow-sm no-print">
            <div class="container-fluid px-4">
                <a class="navbar-brand" href="<c:url value='/invoices'/>"> <i
                        class="fas fa-file-invoice text-primary me-2"></i>Invoices</a>
                <div class="d-flex ms-auto align-items-center">
                    <a class="btn btn-outline-secondary btn-sm" href="<c:url value='/logout'/>">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container-fluid px-4 mt-4">
            <!-- Print-friendly company header -->
            <div class="company-info d-none d-print-block">
                <h2>Pahana Edu Billing System</h2>
                <p>Educational Services & Billing Solutions</p>
                <hr>
            </div>

            <!-- Action buttons (hidden when printing) -->
            <div class="d-flex justify-content-between align-items-center mb-3 no-print">
                <div>
                    <h1 class="h5 mb-0">Invoice Details</h1>
                    <p class="small text-muted mb-0">Invoice ${invoice.invoiceNumber}</p>
                </div>
                <div>
                    <a href="<c:url value='/invoices?action=print&id=${invoice.id}'/>"
                        class="btn btn-outline-success btn-sm me-2" target="_blank"><i class="fas fa-print"></i></a>
                    <a href="<c:url value='/invoices?action=list'/>" class="btn btn-outline-secondary btn-sm"><i
                            class="fas fa-arrow-left"></i></a>
                </div>
            </div>

            <c:if test="${not empty invoice}">
                <!-- Invoice Header -->
                <div class="invoice-header">
                    <div class="row">
                        <div class="col-md-6">
                            <h3 class="text-primary d-print-none">INVOICE</h3>
                            <h3 class="d-none d-print-block">INVOICE</h3>
                            <p><strong>Invoice Number:</strong> ${invoice.invoiceNumber}</p>
                            <p><strong>Invoice Date:</strong> ${invoice.invoiceDate}</p>
                            <p><strong>Due Date:</strong> ${invoice.dueDate}</p>
                            <p><strong>Payment Status:</strong>
                                <span class="badge bg-info d-print-none">${invoice.paymentStatus}</span>
                                <span class="d-none d-print-inline">${invoice.paymentStatus}</span>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <h5>Bill To:</h5>
                            <p><strong>${invoice.customer.name}</strong></p>
                            <c:if test="${not empty invoice.customer.email}">
                                <p>Email: ${invoice.customer.email}</p>
                            </c:if>
                            <c:if test="${not empty invoice.customer.phone}">
                                <p>Phone: ${invoice.customer.phone}</p>
                            </c:if>
                            <c:if test="${not empty invoice.customer.address}">
                                <p>Address: ${invoice.customer.address}</p>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Invoice Items -->
                <div class="card card-modern mb-3">
                    <div class="card-body">
                        <h6 class="mb-3">Invoice Items</h6>
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead class="table-light">
                                    <tr>
                                        <th>Item Name</th>
                                        <th>Quantity</th>
                                        <th>Unit Price</th>
                                        <th>Discount</th>
                                        <th>Line Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${invoiceItems}">
                                        <tr>
                                            <td>${item.item.name}</td>
                                            <td>${item.quantity}</td>
                                            <td>Rs.
                                                <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00" />
                                            </td>
                                            <td>Rs.
                                                <fmt:formatNumber value="${item.discount}" pattern="#,##0.00" />
                                            </td>
                                            <td>Rs.
                                                <fmt:formatNumber value="${item.lineTotal}" pattern="#,##0.00" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="4" class="text-end"><strong>Subtotal:</strong></td>
                                        <td><strong>Rs.
                                                <fmt:formatNumber value="${invoice.subtotal}" pattern="#,##0.00" />
                                            </strong></td>
                                    </tr>
                                    <c:if test="${invoice.taxAmount > 0}">
                                        <tr>
                                            <td colspan="4" class="text-end"><strong>Tax:</strong></td>
                                            <td><strong>Rs.
                                                    <fmt:formatNumber value="${invoice.taxAmount}" pattern="#,##0.00" />
                                                </strong></td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${invoice.discountAmount > 0}">
                                        <tr>
                                            <td colspan="4" class="text-end"><strong>Discount:</strong></td>
                                            <td><strong>-Rs.
                                                    <fmt:formatNumber value="${invoice.discountAmount}"
                                                        pattern="#,##0.00" />
                                                </strong></td>
                                        </tr>
                                    </c:if>
                                    <tr class="table-active">
                                        <td colspan="4" class="text-end"><strong>Total Amount:</strong></td>
                                        <td><strong>Rs.
                                                <fmt:formatNumber value="${invoice.totalAmount}" pattern="#,##0.00" />
                                            </strong></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <!-- Additional Information -->
                        <c:if test="${not empty invoice.notes}">
                            <div class="row mt-4">
                                <div class="col-12">
                                    <h5>Notes:</h5>
                                    <p>${invoice.notes}</p>
                                </div>
                            </div>
                        </c:if>

                        <div class="row mt-4">
                            <div class="col-md-6">
                                <p><strong>Payment Terms:</strong> ${invoice.paymentTerms}</p>
                            </div>
                            <div class="col-md-6 text-end d-none d-print-block">
                                <p><small>Thank you for your business!</small></p>
                            </div>
                        </div>
            </c:if>

            <c:if test="${empty invoice}">
                <div class="alert alert-warning">No invoice details available.</div>
            </c:if>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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