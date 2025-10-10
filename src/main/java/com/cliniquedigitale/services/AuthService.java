package com.cliniquedigitale.services;

import com.cliniquedigitale.dto.LoginDTO;
import com.cliniquedigitale.dto.RegisterPatientDTO;
import com.cliniquedigitale.entity.Patient;
import com.cliniquedigitale.entity.User;
import com.cliniquedigitale.mapper.RegisterPatientMapper;
import com.cliniquedigitale.repository.UserRepository;
import com.cliniquedigitale.util.PasswordUtils;
import com.cliniquedigitale.util.Validator;

import java.util.Map;

public class AuthService {

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
        userRepository.save(newPatient);

        return validator.getErrors();
    }

    /**
     * Login user
     * Returns User if successful, null otherwise
     */
    public User loginUser(LoginDTO dto, Map<String, String> errors) {
        Validator validator = new Validator();

        // Validate inputs
        validator.email("email", dto.getEmail(), "Email is invalid");
        validator.required("password", dto.getPassword(), "Password is required");

        if (validator.hasErrors()) {
            errors.putAll(validator.getErrors());
            return null;
        }

        // Find user by email
        User user = userRepository.findByEmail(dto.getEmail());

        if (user == null) {
            errors.put("email", "No account found with this email");
            return null;
        }

        // Verify password
        boolean passwordMatches = PasswordUtils.verifyPassword(dto.getPassword(), user.getPassword());

        if (!passwordMatches) {
            errors.put("password", "Invalid password");
            return null;
        }

        // ✅ Return user if login successful
        return user;
    }
}