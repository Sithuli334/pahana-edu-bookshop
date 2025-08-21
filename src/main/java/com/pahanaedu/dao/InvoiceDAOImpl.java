package com.pahanaedu.dao;

import com.pahanaedu.model.Invoice;
import com.pahanaedu.model.Customer;
import com.pahanaedu.util.DatabaseConnection;

import java.sql.*;
// ...existing imports...
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * JDBC implementation of InvoiceDAO
 */
public class InvoiceDAOImpl implements InvoiceDAO {

    private static final String INSERT_INVOICE = "INSERT INTO invoices (invoiceNumber, customer_id, invoiceDate, dueDate, subtotal, taxAmount, discountAmount, totalAmount, paymentStatus, notes, paymentTerms) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String SELECT_INVOICE_BY_ID = "SELECT i.id, i.invoiceNumber, i.customer_id, i.invoiceDate, i.dueDate, i.subtotal, i.taxAmount, i.discountAmount, i.totalAmount, i.paymentStatus, i.notes, i.paymentTerms, i.created_at, i.updated_at, "
            +
            "c.name as customer_name, c.email as customer_email, c.phone as customer_phone, c.address as customer_address "
            +
            "FROM invoices i LEFT JOIN customers c ON i.customer_id = c.id WHERE i.id = ?";

    private static final String SELECT_ALL_INVOICES = "SELECT i.id, i.invoiceNumber, i.customer_id, i.invoiceDate, i.dueDate, i.subtotal, i.taxAmount, i.discountAmount, i.totalAmount, i.paymentStatus, i.notes, i.paymentTerms, i.created_at, i.updated_at, "
            +
            "c.name as customer_name, c.email as customer_email, c.phone as customer_phone, c.address as customer_address "
            +
            "FROM invoices i LEFT JOIN customers c ON i.customer_id = c.id ORDER BY i.invoiceDate DESC";

    private static final String SELECT_INVOICES_BY_CUSTOMER_ID = "SELECT i.id, i.invoiceNumber, i.customer_id, i.invoiceDate, i.dueDate, i.subtotal, i.taxAmount, i.discountAmount, i.totalAmount, i.paymentStatus, i.notes, i.paymentTerms, i.created_at, i.updated_at, "
            +
            "c.name as customer_name, c.email as customer_email, c.phone as customer_phone, c.address as customer_address "
            +
            "FROM invoices i LEFT JOIN customers c ON i.customer_id = c.id WHERE i.customer_id = ? ORDER BY i.invoiceDate DESC";

    private static final String UPDATE_INVOICE = "UPDATE invoices SET invoiceNumber = ?, customer_id = ?, invoiceDate = ?, dueDate = ?, subtotal = ?, taxAmount = ?, discountAmount = ?, totalAmount = ?, paymentStatus = ?, notes = ?, paymentTerms = ? WHERE id = ?";

    private static final String DELETE_INVOICE = "DELETE FROM invoices WHERE id = ?";

    private static final String SELECT_INVOICE_BY_NUMBER = "SELECT i.id, i.invoiceNumber, i.customer_id, i.invoiceDate, i.dueDate, i.subtotal, i.taxAmount, i.discountAmount, i.totalAmount, i.paymentStatus, i.notes, i.paymentTerms, i.created_at, i.updated_at, "
            +
            "c.name as customer_name, c.email as customer_email, c.phone as customer_phone, c.address as customer_address "
            +
            "FROM invoices i LEFT JOIN customers c ON i.customer_id = c.id WHERE i.invoiceNumber = ?";

    private static final String SELECT_MAX_INVOICE_NUMBER = "SELECT MAX(CAST(SUBSTRING(invoiceNumber, 4) AS UNSIGNED)) as max_num FROM invoices WHERE invoiceNumber LIKE 'INV%'";

    // Aggregation queries
    private static final String SELECT_SUM_TOTAL_AMOUNT = "SELECT SUM(totalAmount) as total FROM invoices";
    private static final String SELECT_SUM_TOTAL_AMOUNT_BY_MONTH_YEAR = "SELECT SUM(totalAmount) as total FROM invoices WHERE MONTH(invoiceDate) = ? AND YEAR(invoiceDate) = ?";

