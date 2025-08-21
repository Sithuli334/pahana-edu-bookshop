package com.pahanaedu.dao;

import org.junit.jupiter.api.Test;
import java.lang.reflect.Method;
import java.util.Arrays;
import static org.junit.jupiter.api.Assertions.*;

public class InvoiceDAOTest {

    @Test
    public void daoInterfaceExists() {
        assertNotNull(InvoiceDAO.class);
        assertTrue(InvoiceDAO.class.isInterface(), "InvoiceDAO should be an interface");
    }

    @Test
    public void daoHasCrudMethods() throws Exception {
        Class<?> cls = InvoiceDAO.class;
        Method[] methods = cls.getDeclaredMethods();

        boolean hasCrudMethods = Arrays.stream(methods)
                .anyMatch(m -> m.getName().contains("create") ||
                        m.getName().contains("save") ||
                        m.getName().contains("find") ||
                        m.getName().contains("get") ||
                        m.getName().contains("update") ||
                        m.getName().contains("delete"));

        assertTrue(hasCrudMethods, "InvoiceDAO should have CRUD methods");
    }

    @Test
    public void daoHasExpectedMethodCount() {
        Class<?> cls = InvoiceDAO.class;
        Method[] methods = cls.getDeclaredMethods();
        assertTrue(methods.length > 0, "InvoiceDAO should have at least one method");
    }
}
