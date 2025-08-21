package com.pahanaedu.util;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class PasswordUtilTest {

    @Test
    public void simpleHashProducesNonEmptyHex() {
        String h = PasswordUtil.simpleHash("abc");
        assertNotNull(h);
        assertFalse(h.isEmpty());
        assertEquals(64, h.length(), "SHA-256 hex should be 64 characters if implementation uses SHA-256");
    }

    @Test
    public void hashAndVerifyRoundtrip() {
        String pw = "Secret!";
        String stored = PasswordUtil.hashPassword(pw);
        assertNotNull(stored);
        assertTrue(PasswordUtil.verifyPassword(pw, stored));
        assertFalse(PasswordUtil.verifyPassword("wrong", stored));
    }

    @Test
    public void verifyHandlesMalformedStoredValue() {
        assertFalse(PasswordUtil.verifyPassword("pw", "malformed"));
    }
}
