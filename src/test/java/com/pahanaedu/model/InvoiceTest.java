package com.pahanaedu.model;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

public class InvoiceTest {

    @Test
    public void defaultsAndSetters() {
        Invoice inv = new Invoice();
        assertNotNull(inv);
        inv.setInvoiceNumber("INV-100");
        inv.setCustomerId(10);
        inv.setSubtotal(new BigDecimal("50.00"));
        inv.setTaxAmount(new BigDecimal("7.50"));
        inv.setTotalAmount(new BigDecimal("57.50"));

        assertEquals("INV-100", inv.getInvoiceNumber());
        assertEquals(10, inv.getCustomerId());
        assertEquals(new BigDecimal("50.00"), inv.getSubtotal());
        assertEquals(new BigDecimal("7.50"), inv.getTaxAmount());
        assertEquals(new BigDecimal("57.50"), inv.getTotalAmount());
    }

    @Test
    public void datesCanBeSet() {
        Invoice inv = new Invoice();
        LocalDate now = LocalDate.now();
        inv.setInvoiceDate(now);
        inv.setDueDate(now.plusDays(15));
        assertEquals(now, inv.getInvoiceDate());
        assertEquals(now.plusDays(15), inv.getDueDate());
    }
}
