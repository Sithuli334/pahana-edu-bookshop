package com.pahanaedu.dao;

import com.pahanaedu.model.InvoiceItem;
import com.pahanaedu.model.Item;
import com.pahanaedu.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * JDBC implementation of InvoiceItemDAO
 */
public class InvoiceItemDAOImpl implements InvoiceItemDAO {

    private static final String INSERT_INVOICE_ITEM =
        "INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description) VALUES (?, ?, ?, ?, ?, ?, ?)";

    private static final String SELECT_INVOICE_ITEM_BY_ID =
        "SELECT ii.id, ii.invoice_id, ii.item_id, ii.quantity, ii.unitPrice, ii.discount, ii.lineTotal, ii.description, " +
        "i.name as item_name, i.code as item_code, i.unit as item_unit " +
        "FROM invoice_items ii LEFT JOIN items i ON ii.item_id = i.id WHERE ii.id = ?";

    private static final String SELECT_INVOICE_ITEMS_BY_INVOICE_ID =
        "SELECT ii.id, ii.invoice_id, ii.item_id, ii.quantity, ii.unitPrice, ii.discount, ii.lineTotal, ii.description, " +
        "i.name as item_name, i.code as item_code, i.unit as item_unit " +
        "FROM invoice_items ii LEFT JOIN items i ON ii.item_id = i.id WHERE ii.invoice_id = ? ORDER BY ii.id";

    private static final String UPDATE_INVOICE_ITEM =
        "UPDATE invoice_items SET invoice_id = ?, item_id = ?, quantity = ?, unitPrice = ?, discount = ?, lineTotal = ?, description = ? WHERE id = ?";

    private static final String DELETE_INVOICE_ITEM =
        "DELETE FROM invoice_items WHERE id = ?";

    private static final String DELETE_INVOICE_ITEMS_BY_INVOICE_ID =
        "DELETE FROM invoice_items WHERE invoice_id = ?";

    @Override
    public InvoiceItem save(InvoiceItem invoiceItem) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_INVOICE_ITEM, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, invoiceItem.getInvoiceId());
            stmt.setInt(2, invoiceItem.getItemId());
            stmt.setBigDecimal(3, invoiceItem.getQuantity());
            stmt.setBigDecimal(4, invoiceItem.getUnitPrice());
            stmt.setBigDecimal(5, invoiceItem.getDiscount());
            stmt.setBigDecimal(6, invoiceItem.getLineTotal());
            stmt.setString(7, invoiceItem.getDescription());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating invoice item failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    invoiceItem.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating invoice item failed, no ID obtained.");
                }
            }

            return invoiceItem;
        } catch (SQLException e) {
            throw new RuntimeException("Error saving invoice item", e);
        }
    }

    @Override
    public Optional<InvoiceItem> findById(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_INVOICE_ITEM_BY_ID)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToInvoiceItem(rs));
                }
            }

            return Optional.empty();
        } catch (SQLException e) {
            throw new RuntimeException("Error finding invoice item by ID", e);
        }
    }

    @Override
    public List<InvoiceItem> findByInvoiceId(int invoiceId) {
        List<InvoiceItem> invoiceItems = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_INVOICE_ITEMS_BY_INVOICE_ID)) {

            stmt.setInt(1, invoiceId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    invoiceItems.add(mapResultSetToInvoiceItem(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding invoice items by invoice ID", e);
        }

        return invoiceItems;
    }

    @Override
    public InvoiceItem update(InvoiceItem invoiceItem) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_INVOICE_ITEM)) {

            stmt.setInt(1, invoiceItem.getInvoiceId());
            stmt.setInt(2, invoiceItem.getItemId());
            stmt.setBigDecimal(3, invoiceItem.getQuantity());
            stmt.setBigDecimal(4, invoiceItem.getUnitPrice());
            stmt.setBigDecimal(5, invoiceItem.getDiscount());
            stmt.setBigDecimal(6, invoiceItem.getLineTotal());
            stmt.setString(7, invoiceItem.getDescription());
            stmt.setInt(8, invoiceItem.getId());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Updating invoice item failed, no rows affected.");
            }

            return invoiceItem;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating invoice item", e);
        }
    }

    @Override
    public void deleteById(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_INVOICE_ITEM)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting invoice item", e);
        }
    }

    @Override
    public void deleteByInvoiceId(int invoiceId) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_INVOICE_ITEMS_BY_INVOICE_ID)) {

            stmt.setInt(1, invoiceId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting invoice items by invoice ID", e);
        }
    }

    /**
     * Map ResultSet to InvoiceItem object
     */
    private InvoiceItem mapResultSetToInvoiceItem(ResultSet rs) throws SQLException {
        InvoiceItem invoiceItem = new InvoiceItem();
        invoiceItem.setId(rs.getInt("id"));
        invoiceItem.setInvoiceId(rs.getInt("invoice_id"));
        invoiceItem.setItemId(rs.getInt("item_id"));
        invoiceItem.setQuantity(rs.getBigDecimal("quantity"));
        invoiceItem.setUnitPrice(rs.getBigDecimal("unitPrice"));
        invoiceItem.setDiscount(rs.getBigDecimal("discount"));
        invoiceItem.setLineTotal(rs.getBigDecimal("lineTotal"));
        invoiceItem.setDescription(rs.getString("description"));

        // Set item information if available
        String itemName = rs.getString("item_name");
        if (itemName != null) {
            Item item = new Item();
            item.setId(rs.getInt("item_id"));
            item.setName(itemName);
            item.setCode(rs.getString("item_code"));
            item.setUnit(rs.getString("item_unit"));
            invoiceItem.setItem(item);
        }

        return invoiceItem;
    }
}
