package com.pahanaedu.dao;

import com.pahanaedu.model.Invoice;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

/**
 * Data Access Object interface for Invoice entity
 */
public interface InvoiceDAO {

    /**
     * Save a new invoice
     * 
     * @param invoice Invoice to save
     * @return saved invoice with generated ID
     */
    Invoice save(Invoice invoice);

    /**
     * Find invoice by ID
     * 
     * @param id invoice ID
     * @return Optional containing invoice if found
     */
    Optional<Invoice> findById(int id);

    /**
     * Find all invoices
     * 
     * @return list of all invoices
     */
    List<Invoice> findAll();

    /**
     * Find invoices by customer ID
     * 
     * @param customerId customer ID
     * @return list of invoices for the customer
     */
    List<Invoice> findByCustomerId(int customerId);

    /**
     * Update existing invoice
     * 
     * @param invoice invoice to update
     * @return updated invoice
     */
    Invoice update(Invoice invoice);

    /**
     * Delete invoice by ID
     * 
     * @param id invoice ID to delete
     */
    void deleteById(int id);

    /**
     * Find invoice by invoice number
     * 
     * @param invoiceNumber invoice number
     * @return Optional containing invoice if found
     */
    Optional<Invoice> findByInvoiceNumber(String invoiceNumber);

    /**
     * Generate next invoice number
     * 
     * @return next available invoice number
     */
    String generateNextInvoiceNumber();

    /**
     * Sum totalAmount for all invoices. Returns BigDecimal.ZERO when no invoices.
     * 
     * @return sum of totalAmount for all invoices
     */
    BigDecimal sumTotalAmount();

    /**
     * Sum totalAmount for invoices matching given month and year. Month is 1-12.
     * 
     * @param year  calendar year
     * @param month calendar month (1-12)
     * @return sum of totalAmount for the specified month/year
     */
    BigDecimal sumTotalAmountForMonthYear(int year, int month);
}
