package com.cliniquedigitale.services;

import com.cliniquedigitale.dto.UserDTO;
import com.cliniquedigitale.entity.User;
import com.cliniquedigitale.mapper.UserMapper;
import com.cliniquedigitale.repository.UserRepository;

import java.util.List;
import java.util.stream.Collectors;

public class UserService {
    private final UserRepository userRepository = new UserRepository();

    public List<UserDTO> getAllUser() {
        List<User> users = userRepository.findAll();
        return users.stream()
                .map(UserMapper::toDTO)
                .collect(Collectors.toList());
    }
}