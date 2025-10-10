package com.cliniquedigitale.mapper;

import com.cliniquedigitale.dto.LoginDTO;
import com.cliniquedigitale.entity.User;

public class LoginMapper {
    public static User toEntity(LoginDTO dto) {
        User user = new User();

        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());

        return user;
    }

    public static LoginDTO toDTO(User user) {
        LoginDTO loginDTO = new LoginDTO(user.getId(), user.getFullName(), user.getEmail(), user.getRole());
        return loginDTO;
    }

}
