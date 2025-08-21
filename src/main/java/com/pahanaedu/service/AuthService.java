package com.pahanaedu.service;

import com.pahanaedu.dao.UserDAO;
import com.pahanaedu.dao.UserDAOImpl;
import com.pahanaedu.model.User;
import com.pahanaedu.util.PasswordUtil;

import java.util.Optional;

/**
 * Service class for user authentication and management
 */
public class AuthService {

    private final UserDAO userDAO;

    public AuthService() {
        this.userDAO = new UserDAOImpl();
    }

    /**
     * Authenticate user login
     * @param email user email
     * @param password plain text password
     * @return Optional containing user if authentication successful
     */
    public Optional<User> login(String email, String password) {
        Optional<User> userOptional = userDAO.findByEmail(email);

        if (userOptional.isPresent()) {
            User user = userOptional.get();

            // Check if password matches (supports both new hashed and legacy simple hash)
            if (isPasswordValid(password, user.getPassword())) {
                return Optional.of(user);
            }
        }

        return Optional.empty();
    }

    /**
     * Register a new user
     * @param email user email
     * @param password plain text password
     * @param name user full name
     * @return registered user
     * @throws RuntimeException if email already exists
     */
    public User register(String email, String password, String name) {
        // Check if email already exists
        if (userDAO.findByEmail(email).isPresent()) {
            throw new RuntimeException("Email already exists");
        }

        // Hash the password
        String hashedPassword = PasswordUtil.hashPassword(password);

        // Create and save user
        User user = new User(email, hashedPassword, name);
        return userDAO.save(user);
    }

    /**
     * Validate password against stored hash
     * Supports both new salted hash and legacy simple hash formats
     */
    private boolean isPasswordValid(String password, String storedHash) {
        // Try new salted hash format first (contains $)
        if (storedHash.contains("$")) {
            return PasswordUtil.verifyPassword(password, storedHash);
        } else {
            // Legacy format - simple hash (for sample data)
            String simpleHash = PasswordUtil.simpleHash(password);
            return simpleHash.equals(storedHash);
        }
    }

    /**
     * Find user by ID
     * @param id user ID
     * @return Optional containing user if found
     */
    public Optional<User> findById(int id) {
        return userDAO.findById(id);
    }

    /**
     * Update user password
     * @param userId user ID
     * @param newPassword new plain text password
     * @return updated user
     */
    public User updatePassword(int userId, String newPassword) {
        Optional<User> userOptional = userDAO.findById(userId);
        if (userOptional.isEmpty()) {
            throw new RuntimeException("User not found");
        }

        User user = userOptional.get();
        user.setPassword(PasswordUtil.hashPassword(newPassword));
        return userDAO.update(user);
    }
}
