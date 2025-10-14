package com.cliniquedigitale.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet({"/staff/dashboard"})
public class StaffPagesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String userRole = (String) session.getAttribute("userRole");

        if (!"STAFF".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String path = req.getServletPath();

        switch (path) {
            case "/staff/dashboard":
                req.getRequestDispatcher("/views/staff/dashboard.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/staff/dashboard");
        }
    }
}