package com.pahanaedu.dao;

import org.junit.jupiter.api.Test;
import java.lang.reflect.Method;
import java.util.Arrays;
import static org.junit.jupiter.api.Assertions.*;

public class InvoiceItemDAOImplTest {

    @Test
    public void daoImplClassExists() {
        assertNotNull(InvoiceItemDAOImpl.class);
        assertFalse(InvoiceItemDAOImpl.class.isInterface(), "InvoiceItemDAOImpl should be a concrete class");
    }

    @Test
    public void daoImplImplementsInterface() {
        Class<?>[] interfaces = InvoiceItemDAOImpl.class.getInterfaces();
        boolean implementsInvoiceItemDAO = Arrays.stream(interfaces)
                .anyMatch(i -> i.equals(InvoiceItemDAO.class));

        assertTrue(implementsInvoiceItemDAO, "InvoiceItemDAOImpl should implement InvoiceItemDAO interface");
    }

    @Test
    public void daoImplCanBeInstantiated() {
        assertDoesNotThrow(() -> {
            InvoiceItemDAOImpl dao = new InvoiceItemDAOImpl();
            assertNotNull(dao);
        });
    }

    @Test
    public void daoImplHasCrudMethods() throws Exception {
        Class<?> cls = InvoiceItemDAOImpl.class;
        Method[] methods = cls.getDeclaredMethods();

        boolean hasCrudMethods = Arrays.stream(methods)
                .anyMatch(m -> m.getName().contains("create") ||
                        m.getName().contains("save") ||
                        m.getName().contains("find") ||
                        m.getName().contains("get") ||
                        m.getName().contains("update") ||
                        m.getName().contains("delete"));

        assertTrue(hasCrudMethods, "InvoiceItemDAOImpl should have CRUD methods");
    }
}
