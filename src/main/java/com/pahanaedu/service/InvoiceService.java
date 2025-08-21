package com.pahanaedu.service;

import com.pahanaedu.dao.*;
import com.pahanaedu.model.*;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 * Service class for invoice management and business logic
 * Contains the core invoice calculation functionality
 */
public class InvoiceService {

    private final InvoiceDAO invoiceDAO;
    private final InvoiceItemDAO invoiceItemDAO;
    private final CustomerDAO customerDAO;
    private final ItemDAO itemDAO;

    // Tax rate: 15%
    private static final BigDecimal TAX_RATE = new BigDecimal("0.15");

    public InvoiceService() {
        this.invoiceDAO = new InvoiceDAOImpl();
        this.invoiceItemDAO = new InvoiceItemDAOImpl();
        this.customerDAO = new CustomerDAOImpl();
        this.itemDAO = new ItemDAOImpl();
    }

    /**
     * Create a new invoice
     * 
     * @param customerId  customer ID
     * @param invoiceDate invoice date
     * @param dueDate     due date
     * @return created invoice
     */
    public Invoice createInvoice(int customerId, LocalDate invoiceDate, LocalDate dueDate) {
        // Verify customer exists
        Optional<Customer> customer = customerDAO.findById(customerId);
        if (customer.isEmpty()) {
            throw new RuntimeException("Customer not found");
        }

        // Generate invoice number
        String invoiceNumber = invoiceDAO.generateNextInvoiceNumber();

        // Create invoice
        Invoice invoice = new Invoice(invoiceNumber, customerId, invoiceDate, dueDate);
        invoice.setCustomer(customer.get());

        return invoiceDAO.save(invoice);
    }

    /**
     * Add item to invoice
     * 
     * @param invoiceId invoice ID
     * @param itemId    item ID
     * @param quantity  quantity
     * @param discount  discount amount
     * @return created invoice item
     */
    public InvoiceItem addItemToInvoice(int invoiceId, int itemId, BigDecimal quantity, BigDecimal discount) {
        // Verify invoice exists
        Optional<Invoice> invoice = invoiceDAO.findById(invoiceId);
        if (invoice.isEmpty()) {
            throw new RuntimeException("Invoice not found");
        }

        // Verify item exists
        Optional<Item> item = itemDAO.findById(itemId);
        if (item.isEmpty()) {
            throw new RuntimeException("Item not found");
        }

        // Create invoice item
        InvoiceItem invoiceItem = new InvoiceItem();
        invoiceItem.setInvoiceId(invoiceId);
        invoiceItem.setItemId(itemId);
        invoiceItem.setQuantity(quantity);
        invoiceItem.setUnitPrice(item.get().getPrice());
        invoiceItem.setDiscount(discount != null ? discount : BigDecimal.ZERO);
        invoiceItem.setDescription(item.get().getDescription());

        // Calculate line total
        invoiceItem.calculateLineTotal();

        // Save invoice item
        InvoiceItem savedItem = invoiceItemDAO.save(invoiceItem);

        // Recalculate invoice totals
        recalculateInvoiceTotals(invoiceId);

        return savedItem;
    }

    /**
     * CORE BUSINESS LOGIC: Recalculate invoice totals
     * This method fetches the invoice and its items, calculates subtotal,
     * applies 15% tax, and updates the invoice record in the database
     *
     * @param invoiceId invoice ID to recalculate
     */
    public void recalculateInvoiceTotals(int invoiceId) {
        // Fetch the invoice
        Optional<Invoice> invoiceOptional = invoiceDAO.findById(invoiceId);
        if (invoiceOptional.isEmpty()) {
            throw new RuntimeException("Invoice not found");
        }

        Invoice invoice = invoiceOptional.get();

        // Fetch all invoice items
        List<InvoiceItem> invoiceItems = invoiceItemDAO.findByInvoiceId(invoiceId);

        // Calculate subtotal from all line items
        BigDecimal subtotal = BigDecimal.ZERO;
        for (InvoiceItem item : invoiceItems) {
            subtotal = subtotal.add(item.getLineTotal());
        }

        // Calculate tax amount (15% of subtotal minus discount)
        BigDecimal taxableAmount = subtotal.subtract(invoice.getDiscountAmount());
        BigDecimal taxAmount = taxableAmount.multiply(TAX_RATE).setScale(2, RoundingMode.HALF_UP);

        // Calculate total amount
        BigDecimal totalAmount = subtotal.subtract(invoice.getDiscountAmount()).add(taxAmount);

        // Update invoice totals
        invoice.setSubtotal(subtotal);
        invoice.setTaxAmount(taxAmount);
        invoice.setTotalAmount(totalAmount);

        // Save updated invoice
        invoiceDAO.update(invoice);
    }

