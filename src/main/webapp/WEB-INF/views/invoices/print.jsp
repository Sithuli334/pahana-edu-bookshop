<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Invoice ${invoice.invoiceNumber} - Print</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
                rel="stylesheet">
            <style>
                body {
                    font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Arial;
                    font-size: 14px;
                    line-height: 1.45;
                    color: #e6f3fb;
                    background: linear-gradient(135deg, #071428 0%, #072f4f 60%);
                }

                /* Print behavior stays strong and switches to light theme for print */
                @media print {
                    body {
                        font-size: 12px;
                        margin: 0;
                        padding: 20px;
                        color: #000;
                        background: #fff !important;
                    }

                    .container {
                        max-width: none !important;
                        margin: 0 !important;
                        padding: 0 !important;
                    }

                    .no-print {
                        display: none !important;
                    }

                    .page-break {
                        page-break-before: always;
                    }

                    .table {
                        font-size: 11px;
                    }

                    .company-header {
                        margin-bottom: 40px;
                    }

                    .invoice-details {
                        margin-bottom: 30px;
                    }
                }

                @media screen {
                    .container {
                        max-width: 900px;
                        margin: 20px auto;
                        padding: 30px;
                        background: rgba(255, 255, 255, 0.02);
                        box-shadow: 0 8px 30px rgba(2, 6, 23, 0.6);
                        border-radius: 8px;
                    }
                }

                .company-header {
                    text-align: center;
                    margin-bottom: 40px;
                    padding-bottom: 20px;
                    border-bottom: 3px solid rgba(255, 255, 255, 0.06);
                }

                .company-header h1 {
                    color: #00bfa6;
                    font-size: 2.2rem;
                    font-weight: 700;
                    margin-bottom: 5px;
                }

                .company-header p {
                    color: rgba(230, 243, 251, 0.8);
                    font-size: 1rem;
                    margin-bottom: 0;
                }

                .invoice-title {
                    font-size: 1.6rem;
                    font-weight: 700;
                    color: #ffd166;
                    text-align: center;
                    margin: 22px 0;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                }

                .invoice-number {
                    font-size: 1.1rem;
                    font-weight: 700;
                    color: #00bfa6;
                }

                .customer-info {
                    background: rgba(255, 255, 255, 0.02);
                    padding: 16px;
                    border-radius: 8px;
                    margin-bottom: 20px;
                }

                .customer-info h5 {
                    color: #cfeef7;
                    border-bottom: 2px solid rgba(255, 255, 255, 0.03);
                    padding-bottom: 8px;
                    margin-bottom: 12px;
                }

                .table {
                    border: 1px solid rgba(255, 255, 255, 0.04);
                }

                .table thead th {
                    background: linear-gradient(90deg, #06326b, #046d6e);
                    color: #e6f3fb;
                    font-weight: 700;
                    text-align: center;
                    border: 1px solid rgba(255, 255, 255, 0.03);
                }

                .table tbody td {
                    vertical-align: middle;
                    border: 1px solid rgba(255, 255, 255, 0.02);
                    color: #d8f1f8;
                }

                .table tfoot td {
                    font-weight: 700;
                    background: rgba(255, 255, 255, 0.02);
                    border: 1px solid rgba(255, 255, 255, 0.03);
                }

                .footer-info {
                    margin-top: 40px;
                    padding-top: 16px;
                    border-top: 1px solid rgba(255, 255, 255, 0.03);
                    text-align: center;
                    color: rgba(230, 243, 251, 0.7);
                }

                .print-controls {
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    z-index: 1000;
                }

                .btn-print {
                    background: #00bfa6;
                    border-color: #00bfa6;
                    color: #042028;
                }

                .btn-secondary {
                    background: rgba(255, 255, 255, 0.1);
                    border-color: rgba(255, 255, 255, 0.1);
                    color: #e6f3fb;
                }

                .btn-outline-secondary {
                    border-color: rgba(255, 255, 255, 0.15);
                    color: #e6f3fb;
                }
            </style>
        </head>

        <body>
            <!-- Print Controls (visible only on screen) -->
            <div class="print-controls no-print">
                <div class="btn-group-vertical">
                    <button onclick="window.print()" class="btn btn-print text-white mb-2">
                        <i class="fas fa-print"></i> Print
                    </button>
                    <a href="<c:url value='/invoices?action=view&id=${invoice.id}'/>" class="btn btn-secondary mb-2">
                        <i class="fas fa-eye"></i> View
                    </a>
                    <a href="<c:url value='/invoices?action=list'/>" class="btn btn-outline-secondary">
                        <i class="fas fa-list"></i> Back
                    </a>
                </div>
            </div>

            <div class="container">
                <!-- Company Header -->
                <div class="company-header">
                    <h1>Pahana Edu Billing System</h1>
                    <p>Educational Services & Billing Solutions</p>
                    <p>Phone: (555) 123-4567 | Email: info@pahanaedu.com</p>
                    <p>Address: 123 Education Street, Learning City, LC 12345</p>
                </div>

                <!-- Invoice Title -->
                <div class="invoice-title">INVOICE</div>

                <c:if test="${not empty invoice}">
                    <!-- Invoice Details -->
                    <div class="invoice-details">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="row mb-2">
                                    <div class="col-4"><strong>Invoice #:</strong></div>
                                    <div class="col-8"><span class="invoice-number">${invoice.invoiceNumber}</span>
                                    </div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-4"><strong>Invoice Date:</strong></div>
                                    <div class="col-8">${invoice.invoiceDate}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-4"><strong>Due Date:</strong></div>
                                    <div class="col-8">${invoice.dueDate}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-4"><strong>Payment Status:</strong></div>
                                    <div class="col-8">
                                        <strong class="text-info">${invoice.paymentStatus}</strong>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="customer-info">
                                    <h5><i class="fas fa-user"></i> Bill To:</h5>
                                    <div><strong>${invoice.customer.name}</strong></div>
                                    <c:if test="${not empty invoice.customer.email}">
                                        <div>Email: ${invoice.customer.email}</div>
                                    </c:if>
                                    <c:if test="${not empty invoice.customer.phone}">
                                        <div>Phone: ${invoice.customer.phone}</div>
                                    </c:if>
                                    <c:if test="${not empty invoice.customer.address}">
                                        <div>Address: ${invoice.customer.address}</div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Invoice Items Table -->
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th style="width: 40%">Item Description</th>
                                    <th style="width: 12%">Quantity</th>
                                    <th style="width: 16%">Unit Price</th>
                                    <th style="width: 16%">Discount</th>
                                    <th style="width: 16%">Line Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${invoiceItems}">
                                    <tr>
                                        <td>
                                            <strong>${item.item.name}</strong>
                                            <c:if test="${not empty item.item.description}">
                                                <br><small class="text-muted">${item.item.description}</small>
                                            </c:if>
                                        </td>
                                        <td class="text-center">${item.quantity}</td>
                                        <td class="text-end">Rs.
                                            <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00" />
                                        </td>
                                        <td class="text-end">Rs.
                                            <fmt:formatNumber value="${item.discount}" pattern="#,##0.00" />
                                        </td>
                                        <td class="text-end">Rs.
                                            <fmt:formatNumber value="${item.lineTotal}" pattern="#,##0.00" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" class="text-end"><strong>Subtotal:</strong></td>
                                    <td class="text-end"><strong>Rs.
                                            <fmt:formatNumber value="${invoice.subtotal}" pattern="#,##0.00" />
                                        </strong></td>
                                </tr>
                                <c:if test="${invoice.taxAmount > 0}">
                                    <tr>
                                        <td colspan="4" class="text-end"><strong>Tax:</strong></td>
                                        <td class="text-end"><strong>Rs.
                                                <fmt:formatNumber value="${invoice.taxAmount}" pattern="#,##0.00" />
                                            </strong></td>
                                    </tr>
                                </c:if>
                                <c:if test="${invoice.discountAmount > 0}">
                                    <tr>
                                        <td colspan="4" class="text-end"><strong>Total Discount:</strong></td>
                                        <td class="text-end"><strong>-Rs.
                                                <fmt:formatNumber value="${invoice.discountAmount}"
                                                    pattern="#,##0.00" />
                                            </strong></td>
                                    </tr>
                                </c:if>
                                <tr class="total-row">
                                    <td colspan="4" class="text-end"><strong>TOTAL AMOUNT:</strong></td>
                                    <td class="text-end"><strong>Rs.
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
                                <h5><i class="fas fa-sticky-note"></i> Notes:</h5>
                                <div class="border p-3 bg-light rounded">
                                    ${invoice.notes}
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Payment Terms and Footer -->
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <h6><strong>Payment Terms:</strong></h6>
                            <p>${invoice.paymentTerms}</p>
                        </div>
                        <div class="col-md-6 text-end">
                            <h6><strong>Payment Methods:</strong></h6>
                            <p>Cash, Check, Bank Transfer, Credit Card</p>
                        </div>
                    </div>

                    <!-- Footer -->
                    <div class="footer-info">
                        <p><strong>Thank you for your business!</strong></p>
                        <p>For questions about this invoice, please contact us at (555) 123-4567</p>
                        <p><small>Generated on:
                                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd HH:mm:ss" />
                            </small></p>
                    </div>
                </c:if>

                <c:if test="${empty invoice}">
                    <div class="alert alert-warning text-center">
                        <h4><i class="fas fa-exclamation-triangle"></i> Invoice not found</h4>
                        <p>The requested invoice could not be found or loaded.</p>
                        <a href="<c:url value='/invoices?action=list'/>" class="btn btn-primary">
                            <i class="fas fa-list"></i> Back to Invoice List
                        </a>
                    </div>
                </c:if>
            </div>

            <script>
                // Auto-focus on print when page loads (optional)
                window.addEventListener('load', function () {
                    // Uncomment the line below if you want the print dialog to open automatically
                    // window.print();
                });

                // Keyboard shortcut for printing
                document.addEventListener('keydown', function (e) {
                    if (e.ctrlKey && e.key === 'p') {
                        e.preventDefault();
                        window.print();
                    }
                });
            </script>
        </body>

        </html>