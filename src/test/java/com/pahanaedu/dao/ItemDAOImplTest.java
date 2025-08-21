package com.pahanaedu.dao;

import org.junit.jupiter.api.Test;
import java.lang.reflect.Method;
import java.util.Arrays;
import static org.junit.jupiter.api.Assertions.*;

public class ItemDAOImplTest {

    @Test
    public void daoImplClassExists() {
        assertNotNull(ItemDAOImpl.class);
        assertFalse(ItemDAOImpl.class.isInterface(), "ItemDAOImpl should be a concrete class");
    }

    @Test
    public void daoImplImplementsInterface() {
        Class<?>[] interfaces = ItemDAOImpl.class.getInterfaces();
        boolean implementsItemDAO = Arrays.stream(interfaces)
                .anyMatch(i -> i.equals(ItemDAO.class));

        assertTrue(implementsItemDAO, "ItemDAOImpl should implement ItemDAO interface");
    }

    @Test
    public void daoImplCanBeInstantiated() {
        assertDoesNotThrow(() -> {
            ItemDAOImpl dao = new ItemDAOImpl();
            assertNotNull(dao);
        });
    }

    @Test
    public void daoImplHasCrudMethods() throws Exception {
        Class<?> cls = ItemDAOImpl.class;
        Method[] methods = cls.getDeclaredMethods();

        boolean hasCrudMethods = Arrays.stream(methods)
                .anyMatch(m -> m.getName().contains("create") ||
                        m.getName().contains("save") ||
                        m.getName().contains("find") ||
                        m.getName().contains("get") ||
                        m.getName().contains("update") ||
                        m.getName().contains("delete"));

        assertTrue(hasCrudMethods, "ItemDAOImpl should have CRUD methods");
    }
}
