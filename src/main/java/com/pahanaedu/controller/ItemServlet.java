package com.pahanaedu.controller;

import com.pahanaedu.model.Item;
import com.pahanaedu.service.ItemService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

/**
 * Servlet for Item Management
 */
@WebServlet(name = "itemServlet", value = "/items")
public class ItemServlet extends HttpServlet {

    private ItemService itemService;

    @Override
    public void init() {
        itemService = new ItemService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listItems(request, response);
                break;
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "view":
                viewItem(request, response);
                break;
            default:
                listItems(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "save";
        }

        switch (action) {
            case "save":
                saveItem(request, response);
                break;
            case "update":
                updateItem(request, response);
                break;
            case "delete":
                deleteItem(request, response);
                break;
            default:
                listItems(request, response);
                break;
        }
    }

    /**
     * List all items
     */
    private void listItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Item> items = itemService.findAll();
            request.setAttribute("items", items);
            request.getRequestDispatcher("/WEB-INF/views/items/list.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading items: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    /**
     * Show new item form
     */
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            request.setAttribute("item", new Item());
            request.setAttribute("isEdit", false);
            request.getRequestDispatcher("/WEB-INF/views/items/form.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading form: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    /**
     * Show edit item form
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Optional<Item> itemOptional = itemService.findById(id);

            if (itemOptional.isPresent()) {
                request.setAttribute("item", itemOptional.get());
                request.setAttribute("isEdit", true);
                request.getRequestDispatcher("/WEB-INF/views/items/form.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Item not found");
                listItems(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid item ID");
            listItems(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading item: " + e.getMessage());
            listItems(request, response);
        }
    }

    /**
     * View item details
     */
    private void viewItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Optional<Item> itemOptional = itemService.findById(id);

            if (itemOptional.isPresent()) {
                request.setAttribute("item", itemOptional.get());
                request.getRequestDispatcher("/WEB-INF/views/items/view.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Item not found");
                listItems(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid item ID");
            listItems(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading item: " + e.getMessage());
            listItems(request, response);
        }
    }

    /**
     * Save new item
     */
    private void saveItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String name = request.getParameter("name");
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            String unit = request.getParameter("unit");
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));

            Item item = new Item();
            item.setName(name);
            item.setCode(code);
            item.setDescription(description);
            item.setPrice(price);
            item.setUnit(unit);
            item.setStockQuantity(stockQuantity);
            item.setActive(true);

            itemService.createItem(item);

            response.sendRedirect(request.getContextPath() + "/items?action=list&success=created");
        } catch (Exception e) {
            request.setAttribute("item", createItemFromRequest(request));
            request.setAttribute("isEdit", false);
            request.setAttribute("errorMessage", "Error creating item: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/items/form.jsp").forward(request, response);
        }
    }

    /**
     * Update existing item
     */
    private void updateItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("itemId"));
            String name = request.getParameter("name");
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            String unit = request.getParameter("unit");
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            boolean active = "on".equals(request.getParameter("active"));

            Item item = new Item();
            item.setId(id);
            item.setName(name);
            item.setCode(code);
            item.setDescription(description);
            item.setPrice(price);
            item.setUnit(unit);
            item.setStockQuantity(stockQuantity);
            item.setActive(active);

            itemService.updateItem(item);

            response.sendRedirect(request.getContextPath() + "/items?action=list&success=updated");
        } catch (Exception e) {
            try {
                int id = Integer.parseInt(request.getParameter("itemId"));
                showEditForm(request, response);
                request.setAttribute("errorMessage", "Error updating item: " + e.getMessage());
            } catch (Exception ex) {
                listItems(request, response);
                request.setAttribute("errorMessage", "Error updating item: " + e.getMessage());
            }
        }
    }

    /**
     * Delete item
     */
    private void deleteItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            itemService.deleteItem(id);
            response.sendRedirect(request.getContextPath() + "/items?action=list&success=deleted");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error deleting item: " + e.getMessage());
            listItems(request, response);
        }
    }

    /**
     * Helper method to create Item from request parameters
     */
    private Item createItemFromRequest(HttpServletRequest request) {
        Item item = new Item();
        try {
            item.setName(request.getParameter("name"));
            item.setCode(request.getParameter("code"));
            item.setDescription(request.getParameter("description"));
            if (request.getParameter("price") != null && !request.getParameter("price").isEmpty()) {
                item.setPrice(new BigDecimal(request.getParameter("price")));
            }
            item.setUnit(request.getParameter("unit"));
            if (request.getParameter("stockQuantity") != null && !request.getParameter("stockQuantity").isEmpty()) {
                item.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
            }
        } catch (Exception e) {
            // Ignore parsing errors, return item with available data
        }
        return item;
    }
}
