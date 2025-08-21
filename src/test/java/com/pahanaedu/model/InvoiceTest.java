package com.pahanaedu.model;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

public class InvoiceTest {

    @Test
    public void testDefaultConstructorDefaults() {
        Invoice inv = new Invoice();
        assertEquals(BigDecimal.ZERO, inv.getSubtotal());
        assertEquals(Invoice.PaymentStatus.PENDING, inv.getPaymentStatus());
        assertEquals("Net 30", inv.getPaymentTerms());
    }

    @Test
    public void testInvoiceConstructorFields() {
        LocalDate today = LocalDate.now();
        LocalDate due = today.plusDays(30);
        Invoice inv = new Invoice("INV-001", 5, today, due);
        assertEquals("INV-001", inv.getInvoiceNumber());
        assertEquals(5, inv.getCustomerId());
        assertEquals(today, inv.getInvoiceDate());
        assertEquals(due, inv.getDueDate());
    }

    @Test
    public void testPaymentStatusTransition() {
        Invoice inv = new Invoice();
        assertEquals(Invoice.PaymentStatus.PENDING, inv.getPaymentStatus());
        inv.setPaymentStatus(Invoice.PaymentStatus.PAID);
        assertEquals(Invoice.PaymentStatus.PAID, inv.getPaymentStatus());
    }

    @Test
    public void testSetAndGetTotals() {
        Invoice inv = new Invoice();
        inv.setSubtotal(new BigDecimal("100.00"));
        inv.setDiscountAmount(new BigDecimal("10.00"));
        inv.setTaxAmount(new BigDecimal("13.50"));
        inv.setTotalAmount(new BigDecimal("103.50"));

        assertEquals(new BigDecimal("100.00"), inv.getSubtotal());
        assertEquals(new BigDecimal("10.00"), inv.getDiscountAmount());
        assertEquals(new BigDecimal("13.50"), inv.getTaxAmount());
        assertEquals(new BigDecimal("103.50"), inv.getTotalAmount());
    }

    @Test
    public void testInvoiceNumberSetter() {
        Invoice inv = new Invoice();
        inv.setInvoiceNumber("INV-999");
        assertEquals("INV-999", inv.getInvoiceNumber());
    }

    @Test
    public void testDueDateAfterInvoiceDate() {
        LocalDate d = LocalDate.now();
        Invoice inv = new Invoice();
        inv.setInvoiceDate(d);
        inv.setDueDate(d.plusDays(10));
        assertTrue(inv.getDueDate().isAfter(inv.getInvoiceDate()));
    }

    @Test
    public void testNotesField() {
        Invoice inv = new Invoice();
        inv.setNotes("Payment due upon receipt");
        assertEquals("Payment due upon receipt", inv.getNotes());
    }

    @Test
    public void testCreatedUpdatedTimestamps() {
        Invoice inv = new Invoice();
        assertNull(inv.getCreatedAt());
        assertNull(inv.getUpdatedAt());
        java.time.LocalDateTime now = java.time.LocalDateTime.now();
        inv.setCreatedAt(now);
        inv.setUpdatedAt(now);
        assertEquals(now, inv.getCreatedAt());
        assertEquals(now, inv.getUpdatedAt());
    }
}
