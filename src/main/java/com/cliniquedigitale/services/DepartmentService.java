package com.cliniquedigitale.services;

import com.cliniquedigitale.dto.DepartmentDTO;
import com.cliniquedigitale.entity.Department;
import com.cliniquedigitale.mapper.DepartmentMapper;
import com.cliniquedigitale.repository.DepartmentRepository;
import com.cliniquedigitale.util.Validator;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class DepartmentService {

    private final DepartmentRepository departmentRepository = new DepartmentRepository();

    public List<DepartmentDTO> getAllDepartments() {
        List<Department> departments = departmentRepository.findAll();
        return departments.stream()
                .map(DepartmentMapper::toDTO)
                .collect(Collectors.toList());
    }

    public Map<String, String> save(DepartmentDTO dto) {
        Validator validator = new Validator();

        validator.required("name", dto.getName(), "Name is required");
        validator.required("description", dto.getDescription(), "Description is required");

        if (validator.hasErrors()) {
            return validator.getErrors();
        }

        Department newDepartment = DepartmentMapper.toEntity(dto);
        departmentRepository.save(newDepartment);

        return Map.of();
    }

    public Map<String, String> edit(DepartmentDTO dto) {
        Validator validator = new Validator();

        if (dto.getId() == null) {
            return Map.of("id", "Department ID is required for editing");
        }

        validator.required("name", dto.getName(), "Name is required");
        validator.required("description", dto.getDescription(), "Description is required");

        if (validator.hasErrors()) {
            return validator.getErrors();
        }

        try {
            Department existingDept = departmentRepository.findById(dto.getId());
            if (existingDept == null) {
                return Map.of("not_found", "Department not found");
            }

            Department updateDepartment = DepartmentMapper.toEntity(dto);
            departmentRepository.edit(updateDepartment);

            return Map.of();
        } catch (Exception e) {
            return Map.of("system", "Error updating department: " + e.getMessage());
        }
    }

    public Map<String, String> delete(Long id) {
        departmentRepository.delete(id);
        return Map.of();
    }
}
