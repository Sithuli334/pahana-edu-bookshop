package com.pahanaedu.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Customer model class
 */
public class Customer {
    private int id;
    private String name;
    private String email;
    private String phone;
    private String address;
    private String notes;
    private String accountNumber;
    private CustomerType customerType;
    private String telephoneNumber;
    private BigDecimal unitsConsumed;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Enum for customer types
    public enum CustomerType {
        RESIDENTIAL, COMMERCIAL, INDUSTRIAL, INSTITUTION, INDIVIDUAL, FAMILY, BUSINESS
    }

    // Default constructor
    public Customer() {
    }

    // Constructor for new customer creation
    public Customer(String name, String email, String phone, String address,
            String accountNumber, CustomerType customerType) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.accountNumber = accountNumber;
        this.customerType = customerType;
        this.unitsConsumed = BigDecimal.ZERO;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public CustomerType getCustomerType() {
        return customerType;
    }

    public void setCustomerType(CustomerType customerType) {
        this.customerType = customerType;
    }

    public String getTelephoneNumber() {
        return telephoneNumber;
    }

    public void setTelephoneNumber(String telephoneNumber) {
        this.telephoneNumber = telephoneNumber;
    }

    public BigDecimal getUnitsConsumed() {
        return unitsConsumed;
    }

    public void setUnitsConsumed(BigDecimal unitsConsumed) {
        this.unitsConsumed = unitsConsumed;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
