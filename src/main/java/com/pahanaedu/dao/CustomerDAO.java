package com.pahanaedu.dao;

import com.pahanaedu.model.Customer;
import java.util.List;
import java.util.Optional;

/**
 * Data Access Object interface for Customer entity
 */
public interface CustomerDAO {

    /**
     * Save a new customer
     * @param customer Customer to save
     * @return saved customer with generated ID
     */
    Customer save(Customer customer);

    /**
     * Find customer by ID
     * @param id customer ID
     * @return Optional containing customer if found
     */
    Optional<Customer> findById(int id);

    /**
     * Find all customers
     * @return list of all customers
     */
    List<Customer> findAll();

    /**
     * Update existing customer
     * @param customer customer to update
     * @return updated customer
     */
    Customer update(Customer customer);

    /**
     * Delete customer by ID
     * @param id customer ID to delete
     */
    void deleteById(int id);

    /**
     * Find customers by name (partial match)
     * @param name name to search for
     * @return list of matching customers
     */
    List<Customer> findByNameContaining(String name);

    /**
     * Find customer by account number
     * @param accountNumber account number
     * @return Optional containing customer if found
     */
    Optional<Customer> findByAccountNumber(String accountNumber);
}
