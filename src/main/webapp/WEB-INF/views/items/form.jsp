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
                        <c:when test="${isEdit}">Edit Item</c:when>
                        <c:otherwise>New Item</c:otherwise>
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
                            <h1 class="h5 mb-0"><i class="fas fa-box me-1"></i>
                                <c:choose>
                                    <c:when test="${isEdit}">Edit Item</c:when>
                                    <c:otherwise>New Item</c:otherwise>
                                </c:choose>
                            </h1>
                            <p class="small text-muted mb-0">Provide item details and save.</p>
                        </div>
                        <div>
                            <a href="<c:url value='/items?action=list'/>" class="btn btn-secondary btn-sm"><i
                                    class="fas fa-arrow-left me-1"></i> Back to Items</a>
                        </div>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">${errorMessage}</div>
                    </c:if>

                    <div class="card card-modern">
                        <div class="card-body">
                            <form method="post" action="<c:url value='/items'/>">
                                <input type="hidden" name="action"
                                    value="<c:choose><c:when test='${isEdit}'>update</c:when><c:otherwise>save</c:otherwise></c:choose>">
                                <c:if test="${isEdit}">
                                    <input type="hidden" name="itemId" value="${item.id}">
                                </c:if>

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="name" class="form-label">Item Name <span
                                                class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="name" name="name"
                                            value="${item.name}" required maxlength="255">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="code" class="form-label">Item Code <span
                                                class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="code" name="code"
                                            value="${item.code}" required maxlength="100">
                                        <div class="form-text">Unique identifier for the item</div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="price" class="form-label">Price <span
                                                class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <span class="input-group-text">Rs.</span>
                                            <input type="number" step="0.01" class="form-control" id="price"
                                                name="price" value="${item.price}" required min="0">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="unit" class="form-label">Unit</label>
                                        <select class="form-select" id="unit" name="unit">
                                            <option value="UNIT" <c:if test="${item.unit == 'UNIT' or empty item.unit}">
                                                selected</c:if>>Unit</option>
                                            <option value="PIECE" <c:if test="${item.unit == 'PIECE'}">selected</c:if>
                                                >Piece</option>
                                            <option value="BOX" <c:if test="${item.unit == 'BOX'}">selected</c:if>>Box
                                            </option>
                                            <option value="KG" <c:if test="${item.unit == 'KG'}">selected</c:if>
                                                >Kilogram</option>
                                            <option value="METER" <c:if test="${item.unit == 'METER'}">selected</c:if>
                                                >Meter</option>
                                            <option value="HOUR" <c:if test="${item.unit == 'HOUR'}">selected</c:if>
                                                >Hour</option>
                                            <option value="SERVICE" <c:if test="${item.unit == 'SERVICE'}">selected
                                                </c:if>>Service</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="stockQuantity" class="form-label">Stock Quantity</label>
                                        <input type="number" class="form-control" id="stockQuantity"
                                            name="stockQuantity" value="${item.stockQuantity}" min="0">
                                        <div class="form-text">Current inventory count</div>
                                    </div>
                                    <div class="col-md-6">
                                        <c:if test="${isEdit}">
                                            <label class="form-label">Status</label>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="active"
                                                    name="active" <c:if test="${item.active}">checked
                                        </c:if>>
                                        <label class="form-check-label" for="active">Active (available for use in
                                            invoices)</label>
                                    </div>
                                    </c:if>
                                </div>
                                <div class="col-12">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea class="form-control" id="description" name="description" rows="3"
                                        placeholder="Detailed description of the item">${item.description}</textarea>
                                </div>
                        </div>

                        <div class="d-flex justify-content-between mt-3">
                            <a href="<c:url value='/items?action=list'/>" class="btn btn-secondary"><i
                                    class="fas fa-times me-1"></i> Cancel</a>
                            <button type="submit" class="btn btn-primary"><i class="fas fa-save me-1"></i>
                                <c:choose>
                                    <c:when test="${isEdit}">Update Item</c:when>
                                    <c:otherwise>Create Item</c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                        </form>
                    </div>
                </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    <!-- Auto-generate item code when creating a new item -->
                    <c:if test="${not isEdit}">
                    //
                        <![CDATA[
                        (function(){
                            var nameField = document.getElementById('name');
                        var codeField = document.getElementById('code');
                        if (nameField && codeField) {
                            nameField.addEventListener('input', function () {
                                var name = this.value || '';
                                if (name && !codeField.value) {
                                    var prefix = name.replace(/[^a-zA-Z]/g, '').substring(0, 3).toUpperCase();
                                    var suffix = Math.floor(Math.random() * 1000).toString().padStart(3, '0');
                                    codeField.value = prefix + suffix;
                                }
                            });
                            }
                        })();
                    // ]]>
                    </c:if>
                </script>
            </body>

            </html>