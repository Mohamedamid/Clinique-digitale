package com.cliniquedigitale.controllers;

import com.cliniquedigitale.dto.RegisterPatientDTO;
import com.cliniquedigitale.entity.BloodType;
import com.cliniquedigitale.entity.Gender;
import com.cliniquedigitale.entity.Patient;
import com.cliniquedigitale.services.AuthService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Map;

@WebServlet({"/register", "/login", "/logout"})
public class PatientServlet extends HttpServlet {

    private AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/register":
                request.getRequestDispatcher("/WEB-INF/views/patient/register.jsp").forward(request, response);
                break;
            case "/login":
                request.getRequestDispatcher("/WEB-INF/views/patient/login.jsp").forward(request, response);
                break;
            case "/logout":
                logout(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("register".equals(action)) {
            register(req, resp);
        } else if ("login".equals(action)) {
            login(req, resp);
        }
    }

    private void register(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("fullName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String gender = req.getParameter("gender");
        String cin = req.getParameter("cin");
        String insuranceNumber = req.getParameter("insuranceNumber");
        String dateOfBirth = req.getParameter("dateOfBirth");
        String bloodType = req.getParameter("bloodType");

        RegisterPatientDTO registerPatientDTO = new RegisterPatientDTO(
                email, password, name, Gender.valueOf(gender),
                LocalDate.parse(dateOfBirth), phone, cin,
                insuranceNumber, BloodType.valueOf(bloodType)
        );

        Map<String, String> errors = authService.registerPatient(registerPatientDTO);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/WEB-INF/views/patient/register.jsp").forward(req, resp);
        } else {
            req.setAttribute("success", "Registration successful! Please login.");
            req.getRequestDispatcher("/WEB-INF/views/patient/login.jsp").forward(req, resp);
        }
    }

    private void login(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");

        // Validate inputs
        if (email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Email and password are required");
            req.getRequestDispatcher("/WEB-INF/views/patient/login.jsp").forward(req, resp);
            return;
        }

        // Authenticate user
//        Patient patient = authService.loginPatient(email, password);
//
//        if (patient != null) {
//            // Create session
//            HttpSession session = req.getSession();
//            session.setAttribute("user", patient);
//            session.setAttribute("userId", patient.getId());
//            session.setAttribute("userEmail", patient.getUser().getEmail());
//            session.setAttribute("userName", patient.getUser().getFullName());
//            session.setAttribute("userRole", "PATIENT");
//
//            // Set session timeout (30 minutes)
//            session.setMaxInactiveInterval(30 * 60);
//
//            // Handle "Remember Me"
//            if ("on".equals(remember)) {
//                session.setMaxInactiveInterval(30 * 24 * 60 * 60); // 30 days
//            }
//
//            // Redirect to patient dashboard
//            resp.sendRedirect(req.getContextPath() + "/patient/dashboard");
//        } else {
//            req.setAttribute("error", "Invalid email or password");
//            req.getRequestDispatcher("/WEB-INF/views/patient/login.jsp").forward(req, resp);
//        }
    }

    private void logout(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        resp.sendRedirect(req.getContextPath() + "/login?success=Logged out successfully");
    }
}