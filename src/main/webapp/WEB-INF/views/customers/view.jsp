<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>View Customer - Pahana Edu Billing</title>
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

                .detail-key {
                    color: rgba(230, 243, 251, 0.8);
                    font-weight: 600
                }

                /* Tables: match invoices/dashboard dark table styles */
                .table {
                    color: #e6f3fb;
                    background-color: transparent !important;
                    border-color: rgba(255, 255, 255, 0.05);
                }

                .table thead,
                .table thead th {
                    background-color: #06326b !important;
                    color: #e6f3fb !important;
                    border-bottom: none !important;
                }

                .table tbody td {
                    background-color: transparent !important;
                    color: #d8f1f8;
                    border-color: rgba(255, 255, 255, 0.05);
                }

                .table-hover tbody tr:hover {
                    background-color: rgba(255, 255, 255, 0.03) !important;
                    color: #ffffff;
                }

                /* Form controls consistent with other pages */
                .form-control,
                .form-select {
                    background: rgba(255, 255, 255, 0.03);
                    color: #e6f3fb;
                    border: 1px solid rgba(255, 255, 255, 0.06);
                }

                .form-control::placeholder {
                    color: rgba(230, 243, 251, 0.5);
                }

                .form-control:focus,
                .form-select:focus {
                    background: rgba(255, 255, 255, 0.05);
                    color: #fff;
                    border-color: rgba(0, 191, 166, 0.4);
                    box-shadow: 0 0 0 0.25rem rgba(0, 191, 166, 0.12);
                }

                /* Buttons */
                .btn-primary {
                    background: #00bfa6;
                    border-color: #00bfa6;
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
                    <a class="navbar-brand d-flex align-items-center" href="<c:url value='/dashboard'/>">
                        <span class="me-2"><i class="fas fa-users text-primary"></i></span>
                        <span>Customers</span>
                    </a>
                    <div class="d-flex ms-auto align-items-center">
                        <div class="me-3 text-muted small">Welcome, <strong>${sessionScope.userName}</strong></div>
                        <a class="btn btn-outline-secondary btn-sm" href="<c:url value='/logout'/>">Logout</a>
                    </div>
                </div>
            </nav>

            <div class="container-fluid px-4 mt-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <h1 class="h5 mb-0">Customer Details</h1>
                        <p class="small text-muted mb-0">Read-only view of customer information.</p>
                    </div>
                    <div>
                        <a href="<c:url value='/customers?action=list'/>" class="btn btn-secondary btn-sm"><i
                                class="fas fa-arrow-left me-1"></i> Back to List</a>
                    </div>
                </div>

                <div class="card card-modern">
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="mb-2 detail-key">Customer Name</div>
                                <div>${customer.name}</div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-2 detail-key">Email</div>
                                <div>${customer.email}</div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-2 detail-key">Phone</div>
                                <div>${customer.phone}</div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-2 detail-key">Telephone Number</div>
                                <div>${customer.telephoneNumber}</div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-2 detail-key">Account Number</div>
                                <div>${customer.accountNumber}</div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-2 detail-key">Customer Type</div>
                                <div>${customer.customerType}</div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-2 detail-key">Units Consumed</div>
                                <div>${customer.unitsConsumed}</div>
                            </div>
                            <div class="col-12">
                                <div class="mb-2 detail-key">Address</div>
                                <div>${customer.address}</div>
                            </div>
                            <div class="col-12">
                                <div class="mb-2 detail-key">Notes</div>
                                <div>${customer.notes}</div>
                            </div>
                        </div>

                        <div class="mt-4 d-flex gap-2">
                            <a href="<c:url value='/customers'/>?action=edit&id=${customer.id}"
                                class="btn btn-primary btn-sm"><i class="fas fa-edit me-1"></i> Edit</a>
                            <a href="<c:url value='/customers?action=list'/>" class="btn btn-secondary btn-sm">Close</a>
                        </div>
                    </div>
                </div>
            </div>

            <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
        </body>

        </html>