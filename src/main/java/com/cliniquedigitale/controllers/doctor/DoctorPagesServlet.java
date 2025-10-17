package com.cliniquedigitale.controllers.doctor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet({
        "/doctor/dashboard",
        "/doctor/notes",
        "/doctor/patients",
//        "/doctor/availability",
        "/doctor/appointments",
})
public class DoctorPagesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String userRole = (String) session.getAttribute("userRole");

        if (!"DOCTOR".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String path = req.getServletPath();

        switch (path) {
            case "/doctor/dashboard":
                req.getRequestDispatcher("/views/doctor/dashboard.jsp").forward(req, resp);
                break;
            case "/doctor/appointments":
                req.getRequestDispatcher("/views/doctor/appointments.jsp").forward(req, resp);
                break;
            case "/doctor/availability":
                req.getRequestDispatcher("/views/doctor/availability.jsp").forward(req, resp);
                break;
            case "/doctor/patients":
                req.getRequestDispatcher("/views/doctor/patients.jsp").forward(req, resp);
                break;
            case "/doctor/notes":
                req.getRequestDispatcher("/views/doctor/notes.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/doctor/dashboard");
        }
    }
}