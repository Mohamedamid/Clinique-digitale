package com.cliniquedigitale.services;

import com.cliniquedigitale.dto.SpecialiteDTO;
import com.cliniquedigitale.entity.Department;
import com.cliniquedigitale.entity.Specialite;
import com.cliniquedigitale.mapper.SpecialiteMapper;
import com.cliniquedigitale.repository.DepartmentRepository;
import com.cliniquedigitale.repository.SpecialiteRepository;
import com.cliniquedigitale.util.Validator;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class SpecialiteService {

    private final SpecialiteRepository specialiteRepository = new SpecialiteRepository();
    private final DepartmentRepository departmentRepository = new DepartmentRepository();

    public Map<String, String> save(SpecialiteDTO dto) {
        Validator validator = new Validator();

        // Pour l'ajout, l'ID doit être null
        if (dto.getId() != null) {
            return Map.of("id", "ID should be null for new specialty");
        }

        validator.required("name", dto.getName(), "Name is required");

        validator.required("description", dto.getDescription(), "Description is required");

        if (dto.getDepartmentId() == null) {
            validator.addError("departmentId", "Department is required");
        }

        if (validator.hasErrors()) {
            return validator.getErrors();
        }

        try {
            // Récupérer le département complet
            Department department = departmentRepository.findById(dto.getDepartmentId());
            if (department == null) {
                return Map.of("departmentId", "Selected department not found");
            }

            Specialite newSpecialite = SpecialiteMapper.toEntity(dto, department);
            specialiteRepository.save(newSpecialite);

            return Map.of();
        } catch (Exception e) {
            return Map.of("system", "Error creating specialty: " + e.getMessage());
        }
    }

    public Map<String, String> edit(SpecialiteDTO dto) {
        Validator validator = new Validator();

        // Validation de l'ID
        if (dto.getId() == null) {
            return Map.of("id", "Specialty ID is required for editing");
        }

        validator.required("name", dto.getName(), "Name is required");

        validator.required("description", dto.getDescription(), "Description is required");

        if (dto.getDepartmentId() == null) {
            validator.addError("departmentId", "Department is required");
        }

        if (validator.hasErrors()) {
            return validator.getErrors();
        }

        try {
            // Vérifier si la spécialité existe
            Specialite existingSpecialite = specialiteRepository.findById(dto.getId());
            if (existingSpecialite == null) {
                return Map.of("not_found", "Specialty not found");
            }

            // Récupérer le département complet
            Department department = departmentRepository.findById(dto.getDepartmentId());
            if (department == null) {
                return Map.of("departmentId", "Selected department not found");
            }

            Specialite updateSpecialite = SpecialiteMapper.toEntity(dto, department);
            specialiteRepository.edit(updateSpecialite);

            return Map.of();
        } catch (Exception e) {
            return Map.of("system", "Error updating specialty: " + e.getMessage());
        }
    }

    public List<SpecialiteDTO> getAllSpecialites() {
        List<Specialite> specialites = specialiteRepository.findAll();
        return specialites.stream()
                .map(SpecialiteMapper::toDTO)
                .collect(Collectors.toList());
    }

    public Map<String, String> delete(Long id) {
        specialiteRepository.delete(id);
        return Map.of();
    }
}
