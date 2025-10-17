package com.cliniquedigitale.controllers.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/appointments")
public class AppointmentsPageServlet extends HttpServlet {   // ✅ extends HttpServlet

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // هنا لاحقاً غادي نجيب list appointments من service
        // List<AppointmentDTO> appointments = appointmentService.getAll();
        // req.setAttribute("appointments", appointments);

        req.getRequestDispatcher("/views/admin/appointments.jsp").forward(req, resp);
    }
}
