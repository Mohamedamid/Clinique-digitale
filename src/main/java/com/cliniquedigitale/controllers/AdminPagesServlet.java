package com.cliniquedigitale.controllers;

import com.cliniquedigitale.dto.UserDTO;
import com.cliniquedigitale.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet({"/admin/dashboard", "/admin/users"})
public class AdminPagesServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String userRole = (String) session.getAttribute("userRole");
        if (!"ADMIN".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String path = req.getServletPath();

        switch (path) {
            case "/admin/dashboard":
                req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, resp);
                break;
            case "/admin/users":
                List<UserDTO> users = userService.getAllUser();
                req.setAttribute("userList", users);
                req.getRequestDispatcher("/views/admin/users.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }
}