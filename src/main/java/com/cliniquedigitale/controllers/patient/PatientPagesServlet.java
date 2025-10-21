package com.cliniquedigitale.controllers.patient;

import com.cliniquedigitale.dto.DoctorDTO;
import com.cliniquedigitale.dto.SpecialiteDTO;
import com.cliniquedigitale.services.AvailabilityService;
import com.cliniquedigitale.services.DoctorService;
import com.cliniquedigitale.services.SpecialiteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import java.util.List;

@WebServlet({"/patient/dashboard","/patient/index"})
public class PatientPagesServlet extends HttpServlet {
    private final SpecialiteService specialiteService = new SpecialiteService();
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

        String path = req.getServletPath();


        switch (path) {
            case "/patient/dashboard":
                req.getRequestDispatcher("/views/patient/dashboard.jsp").forward(req, resp);
                break;
            case "/patient/index":
                List<SpecialiteDTO> specialties = specialiteService.getAllSpecialites();
                List<DoctorDTO> doctors = doctorService.getAllDoctors();
                req.setAttribute("doctors",doctors);
                req.setAttribute("specialties", specialties);
                req.getRequestDispatcher("/views/patient/index.jsp").forward(req, resp);
                break;
            case "/patient/records":
                req.getRequestDispatcher("/views/patient/records.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/patient/dashboard");
        }
    }
}