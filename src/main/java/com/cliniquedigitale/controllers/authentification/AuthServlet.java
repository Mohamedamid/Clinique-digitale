package com.cliniquedigitale.controllers.authentification;

import com.cliniquedigitale.dto.LoginDTO;
import com.cliniquedigitale.dto.PatientDTO;
import com.cliniquedigitale.entity.BloodType;
import com.cliniquedigitale.entity.Gender;
import com.cliniquedigitale.entity.User;
import com.cliniquedigitale.services.AuthService;
import com.cliniquedigitale.services.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

@WebServlet({"/register", "/login", "/logout"})
public class AuthServlet extends HttpServlet {

    private AuthService authService = new AuthService();
    private PatientService patientService = new PatientService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/register":
                request.getRequestDispatcher("/views/Authentification/register.jsp").forward(request, response);
                break;
            case "/login":
                request.getRequestDispatcher("/views/Authentification/login.jsp").forward(request, response);
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
        String gender = req.getParameter("gender");
        String cin = req.getParameter("cin");
        String insuranceNumber = req.getParameter("insuranceNumber");
        String dateOfBirth = req.getParameter("dateOfBirth");
        String bloodType = req.getParameter("bloodType");

        PatientDTO registerPatientDTO = new PatientDTO(
                email, password, name, Gender.valueOf(gender),
                LocalDate.parse(dateOfBirth), cin,
                insuranceNumber, BloodType.valueOf(bloodType)
        );

        Map<String, String> errors = patientService.createPatient(registerPatientDTO);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/views/Authentification/register.jsp").forward(req, resp);
        } else {
            req.setAttribute("success", "Registration successful! Please login.");
            req.getRequestDispatcher("/views/Authentification/login.jsp").forward(req, resp);
        }
    }

    private void login(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");

        if (email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Email and password are required");
            req.getRequestDispatcher("/views/Authentification/login.jsp").forward(req, resp);
            return;
        }

        LoginDTO loginDTO = new LoginDTO(email, password);
        Map<String, String> errors = new HashMap<>();
        User user = authService.loginUser(loginDTO, errors);

        if (user == null) {
            req.setAttribute("errors", errors);
            req.setAttribute("error", "Invalid email or password");
            req.getRequestDispatcher("/views/Authentification/login.jsp").forward(req, resp);
        } else {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userName", user.getFullName());
            session.setAttribute("userRole", user.getRole().name());

            session.setMaxInactiveInterval(30 * 60);

            if ("on".equals(remember)) {
                session.setMaxInactiveInterval(30 * 24 * 60 * 60);
            }

            String role = user.getRole().name();

            switch (role) {
                case "ADMIN":
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                    break;
                case "PATIENT":
                    resp.sendRedirect(req.getContextPath() + "/patient/dashboard");
                    break;
                case "DOCTOR":
                    resp.sendRedirect(req.getContextPath() + "/doctor/dashboard");
                    break;
                case "STAFF":
                    resp.sendRedirect(req.getContextPath() + "/staff/dashboard");
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/");
            }
        }
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