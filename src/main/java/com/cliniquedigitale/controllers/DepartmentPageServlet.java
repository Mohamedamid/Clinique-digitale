package com.cliniquedigitale.controllers;

import com.cliniquedigitale.dto.DepartmentDTO;
import com.cliniquedigitale.services.DepartmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet({
        "/admin/departments",
        "/admin/departments/save",
        "/admin/departments/edit",
        "/admin/departments/delete"
})
public class DepartmentPageServlet extends HttpServlet {

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
            deleteDepartment(req, resp);
            return;
        }

        List<DepartmentDTO> departments = departmentService.getAllDepartments();
        req.setAttribute("departmentList", departments);
        req.getRequestDispatcher("/views/admin/departments.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            createDepartment(req, resp);
        } else if ("edit".equals(action)) {
            editDepartment(req, resp);
        }
    }

    private void createDepartment(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String isActiveParam = req.getParameter("is_active");
        String description = req.getParameter("description");

        boolean active = "true".equalsIgnoreCase(isActiveParam);
        DepartmentDTO departmentDTO = new DepartmentDTO(null ,name, active, description, null);

        Map<String, String> errors = departmentService.save(departmentDTO);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
        } else {
            req.setAttribute("success", "Department created successfully!");
        }

        List<DepartmentDTO> departments = departmentService.getAllDepartments();
        req.setAttribute("departmentList", departments);
        req.getRequestDispatcher("/views/admin/departments.jsp").forward(req, resp);
    }

    private void editDepartment(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Long id = Long.parseLong( req.getParameter("id"));
        String name = req.getParameter("name");
        String isActiveParam = req.getParameter("is_active");
        String description = req.getParameter("description");

        boolean active = "true".equalsIgnoreCase(isActiveParam);
        DepartmentDTO departmentDTO = new DepartmentDTO(id, name, active, description, null);

        Map<String, String> errors = departmentService.edit(departmentDTO);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
        } else {
            req.setAttribute("success", "Department updated successfully!");
        }

        List<DepartmentDTO> departments = departmentService.getAllDepartments();
        req.setAttribute("departmentList", departments);
        req.getRequestDispatcher("/views/admin/departments.jsp").forward(req, resp);
    }

    private void deleteDepartment(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Long id = Long.parseLong(req.getParameter("id"));
        Map<String, String> errors = departmentService.delete(id);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
        } else {
            req.setAttribute("success", "Department deleted successfully!");
        }

        List<DepartmentDTO> departments = departmentService.getAllDepartments();
        req.setAttribute("departmentList", departments);
        req.getRequestDispatcher("/views/admin/departments.jsp").forward(req, resp);
    }
}
