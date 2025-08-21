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
                /* Layout: center and constrain printable card for better visual balance */
                @media screen {
                    .container {
                        max-width: 880px;
                        margin: 28px auto;
                        padding: 36px;
                        background: rgba(255, 255, 255, 0.02);
                        box-shadow: 0 8px 30px rgba(2, 6, 23, 0.6);
                        border-radius: 10px;
                    }
                }

                body {
                    font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Arial;
                    font-size: 14px;
                    line-height: 1.45;
                    color: #e6f3fb;
                    background: linear-gradient(135deg, #071428 0%, #072f4f 60%);
                }

                /* Company header */
                .company-header {
                    text-align: center;
                    margin-bottom: 20px;
                    padding-bottom: 16px;
                    border-bottom: 2px solid rgba(255, 255, 255, 0.04);
                }

                .company-header h1 {
                    color: #00bfa6;
                    font-size: 2rem;
                    font-weight: 700;
                    margin-bottom: 6px;
                }

                .company-header p {
                    color: rgba(230, 243, 251, 0.82);
                    margin: 0;
                    font-size: 0.95rem;
                }

                /* Invoice title */
                .invoice-title {
                    font-size: 1.6rem;
                    font-weight: 700;
                    color: #ffd166;
                    text-align: center;
                    margin: 18px 0;
                    letter-spacing: 1px;
                }

                /* Customer information box */
                .customer-info {
                    background: rgba(255, 255, 255, 0.02);
                    padding: 14px;
                    border-radius: 8px;
                    margin-bottom: 18px;
                }

                .customer-info h5 {
                    color: #cfeef7;
                    margin-bottom: 8px;
                    font-weight: 600;
                }

                /* Notes box (dark friendly) */
                .notes-box {
                    background: rgba(255, 255, 255, 0.03);
                    color: #d8f1f8;
                    border-radius: 6px;
                    padding: 12px;
                    border: 1px solid rgba(255, 255, 255, 0.03);
                }

                /* Main table: solid single-color header, increased padding */
                .table {
                    border: 1px solid rgba(255, 255, 255, 0.04);
                    background: transparent;
                    color: #e6f3fb;
                }

                .table thead th {
                    background-color: #06326b !important;
                    /* single header color */
                    color: #ffffff !important;
                    font-weight: 700;
                    text-align: center;
                    padding: 10px 12px;
                    border: 0;
                }

                .table tbody td {
                    color: #d8f1f8;
                    padding: 12px;
                    vertical-align: middle;
                    border-top: 1px solid rgba(255, 255, 255, 0.02);
                }

                .table tbody td.text-end {
                    text-align: right;
                }

                /* Totals / footer styling to stand out */
                .table tfoot td {
                    font-weight: 700;
                    background: rgba(0, 0, 0, 0.08);
                    color: #ffffff;
                    padding: 10px 12px;
                    border-top: 1px solid rgba(255, 255, 255, 0.03);
                }

                .table tfoot tr.total-row td {
                    background: rgba(6, 50, 107, 0.9);
                    color: #ffd;
                    /* soft highlight for the grand total */
                }

                /* Make small numeric columns centered or right aligned for readability */
                .table td.text-center {
                    text-align: center;
                }

                .table td.text-right,
                .table td.text-end {
                    text-align: right;
                }

                /* Print controls (screen only) — smaller, non-intrusive */
                .print-controls.no-print {
                    position: fixed;
                    top: 20px;
                    right: 18px;
                    z-index: 1200;
                }

                .print-controls .btn {
                    min-width: 110px;
                    margin-bottom: 8px;
                }

                @media (max-width: 900px) {
                    .print-controls.no-print {
                        position: static;
                        display: flex;
                        gap: 8px;
                        justify-content: center;
                        margin-bottom: 12px;
                    }

                    .container {
                        margin: 16px;
                        padding: 18px;
                    }
                }

                /* Buttons */
                .btn-print {
                    background: #00bfa6;
                    border-color: #00bfa6;
                    color: #042028;
                }

                .btn-secondary {
                    background: rgba(255, 255, 255, 0.06);
                    border-color: rgba(255, 255, 255, 0.06);
                    color: #e6f3fb;
                }

                .btn-outline-secondary {
                    border-color: rgba(255, 255, 255, 0.12);
                    color: #e6f3fb;
                }

                /* Footer info */
                .footer-info {
                    margin-top: 28px;
                    padding-top: 12px;
                    border-top: 1px solid rgba(255, 255, 255, 0.03);
                    text-align: center;
                    color: rgba(230, 243, 251, 0.72);
                    font-size: 0.95rem;
                }

                /* Print-specific overrides: force light theme and readable print output */
                @media print {
                    body {
                        color: #000;
                        background: #fff !important;
                    }

                    .container {
                        box-shadow: none !important;
                        background: #fff !important;
                        padding: 0 !important;
                        max-width: none !important;
                        margin: 0 !important;
                    }

                    .print-controls {
                        display: none !important;
                    }

                    .company-header h1 {
                        color: #000;
                    }

                    .table thead th {
                        background-color: #f4f4f4 !important;
                        color: #000 !important;
                    }

                    .table tbody td,
                    .table tfoot td {
                        color: #000 !important;
                        background: transparent !important;
                        border-color: #ddd !important;
                    }

                    .notes-box {
                        background: #fff;
                        color: #000;
                        border: 1px solid #eee;
                    }
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
                                <div class="notes-box">
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