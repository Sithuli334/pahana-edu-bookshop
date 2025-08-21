package com.pahanaedu.model;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class CustomerTest {

    @Test
    public void testConstructorAndUnitsConsumedDefault() {
        Customer c = new Customer("Alice", "a@example.com", "123", "Addr", "ACC1", Customer.CustomerType.INDIVIDUAL);
        assertEquals("Alice", c.getName());
        assertEquals(Customer.CustomerType.INDIVIDUAL, c.getCustomerType());
        assertEquals(BigDecimal.ZERO, c.getUnitsConsumed(), "New customer should have unitsConsumed 0 by default");
    }

    @Test
    public void testSetCustomerTypeAndGet() {
        Customer c = new Customer();
        c.setCustomerType(Customer.CustomerType.BUSINESS);
        assertEquals(Customer.CustomerType.BUSINESS, c.getCustomerType());
    }

    @Test
    public void testUnitsConsumedArithmetic() {
        Customer c = new Customer();
        c.setUnitsConsumed(new BigDecimal("5.5"));
        assertEquals(new BigDecimal("5.5"), c.getUnitsConsumed());
        c.setUnitsConsumed(c.getUnitsConsumed().add(new BigDecimal("4.5")));
        assertEquals(new BigDecimal("10.0"), c.getUnitsConsumed());
    }

    @Test
    public void testContactFields() {
        Customer c = new Customer();
        c.setEmail("bob@example.com");
        c.setPhone("0771234567");
        c.setTelephoneNumber("011-2345678");
        assertEquals("bob@example.com", c.getEmail());
        assertEquals("0771234567", c.getPhone());
        assertEquals("011-2345678", c.getTelephoneNumber());
    }

    @Test
    public void testAddressAndAccountNumber() {
        Customer c = new Customer();
        c.setAddress("123 Main St");
        c.setAccountNumber("ACCT-123");
        assertEquals("123 Main St", c.getAddress());
        assertEquals("ACCT-123", c.getAccountNumber());
    }

    @Test
    public void testCustomerTypeEnumCoverage() {
        // iterate all customer types to ensure enum exists and is stable
        for (Customer.CustomerType ct : Customer.CustomerType.values()) {
            assertNotNull(ct.name());
        }
    }

    @Test
    public void testNegativeUnitsConsumedAllowed() {
        Customer c = new Customer();
        c.setUnitsConsumed(new java.math.BigDecimal("-5.0"));
        assertEquals(new java.math.BigDecimal("-5.0"), c.getUnitsConsumed());
    }
}
