package com.cliniquedigitale.mapper;

import com.cliniquedigitale.dto.UserDTO;
import com.cliniquedigitale.entity.User;

public class UserMapper {
    public static UserDTO toDTO(User user) {
        return new UserDTO(user.getId(), user.getFullName(), user.getEmail(), user.getRole());
    }
}