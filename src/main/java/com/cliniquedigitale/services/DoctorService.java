package com.cliniquedigitale.services;

import com.cliniquedigitale.dto.DoctorDTO;
import com.cliniquedigitale.entity.Doctor;
import com.cliniquedigitale.entity.Specialite;
import com.cliniquedigitale.mapper.DoctorMapper;
import com.cliniquedigitale.repository.DoctorRepository;
import com.cliniquedigitale.repository.SpecialiteRepository;
import com.cliniquedigitale.repository.UserRepository;
import com.cliniquedigitale.util.PasswordUtils;
import com.cliniquedigitale.util.Validator;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class DoctorService {
    private final SpecialiteRepository specialiteRepository = new SpecialiteRepository();
    private final DoctorRepository doctorRepository = new DoctorRepository();

    public Map<String, String> save(DoctorDTO dto) {
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
        if (dto.getMatricule() == null || dto.getMatricule().isEmpty()) {
            validator.addError("matricule", "Matricule is required");
        }
        if (dto.getSpecialiteId() == null) {
            validator.addError("specialiteId", "Speciality is required");
        }

        if (validator.hasErrors()) return validator.getErrors();

        try {
            // 👇 check if email already exists
            UserRepository userRepository = new UserRepository();
            var existingUser = userRepository.findByEmail(dto.getEmail());
            if (existingUser != null) {
                return Map.of("email", "This email already exists");
            }

            Specialite specialite = specialiteRepository.findById(dto.getSpecialiteId());
            if (specialite == null)
                return Map.of("specialiteId", "Speciality not found");

            // hash password
            dto.setPassword(PasswordUtils.hashPassword(dto.getPassword()));

            Doctor doctor = DoctorMapper.toEntity(dto, specialite);
            doctorRepository.save(doctor);
            return Map.of();

        } catch (Exception e) {
            e.printStackTrace();
            return Map.of("system", "Error: " + e.getMessage());
        }
    }


    public Map<String, String> edit(DoctorDTO dto) {
        Validator validator = new Validator();

        if (dto.getFullName() == null || dto.getFullName().isEmpty()) {
            validator.addError("fullName", "Full name is required");
        }
        if (dto.getEmail() == null || dto.getEmail().isEmpty()) {
            validator.addError("email", "Email is required");
        }
        if (dto.getMatricule() == null || dto.getMatricule().isEmpty()) {
            validator.addError("matricule", "Matricule is required");
        }
        if (dto.getSpecialiteId() == null) {
            validator.addError("specialiteId", "Speciality is required");
        }

        if (validator.hasErrors()) return validator.getErrors();

        try {
            Doctor existingDoctor = doctorRepository.findById(dto.getId());
            if (existingDoctor == null) {
                return Map.of("not_found", "Doctor not found");
            }

            Specialite specialite = specialiteRepository.findById(dto.getSpecialiteId());
            if (specialite == null) {
                return Map.of("specialiteId", "Speciality not found");
            }

            // --- تحديث بيانات المستخدم ---
            existingDoctor.getUser().setFullName(dto.getFullName());
            existingDoctor.getUser().setEmail(dto.getEmail());
            existingDoctor.getUser().setRole(existingDoctor.getUser().getRole()); // نفس الدور

            // فقط إذا المستخدم دخل كلمة سر جديدة
            if (dto.getPassword() != null && !dto.getPassword().isEmpty()) {
                String hashedPassword = PasswordUtils.hashPassword(dto.getPassword());
                existingDoctor.getUser().setPassword(hashedPassword);
            }

            // --- تحديث بيانات الطبيب ---
            existingDoctor.setMatricule(dto.getMatricule());
            existingDoctor.setSpecialite(specialite);

            // --- حفظ التحديث ---
            doctorRepository.edit(existingDoctor);

            return Map.of();

        } catch (Exception e) {
            e.printStackTrace();
            return Map.of("system", "Error updating doctor: " + e.getMessage());
        }
    }

    public Doctor findByUserId(Long userId) {
        return doctorRepository.findByUserId(userId);
    }

    public List<DoctorDTO> getAllDoctors() {
        List<Doctor> doctors = doctorRepository.findAll();
        return doctors.stream()
                .map(DoctorMapper::toDTO)
                .collect(Collectors.toList());
    }

    public Map<String, String> delete(Long id) {
        doctorRepository.delete(id);
        return Map.of();
    }
}
