package com.cliniquedigitale.controllers.admin;

import com.cliniquedigitale.dto.StaffDTO;
import com.cliniquedigitale.services.StaffService;
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
import java.util.stream.Collectors;

@WebServlet({
        "/admin/staff",
        "/admin/staff/save",
        "/admin/staff/edit",
        "/admin/staff/delete"
})
public class StaffPagesServlet extends HttpServlet {
    private final StaffService staffService = new StaffService();

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

        if ("/staff/dashboard".equals(path)) {
            if (!"STAFF".equals(userRole)) {
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            }
            req.getRequestDispatcher("/views/staff/dashboard.jsp").forward(req, resp);
            return;
        }

        if (path.startsWith("/admin/staff") && !"ADMIN".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            deleteStaff(req, resp);
            return;
        }

        loadSpecialitesAndStaffs(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        if ("/admin/staff/save".equals(path)) {
            String action = req.getParameter("action");
            if ("edit".equals(action)) {
                editStaff(req, resp);
            } else {
                createStaff(req, resp);
            }
        }
    }

    private void createStaff(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String position = req.getParameter("position");

            StaffDTO staffDTO = new StaffDTO(null, fullName, email, password, position);

            Map<String, String> errors = staffService.save(staffDTO);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
            } else {
                req.setAttribute("success", "Staff created successfully!");
            }

        } catch (Exception e) {
            req.setAttribute("error", "Error creating staff: " + e.getMessage());
        }

        loadSpecialitesAndStaffs(req, resp);
    }

    private void editStaff(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                req.setAttribute("error", "Staff ID is required");
                loadSpecialitesAndStaffs(req, resp);
                return;
            }

            Long id = Long.parseLong(idParam);
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String position = req.getParameter("position");

            StaffDTO staffDTO = new StaffDTO(id, fullName, email, password, position);

            Map<String, String> errors = staffService.edit(staffDTO);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
            } else {
                req.setAttribute("success", "Staff updated successfully!");
            }

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid ID format");
        } catch (Exception e) {
            req.setAttribute("error", "Error updating staff: " + e.getMessage());
        }

        loadSpecialitesAndStaffs(req, resp);
    }

    private void deleteStaff(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                req.setAttribute("error", "Staff ID is required");
                loadSpecialitesAndStaffs(req, resp);
                return;
            }

            Long id = Long.parseLong(idParam);
            Map<String, String> errors = staffService.delete(id);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
            } else {
                req.setAttribute("success", "Staff deleted successfully!");
            }

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid ID format");
        } catch (Exception e) {
            req.setAttribute("error", "Error deleting staff: " + e.getMessage());
        }

        loadSpecialitesAndStaffs(req, resp);
    }

    private void loadSpecialitesAndStaffs(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String query = req.getParameter("q");
            List<StaffDTO> staff = staffService.getAllStaff();

            if (query != null && !query.isEmpty()) {

                String queryLower = query.toLowerCase();
                staff = staff.stream()
                        .filter(u -> u.getFullName().toLowerCase().contains(queryLower)
                                || u.getEmail().toLowerCase().contains(queryLower))
                        .collect(Collectors.toList());
            }
            System.out.println(staff);

            req.setAttribute("staffList", staff);
            req.getRequestDispatcher("/views/admin/staff.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error loading data: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/staff.jsp").forward(req, resp);
        }
    }
}