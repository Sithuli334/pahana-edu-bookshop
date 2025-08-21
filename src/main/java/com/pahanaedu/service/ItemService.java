package com.pahanaedu.service;

import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.dao.ItemDAOImpl;
import com.pahanaedu.model.Item;

import java.util.List;
import java.util.Optional;

/**
 * Service class for item management business logic
 */
public class ItemService {

    private final ItemDAO itemDAO;

    public ItemService() {
        this.itemDAO = new ItemDAOImpl();
    }

    /**
     * Create a new item
     * @param item item to create
     * @return saved item
     * @throws RuntimeException if item code already exists
     */
    public Item createItem(Item item) {
        // Validate item code uniqueness
        if (item.getCode() != null && itemDAO.findByCode(item.getCode()).isPresent()) {
            throw new RuntimeException("Item code already exists");
        }

        return itemDAO.save(item);
    }

    /**
     * Find item by ID
     * @param id item ID
     * @return Optional containing item if found
     */
    public Optional<Item> findById(int id) {
        return itemDAO.findById(id);
    }

    /**
     * Find all items
     * @return list of all items
     */
    public List<Item> findAll() {
        return itemDAO.findAll();
    }

    /**
     * Find all active items
     * @return list of active items
     */
    public List<Item> findAllActive() {
        return itemDAO.findAllActive();
    }

    /**
     * Update existing item
     * @param item item to update
     * @return updated item
     * @throws RuntimeException if item not found or code conflict
     */
    public Item updateItem(Item item) {
        // Verify item exists
        Optional<Item> existingItem = itemDAO.findById(item.getId());
        if (existingItem.isEmpty()) {
            throw new RuntimeException("Item not found");
        }

        // Check code uniqueness (excluding current item)
        Optional<Item> itemWithSameCode = itemDAO.findByCode(item.getCode());
        if (itemWithSameCode.isPresent() && itemWithSameCode.get().getId() != item.getId()) {
            throw new RuntimeException("Item code already exists");
        }

        return itemDAO.update(item);
    }

    /**
     * Delete item by ID
     * @param id item ID to delete
     * @throws RuntimeException if item not found
     */
    public void deleteItem(int id) {
        if (itemDAO.findById(id).isEmpty()) {
            throw new RuntimeException("Item not found");
        }
        itemDAO.deleteById(id);
    }

    /**
     * Search items by name
     * @param name name to search for
     * @return list of matching items
     */
    public List<Item> searchByName(String name) {
        return itemDAO.findByNameContaining(name);
    }

    /**
     * Find item by code
     * @param code item code
     * @return Optional containing item if found
     */
    public Optional<Item> findByCode(String code) {
        return itemDAO.findByCode(code);
    }
}
