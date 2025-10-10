package com.cliniquedigitale.mapper;

import com.cliniquedigitale.dto.RegisterPatientDTO;
import com.cliniquedigitale.entity.Patient;
import com.cliniquedigitale.entity.Role;
import com.cliniquedigitale.entity.User;

public class PatientMapper {

    public static Patient toEntity(RegisterPatientDTO dto) {
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
}