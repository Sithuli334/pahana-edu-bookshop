package com.pahanaedu.dao;

import com.pahanaedu.model.InvoiceItem;
import java.util.List;
import java.util.Optional;

/**
 * Data Access Object interface for InvoiceItem entity
 */
public interface InvoiceItemDAO {

    /**
     * Save a new invoice item
     * @param invoiceItem InvoiceItem to save
     * @return saved invoice item with generated ID
     */
    InvoiceItem save(InvoiceItem invoiceItem);

    /**
     * Find invoice item by ID
     * @param id invoice item ID
     * @return Optional containing invoice item if found
     */
    Optional<InvoiceItem> findById(int id);

    /**
     * Find all invoice items for a specific invoice
     * @param invoiceId invoice ID
     * @return list of invoice items
     */
    List<InvoiceItem> findByInvoiceId(int invoiceId);

    /**
     * Update existing invoice item
     * @param invoiceItem invoice item to update
     * @return updated invoice item
     */
    InvoiceItem update(InvoiceItem invoiceItem);

    /**
     * Delete invoice item by ID
     * @param id invoice item ID to delete
     */
    void deleteById(int id);

    /**
     * Delete all invoice items for a specific invoice
     * @param invoiceId invoice ID
     */
    void deleteByInvoiceId(int invoiceId);
}
