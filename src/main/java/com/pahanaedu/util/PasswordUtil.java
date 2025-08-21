package com.pahanaedu.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

/**
 * Password utility for secure hashing and verification
 * Uses SHA-256 with salt for password security
 */
public class PasswordUtil {

    private static final String ALGORITHM = "SHA-256";
    private static final int SALT_LENGTH = 16;

    /**
     * Generate a random salt
     * @return byte array containing the salt
     */
    private static byte[] generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[SALT_LENGTH];
        random.nextBytes(salt);
        return salt;
    }

    /**
     * Convert byte array to hexadecimal string
     * @param bytes byte array to convert
     * @return hexadecimal string representation
     */
    private static String bytesToHex(byte[] bytes) {
        StringBuilder result = new StringBuilder();
        for (byte b : bytes) {
            result.append(String.format("%02x", b));
        }
        return result.toString();
    }

    /**
     * Convert hexadecimal string to byte array
     * @param hex hexadecimal string
     * @return byte array
     */
    private static byte[] hexToBytes(String hex) {
        int len = hex.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(hex.charAt(i), 16) << 4)
                    + Character.digit(hex.charAt(i + 1), 16));
        }
        return data;
    }

    /**
     * Hash password with salt
     * @param password plain text password
     * @param salt salt bytes
     * @return hashed password as hex string
     */
    private static String hashPassword(String password, byte[] salt) {
        try {
            MessageDigest md = MessageDigest.getInstance(ALGORITHM);
            md.update(salt);
            byte[] hashedPassword = md.digest(password.getBytes(StandardCharsets.UTF_8));
            return bytesToHex(hashedPassword);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not available", e);
        }
    }

    /**
     * Hash a password for storage
     * @param password plain text password
     * @return salted hash in format: salt$hash
     */
    public static String hashPassword(String password) {
        byte[] salt = generateSalt();
        String hashedPassword = hashPassword(password, salt);
        return bytesToHex(salt) + "$" + hashedPassword;
    }

    /**
     * Verify a password against a stored hash
     * @param password plain text password to verify
     * @param storedHash stored hash in format: salt$hash
     * @return true if password matches
     */
    public static boolean verifyPassword(String password, String storedHash) {
        try {
            String[] parts = storedHash.split("\\$");
            if (parts.length != 2) {
                return false;
            }

            byte[] salt = hexToBytes(parts[0]);
            String expectedHash = parts[1];
            String actualHash = hashPassword(password, salt);

            return expectedHash.equals(actualHash);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Simple hash for legacy passwords (used in sample data)
     * @param password plain text password
     * @return simple SHA-256 hash
     */
    public static String simpleHash(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance(ALGORITHM);
            byte[] hashedPassword = md.digest(password.getBytes(StandardCharsets.UTF_8));
            return bytesToHex(hashedPassword);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not available", e);
        }
    }
}
