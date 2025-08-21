package com.pahanaedu.dao;

import org.junit.jupiter.api.Test;
import java.lang.reflect.Method;
import java.util.Arrays;
import static org.junit.jupiter.api.Assertions.*;

public class CustomerDAOImplTest {

    @Test
    public void daoImplClassExists() {
        assertNotNull(CustomerDAOImpl.class);
        assertFalse(CustomerDAOImpl.class.isInterface(), "CustomerDAOImpl should be a concrete class");
    }

    @Test
    public void daoImplImplementsInterface() {
        Class<?>[] interfaces = CustomerDAOImpl.class.getInterfaces();
        boolean implementsCustomerDAO = Arrays.stream(interfaces)
                .anyMatch(i -> i.equals(CustomerDAO.class));

        assertTrue(implementsCustomerDAO, "CustomerDAOImpl should implement CustomerDAO interface");
    }

    @Test
    public void daoImplCanBeInstantiated() {
        assertDoesNotThrow(() -> {
            CustomerDAOImpl dao = new CustomerDAOImpl();
            assertNotNull(dao);
        });
    }

    @Test
    public void daoImplHasCrudMethods() throws Exception {
        Class<?> cls = CustomerDAOImpl.class;
        Method[] methods = cls.getDeclaredMethods();

        boolean hasCrudMethods = Arrays.stream(methods)
                .anyMatch(m -> m.getName().contains("create") ||
                        m.getName().contains("save") ||
                        m.getName().contains("find") ||
                        m.getName().contains("get") ||
                        m.getName().contains("update") ||
                        m.getName().contains("delete"));

        assertTrue(hasCrudMethods, "CustomerDAOImpl should have CRUD methods");
    }
}
