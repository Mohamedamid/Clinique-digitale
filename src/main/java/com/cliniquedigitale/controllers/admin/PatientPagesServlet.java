package com.cliniquedigitale.controllers.admin;

import com.cliniquedigitale.dto.PatientDTO;
import com.cliniquedigitale.entity.BloodType;
import com.cliniquedigitale.entity.Gender;
import com.cliniquedigitale.services.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet({
        "/admin/patients",
        "/admin/patients/save",
        "/admin/patients/edit",
        "/admin/patients/delete"
})
public class PatientPagesServlet extends HttpServlet {
    private final PatientService patientService = new PatientService();
    private final DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String userRole = (String) session.getAttribute("userRole");
        String path = req.getServletPath();

        if (path.startsWith("/admin/patients") && !"ADMIN".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            deletePatient(req, resp);
            return;
        }

        loadPatients(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        if ("/admin/patients/save".equals(path)) {
            String action = req.getParameter("action");
            if ("edit".equals(action)) {
                editPatient(req, resp);
            } else {
                createPatient(req, resp);
            }
        }
    }

    private void createPatient(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String cin = req.getParameter("cin");
            String dateOfBirthStr = req.getParameter("dateOfBirth");
            String genderStr = req.getParameter("gender");
            String bloodTypeStr = req.getParameter("bloodType");
            String insuranceNumber = req.getParameter("insuranceNumber");

            LocalDate birthDate = null;
            if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
                birthDate = LocalDate.parse(dateOfBirthStr, dateFormatter);
            }

            Gender gender = null;
            if (genderStr != null && !genderStr.trim().isEmpty()) {
                gender = Gender.valueOf(genderStr);
            }

            BloodType bloodType = null;
            if (bloodTypeStr != null && !bloodTypeStr.trim().isEmpty()) {
                bloodType = BloodType.valueOf(bloodTypeStr);
            }

            PatientDTO patientDTO = new PatientDTO(
                    email,
                    password,
                    fullName,
                    gender,
                    birthDate,
                    cin,
                    insuranceNumber,
                    bloodType
            );

            Map<String, String> errors = patientService.createPatient(patientDTO);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
            } else {
                req.setAttribute("success", "Patient created successfully!");
            }

        } catch (IllegalArgumentException e) {
            req.setAttribute("error", "Invalid enum value: " + e.getMessage());
        } catch (Exception e) {
            req.setAttribute("error", "Error creating patient: " + e.getMessage());
            e.printStackTrace();
        }

        loadPatients(req, resp);
    }

    private void editPatient(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                req.setAttribute("error", "Patient ID is required");
                loadPatients(req, resp);
                return;
            }

            Long id = Long.parseLong(idParam);
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String cin = req.getParameter("cin");
            String dateOfBirthStr = req.getParameter("dateOfBirth");
            String genderStr = req.getParameter("gender");
            String bloodTypeStr = req.getParameter("bloodType");
            String insuranceNumber = req.getParameter("insuranceNumber");

            LocalDate birthDate = null;
            if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
                birthDate = LocalDate.parse(dateOfBirthStr, dateFormatter);
            }

            Gender gender = null;
            if (genderStr != null && !genderStr.trim().isEmpty()) {
                gender = Gender.valueOf(genderStr);
            }

            BloodType bloodType = null;
            if (bloodTypeStr != null && !bloodTypeStr.trim().isEmpty()) {
                bloodType = BloodType.valueOf(bloodTypeStr);
            }

            PatientDTO patientDTO = new PatientDTO(
                    email,
                    password,
                    fullName,
                    gender,
                    birthDate,
                    cin,
                    insuranceNumber,
                    bloodType
            );

            patientDTO.setId(id);

            Map<String, String> errors = patientService.edit(patientDTO);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
            } else {
                req.setAttribute("success", "Patient updated successfully!");
            }

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid ID format");
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", "Invalid enum value: " + e.getMessage());
        } catch (Exception e) {
            req.setAttribute("error", "Error updating patient: " + e.getMessage());
            e.printStackTrace();
        }

        loadPatients(req, resp);
    }

    private void deletePatient(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                req.setAttribute("error", "Patient ID is required");
                loadPatients(req, resp);
                return;
            }

            Long id = Long.parseLong(idParam);
            Map<String, String> errors = patientService.delete(id);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
            } else {
                req.setAttribute("success", "Patient deleted successfully!");
            }

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid ID format");
        } catch (Exception e) {
            req.setAttribute("error", "Error deleting patient: " + e.getMessage());
        }

        loadPatients(req, resp);
    }

    private void loadPatients(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String query = req.getParameter("q");
            List<PatientDTO> patients = patientService.getAllPatients();

            if (query != null && !query.isEmpty()) {
                String queryLower = query.toLowerCase();
                patients = patients.stream()
                        .filter(p -> p.getFullName().toLowerCase().contains(queryLower)
                                || p.getEmail().toLowerCase().contains(queryLower))
                        .collect(Collectors.toList());
            }

            req.setAttribute("patientList", patients);

            req.getRequestDispatcher("/views/admin/patients.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error loading data: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/patients.jsp").forward(req, resp);
        }
    }
}