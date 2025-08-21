package com.pahanaedu.controller;

import com.pahanaedu.util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Database test servlet to verify connection and tables
 */
@WebServlet(name = "dbTestServlet", value = "/dbtest")
public class DatabaseTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Database Test</title></head><body>");
        out.println("<h1>Pahana Edu Billing System - Database Test</h1>");

        try {
            // Test basic connection
            boolean connectionOk = DatabaseConnection.testConnection();
            out.println("<h2>Connection Test: " + (connectionOk ? "✅ SUCCESS" : "❌ FAILED") + "</h2>");

            if (connectionOk) {
                try (Connection conn = DatabaseConnection.getConnection();
                     Statement stmt = conn.createStatement()) {

                    // Test tables existence
                    out.println("<h3>Table Check:</h3>");
                    String[] tables = {"users", "customers", "items", "invoices", "invoice_items"};

                    for (String table : tables) {
                        try {
                            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM " + table);
                            if (rs.next()) {
                                int count = rs.getInt("count");
                                out.println("<p>✅ Table '" + table + "' exists with " + count + " records</p>");
                            }
                            rs.close();
                        } catch (Exception e) {
                            out.println("<p>❌ Table '" + table + "' does not exist or error: " + e.getMessage() + "</p>");
                        }
                    }

                    // Test sample data
                    out.println("<h3>Sample Data Check:</h3>");
                    try {
                        ResultSet rs = stmt.executeQuery("SELECT email, name FROM users LIMIT 5");
                        out.println("<p><strong>Users:</strong></p><ul>");
                        while (rs.next()) {
                            out.println("<li>" + rs.getString("email") + " - " + rs.getString("name") + "</li>");
                        }
                        out.println("</ul>");
                        rs.close();
                    } catch (Exception e) {
                        out.println("<p>❌ Error reading users: " + e.getMessage() + "</p>");
                    }
                }
            }

        } catch (Exception e) {
            out.println("<h2>❌ Database Error:</h2>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            e.printStackTrace();
        }

        out.println("<hr>");
        out.println("<h3>Instructions to Fix:</h3>");
        out.println("<ol>");
        out.println("<li>Make sure MySQL is running on localhost:3306</li>");
        out.println("<li>Run the database setup script: <code>database/setup_simple.sql</code></li>");
        out.println("<li>Update password in DatabaseConnection.java if needed</li>");
        out.println("<li>Refresh this page to test again</li>");
        out.println("</ol>");

        out.println("<p><a href='" + request.getContextPath() + "/login'>Go to Login Page</a></p>");
        out.println("</body></html>");
    }
}
