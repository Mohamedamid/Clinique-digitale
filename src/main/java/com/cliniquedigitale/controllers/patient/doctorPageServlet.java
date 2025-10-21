package com.cliniquedigitale.controllers.patient;

import com.cliniquedigitale.entity.Doctor;
import com.cliniquedigitale.services.AvailabilityService;
import com.cliniquedigitale.services.DoctorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/patient/doctors/*")
public class doctorPageServlet extends HttpServlet {

    private final DoctorService doctorService = new DoctorService();
    private final AvailabilityService availabilityService = new AvailabilityService();

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

        String pathInfo = req.getPathInfo();
        System.out.println(pathInfo);

        Long doctorId = Long.parseLong(pathInfo.substring(1));
        Doctor doctor = doctorService.findDoctor(doctorId);
        System.out.println(doctor);

        if (doctor == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Doctor not found");
            return;
        }
        req.setAttribute("doctor", doctor);
        List<LocalDate> availableDays = availabilityService.generateAvailableDays(doctorId);
        req.setAttribute("availableDays", availableDays);
        req.getRequestDispatcher("/views/patient/doctors.jsp").forward(req, resp);
    }
}