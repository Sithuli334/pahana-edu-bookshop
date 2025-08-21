<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
    <%@ page session="true" %>
        <%@ page isELIgnored="false" %>
            <%@ taglib prefix="c" uri="jakarta.tags.core" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Error - Pahana Edu Billing System</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <style>
                        body {
                            background-color: #f8f9fa;
                            padding-top: 40px;
                        }

                        .error-container {
                            max-width: 600px;
                            margin: 0 auto;
                            background: white;
                            padding: 30px;
                            border-radius: 10px;
                            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                            text-align: center;
                        }

                        .error-code {
                            font-size: 72px;
                            font-weight: bold;
                            color: #dc3545;
                        }
                    </style>
                </head>

                <body>
                    <div class="container">
                        <div class="error-container">
                            <div class="error-code">
                                ${pageContext.errorData.statusCode}
                            </div>
                            <h1 class="mt-4">Oops! Something went wrong</h1>
                            <p class="lead mb-4">
                                We're sorry, but an error occurred while processing your request.
                            </p>

                            <!-- Display detailed error information -->
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger text-start">
                                    <h5>Error Details:</h5>
                                    <p><strong>Message:</strong> ${errorMessage}</p>
                                    <c:if test="${not empty errorDetails}">
                                        <p><strong>Details:</strong> ${errorDetails}</p>
                                    </c:if>
                                </div>
                            </c:if>

                            <div class="d-grid gap-2 col-6 mx-auto">
                                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Return to Home</a>
                            </div>
                        </div>
                    </div>

                    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>