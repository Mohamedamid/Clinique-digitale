package com.cliniquedigitale.controllers;

import com.cliniquedigitale.dto.DepartmentDTO;
import com.cliniquedigitale.dto.SpecialiteDTO;
import com.cliniquedigitale.services.DepartmentService;
import com.cliniquedigitale.services.SpecialiteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet({
        "/admin/specialites",
        "/admin/specialites/save",
        "/admin/specialites/edit",
        "/admin/specialites/delete"
})
public class SpecialitePageServlet extends HttpServlet {

    private final SpecialiteService specialiteService = new SpecialiteService();
    private final DepartmentService departmentService = new DepartmentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            deleteSpecialite(req, resp);
            return;
        }

        loadSpecialitesAndDepartments(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            createSpecialite(req, resp);
        } else if ("edit".equals(action)) {
            editSpecialite(req, resp);
        }
    }

    private void createSpecialite(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Map<String, String> errors = new HashMap<>();

        try {
            String name = req.getParameter("name");
            String isActiveParam = req.getParameter("is_active");
            String description = req.getParameter("description");
            String departmentIdParam = req.getParameter("departmentId");

            if (name == null || description == null || departmentIdParam == null) {
                errors.put("system", "Missing required parameters");
                req.setAttribute("errors", errors);
                loadSpecialitesAndDepartments(req, resp);
                return;
            }

            Long departmentId = Long.parseLong(departmentIdParam);
            boolean active = "true".equalsIgnoreCase(isActiveParam);

            SpecialiteDTO specialiteDTO = new SpecialiteDTO(
                    null, name, active, description, departmentId, null
            );

            errors = specialiteService.save(specialiteDTO);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
            } else {
                req.setAttribute("success", "Specialty created successfully!");
            }

        } catch (NumberFormatException e) {
            errors.put("departmentId", "Invalid department selected");
            req.setAttribute("errors", errors);
        } catch (Exception e) {
            errors.put("system", "Error creating specialty: " + e.getMessage());
            req.setAttribute("errors", errors);
        }

        loadSpecialitesAndDepartments(req, resp);
    }

    private void editSpecialite(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Map<String, String> errors = new HashMap<>();

        try {
            Long id = Long.parseLong(req.getParameter("id"));
            String name = req.getParameter("name");
            String isActiveParam = req.getParameter("is_active");
            String description = req.getParameter("description");
            Long departmentId = Long.parseLong(req.getParameter("departmentId"));

            boolean active = "true".equalsIgnoreCase(isActiveParam);

            SpecialiteDTO specialiteDTO = new SpecialiteDTO(
                    id, name, active, description, departmentId, null
            );

            errors = specialiteService.edit(specialiteDTO);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
            } else {
                req.setAttribute("success", "Specialty updated successfully!");
            }

        } catch (NumberFormatException e) {
            errors.put("system", "Invalid ID format");
            req.setAttribute("errors", errors);
        } catch (Exception e) {
            errors.put("system", "Error updating specialty: " + e.getMessage());
            req.setAttribute("errors", errors);
        }

        loadSpecialitesAndDepartments(req, resp);
    }

    private void deleteSpecialite(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Map<String, String> errors = new HashMap<>();

        try {
            Long id = Long.parseLong(req.getParameter("id"));
            errors = specialiteService.delete(id);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
            } else {
                req.setAttribute("success", "Specialty deleted successfully!");
            }

        } catch (NumberFormatException e) {
            errors.put("id", "Invalid specialty ID");
            req.setAttribute("errors", errors);
        } catch (Exception e) {
            errors.put("system", "Error deleting specialty: " + e.getMessage());
            req.setAttribute("errors", errors);
        }

        loadSpecialitesAndDepartments(req, resp);
    }

    private void loadSpecialitesAndDepartments(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<SpecialiteDTO> specialites = specialiteService.getAllSpecialites();
            List<DepartmentDTO> departments = departmentService.getAllDepartments();

            req.setAttribute("specialiteList", specialites);
            req.setAttribute("departmentList", departments);

            req.getRequestDispatcher("/views/admin/specialites.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error loading data: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/specialites.jsp").forward(req, resp);
        }
    }
}