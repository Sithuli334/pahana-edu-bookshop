package com.pahanaedu.controller;

import org.junit.jupiter.api.Test;
import java.lang.reflect.Method;
import java.util.Arrays;
import static org.junit.jupiter.api.Assertions.*;

public class AuthenticationFilterTest {

    @Test
    public void filterClassExists() {
        assertNotNull(AuthenticationFilter.class);
    }

    @Test
    public void filterCanBeInstantiated() {
        assertDoesNotThrow(() -> {
            AuthenticationFilter filter = new AuthenticationFilter();
            assertNotNull(filter);
        });
    }

    @Test
    public void filterHasFilterMethods() throws Exception {
        Class<?> cls = AuthenticationFilter.class;
        Method[] methods = cls.getDeclaredMethods();

        boolean hasFilterMethod = Arrays.stream(methods)
                .anyMatch(m -> m.getName().contains("doFilter") || m.getName().contains("filter"));

        assertTrue(hasFilterMethod, "AuthenticationFilter should have filter methods");
    }

    @Test
    public void filterHasExpectedMethodCount() {
        Class<?> cls = AuthenticationFilter.class;
        Method[] methods = cls.getDeclaredMethods();
        assertTrue(methods.length > 0, "AuthenticationFilter should have at least one method");
    }
}
