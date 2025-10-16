package com.cliniquedigitale.services;

import com.cliniquedigitale.dto.StaffDTO;
import com.cliniquedigitale.entity.Staff;
import com.cliniquedigitale.mapper.StaffMapper;
import com.cliniquedigitale.repository.StaffRepository;
import com.cliniquedigitale.repository.UserRepository;
import com.cliniquedigitale.util.PasswordUtils;
import com.cliniquedigitale.util.Validator;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class StaffService {
    private final StaffRepository staffRepository = new StaffRepository();

    public Map<String, String> save(StaffDTO dto) {
        Validator validator = new Validator();

        if (dto.getFullName() == null || dto.getFullName().isEmpty()) {
            validator.addError("fullName", "Full name is required");
        }
        if (dto.getEmail() == null || dto.getEmail().isEmpty()) {
            validator.addError("email", "Email is required");
        }
        if (dto.getPassword() == null || dto.getPassword().isEmpty()) {
            validator.addError("password", "Password is required");
        }
        if (dto.getPosition() == null || dto.getPosition().isEmpty()) {
            validator.addError("position", "Position is required");
        }

        if (validator.hasErrors()) return validator.getErrors();

        try {
            UserRepository userRepository = new UserRepository();
            var existingUser = userRepository.findByEmail(dto.getEmail());
            if (existingUser != null) {
                return Map.of("email", "This email already exists");
            }

            dto.setPassword(PasswordUtils.hashPassword(dto.getPassword()));

            Staff staff = StaffMapper.toEntity(dto);
            staffRepository.save(staff);
            return Map.of();

        } catch (Exception e) {
            e.printStackTrace();
            return Map.of("system", "Error: " + e.getMessage());
        }
    }


    public Map<String, String> edit(StaffDTO dto) {
        Validator validator = new Validator();

        if (dto.getFullName() == null || dto.getFullName().isEmpty()) {
            validator.addError("fullName", "Full name is required");
        }
        if (dto.getEmail() == null || dto.getEmail().isEmpty()) {
            validator.addError("email", "Email is required");
        }
        if (dto.getPassword() == null || dto.getPassword().isEmpty()) {
            validator.addError("password", "Password is required");
        }
        if (dto.getPosition() == null || dto.getPosition().isEmpty()) {
            validator.addError("position", "Position is required");
        }

        if (validator.hasErrors()) return validator.getErrors();

        try {
            Staff existingStaff = staffRepository.findById(dto.getId());
            if (existingStaff == null) {
                return Map.of("not_found", "Staff not found");
            }

            existingStaff.getUser().setFullName(dto.getFullName());
            existingStaff.getUser().setEmail(dto.getEmail());
            existingStaff.getUser().setRole(existingStaff.getUser().getRole());

            if (dto.getPassword() != null && !dto.getPassword().isEmpty()) {
                String hashedPassword = PasswordUtils.hashPassword(dto.getPassword());
                existingStaff.getUser().setPassword(hashedPassword);
            }

            existingStaff.setPosition(dto.getPosition());

            staffRepository.edit(existingStaff);

            return Map.of();

        } catch (Exception e) {
            e.printStackTrace();
            return Map.of("system", "Error updating staff: " + e.getMessage());
        }
    }


    public List<StaffDTO> getAllStaff() {
        List<Staff> staff = staffRepository.findAll();
        return staff.stream()
                .map(StaffMapper::toDTO)
                .collect(Collectors.toList());
    }

    public Map<String, String> delete(Long id) {
        staffRepository.delete(id);
        return Map.of();
    }
}
