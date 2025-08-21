package com.pahanaedu.model;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class ItemTest {

    @Test
    public void beanSettersAndGetters() {
        Item it = new Item();
        it.setName("Notebook");
        it.setCode("NB01");
        it.setPrice(new BigDecimal("12.34"));
        it.setStockQuantity(5);
        it.setActive(true);

        assertEquals("Notebook", it.getName());
        assertEquals("NB01", it.getCode());
        assertEquals(new BigDecimal("12.34"), it.getPrice());
        assertEquals(5, it.getStockQuantity());
        assertTrue(it.isActive());
    }

    @Test
    public void stockQuantityEdgeCases() {
        Item it = new Item();
        it.setStockQuantity(0);
        assertEquals(0, it.getStockQuantity());
        it.setStockQuantity(-1);
        assertEquals(-1, it.getStockQuantity());
    }
}