    @Override
    public Invoice save(Invoice invoice) {
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(INSERT_INVOICE, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, invoice.getInvoiceNumber());
            stmt.setInt(2, invoice.getCustomerId());
            stmt.setDate(3, Date.valueOf(invoice.getInvoiceDate()));
            stmt.setDate(4, Date.valueOf(invoice.getDueDate()));
            stmt.setBigDecimal(5, invoice.getSubtotal());
            stmt.setBigDecimal(6, invoice.getTaxAmount());
            stmt.setBigDecimal(7, invoice.getDiscountAmount());
            stmt.setBigDecimal(8, invoice.getTotalAmount());
            stmt.setString(9, invoice.getPaymentStatus().name());
            stmt.setString(10, invoice.getNotes());
            stmt.setString(11, invoice.getPaymentTerms());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating invoice failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    invoice.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating invoice failed, no ID obtained.");
                }
            }

            return invoice;
        } catch (SQLException e) {
            throw new RuntimeException("Error saving invoice", e);
        }
    }

    @Override
    public Optional<Invoice> findById(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(SELECT_INVOICE_BY_ID)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToInvoice(rs));
                }
            }

            return Optional.empty();
        } catch (SQLException e) {
            throw new RuntimeException("Error finding invoice by ID", e);
        }
    }

    @Override
    public List<Invoice> findAll() {
        List<Invoice> invoices = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(SELECT_ALL_INVOICES);
                ResultSet rs = stmt.executeQuery()) {

            System.out.println("DEBUG: Executing findAll query");
            while (rs.next()) {
                invoices.add(mapResultSetToInvoice(rs));
            }
            System.out.println("DEBUG: findAll completed, found " + invoices.size() + " invoices");

        } catch (SQLException e) {
            System.err.println("ERROR in findAll: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Error finding all invoices", e);
        }

        return invoices;
    }

    @Override
    public List<Invoice> findByCustomerId(int customerId) {
        List<Invoice> invoices = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(SELECT_INVOICES_BY_CUSTOMER_ID)) {

            stmt.setInt(1, customerId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    invoices.add(mapResultSetToInvoice(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding invoices by customer ID", e);
        }

        return invoices;
    }

    @Override
    public Invoice update(Invoice invoice) {
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(UPDATE_INVOICE)) {

            stmt.setString(1, invoice.getInvoiceNumber());
            stmt.setInt(2, invoice.getCustomerId());
            stmt.setDate(3, Date.valueOf(invoice.getInvoiceDate()));
            stmt.setDate(4, Date.valueOf(invoice.getDueDate()));
            stmt.setBigDecimal(5, invoice.getSubtotal());
            stmt.setBigDecimal(6, invoice.getTaxAmount());
            stmt.setBigDecimal(7, invoice.getDiscountAmount());
            stmt.setBigDecimal(8, invoice.getTotalAmount());
            stmt.setString(9, invoice.getPaymentStatus().name());
            stmt.setString(10, invoice.getNotes());
            stmt.setString(11, invoice.getPaymentTerms());
            stmt.setInt(12, invoice.getId());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Updating invoice failed, no rows affected.");
            }

            return invoice;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating invoice", e);
        }
    }

    @Override
    public void deleteById(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(DELETE_INVOICE)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting invoice", e);
        }
    }

    @Override
    public Optional<Invoice> findByInvoiceNumber(String invoiceNumber) {
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(SELECT_INVOICE_BY_NUMBER)) {

            stmt.setString(1, invoiceNumber);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToInvoice(rs));
                }
            }

            return Optional.empty();
        } catch (SQLException e) {
            throw new RuntimeException("Error finding invoice by number", e);
        }
    }

    @Override
    public String generateNextInvoiceNumber() {
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(SELECT_MAX_INVOICE_NUMBER);
                ResultSet rs = stmt.executeQuery()) {

            int nextNumber = 1;
            if (rs.next()) {
                int maxNumber = rs.getInt("max_num");
                nextNumber = maxNumber + 1;
            }

            return String.format("INV%05d", nextNumber);

        } catch (SQLException e) {
            throw new RuntimeException("Error generating next invoice number", e);
        }
    }

    @Override
    public java.math.BigDecimal sumTotalAmount() {
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(SELECT_SUM_TOTAL_AMOUNT);
                ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                java.math.BigDecimal total = rs.getBigDecimal("total");
                return total != null ? total : java.math.BigDecimal.ZERO;
            }

            return java.math.BigDecimal.ZERO;
        } catch (SQLException e) {
            throw new RuntimeException("Error summing totalAmount", e);
        }
    }

    @Override
    public java.math.BigDecimal sumTotalAmountForMonthYear(int year, int month) {
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(SELECT_SUM_TOTAL_AMOUNT_BY_MONTH_YEAR)) {

            stmt.setInt(1, month);
            stmt.setInt(2, year);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    java.math.BigDecimal total = rs.getBigDecimal("total");
                    return total != null ? total : java.math.BigDecimal.ZERO;
                }
            }

            return java.math.BigDecimal.ZERO;
        } catch (SQLException e) {
            throw new RuntimeException("Error summing totalAmount for month/year", e);
        }
    }

    /**
     * Map ResultSet to Invoice object
     */
    private Invoice mapResultSetToInvoice(ResultSet rs) throws SQLException {
        Invoice invoice = new Invoice();
        invoice.setId(rs.getInt("id"));
        invoice.setInvoiceNumber(rs.getString("invoiceNumber"));
        invoice.setCustomerId(rs.getInt("customer_id"));
        invoice.setInvoiceDate(rs.getDate("invoiceDate").toLocalDate());
        invoice.setDueDate(rs.getDate("dueDate").toLocalDate());
        invoice.setSubtotal(rs.getBigDecimal("subtotal"));
        invoice.setTaxAmount(rs.getBigDecimal("taxAmount"));
        invoice.setDiscountAmount(rs.getBigDecimal("discountAmount"));
        invoice.setTotalAmount(rs.getBigDecimal("totalAmount"));
        invoice.setPaymentStatus(Invoice.PaymentStatus.valueOf(rs.getString("paymentStatus")));
        invoice.setNotes(rs.getString("notes"));
        invoice.setPaymentTerms(rs.getString("paymentTerms"));

        // Set customer information if available
        String customerName = rs.getString("customer_name");
        if (customerName != null) {
            Customer customer = new Customer();
            customer.setId(rs.getInt("customer_id"));
            customer.setName(customerName);
            customer.setEmail(rs.getString("customer_email"));
            customer.setPhone(rs.getString("customer_phone"));
            customer.setAddress(rs.getString("customer_address"));
            invoice.setCustomer(customer);
        }

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            invoice.setCreatedAt(createdAt.toLocalDateTime());
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            invoice.setUpdatedAt(updatedAt.toLocalDateTime());
        }

        return invoice;
    }
}
