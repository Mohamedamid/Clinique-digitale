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