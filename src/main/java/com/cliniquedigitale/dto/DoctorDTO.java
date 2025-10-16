package com.cliniquedigitale.dto;

public class DoctorDTO {
    private Long id;
    private String fullName;
    private String email;
    private String password;
    private String matricule;
    private Long specialiteId;
    private String specialiteName;

    public DoctorDTO() {}

    public DoctorDTO(Long id, String fullName, String email, String password, String matricule, Long specialiteId, String specialiteName) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.matricule = matricule;
        this.specialiteId = specialiteId;
        this.specialiteName = specialiteName;
    }

    // Getters
    public Long getId() {
        return id;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getMatricule() {
        return matricule;
    }

    public Long getSpecialiteId() {
        return specialiteId;
    }

    public String getSpecialiteName() {
        return specialiteName;
    }

    // Setters
    public void setId(Long id) {
        this.id = id;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public void setSpecialiteId(Long specialiteId) {
        this.specialiteId = specialiteId;
    }

    public void setSpecialiteName(String specialiteName) {
        this.specialiteName = specialiteName;
    }
}