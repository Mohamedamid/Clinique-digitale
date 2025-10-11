package com.cliniquedigitale.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet({"/patient/dashboard", "/patient/appointments", "/patient/doctors", "/patient/records"})
public class PatientPagesServlet extends HttpServlet {

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

        if (!"PATIENT".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        // Forward based on path
        String path = req.getServletPath();

        switch (path) {
            case "/patient/dashboard":
                req.getRequestDispatcher("/WEB-INF/views/patient/dashboard.jsp").forward(req, resp);
                break;
            case "/patient/appointments":
                req.getRequestDispatcher("/WEB-INF/views/patient/appointments.jsp").forward(req, resp);
                break;
            case "/patient/doctors":
                req.getRequestDispatcher("/WEB-INF/views/patient/doctors.jsp").forward(req, resp);
                break;
            case "/patient/records":
                req.getRequestDispatcher("/WEB-INF/views/patient/records.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/patient/dashboard");
        }
    }
}