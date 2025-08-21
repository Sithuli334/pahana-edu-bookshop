package com.pahanaedu.dao;

import org.junit.jupiter.api.Test;
import java.lang.reflect.Method;
import java.util.Arrays;
import static org.junit.jupiter.api.Assertions.*;

public class InvoiceDAOImplTest {

    @Test
    public void daoImplClassExists() {
        assertNotNull(InvoiceDAOImpl.class);
        assertFalse(InvoiceDAOImpl.class.isInterface(), "InvoiceDAOImpl should be a concrete class");
    }

    @Test
    public void daoImplImplementsInterface() {
        Class<?>[] interfaces = InvoiceDAOImpl.class.getInterfaces();
        boolean implementsInvoiceDAO = Arrays.stream(interfaces)
                .anyMatch(i -> i.equals(InvoiceDAO.class));

        assertTrue(implementsInvoiceDAO, "InvoiceDAOImpl should implement InvoiceDAO interface");
    }

    @Test
    public void daoImplCanBeInstantiated() {
        assertDoesNotThrow(() -> {
            InvoiceDAOImpl dao = new InvoiceDAOImpl();
            assertNotNull(dao);
        });
    }

    @Test
    public void daoImplHasCrudMethods() throws Exception {
        Class<?> cls = InvoiceDAOImpl.class;
        Method[] methods = cls.getDeclaredMethods();

        boolean hasCrudMethods = Arrays.stream(methods)
                .anyMatch(m -> m.getName().contains("create") ||
                        m.getName().contains("save") ||
                        m.getName().contains("find") ||
                        m.getName().contains("get") ||
                        m.getName().contains("update") ||
                        m.getName().contains("delete"));

        assertTrue(hasCrudMethods, "InvoiceDAOImpl should have CRUD methods");
    }
}
