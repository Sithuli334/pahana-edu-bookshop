package com.pahanaedu.dao;

import com.pahanaedu.model.Customer;
import com.pahanaedu.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * JDBC implementation of CustomerDAO
 */
public class CustomerDAOImpl implements CustomerDAO {

    private static final String INSERT_CUSTOMER =
        "INSERT INTO customers (name, email, phone, address, notes, accountNumber, customerType, telephoneNumber, unitsConsumed) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String SELECT_CUSTOMER_BY_ID =
        "SELECT id, name, email, phone, address, notes, accountNumber, customerType, telephoneNumber, unitsConsumed, created_at, updated_at FROM customers WHERE id = ?";

    private static final String SELECT_ALL_CUSTOMERS =
        "SELECT id, name, email, phone, address, notes, accountNumber, customerType, telephoneNumber, unitsConsumed, created_at, updated_at FROM customers ORDER BY name";

    private static final String UPDATE_CUSTOMER =
        "UPDATE customers SET name = ?, email = ?, phone = ?, address = ?, notes = ?, accountNumber = ?, customerType = ?, telephoneNumber = ?, unitsConsumed = ? WHERE id = ?";

    private static final String DELETE_CUSTOMER =
        "DELETE FROM customers WHERE id = ?";

    private static final String SELECT_CUSTOMERS_BY_NAME =
        "SELECT id, name, email, phone, address, notes, accountNumber, customerType, telephoneNumber, unitsConsumed, created_at, updated_at FROM customers WHERE name LIKE ? ORDER BY name";

    private static final String SELECT_CUSTOMER_BY_ACCOUNT_NUMBER =
        "SELECT id, name, email, phone, address, notes, accountNumber, customerType, telephoneNumber, unitsConsumed, created_at, updated_at FROM customers WHERE accountNumber = ?";

    @Override
    public Customer save(Customer customer) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_CUSTOMER, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getAddress());
            stmt.setString(5, customer.getNotes());
            stmt.setString(6, customer.getAccountNumber());
            stmt.setString(7, customer.getCustomerType().name());
            stmt.setString(8, customer.getTelephoneNumber());
            stmt.setBigDecimal(9, customer.getUnitsConsumed());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating customer failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    customer.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating customer failed, no ID obtained.");
                }
            }

            return customer;
        } catch (SQLException e) {
            throw new RuntimeException("Error saving customer", e);
        }
    }

    @Override
    public Optional<Customer> findById(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_CUSTOMER_BY_ID)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToCustomer(rs));
                }
            }

            return Optional.empty();
        } catch (SQLException e) {
            throw new RuntimeException("Error finding customer by ID", e);
        }
    }

    @Override
    public List<Customer> findAll() {
        List<Customer> customers = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL_CUSTOMERS);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                customers.add(mapResultSetToCustomer(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding all customers", e);
        }

        return customers;
    }

    @Override
    public Customer update(Customer customer) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_CUSTOMER)) {

            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getAddress());
            stmt.setString(5, customer.getNotes());
            stmt.setString(6, customer.getAccountNumber());
            stmt.setString(7, customer.getCustomerType().name());
            stmt.setString(8, customer.getTelephoneNumber());
            stmt.setBigDecimal(9, customer.getUnitsConsumed());
            stmt.setInt(10, customer.getId());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Updating customer failed, no rows affected.");
            }

            return customer;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating customer", e);
        }
    }

    @Override
    public void deleteById(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_CUSTOMER)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting customer", e);
        }
    }

    @Override
    public List<Customer> findByNameContaining(String name) {
        List<Customer> customers = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_CUSTOMERS_BY_NAME)) {

            stmt.setString(1, "%" + name + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    customers.add(mapResultSetToCustomer(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding customers by name", e);
        }

        return customers;
    }

    @Override
    public Optional<Customer> findByAccountNumber(String accountNumber) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_CUSTOMER_BY_ACCOUNT_NUMBER)) {

            stmt.setString(1, accountNumber);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToCustomer(rs));
                }
            }

            return Optional.empty();
        } catch (SQLException e) {
            throw new RuntimeException("Error finding customer by account number", e);
        }
    }

    /**
     * Map ResultSet to Customer object
     */
    private Customer mapResultSetToCustomer(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setId(rs.getInt("id"));
        customer.setName(rs.getString("name"));
        customer.setEmail(rs.getString("email"));
        customer.setPhone(rs.getString("phone"));
        customer.setAddress(rs.getString("address"));
        customer.setNotes(rs.getString("notes"));
        customer.setAccountNumber(rs.getString("accountNumber"));
        customer.setCustomerType(Customer.CustomerType.valueOf(rs.getString("customerType")));
        customer.setTelephoneNumber(rs.getString("telephoneNumber"));
        customer.setUnitsConsumed(rs.getBigDecimal("unitsConsumed"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            customer.setCreatedAt(createdAt.toLocalDateTime());
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            customer.setUpdatedAt(updatedAt.toLocalDateTime());
        }

        return customer;
    }
}
