package com.pahanaedu.model;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class CustomerTest {

    @Test
    public void beanPropertiesWork() {
        Customer c = new Customer();
        c.setName("Alice");
        c.setEmail("alice@example.com");
        c.setAccountNumber("ACC-001");
        c.setUnitsConsumed(new BigDecimal("2.50"));

        assertEquals("Alice", c.getName());
        assertEquals("alice@example.com", c.getEmail());
        assertEquals("ACC-001", c.getAccountNumber());
        assertEquals(new BigDecimal("2.50"), c.getUnitsConsumed());
    }

    @Test
    public void customerTypeEnumExists() {
        Customer.CustomerType[] types = Customer.CustomerType.values();
        assertTrue(types.length >= 1, "CustomerType enum should contain at least one value");
    }

    @Test
    public void unitsConsumedNullHandledGracefully() {
        Customer c = new Customer();
        // model may allow null for unitsConsumed; ensure getter returns what was set
        c.setUnitsConsumed(null);
        assertNull(c.getUnitsConsumed());
    }
}
