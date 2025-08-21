package com.pahanaedu.controller;

import com.pahanaedu.model.User;
import com.pahanaedu.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet for handling user registration
 */
@WebServlet(name = "registerServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() throws ServletException {
        authService = new AuthService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Forward to registration page
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String name = request.getParameter("name");

        // Validate input
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required");
            request.setAttribute("email", email);
            request.setAttribute("name", name);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Validate password confirmation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match");
            request.setAttribute("email", email);
            request.setAttribute("name", name);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        try {
            // Attempt to register user
            User user = authService.register(email.trim(), password, name.trim());

            // Registration successful - create session and redirect
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());

            response.sendRedirect(request.getContextPath() + "/dashboard");

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Registration failed: " + e.getMessage());
            request.setAttribute("email", email);
            request.setAttribute("name", name);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
}
