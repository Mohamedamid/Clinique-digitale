package com.cliniquedigitale.controllers.doctor;

import com.cliniquedigitale.entity.Availability;
import com.cliniquedigitale.entity.Doctor;
import com.cliniquedigitale.repository.DoctorRepository;
import com.cliniquedigitale.services.AvailabilityService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet({
        "/doctor/availability",
        "/doctor/availability/save",
        "/doctor/availability/edit",
        "/doctor/availability/delete",
})
public class AvailabilityServlet extends HttpServlet {
    private AvailabilityService availabilityService;
    private final DoctorRepository doctorRepository = new DoctorRepository();

    @Override
    public void init() throws ServletException {
        this.availabilityService = new AvailabilityService();
    }

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

        Long userId = (Long) session.getAttribute("userId");

        // Récupérer le doctorId d'abord
        Doctor doctor = doctorRepository.findByUserId(userId);

        Long doctorId = doctor.getId();

        String path = req.getServletPath();
        System.out.println("GET Request Path: " + path);

        if (path.equals("/doctor/availability")) {
            List<Availability> availabilities = availabilityService.getDoctorAvailability(doctorId);
            System.out.println(availabilities);
            req.setAttribute("availabilities", availabilities);
            req.getRequestDispatcher("/views/doctor/availability.jsp").forward(req, resp);
        } else {
            List<Availability> availabilities = availabilityService.getDoctorAvailability(doctorId);
            System.out.println(availabilities);
            req.setAttribute("availabilities", availabilities);
            req.getRequestDispatcher("/views/doctor/availability.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
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

        Long userId = (Long) session.getAttribute("userId");

        // Récupérer le doctorId d'abord
        Doctor doctor = doctorRepository.findByUserId(userId);

        Long doctorId = doctor.getId();

        if (doctor == null) {
            req.setAttribute("error", "Doctor profile not found");
            req.getRequestDispatcher("/views/doctor/availability.jsp").forward(req, resp);
            return;
        }


        String path = req.getServletPath();
        System.out.println("POST Request Path: " + path);

        switch (path) {
            case "/doctor/availability/save":
                saveAvailability(req, resp, doctorId);
                break;
            case "/doctor/availability/delete":
                deleteAvailability(req, resp);
                break;
            default:
                List<Availability> availabilities = availabilityService.getDoctorAvailability(doctorId);
                req.setAttribute("availabilities", availabilities);
                req.getRequestDispatcher("/views/doctor/availability.jsp").forward(req, resp);
                break;
        }
    }

    private void saveAvailability(HttpServletRequest req, HttpServletResponse resp, Long doctorId)
            throws ServletException, IOException {

        System.out.println("=== Starting saveAvailability ===");
        System.out.println("Using Doctor ID: " + doctorId);

        try {
            Map<String, String> errors = availabilityService.saveWeeklyAvailability(req.getParameterMap(), doctorId);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                System.out.println("Validation errors: " + errors);

                // Rester sur la page pour afficher les erreurs
                List<Availability> availabilities = availabilityService.getDoctorAvailability(doctorId);
                req.setAttribute("availabilities", availabilities);
                req.getRequestDispatcher("/views/doctor/availability.jsp").forward(req, resp);
                return;
            }

            // ✅ Redirection après succès
            resp.sendRedirect(req.getContextPath() + "/doctor/availability?success=1");
            return;

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de l'enregistrement: " + e.getMessage());
            req.getRequestDispatcher("/views/doctor/availability.jsp").forward(req, resp);
        }
    }


    private void deleteAvailability(HttpServletRequest req, HttpServletResponse resp)
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

        try {
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.trim().isEmpty()) {
                Long availabilityId = Long.parseLong(idParam);
                availabilityService.deleteAvailability(availabilityId);
                req.setAttribute("success", "Disponibilité supprimée avec succès!");
            } else {
                req.setAttribute("error", "ID de disponibilité manquant");
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "ID de disponibilité invalide");
        } catch (Exception e) {
            req.setAttribute("error", "Erreur lors de la suppression: " + e.getMessage());
        }

        Long userId = (Long) session.getAttribute("userId");
        Doctor doctor = doctorRepository.findByUserId(userId);
        if (doctor != null) {
            List<Availability> availabilities = availabilityService.getDoctorAvailability(doctor.getId());
            req.setAttribute("availabilities", availabilities);
        }
        req.setAttribute("activePage", "availability");
        req.getRequestDispatcher("/views/doctor/availability.jsp").forward(req, resp);
    }

//    private Long getCurrentDoctorId(HttpSession session) {
//        try {
//            Object doctorIdObj = session.getAttribute("doctorId");
//            if (doctorIdObj instanceof Long) {
//                return (Long) doctorIdObj;
//            } else if (doctorIdObj instanceof Integer) {
//                return ((Integer) doctorIdObj).longValue();
//            } else if (doctorIdObj instanceof String) {
//                return Long.parseLong((String) doctorIdObj);
//            }
//            return null;
//        } catch (Exception e) {
//            return null;
//        }
//    }
}