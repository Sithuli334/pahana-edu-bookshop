package com.pahanaedu.service;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.CustomerDAOImpl;
import com.pahanaedu.model.Customer;

import java.util.List;
import java.util.Optional;

/**
 * Service class for customer management business logic
 */
public class CustomerService {

    private final CustomerDAO customerDAO;

    public CustomerService() {
        this.customerDAO = new CustomerDAOImpl();
    }

    /**
     * Create a new customer
     * @param customer customer to create
     * @return saved customer
     * @throws RuntimeException if account number already exists
     */
    public Customer createCustomer(Customer customer) {
        // Validate account number uniqueness
        if (customer.getAccountNumber() != null &&
            customerDAO.findByAccountNumber(customer.getAccountNumber()).isPresent()) {
            throw new RuntimeException("Account number already exists");
        }

        // Generate account number if not provided
        if (customer.getAccountNumber() == null || customer.getAccountNumber().trim().isEmpty()) {
            customer.setAccountNumber(generateAccountNumber());
        }

        return customerDAO.save(customer);
    }

    /**
     * Find customer by ID
     * @param id customer ID
     * @return Optional containing customer if found
     */
    public Optional<Customer> findById(int id) {
        return customerDAO.findById(id);
    }

    /**
     * Find all customers
     * @return list of all customers
     */
    public List<Customer> findAll() {
        return customerDAO.findAll();
    }

    /**
     * Update existing customer
     * @param customer customer to update
     * @return updated customer
     * @throws RuntimeException if customer not found or account number conflict
     */
    public Customer updateCustomer(Customer customer) {
        // Verify customer exists
        Optional<Customer> existingCustomer = customerDAO.findById(customer.getId());
        if (existingCustomer.isEmpty()) {
            throw new RuntimeException("Customer not found");
        }

        // Check account number uniqueness (excluding current customer)
        Optional<Customer> customerWithSameAccount = customerDAO.findByAccountNumber(customer.getAccountNumber());
        if (customerWithSameAccount.isPresent() &&
            customerWithSameAccount.get().getId() != customer.getId()) {
            throw new RuntimeException("Account number already exists");
        }

        return customerDAO.update(customer);
    }

    /**
     * Delete customer by ID
     * @param id customer ID to delete
     * @throws RuntimeException if customer not found
     */
    public void deleteCustomer(int id) {
        if (customerDAO.findById(id).isEmpty()) {
            throw new RuntimeException("Customer not found");
        }
        customerDAO.deleteById(id);
    }

    /**
     * Search customers by name
     * @param name name to search for
     * @return list of matching customers
     */
    public List<Customer> searchByName(String name) {
        return customerDAO.findByNameContaining(name);
    }

    /**
     * Find customer by account number
     * @param accountNumber account number
     * @return Optional containing customer if found
     */
    public Optional<Customer> findByAccountNumber(String accountNumber) {
        return customerDAO.findByAccountNumber(accountNumber);
    }

    /**
     * Generate next available account number
     * @return generated account number
     */
    private String generateAccountNumber() {
        List<Customer> customers = customerDAO.findAll();
        int maxNumber = 0;

        for (Customer customer : customers) {
            String accountNumber = customer.getAccountNumber();
            if (accountNumber != null && accountNumber.startsWith("ACC")) {
                try {
                    int number = Integer.parseInt(accountNumber.substring(3));
                    if (number > maxNumber) {
                        maxNumber = number;
                    }
                } catch (NumberFormatException e) {
                    // Ignore invalid format
                }
            }
        }

        return String.format("ACC%03d", maxNumber + 1);
    }
}
