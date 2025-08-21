package com.pahanaedu.controller;

import com.pahanaedu.service.CustomerService;
import com.pahanaedu.service.InvoiceService;
import com.pahanaedu.service.ItemService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import com.pahanaedu.model.Invoice;

/**
 * Dashboard servlet showing key business statistics
 */
@WebServlet(name = "dashboardServlet", value = "/dashboard")
public class DashboardServlet extends HttpServlet {

        private CustomerService customerService;
        private InvoiceService invoiceService;
        private ItemService itemService;

        @Override
        public void init() throws ServletException {
                customerService = new CustomerService();
                invoiceService = new InvoiceService();
                itemService = new ItemService();
        }

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {

                try {
                        // Calculate dashboard statistics
                        int totalCustomers = customerService.findAll().size();
                        List<com.pahanaedu.model.Invoice> allInvoices = invoiceService.findAll();
                        int totalInvoices = allInvoices.size();
                        int totalItems = itemService.findAllActive().size();

                        // Use DAO aggregation for revenue to avoid loading and summing in memory
                        BigDecimal totalRevenue = invoiceService.getTotalRevenue();

                        // Calculate pending and paid invoices counts from in-memory list
                        long pendingInvoices = allInvoices.stream()
                                        .filter(invoice -> "PENDING".equals(invoice.getPaymentStatus().toString()))
                                        .count();

                        long paidInvoices = allInvoices.stream()
                                        .filter(invoice -> "PAID".equals(invoice.getPaymentStatus().toString()))
                                        .count();

                        // Calculate monthly revenue (current month) using DAO to leverage DB
                        // aggregation
                        LocalDate now = LocalDate.now();
                        BigDecimal monthlyRevenue = invoiceService.getMonthlyRevenue(now.getYear(),
                                        now.getMonthValue());

                        // Get recent invoices (last 5)
                        List<Invoice> recentInvoices = allInvoices.stream()
                                        .sorted((a, b) -> b.getCreatedAt().compareTo(a.getCreatedAt()))
                                        .limit(5)
                                        .collect(java.util.stream.Collectors.toList());

                        // Set attributes for JSP
                        request.setAttribute("totalCustomers", totalCustomers);
                        request.setAttribute("totalInvoices", totalInvoices);
                        request.setAttribute("totalItems", totalItems);
                        request.setAttribute("totalRevenue", totalRevenue);
                        request.setAttribute("pendingInvoices", pendingInvoices);
                        request.setAttribute("paidInvoices", paidInvoices);
                        request.setAttribute("monthlyRevenue", monthlyRevenue);
                        request.setAttribute("recentInvoices", recentInvoices);

                        // Forward to dashboard JSP
                        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);

                } catch (Exception e) {
                        request.setAttribute("errorMessage", "Error loading dashboard: " + e.getMessage());
                        request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                }
        }
}
