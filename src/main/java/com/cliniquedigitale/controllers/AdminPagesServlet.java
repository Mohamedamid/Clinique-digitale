package com.cliniquedigitale.controllers;

import com.cliniquedigitale.dto.SpecialiteDTO;
import com.cliniquedigitale.dto.UserDTO;
import com.cliniquedigitale.services.SpecialiteService;
import com.cliniquedigitale.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet({"/admin/dashboard", "/admin/users"})
public class AdminPagesServlet extends HttpServlet {
    private final UserService userService = new UserService();
    private final SpecialiteService specialiteService = new SpecialiteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Check session
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Check role
        String userRole = (String) session.getAttribute("userRole");

        if (!"ADMIN".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        // Forward based on path
        String path = req.getServletPath();

        switch (path) {
            case "/admin/dashboard":
                req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, resp);
                break;
            case "/admin/users":
                // Filtering and searching
                String role = req.getParameter("role");
                String query = req.getParameter("q");

                List<UserDTO> users = userService.getAllUser();

                if (role != null && !role.isEmpty()) {
                    users = users.stream()
                            .filter(u -> u.getRole().toString().equalsIgnoreCase(role))
                            .collect(Collectors.toList());
                }
                if (query != null && !query.isEmpty()) {
                    String queryLower = query.toLowerCase();
                    users = users.stream()
                            .filter(u -> u.getFullName().toLowerCase().contains(queryLower)
                                    || u.getEmail().toLowerCase().contains(queryLower))
                            .collect(Collectors.toList());
                }

                List<SpecialiteDTO> specialites = specialiteService.getAllSpecialites();
                req.setAttribute("specialiteList", specialites);
                req.setAttribute("userList", users);
                req.getRequestDispatcher("/views/admin/users.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }
}