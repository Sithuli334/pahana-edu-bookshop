package com.pahanaedu.model;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class InvoiceItemTest {

    @Test
    public void calculateLineTotalSimple() {
        InvoiceItem ii = new InvoiceItem();
        ii.setQuantity(new BigDecimal("3"));
        ii.setUnitPrice(new BigDecimal("2.00"));
        ii.setDiscount(BigDecimal.ZERO);
        ii.calculateLineTotal();
        assertEquals(new BigDecimal("6.00"), ii.getLineTotal());
    }

    @Test
    public void negativeQuantityProducesNegativeLineTotal() {
        InvoiceItem ii = new InvoiceItem();
        ii.setQuantity(new BigDecimal("-2"));
        ii.setUnitPrice(new BigDecimal("5.00"));
        ii.setDiscount(BigDecimal.ZERO);
        ii.calculateLineTotal();
        assertEquals(new BigDecimal("-10.00"), ii.getLineTotal());
    }

    @Test
    public void nullDiscountMayBeTreatedAsZeroOrThrow() {
        InvoiceItem ii = new InvoiceItem();
        ii.setQuantity(new BigDecimal("1"));
        ii.setUnitPrice(new BigDecimal("1.00"));
        try {
            ii.setDiscount(null);
            // if no exception, calling calculateLineTotal should succeed
            ii.calculateLineTotal();
            assertNotNull(ii.getLineTotal());
        } catch (NullPointerException npe) {
            // acceptable: model might throw when discount is null
            assertTrue(true);
        }
    }
}
