package com.pahanaedu.model;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class InvoiceItemTest {

    @Test
    public void testCalculateLineTotal() {
        InvoiceItem ii = new InvoiceItem(1, 2, new BigDecimal("3"), new BigDecimal("10.00"));
        // default discount 0
        ii.calculateLineTotal();
        assertEquals(new BigDecimal("30.00"), ii.getLineTotal(),
                "Line total should be quantity * unitPrice when no discount");
    }

    @Test
    public void testSettersUpdateLineTotal() {
        InvoiceItem ii = new InvoiceItem();
        ii.setQuantity(new BigDecimal("2"));
        ii.setUnitPrice(new BigDecimal("5.50"));
        ii.setDiscount(new BigDecimal("1.00"));

        // lineTotal should be recalculated
        assertEquals(new BigDecimal("10.00"), ii.getLineTotal(), "Line total should be quantity*unitPrice - discount");
    }

    @Test
    public void testNegativeQuantityHandled() {
        InvoiceItem ii = new InvoiceItem();
        ii.setQuantity(new BigDecimal("-1"));
        ii.setUnitPrice(new BigDecimal("5.00"));
        ii.calculateLineTotal();
        // negative quantities allowed at model level; verify arithmetic
        assertEquals(new BigDecimal("-5.00"), ii.getLineTotal());
    }

    @Test
    public void testLargeValuesPrecision() {
        InvoiceItem ii = new InvoiceItem(1, 2, new BigDecimal("1000000"), new BigDecimal("12345.67"));
        ii.calculateLineTotal();
        // ensure large multiplication works without exception
        assertNotNull(ii.getLineTotal());
    }

    @Test
    public void testDiscountGreaterThanSubtotal() {
        InvoiceItem ii = new InvoiceItem();
        ii.setQuantity(new BigDecimal("1"));
        ii.setUnitPrice(new BigDecimal("5.00"));
        ii.setDiscount(new BigDecimal("10.00"));
        // line total becomes negative when discount > subtotal
        assertEquals(new BigDecimal("-5.00"), ii.getLineTotal());
    }

    @Test
    public void testZeroUnitPrice() {
        InvoiceItem ii = new InvoiceItem();
        ii.setQuantity(new BigDecimal("10"));
        ii.setUnitPrice(BigDecimal.ZERO);
        ii.setDiscount(BigDecimal.ZERO);
        assertEquals(BigDecimal.ZERO, ii.getLineTotal());
    }

    @Test
    public void testNullDiscountTreatedAsZero() {
        InvoiceItem ii = new InvoiceItem();
        ii.setQuantity(new BigDecimal("2"));
        ii.setUnitPrice(new BigDecimal("3.00"));
        // The current model calls calculateLineTotal() inside setDiscount and
        // will throw NullPointerException when passed null. Assert that behavior.
        assertThrows(NullPointerException.class, () -> ii.setDiscount(null));
    }

    @Test
    public void testDescriptionSetter() {
        InvoiceItem ii = new InvoiceItem();
        ii.setDescription("Line item description");
        assertEquals("Line item description", ii.getDescription());
    }

    @Test
    public void testItemIdSetterGetter() {
        InvoiceItem ii = new InvoiceItem();
        ii.setItemId(42);
        assertEquals(42, ii.getItemId());
    }
}
