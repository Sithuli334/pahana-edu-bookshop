package com.pahanaedu.service;

import org.junit.jupiter.api.Test;

import java.lang.reflect.Method;
import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;

public class InvoiceServiceTest {

    @Test
    public void serviceHasCreateAndAddMethods() throws Exception {
        Class<?> cls = InvoiceService.class;
        Method create = Arrays.stream(cls.getDeclaredMethods())
                .filter(m -> m.getName().equals("createInvoice"))
                .findFirst().orElse(null);
        Method add = Arrays.stream(cls.getDeclaredMethods())
                .filter(m -> m.getName().equals("addItemToInvoice"))
                .findFirst().orElse(null);

        assertNotNull(create, "InvoiceService should have a createInvoice method");
        assertNotNull(add, "InvoiceService should have an addItemToInvoice method");
    }
}
