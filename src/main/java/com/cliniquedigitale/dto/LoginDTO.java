package com.cliniquedigitale.dto;

import com.cliniquedigitale.entity.Role;

public class LoginDTO {
    private Long id;
    private String fullName;
    private String email;
    private String password;
    private Role role;

    public LoginDTO(String email, String password){
        this.email = email;
        this.password = password;
    }

    public LoginDTO(Long id ,String fullName ,String email, Role role){
        this.id = id;
        this.email = email;
        this.role = role;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
