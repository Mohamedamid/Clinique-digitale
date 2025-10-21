package com.cliniquedigitale.services;

import com.cliniquedigitale.dto.PatientDTO;
import com.cliniquedigitale.entity.Doctor;
import com.cliniquedigitale.entity.Patient;
import com.cliniquedigitale.entity.Patient;
import com.cliniquedigitale.entity.User;
import com.cliniquedigitale.mapper.PatientMapper;
import com.cliniquedigitale.repository.PatientRepository;
import com.cliniquedigitale.repository.UserRepository;
import com.cliniquedigitale.util.PasswordUtils;
import com.cliniquedigitale.util.Validator;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class PatientService {
    private PatientRepository patientRepository = new PatientRepository();
    private UserRepository userRepository = new UserRepository();

    public Map<String, String> createPatient(PatientDTO dto) {
        Validator validator = new Validator();

        validator.required("fullName", dto.getFullName(), "Name is required");
        validator.email("email", dto.getEmail(), "Email is invalid");
        validator.minLength("password", dto.getPassword(), 6, "Password must be at least 6 characters");
        validator.regex("cin", dto.getCin(), "^[A-Z]{1,2}\\d{4,6}$", "CIN format is invalid");
        validator.required("gender", dto.getGender().name(), "Gender is required");
        validator.required("insuranceNumber", dto.getInsuranceNumber(), "Insurance number is required");
        validator.required("dateOfBirth", String.valueOf(dto.getBirthDate()), "Date of birth is required");
        validator.required("bloodType", dto.getBloodType().name(), "Blood type is required");

        User existingUser = userRepository.findByEmail(dto.getEmail());
        if (existingUser != null) {
            validator.addError("email", "Email already exists");
        }

        if (validator.hasErrors()) {
            return validator.getErrors();
        }

        String hashedPassword = PasswordUtils.hashPassword(dto.getPassword());
        dto.setPassword(hashedPassword);

        Patient newPatient = PatientMapper.toEntity(dto);
        patientRepository.save(newPatient);

        return validator.getErrors();
    }

    public Map<String, String> edit(PatientDTO dto) {
        Validator validator = new Validator();

        validator.required("fullName", dto.getFullName(), "Name is required");
        validator.email("email", dto.getEmail(), "Email is invalid");
        validator.minLength("password", dto.getPassword(), 6, "Password must be at least 6 characters");
        validator.regex("cin", dto.getCin(), "^[A-Z]{1,2}\\d{4,6}$", "CIN format is invalid");
        validator.required("gender", dto.getGender().name(), "Gender is required");
        validator.required("insuranceNumber", dto.getInsuranceNumber(), "Insurance number is required");
        validator.required("dateOfBirth", String.valueOf(dto.getBirthDate()), "Date of birth is required");
        validator.required("bloodType", dto.getBloodType().name(), "Blood type is required");

        try {
            Patient existingPatient = patientRepository.findById(dto.getId());
            if (existingPatient == null) {
                return Map.of("not_found", "Patient not found");
            }

            existingPatient.getUser().setFullName(dto.getFullName());
            existingPatient.getUser().setEmail(dto.getEmail());
            existingPatient.getUser().setRole(existingPatient.getUser().getRole());

            if (dto.getPassword() != null && !dto.getPassword().isEmpty()) {
                String hashedPassword = PasswordUtils.hashPassword(dto.getPassword());
                existingPatient.getUser().setPassword(hashedPassword);
            }

            existingPatient.setCin(dto.getCin());
            existingPatient.setInsuranceNumber(dto.getInsuranceNumber());
            existingPatient.setDateOfBirth(dto.getBirthDate());
            existingPatient.setGender(dto.getGender());
            existingPatient.setBloodType(dto.getBloodType());

            patientRepository.edit(existingPatient);

            return Map.of();

        } catch (Exception e) {
            e.printStackTrace();
            return Map.of("system", "Error updating patient: " + e.getMessage());
        }

    }

    public List<PatientDTO> getAllPatients() {
        List<Patient> patient = patientRepository.findAll();
        return patient.stream()
                .map(PatientMapper::toDTO)
                .collect(Collectors.toList());
    }

    public Map<String, String> delete(Long id) {
        patientRepository.delete(id);
        return Map.of();
    }

    public Patient findByUserId(Long userId) {
        return patientRepository.findByUserId(userId);
    }

}
