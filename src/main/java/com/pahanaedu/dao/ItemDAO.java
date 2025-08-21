package com.pahanaedu.dao;

import com.pahanaedu.model.Item;
import java.util.List;
import java.util.Optional;

/**
 * Data Access Object interface for Item entity
 */
public interface ItemDAO {

    /**
     * Save a new item
     * @param item Item to save
     * @return saved item with generated ID
     */
    Item save(Item item);

    /**
     * Find item by ID
     * @param id item ID
     * @return Optional containing item if found
     */
    Optional<Item> findById(int id);

    /**
     * Find all items
     * @return list of all items
     */
    List<Item> findAll();

    /**
     * Find all active items
     * @return list of active items
     */
    List<Item> findAllActive();

    /**
     * Update existing item
     * @param item item to update
     * @return updated item
     */
    Item update(Item item);

    /**
     * Delete item by ID
     * @param id item ID to delete
     */
    void deleteById(int id);

    /**
     * Find item by code
     * @param code item code
     * @return Optional containing item if found
     */
    Optional<Item> findByCode(String code);

    /**
     * Find items by name (partial match)
     * @param name name to search for
     * @return list of matching items
     */
    List<Item> findByNameContaining(String name);
}
