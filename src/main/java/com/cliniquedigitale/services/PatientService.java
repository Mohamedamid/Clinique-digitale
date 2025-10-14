package com.cliniquedigitale.services;

import com.cliniquedigitale.dto.RegisterPatientDTO;
import com.cliniquedigitale.entity.Patient;
import com.cliniquedigitale.entity.User;
import com.cliniquedigitale.mapper.RegisterPatientMapper;
import com.cliniquedigitale.repository.PatientRepository;
import com.cliniquedigitale.repository.UserRepository;
import com.cliniquedigitale.util.PasswordUtils;
import com.cliniquedigitale.util.Validator;

import java.util.Map;

public class PatientService {
    private PatientRepository patientRepository = new PatientRepository();
    private UserRepository userRepository = new UserRepository();

    /**
     * Register a new patient
     */
    public Map<String, String> registerPatient(RegisterPatientDTO dto) {
        Validator validator = new Validator();

        validator.required("fullName", dto.getFullName(), "Name is required");
        validator.email("email", dto.getEmail(), "Email is invalid");
        validator.minLength("password", dto.getPassword(), 6, "Password must be at least 6 characters");
        validator.regex("cin", dto.getCin(), "^[A-Z]{1,2}\\d{4,6}$", "CIN format is invalid");
        validator.minLength("phone", dto.getPhone(), 10, "Phone number is invalid");
        validator.required("gender", dto.getGender().name(), "Gender is required");
        validator.required("insuranceNumber", dto.getInsuranceNumber(), "Insurance number is required");
        validator.required("dateOfBirth", String.valueOf(dto.getBirthDate()), "Date of birth is required");
        validator.required("bloodType", dto.getBloodType().name(), "Blood type is required");

        // Check if email exists
        User existingUser = userRepository.findByEmail(dto.getEmail());
        if (existingUser != null) {
            validator.addError("email", "Email already exists");
        }

        if (validator.hasErrors()) {
            return validator.getErrors();
        }

        // Hash password
        String hashedPassword = PasswordUtils.hashPassword(dto.getPassword());
        dto.setPassword(hashedPassword);

        // Save patient
        Patient newPatient = RegisterPatientMapper.toEntity(dto);
        patientRepository.save(newPatient);

        return validator.getErrors();
    }
}
