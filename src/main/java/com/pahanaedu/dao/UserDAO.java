package com.pahanaedu.dao;

import com.pahanaedu.model.User;
import java.util.List;
import java.util.Optional;

/**
 * Data Access Object interface for User entity
 */
public interface UserDAO {

    /**
     * Save a new user
     * @param user User to save
     * @return saved user with generated ID
     */
    User save(User user);

    /**
     * Find user by ID
     * @param id user ID
     * @return Optional containing user if found
     */
    Optional<User> findById(int id);

    /**
     * Find user by email
     * @param email user email
     * @return Optional containing user if found
     */
    Optional<User> findByEmail(String email);

    /**
     * Find all users
     * @return list of all users
     */
    List<User> findAll();

    /**
     * Update existing user
     * @param user user to update
     * @return updated user
     */
    User update(User user);

    /**
     * Delete user by ID
     * @param id user ID to delete
     */
    void deleteById(int id);
}
