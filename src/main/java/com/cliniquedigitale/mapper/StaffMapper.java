package com.cliniquedigitale.mapper;

import com.cliniquedigitale.dto.StaffDTO;
import com.cliniquedigitale.entity.Staff;
import com.cliniquedigitale.entity.Role;
import com.cliniquedigitale.entity.User;

public class StaffMapper {

    public static Staff toEntity(StaffDTO dto) {
        Staff staff = new Staff();
        User user = new User();

        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        user.setRole(Role.STAFF);
        staff.setPosition(dto.getPosition());
        staff.setUser(user);

        return staff;
    }

    public static StaffDTO toDTO(Staff staff) {

        StaffDTO dto = new StaffDTO();
        dto.setId(staff.getId());
        dto.setFullName(staff.getUser() != null ? staff.getUser().getFullName() : null);
        dto.setEmail(staff.getUser() != null ? staff.getUser().getEmail() : null);
        dto.setPosition(staff.getUser() != null ? staff.getPosition() : null);

        return dto;
    }
}
