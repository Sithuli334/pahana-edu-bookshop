package com.pahanaedu.controller;

import com.pahanaedu.model.*;
import com.pahanaedu.service.InvoiceService;
import com.pahanaedu.service.CustomerService;
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
import java.util.Optional;

/**
 * Servlet for Invoice Management with Core Business Logic
 * Includes the critical addItem functionality with invoice recalculation
 */
@WebServlet(name = "invoiceServlet", value = "/invoices")
public class InvoiceServlet extends HttpServlet {

    private InvoiceService invoiceService;
    private CustomerService customerService;
    private ItemService itemService;

    @Override
    public void init() {
        invoiceService = new InvoiceService();
        customerService = new CustomerService();
        itemService = new ItemService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listInvoices(request, response);
                break;
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "view":
                viewInvoice(request, response);
                break;
            case "print":
                printInvoice(request, response);
                break;
            default:
                listInvoices(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "save";
        }

        switch (action) {
            case "save":
                saveInvoice(request, response);
                break;
            case "update":
                updateInvoice(request, response);
                break;
            case "addItem":
                addItemToInvoice(request, response);
                break;
            case "removeItem":
                removeItemFromInvoice(request, response);
                break;
            case "updateStatus":
                updatePaymentStatus(request, response);
                break;
            case "delete":
                deleteInvoice(request, response);
                break;
            default:
                listInvoices(request, response);
                break;
        }
    }

    /**
     * CRITICAL BUSINESS LOGIC: Add item to invoice
     * This flow creates a new InvoiceItem, saves it via service/DAO,
     * calls invoiceService.recalculateInvoiceTotals(), and redirects
     * to prevent duplicate form submissions
     */
    private void addItemToInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Parse request parameters
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            BigDecimal quantity = new BigDecimal(request.getParameter("quantity"));

            // Parse discount (optional)
            BigDecimal discount = BigDecimal.ZERO;
            String discountStr = request.getParameter("discount");
            if (discountStr != null && !discountStr.trim().isEmpty()) {
                discount = new BigDecimal(discountStr);
            }

            // 1. Create and save new InvoiceItem via service/DAO
            invoiceService.addItemToInvoice(invoiceId, itemId, quantity, discount);

