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

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String userRole = (String) session.getAttribute("userRole");

        if (!"PATIENT".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String path = req.getServletPath();

        switch (path) {
            case "/patient/dashboard":
                req.getRequestDispatcher("/views/patient/dashboard.jsp").forward(req, resp);
                break;
            case "/patient/appointments":
                req.getRequestDispatcher("/views/patient/appointments.jsp").forward(req, resp);
                break;
            case "/patient/doctors":
                req.getRequestDispatcher("/views/patient/doctors.jsp").forward(req, resp);
                break;
            case "/patient/records":
                req.getRequestDispatcher("/views/patient/records.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/patient/dashboard");
        }
    }
}