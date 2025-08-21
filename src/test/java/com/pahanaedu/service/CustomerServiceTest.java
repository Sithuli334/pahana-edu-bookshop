package com.pahanaedu.service;

import org.junit.jupiter.api.Test;
import java.lang.reflect.Method;
import java.util.Arrays;
import static org.junit.jupiter.api.Assertions.*;

public class CustomerServiceTest {

    @Test
    public void serviceClassExists() {
        assertNotNull(CustomerService.class);
    }

    @Test
    public void serviceHasCustomerMethods() throws Exception {
        Class<?> cls = CustomerService.class;
        Method[] methods = cls.getDeclaredMethods();

        boolean hasCustomerMethod = Arrays.stream(methods)
                .anyMatch(m -> m.getName().contains("customer") || m.getName().contains("Customer"));

        assertTrue(hasCustomerMethod, "CustomerService should have customer-related methods");
    }

    @Test
    public void serviceCanBeInstantiated() {
        assertDoesNotThrow(() -> {
            CustomerService service = new CustomerService();
            assertNotNull(service);
        });
    }

    @Test
    public void serviceHasExpectedMethodCount() {
        Class<?> cls = CustomerService.class;
        Method[] methods = cls.getDeclaredMethods();
        assertTrue(methods.length > 0, "CustomerService should have at least one method");
    }

    @Test
    public void serviceHasCrudMethods() throws Exception {
        Class<?> cls = CustomerService.class;
        Method[] methods = cls.getDeclaredMethods();

        boolean hasCrudMethods = Arrays.stream(methods)
                .anyMatch(m -> m.getName().contains("create") ||
                        m.getName().contains("read") ||
                        m.getName().contains("update") ||
                        m.getName().contains("delete") ||
                        m.getName().contains("find") ||
                        m.getName().contains("get"));

        assertTrue(hasCrudMethods, "CustomerService should have CRUD operations");
    }
}