            // 2. The service automatically calls recalculateInvoiceTotals()
            // 3. Use sendRedirect() to prevent duplicate form submissions
            response.sendRedirect(request.getContextPath() + "/invoices?action=edit&id=" + invoiceId);

        } catch (Exception e) {
            // If error occurs, redirect back to edit page with error
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            response.sendRedirect(
                    request.getContextPath() + "/invoices?action=edit&id=" + invoiceId + "&error=" + e.getMessage());
        }
    }

    /**
     * List all invoices
     */
    private void listInvoices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            System.out.println("DEBUG: Starting listInvoices method");

            // Test database connection first
            try {
                boolean connectionTest = com.pahanaedu.util.DatabaseConnection.testConnection();
                System.out.println("DEBUG: Database connection test: " + connectionTest);
                if (!connectionTest) {
                    throw new RuntimeException("Database connection failed");
                }
            } catch (Exception dbE) {
                System.err.println("DEBUG: Database connection error: " + dbE.getMessage());
                throw new RuntimeException("Database connection failed: " + dbE.getMessage(), dbE);
            }

            List<Invoice> invoices = invoiceService.findAll();
            System.out.println("DEBUG: Found " + (invoices != null ? invoices.size() : "null") + " invoices");
            request.setAttribute("invoices", invoices);
            request.getRequestDispatcher("/WEB-INF/views/invoices/list.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("ERROR in listInvoices: " + e.getMessage());
            e.printStackTrace();

            // Create a detailed error message
            String detailedError = "Error loading invoices: " + e.getMessage();
            if (e.getCause() != null) {
                detailedError += " (Caused by: " + e.getCause().getMessage() + ")";
            }

            request.setAttribute("errorMessage", detailedError);
            request.setAttribute("errorDetails", e.toString());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    /**
     * Show new invoice form
     */
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Customer> customers = customerService.findAll();
            request.setAttribute("customers", customers);
            request.setAttribute("invoice", new Invoice());
            request.setAttribute("isEdit", false);
            request.getRequestDispatcher("/WEB-INF/views/invoices/form.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading form: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    /**
     * Show edit invoice form with items
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Optional<Invoice> invoiceOptional = invoiceService.findByIdWithItems(id);

            if (invoiceOptional.isPresent()) {
                Invoice invoice = invoiceOptional.get();
                List<InvoiceItem> invoiceItems = invoiceService.getInvoiceItems(id);
                List<Customer> customers = customerService.findAll();
                List<Item> items = itemService.findAllActive();

                request.setAttribute("invoice", invoice);
                request.setAttribute("invoiceItems", invoiceItems);
                request.setAttribute("customers", customers);
                request.setAttribute("items", items);
                request.setAttribute("isEdit", true);

                // Check for error message from redirect
                String error = request.getParameter("error");
                if (error != null) {
                    request.setAttribute("errorMessage", error);
                }

                request.getRequestDispatcher("/WEB-INF/views/invoices/edit.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Invoice not found");
                listInvoices(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid invoice ID");
            listInvoices(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading invoice: " + e.getMessage());
            listInvoices(request, response);
        }
    }

    /**
     * View invoice details
     */
    private void viewInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Optional<Invoice> invoiceOptional = invoiceService.findByIdWithItems(id);

            if (invoiceOptional.isPresent()) {
                Invoice invoice = invoiceOptional.get();
                List<InvoiceItem> invoiceItems = invoiceService.getInvoiceItems(id);

                request.setAttribute("invoice", invoice);
                request.setAttribute("invoiceItems", invoiceItems);
                request.getRequestDispatcher("/WEB-INF/views/invoices/view.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Invoice not found");
                listInvoices(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid invoice ID");
            listInvoices(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading invoice: " + e.getMessage());
            listInvoices(request, response);
        }
    }

    /**
     * Save new invoice
     */
    private void saveInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            LocalDate invoiceDate = LocalDate.parse(request.getParameter("invoiceDate"));
            LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));

            Invoice invoice = invoiceService.createInvoice(customerId, invoiceDate, dueDate);

            response.sendRedirect(request.getContextPath() + "/invoices?action=edit&id=" + invoice.getId());
        } catch (Exception e) {
            List<Customer> customers = customerService.findAll();
            request.setAttribute("customers", customers);
            request.setAttribute("invoice", new Invoice());
            request.setAttribute("isEdit", false);
            request.setAttribute("errorMessage", "Error creating invoice: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/invoices/form.jsp").forward(request, response);
        }
    }

    /**
     * Update existing invoice
     */
    private void updateInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            LocalDate invoiceDate = LocalDate.parse(request.getParameter("invoiceDate"));
            LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
            String paymentTerms = request.getParameter("paymentTerms");
            String paymentStatus = request.getParameter("paymentStatus");
            String notes = request.getParameter("notes");

            // Get the existing invoice
            Optional<Invoice> invoiceOptional = invoiceService.findByIdWithItems(invoiceId);
            if (invoiceOptional.isEmpty()) {
                throw new RuntimeException("Invoice not found");
            }

            Invoice invoice = invoiceOptional.get();
            invoice.setInvoiceDate(invoiceDate);
            invoice.setDueDate(dueDate);
            invoice.setPaymentTerms(paymentTerms);
            invoice.setPaymentStatus(Invoice.PaymentStatus.valueOf(paymentStatus));
            invoice.setNotes(notes);

            // Update the invoice using the service
            invoiceService.updateInvoice(invoice);

            response.sendRedirect(
                    request.getContextPath() + "/invoices?action=edit&id=" + invoiceId + "&success=updated");
        } catch (Exception e) {
            try {
                request.setAttribute("errorMessage", "Error updating invoice: " + e.getMessage());
                showEditForm(request, response);
            } catch (Exception ex) {
                request.setAttribute("errorMessage", "Error updating invoice: " + e.getMessage());
                listInvoices(request, response);
            }
        }
    }

    /**
     * Remove item from invoice
     */
    private void removeItemFromInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int invoiceItemId = Integer.parseInt(request.getParameter("invoiceItemId"));
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));

            invoiceService.removeItemFromInvoice(invoiceItemId);

            response.sendRedirect(request.getContextPath() + "/invoices?action=edit&id=" + invoiceId);
        } catch (Exception e) {
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            response.sendRedirect(
                    request.getContextPath() + "/invoices?action=edit&id=" + invoiceId + "&error=" + e.getMessage());
        }
    }

    /**
     * Update payment status
     */
    private void updatePaymentStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            Invoice.PaymentStatus status = Invoice.PaymentStatus.valueOf(request.getParameter("paymentStatus"));

            invoiceService.updatePaymentStatus(invoiceId, status);

            response.sendRedirect(request.getContextPath() + "/invoices?action=view&id=" + invoiceId);
        } catch (Exception e) {
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            response.sendRedirect(
                    request.getContextPath() + "/invoices?action=view&id=" + invoiceId + "&error=" + e.getMessage());
        }
    }

    /**
     * Display printable version of invoice
     */
    private void printInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Optional<Invoice> invoiceOptional = invoiceService.findByIdWithItems(id);

            if (invoiceOptional.isPresent()) {
                Invoice invoice = invoiceOptional.get();
                List<InvoiceItem> invoiceItems = invoiceService.getInvoiceItems(id);

                request.setAttribute("invoice", invoice);
                request.setAttribute("invoiceItems", invoiceItems);
                request.getRequestDispatcher("/WEB-INF/views/invoices/print.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Invoice not found");
                listInvoices(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid invoice ID");
            listInvoices(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading invoice for printing: " + e.getMessage());
            listInvoices(request, response);
        }
    }

    /**
     * Delete invoice
     */
    private void deleteInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            invoiceService.deleteInvoice(id);

            response.sendRedirect(request.getContextPath() + "/invoices?action=list");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error deleting invoice: " + e.getMessage());
            listInvoices(request, response);
        }
    }
}
