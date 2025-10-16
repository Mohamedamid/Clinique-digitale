package com.cliniquedigitale.mapper;

import com.cliniquedigitale.dto.PatientDTO;
import com.cliniquedigitale.dto.PatientDTO;
import com.cliniquedigitale.entity.Patient;
import com.cliniquedigitale.entity.Role;
import com.cliniquedigitale.entity.Patient;
import com.cliniquedigitale.entity.User;

public class PatientMapper {

    public static Patient toEntity(PatientDTO dto) {
        Patient patient = new Patient();

        User user = new User();
        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        user.setRole(Role.PATIENT);

        patient.setCin(dto.getCin());
        patient.setGender(dto.getGender());
        patient.setBloodType(dto.getBloodType());
        patient.setInsuranceNumber(dto.getInsuranceNumber());
        patient.setDateOfBirth(dto.getBirthDate());
        patient.setUser(user);

        return patient;
    }

    public static PatientDTO toDTO(Patient patient) {

        PatientDTO dto = new PatientDTO();
        dto.setId(patient.getId());
        dto.setFullName(patient.getUser() != null ? patient.getUser().getFullName() : null);
        dto.setEmail(patient.getUser() != null ? patient.getUser().getEmail() : null);
        dto.setCin(patient.getUser() != null ? patient.getCin() : null);
        dto.setGender(patient.getUser() != null ? patient.getGender() : null);
        dto.setBloodType(patient.getUser() != null ? patient.getBloodType() : null);
        dto.setInsuranceNumber(patient.getUser() != null ? patient.getInsuranceNumber() : null);
        dto.setBirthDate(patient.getUser() != null ? patient.getDateOfBirth() : null);

        return dto;
    }
}