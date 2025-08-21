package com.pahanaedu.dao;

import com.pahanaedu.model.Item;
import com.pahanaedu.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * JDBC implementation of ItemDAO
 */
public class ItemDAOImpl implements ItemDAO {

    private static final String INSERT_ITEM =
        "INSERT INTO items (name, code, description, price, unit, active, stockQuantity) VALUES (?, ?, ?, ?, ?, ?, ?)";

    private static final String SELECT_ITEM_BY_ID =
        "SELECT id, name, code, description, price, unit, active, stockQuantity, created_at, updated_at FROM items WHERE id = ?";

    private static final String SELECT_ALL_ITEMS =
        "SELECT id, name, code, description, price, unit, active, stockQuantity, created_at, updated_at FROM items ORDER BY name";

    private static final String SELECT_ACTIVE_ITEMS =
        "SELECT id, name, code, description, price, unit, active, stockQuantity, created_at, updated_at FROM items WHERE active = TRUE ORDER BY name";

    private static final String UPDATE_ITEM =
        "UPDATE items SET name = ?, code = ?, description = ?, price = ?, unit = ?, active = ?, stockQuantity = ? WHERE id = ?";

    private static final String DELETE_ITEM =
        "DELETE FROM items WHERE id = ?";

    private static final String SELECT_ITEM_BY_CODE =
        "SELECT id, name, code, description, price, unit, active, stockQuantity, created_at, updated_at FROM items WHERE code = ?";

    private static final String SELECT_ITEMS_BY_NAME =
        "SELECT id, name, code, description, price, unit, active, stockQuantity, created_at, updated_at FROM items WHERE name LIKE ? ORDER BY name";

    @Override
    public Item save(Item item) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_ITEM, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, item.getName());
            stmt.setString(2, item.getCode());
            stmt.setString(3, item.getDescription());
            stmt.setBigDecimal(4, item.getPrice());
            stmt.setString(5, item.getUnit());
            stmt.setBoolean(6, item.isActive());
            stmt.setInt(7, item.getStockQuantity());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating item failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    item.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating item failed, no ID obtained.");
                }
            }

            return item;
        } catch (SQLException e) {
            throw new RuntimeException("Error saving item", e);
        }
    }

    @Override
    public Optional<Item> findById(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ITEM_BY_ID)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToItem(rs));
                }
            }

            return Optional.empty();
        } catch (SQLException e) {
            throw new RuntimeException("Error finding item by ID", e);
        }
    }

    @Override
    public List<Item> findAll() {
        List<Item> items = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL_ITEMS);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding all items", e);
        }

        return items;
    }

    @Override
    public List<Item> findAllActive() {
        List<Item> items = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ACTIVE_ITEMS);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding active items", e);
        }

        return items;
    }

    @Override
    public Item update(Item item) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_ITEM)) {

            stmt.setString(1, item.getName());
            stmt.setString(2, item.getCode());
            stmt.setString(3, item.getDescription());
            stmt.setBigDecimal(4, item.getPrice());
            stmt.setString(5, item.getUnit());
            stmt.setBoolean(6, item.isActive());
            stmt.setInt(7, item.getStockQuantity());
            stmt.setInt(8, item.getId());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Updating item failed, no rows affected.");
            }

            return item;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating item", e);
        }
    }

    @Override
    public void deleteById(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_ITEM)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting item", e);
        }
    }

    @Override
    public Optional<Item> findByCode(String code) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ITEM_BY_CODE)) {

            stmt.setString(1, code);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToItem(rs));
                }
            }

            return Optional.empty();
        } catch (SQLException e) {
            throw new RuntimeException("Error finding item by code", e);
        }
    }

    @Override
    public List<Item> findByNameContaining(String name) {
        List<Item> items = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ITEMS_BY_NAME)) {

            stmt.setString(1, "%" + name + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    items.add(mapResultSetToItem(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding items by name", e);
        }

        return items;
    }

    /**
     * Map ResultSet to Item object
     */
    private Item mapResultSetToItem(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setCode(rs.getString("code"));
        item.setDescription(rs.getString("description"));
        item.setPrice(rs.getBigDecimal("price"));
        item.setUnit(rs.getString("unit"));
        item.setActive(rs.getBoolean("active"));
        item.setStockQuantity(rs.getInt("stockQuantity"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            item.setCreatedAt(createdAt.toLocalDateTime());
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            item.setUpdatedAt(updatedAt.toLocalDateTime());
        }

        return item;
    }
}
