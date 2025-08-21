package com.pahanaedu.controller;

import com.pahanaedu.model.Customer;
import com.pahanaedu.service.CustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

/**
 * Complete CRUD Servlet for Customer Management
 * Demonstrates the action parameter pattern with switch statement
 */
@WebServlet(name = "customerServlet", value = "/customers")
public class CustomerServlet extends HttpServlet {

    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
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
                listCustomers(request, response);
                break;
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "view":
                viewCustomer(request, response);
                break;
            case "search":
                searchCustomers(request, response);
                break;
            default:
                listCustomers(request, response);
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
                saveCustomer(request, response);
                break;
            case "update":
                updateCustomer(request, response);
                break;
            case "delete":
                deleteCustomer(request, response);
                break;
            default:
                listCustomers(request, response);
                break;
        }
    }

    /**
     * List all customers
     */
    private void listCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Customer> customers = customerService.findAll();
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("/WEB-INF/views/customers/list.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading customers: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    /**
     * Show new customer form
     */
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("customer", new Customer());
        request.setAttribute("isEdit", false);
        request.getRequestDispatcher("/WEB-INF/views/customers/form.jsp").forward(request, response);
    }

    /**
     * Show edit customer form
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Optional<Customer> customerOptional = customerService.findById(id);

            if (customerOptional.isPresent()) {
                request.setAttribute("customer", customerOptional.get());
                request.setAttribute("isEdit", true);
                request.getRequestDispatcher("/WEB-INF/views/customers/form.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Customer not found");
                listCustomers(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid customer ID");
            listCustomers(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading customer: " + e.getMessage());
            listCustomers(request, response);
        }
    }

    /**
     * View customer details
     */
    private void viewCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Optional<Customer> customerOptional = customerService.findById(id);

            if (customerOptional.isPresent()) {
                request.setAttribute("customer", customerOptional.get());
                request.getRequestDispatcher("/WEB-INF/views/customers/view.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Customer not found");
                listCustomers(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid customer ID");
            listCustomers(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading customer: " + e.getMessage());
            listCustomers(request, response);
        }
    }

    /**
     * Search customers by name
     */
    private void searchCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchTerm = request.getParameter("searchTerm");
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            listCustomers(request, response);
            return;
        }

        try {
            List<Customer> customers = customerService.searchByName(searchTerm.trim());
            request.setAttribute("customers", customers);
            request.setAttribute("searchTerm", searchTerm);
            request.getRequestDispatcher("/WEB-INF/views/customers/list.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error searching customers: " + e.getMessage());
            listCustomers(request, response);
        }
    }

    /**
     * Save new customer
     */
    private void saveCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Customer customer = buildCustomerFromRequest(request);
            customerService.createCustomer(customer);

            request.setAttribute("successMessage", "Customer created successfully");
            response.sendRedirect(request.getContextPath() + "/customers?action=list");
        } catch (Exception e) {
            Customer customer = buildCustomerFromRequest(request);
            request.setAttribute("customer", customer);
            request.setAttribute("isEdit", false);
            request.setAttribute("errorMessage", "Error creating customer: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/customers/form.jsp").forward(request, response);
        }
    }

    /**
     * Update existing customer
     */
    private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Customer customer = buildCustomerFromRequest(request);
            int id = Integer.parseInt(request.getParameter("id"));
            customer.setId(id);

            customerService.updateCustomer(customer);

            response.sendRedirect(request.getContextPath() + "/customers?action=list");
        } catch (Exception e) {
            Customer customer = buildCustomerFromRequest(request);
            request.setAttribute("customer", customer);
            request.setAttribute("isEdit", true);
            request.setAttribute("errorMessage", "Error updating customer: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/customers/form.jsp").forward(request, response);
        }
    }

    /**
     * Delete customer
     */
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            customerService.deleteCustomer(id);

            response.sendRedirect(request.getContextPath() + "/customers?action=list");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error deleting customer: " + e.getMessage());
            listCustomers(request, response);
        }
    }

    /**
     * Build Customer object from request parameters
     */
    private Customer buildCustomerFromRequest(HttpServletRequest request) {
        Customer customer = new Customer();
        customer.setName(request.getParameter("name"));
        customer.setEmail(request.getParameter("email"));
        customer.setPhone(request.getParameter("phone"));
        customer.setAddress(request.getParameter("address"));
        customer.setNotes(request.getParameter("notes"));
        customer.setAccountNumber(request.getParameter("accountNumber"));
        customer.setTelephoneNumber(request.getParameter("telephoneNumber"));

        // Handle customer type
        String customerType = request.getParameter("customerType");
        if (customerType != null && !customerType.trim().isEmpty()) {
            customer.setCustomerType(Customer.CustomerType.valueOf(customerType));
        } else {
            customer.setCustomerType(Customer.CustomerType.RESIDENTIAL);
        }

        // Handle units consumed
        String unitsConsumed = request.getParameter("unitsConsumed");
        if (unitsConsumed != null && !unitsConsumed.trim().isEmpty()) {
            try {
                customer.setUnitsConsumed(new BigDecimal(unitsConsumed));
            } catch (NumberFormatException e) {
                customer.setUnitsConsumed(BigDecimal.ZERO);
            }
        } else {
            customer.setUnitsConsumed(BigDecimal.ZERO);
        }

        return customer;
    }
}
