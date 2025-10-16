package com.cliniquedigitale.controllers.admin;

import com.cliniquedigitale.dto.DoctorDTO;
import com.cliniquedigitale.dto.SpecialiteDTO;
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
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet({
        "/admin/doctors",
        "/admin/doctors/save",
        "/admin/doctors/edit",
        "/admin/doctors/delete"
})
public class DoctorPagesServlet extends HttpServlet {
    private final DoctorService doctorService = new DoctorService();
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

        String userRole = (String) session.getAttribute("userRole");
        String path = req.getServletPath();

        if ("/doctor/dashboard".equals(path)) {
            if (!"DOCTOR".equals(userRole)) {
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            }
            req.getRequestDispatcher("/views/doctor/dashboard.jsp").forward(req, resp);
            return;
        }

        if (path.startsWith("/admin/doctors") && !"ADMIN".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            deleteDoctor(req, resp);
            return;
        }

        loadSpecialitesAndDoctors(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        if ("/admin/doctors/save".equals(path)) {
            String action = req.getParameter("action");
            if ("edit".equals(action)) {
                editDoctor(req, resp);
            } else {
                createDoctor(req, resp);
            }
        }
    }

    private void createDoctor(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String matricule = req.getParameter("matricule");
            String specialiteIdParam = req.getParameter("specialiteId");

            Long specialiteId = Long.parseLong(specialiteIdParam);

            DoctorDTO doctorDTO = new DoctorDTO(null, fullName, email, password, matricule, specialiteId, null);

            Map<String, String> errors = doctorService.save(doctorDTO);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
            } else {
                req.setAttribute("success", "Doctor created successfully!");
            }

        } catch (Exception e) {
            req.setAttribute("error", "Error creating doctor: " + e.getMessage());
        }

        loadSpecialitesAndDoctors(req, resp);
    }

    private void editDoctor(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                req.setAttribute("error", "Doctor ID is required");
                loadSpecialitesAndDoctors(req, resp);
                return;
            }

            Long id = Long.parseLong(idParam);
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String matricule = req.getParameter("matricule");
            String specialiteIdParam = req.getParameter("specialiteId");

            Long specialiteId = Long.parseLong(specialiteIdParam);

            DoctorDTO doctorDTO = new DoctorDTO(id, fullName, email, password, matricule, specialiteId, null);

            Map<String, String> errors = doctorService.edit(doctorDTO);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
            } else {
                req.setAttribute("success", "Doctor updated successfully!");
            }

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid ID format");
        } catch (Exception e) {
            req.setAttribute("error", "Error updating doctor: " + e.getMessage());
        }

        loadSpecialitesAndDoctors(req, resp);
    }

    private void deleteDoctor(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                req.setAttribute("error", "Doctor ID is required");
                loadSpecialitesAndDoctors(req, resp);
                return;
            }

            Long id = Long.parseLong(idParam);
            Map<String, String> errors = doctorService.delete(id);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
            } else {
                req.setAttribute("success", "Doctor deleted successfully!");
            }

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid ID format");
        } catch (Exception e) {
            req.setAttribute("error", "Error deleting doctor: " + e.getMessage());
        }

        loadSpecialitesAndDoctors(req, resp);
    }

    private void loadSpecialitesAndDoctors(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String query = req.getParameter("q");
            List<SpecialiteDTO> specialites = specialiteService.getAllSpecialites();
            List<DoctorDTO> doctors = doctorService.getAllDoctors();

            if (query != null && !query.isEmpty()) {

                String queryLower = query.toLowerCase();
                doctors = doctors.stream()
                        .filter(u -> u.getFullName().toLowerCase().contains(queryLower)
                                || u.getEmail().toLowerCase().contains(queryLower)
                                || u.getMatricule().toLowerCase().contains(queryLower))
                        .collect(Collectors.toList());
            }

            req.setAttribute("specialiteList", specialites);
            req.setAttribute("doctorList", doctors);
            req.getRequestDispatcher("/views/admin/doctors.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error loading data: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/doctors.jsp").forward(req, resp);
        }
    }
}