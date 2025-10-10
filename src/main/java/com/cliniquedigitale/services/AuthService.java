package com.cliniquedigitale.services;

import com.cliniquedigitale.dto.RegisterPatientDTO;
import com.cliniquedigitale.entity.Patient;
import com.cliniquedigitale.mapper.PatientMapper;
import com.cliniquedigitale.repository.UserRepository;
import com.cliniquedigitale.util.PasswordUtils;
import com.cliniquedigitale.util.Validator;

import java.util.Map;

public class AuthService {

    private UserRepository userRepository = new UserRepository();

    public Map<String, String> registerPatient(RegisterPatientDTO dto) {

        Validator validator = new Validator();

        validator.required("name", dto.getFullName(), "Name is required");
        validator.email("email", dto.getEmail(), "Email is invalid");
        validator.minLength("password", dto.getPassword(), 6, "Password must be at least 6 characters");
        validator.regex("cin", dto.getCin(), "^[A-Z]{1,2}\\d{4,6}$", "CIN format is invalid");
        validator.minLength("phone",dto.getPhone(),10,"Phone number is invalid");
        validator.required("gender",  dto.getGender().name(), "Gender is invalid");
        validator.required("insuranceNumber", dto.getInsuranceNumber(), "Insurance number is invalid");
        validator.required("dateOfBirth", String.valueOf(dto.getBirthDate()), "Date of birth is invalid");
        validator.required("TypeBlood", dto.getBloodType().name(), "Blood is invalid");

        if (validator.hasErrors()) {
            return validator.getErrors();
        }

        String hashedPassword = PasswordUtils.hashPassword(dto.getPassword());
        dto.setPassword(hashedPassword);

        Patient newPatient = PatientMapper.toEntity(dto);
        userRepository.save(newPatient);

        return validator.getErrors();
    }
}