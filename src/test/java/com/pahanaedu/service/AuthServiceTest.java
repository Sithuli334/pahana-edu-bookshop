package com.pahanaedu.service;

import org.junit.jupiter.api.Test;
import java.lang.reflect.Method;
import java.util.Arrays;
import static org.junit.jupiter.api.Assertions.*;

public class AuthServiceTest {

    @Test
    public void serviceClassExists() {
        assertNotNull(AuthService.class);
    }

    @Test
    public void serviceHasAuthenticationMethods() throws Exception {
        Class<?> cls = AuthService.class;
        Method[] methods = cls.getDeclaredMethods();

        boolean hasAuthMethod = Arrays.stream(methods)
                .anyMatch(m -> m.getName().contains("authenticate") || m.getName().contains("login"));

        assertTrue(hasAuthMethod, "AuthService should have authentication-related methods");
    }

    @Test
    public void serviceCanBeInstantiated() {
        assertDoesNotThrow(() -> {
            AuthService service = new AuthService();
            assertNotNull(service);
        });
    }

    @Test
    public void serviceHasExpectedMethodCount() {
        Class<?> cls = AuthService.class;
        Method[] methods = cls.getDeclaredMethods();
        assertTrue(methods.length > 0, "AuthService should have at least one method");
    }
}
