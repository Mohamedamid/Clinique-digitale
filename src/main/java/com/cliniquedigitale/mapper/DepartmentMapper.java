package com.cliniquedigitale.mapper;

import com.cliniquedigitale.dto.DepartmentDTO;
import com.cliniquedigitale.entity.Department;

public class DepartmentMapper {
    public static Department toEntity(DepartmentDTO dto) {
        Department department = new Department();
        department.setId(dto.getId());
        department.setName(dto.getName());
        department.setActive(dto.getActive());
        department.setDescription(dto.getDescription());
        return department;
    }

    public static DepartmentDTO toDTO(Department department) {
        return new DepartmentDTO(
                department.getId(),
                department.getName(),
                department.isActive(),
                department.getDescription(),
                department.getCreatedAt()
        );
    }
}
