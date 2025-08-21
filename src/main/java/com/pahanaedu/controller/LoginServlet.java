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
import java.util.Optional;

/**
 * Servlet for handling user login
 */
@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

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

        // Forward to login page
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email and password are required");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        try {
            // Attempt to authenticate user
            Optional<User> userOptional = authService.login(email.trim(), password);

            if (userOptional.isPresent()) {
                // Login successful - create session
                User user = userOptional.get();
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("userName", user.getName());

                // Redirect to dashboard
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                // Login failed
                request.setAttribute("errorMessage", "Invalid email or password");
                request.setAttribute("email", email); // Keep email in form
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Login failed: " + e.getMessage());
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}
