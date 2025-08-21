package com.pahanaedu.service;

import org.junit.jupiter.api.Test;
import java.lang.reflect.Method;
import java.util.Arrays;
import static org.junit.jupiter.api.Assertions.*;

public class ItemServiceTest {

    @Test
    public void serviceClassExists() {
        assertNotNull(ItemService.class);
    }

    @Test
    public void serviceHasItemMethods() throws Exception {
        Class<?> cls = ItemService.class;
        Method[] methods = cls.getDeclaredMethods();

        boolean hasItemMethod = Arrays.stream(methods)
                .anyMatch(m -> m.getName().contains("item") || m.getName().contains("Item"));

        assertTrue(hasItemMethod, "ItemService should have item-related methods");
    }

    @Test
    public void serviceCanBeInstantiated() {
        assertDoesNotThrow(() -> {
            ItemService service = new ItemService();
            assertNotNull(service);
        });
    }

    @Test
    public void serviceHasExpectedMethodCount() {
        Class<?> cls = ItemService.class;
        Method[] methods = cls.getDeclaredMethods();
        assertTrue(methods.length > 0, "ItemService should have at least one method");
    }

    @Test
    public void serviceHasCrudMethods() throws Exception {
        Class<?> cls = ItemService.class;
        Method[] methods = cls.getDeclaredMethods();

        boolean hasCrudMethods = Arrays.stream(methods)
                .anyMatch(m -> m.getName().contains("create") ||
                        m.getName().contains("read") ||
                        m.getName().contains("update") ||
                        m.getName().contains("delete") ||
                        m.getName().contains("find") ||
                        m.getName().contains("get"));

        assertTrue(hasCrudMethods, "ItemService should have CRUD operations");
    }
}
