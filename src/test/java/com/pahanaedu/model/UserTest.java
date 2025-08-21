package com.pahanaedu.model;

import org.junit.jupiter.api.Test;
import java.time.LocalDateTime;
import static org.junit.jupiter.api.Assertions.*;

public class UserTest {

    @Test
    public void beanPropertiesWork() {
        User user = new User();
        user.setName("testuser");
        user.setPassword("testpass");
        user.setEmail("test@example.com");
        user.setId(1);

        assertEquals("testuser", user.getName());
        assertEquals("testpass", user.getPassword());
        assertEquals("test@example.com", user.getEmail());
        assertEquals(1, user.getId());
    }

    @Test
    public void userCanBeCreatedWithDefaults() {
        User user = new User();
        assertNotNull(user);
        assertNull(user.getName());
        assertNull(user.getPassword());
        assertNull(user.getEmail());
        assertEquals(0, user.getId());
    }

    @Test
    public void userHandlesNullValues() {
        User user = new User();
        user.setName(null);
        user.setPassword(null);
        user.setEmail(null);

        assertNull(user.getName());
        assertNull(user.getPassword());
        assertNull(user.getEmail());
    }

    @Test
    public void userConstructorWithParametersWorks() {
        User user = new User("test@example.com", "password123", "Test User");
        assertEquals("test@example.com", user.getEmail());
        assertEquals("password123", user.getPassword());
        assertEquals("Test User", user.getName());
    }

    @Test
    public void userCreatedAtPropertyWorks() {
        User user = new User();
        LocalDateTime now = LocalDateTime.now();
        user.setCreatedAt(now);
        assertEquals(now, user.getCreatedAt());
    }
}