    /**
     * Find invoice by ID with items
     * 
     * @param id invoice ID
     * @return Optional containing invoice if found
     */
    public Optional<Invoice> findByIdWithItems(int id) {
        return invoiceDAO.findById(id);
    }

    /**
     * Get invoice items for an invoice
     * 
     * @param invoiceId invoice ID
     * @return list of invoice items
     */
    public List<InvoiceItem> getInvoiceItems(int invoiceId) {
        return invoiceItemDAO.findByInvoiceId(invoiceId);
    }

    /**
     * Find all invoices
     * 
     * @return list of all invoices
     */
    public List<Invoice> findAll() {
        return invoiceDAO.findAll();
    }

    /**
     * Find invoices by customer ID
     * 
     * @param customerId customer ID
     * @return list of invoices for the customer
     */
    public List<Invoice> findByCustomerId(int customerId) {
        return invoiceDAO.findByCustomerId(customerId);
    }

    /**
     * Sum total revenue for all invoices (delegates to DAO)
     * 
     * @return total revenue as BigDecimal
     */
    public java.math.BigDecimal getTotalRevenue() {
        return invoiceDAO.sumTotalAmount();
    }

    /**
     * Sum total revenue for given month/year (month 1-12)
     * 
     * @param year  calendar year
     * @param month calendar month (1-12)
     * @return total revenue for the month/year
     */
    public java.math.BigDecimal getMonthlyRevenue(int year, int month) {
        return invoiceDAO.sumTotalAmountForMonthYear(year, month);
    }

    /**
     * Remove item from invoice
     * 
     * @param invoiceItemId invoice item ID to remove
     */
    public void removeItemFromInvoice(int invoiceItemId) {
        // Find the invoice item to get the invoice ID
        Optional<InvoiceItem> itemOptional = invoiceItemDAO.findById(invoiceItemId);
        if (itemOptional.isEmpty()) {
            throw new RuntimeException("Invoice item not found");
        }

        int invoiceId = itemOptional.get().getInvoiceId();

        // Delete the item
        invoiceItemDAO.deleteById(invoiceItemId);

        // Recalculate invoice totals
        recalculateInvoiceTotals(invoiceId);
    }

    /**
     * Update invoice payment status
     * 
     * @param invoiceId     invoice ID
     * @param paymentStatus new payment status
     */
    public void updatePaymentStatus(int invoiceId, Invoice.PaymentStatus paymentStatus) {
        Optional<Invoice> invoiceOptional = invoiceDAO.findById(invoiceId);
        if (invoiceOptional.isEmpty()) {
            throw new RuntimeException("Invoice not found");
        }

        Invoice invoice = invoiceOptional.get();
        invoice.setPaymentStatus(paymentStatus);
        invoiceDAO.update(invoice);
    }

    /**
     * Update invoice details
     * 
     * @param invoice invoice to update
     */
    public void updateInvoice(Invoice invoice) {
        // Verify invoice exists
        if (invoiceDAO.findById(invoice.getId()).isEmpty()) {
            throw new RuntimeException("Invoice not found");
        }

        invoiceDAO.update(invoice);
    }

    /**
     * Delete invoice and all its items
     * 
     * @param invoiceId invoice ID to delete
     */
    public void deleteInvoice(int invoiceId) {
        // Verify invoice exists
        if (invoiceDAO.findById(invoiceId).isEmpty()) {
            throw new RuntimeException("Invoice not found");
        }

        // Delete all invoice items first (handled by CASCADE in DB)
        invoiceDAO.deleteById(invoiceId);
    }
}
