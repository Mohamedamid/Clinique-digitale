package com.cliniquedigitale.mapper;

import com.cliniquedigitale.dto.DoctorDTO;
import com.cliniquedigitale.entity.Doctor;
import com.cliniquedigitale.entity.Role;
import com.cliniquedigitale.entity.Specialite;
import com.cliniquedigitale.entity.User;

public class DoctorMapper {

    public static Doctor toEntity(DoctorDTO dto, Specialite specialite) {
        Doctor doctor = new Doctor();
        User user = new User();

        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        user.setRole(Role.DOCTOR);

        doctor.setMatricule(dto.getMatricule());
        doctor.setSpecialite(specialite);
        doctor.setUser(user);

        return doctor;
    }

    public static DoctorDTO toDTO(Doctor doctor) {
        Long specialiteId = null;
        String specialiteName = null;

        if (doctor.getSpecialite() != null) {
            specialiteId = doctor.getSpecialite().getId();
            specialiteName = doctor.getSpecialite().getName();
        }

        DoctorDTO dto = new DoctorDTO();
        dto.setId(doctor.getId());
        dto.setMatricule(doctor.getMatricule());
        dto.setFullName(doctor.getUser() != null ? doctor.getUser().getFullName() : null);
        dto.setEmail(doctor.getUser() != null ? doctor.getUser().getEmail() : null);
        dto.setSpecialiteId(specialiteId);
        dto.setSpecialiteName(specialiteName);

        return dto;
    }
}
