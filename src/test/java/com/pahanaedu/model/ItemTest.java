package com.pahanaedu.model;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class ItemTest {

    @Test
    public void testConstructorDefaults() {
        Item it = new Item("Pen", "PEN01", "Blue ink pen", new BigDecimal("1.25"), "pcs");
        assertTrue(it.isActive(), "New item should be active by default");
        assertEquals(0, it.getStockQuantity(), "New item should have stockQuantity 0 by default");
        assertEquals(new BigDecimal("1.25"), it.getPrice());
    }

    @Test
    public void testSetPriceAndGet() {
        Item it = new Item();
        it.setPrice(new BigDecimal("9.99"));
        assertEquals(new BigDecimal("9.99"), it.getPrice());
    }

    @Test
    public void testActivateDeactivate() {
        Item it = new Item();
        it.setActive(false);
        assertFalse(it.isActive());
        it.setActive(true);
        assertTrue(it.isActive());
    }

    @Test
    public void testStockQuantitySetters() {
        Item it = new Item();
        it.setStockQuantity(10);
        assertEquals(10, it.getStockQuantity());
        it.setStockQuantity(0);
        assertEquals(0, it.getStockQuantity());
    }

    @Test
    public void testNameAndCodeSetters() {
        Item it = new Item();
        it.setName("Notebook");
        it.setCode("NB01");
        assertEquals("Notebook", it.getName());
        assertEquals("NB01", it.getCode());
    }

    @Test
    public void testCreatedUpdatedTimestamps() {
        Item it = new Item();
        assertNull(it.getCreatedAt());
        assertNull(it.getUpdatedAt());
        java.time.LocalDateTime now = java.time.LocalDateTime.now();
        it.setCreatedAt(now);
        it.setUpdatedAt(now);
        assertEquals(now, it.getCreatedAt());
        assertEquals(now, it.getUpdatedAt());
    }

    @Test
    public void testUnitGetterSetter() {
        Item it = new Item();
        it.setUnit("box");
        assertEquals("box", it.getUnit());
    }

    @Test
    public void testDescriptionSetterGetter() {
        Item it = new Item();
        it.setDescription("A fine item");
        assertEquals("A fine item", it.getDescription());
    }
}
