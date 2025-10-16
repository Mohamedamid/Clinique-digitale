package com.cliniquedigitale.mapper;

import com.cliniquedigitale.dto.SpecialiteDTO;
import com.cliniquedigitale.entity.Specialite;
import com.cliniquedigitale.entity.Department;

public class SpecialiteMapper {
    public static Specialite toEntity(SpecialiteDTO dto, Department department) {
        Specialite specialite = new Specialite();

        if (dto.getId() != null) {
            specialite.setId(dto.getId());
        }

        specialite.setName(dto.getName());
        specialite.setActive(dto.getActive());
        specialite.setDescription(dto.getDescription());
        specialite.setDepartment(department);
        return specialite;
    }

    public static SpecialiteDTO toDTO(Specialite specialite) {
        Long departmentId = null;
        String departmentName = null;

        if (specialite.getDepartment() != null) {
            departmentId = specialite.getDepartment().getId();
            departmentName = specialite.getDepartment().getName();
        }

        return new SpecialiteDTO(
                specialite.getId(),
                specialite.getName(),
                specialite.isActive(),
                specialite.getDescription(),
                departmentId,
                departmentName
        );
    }
}