package com.cliniquedigitale.dto;

import com.cliniquedigitale.entity.BloodType;
import com.cliniquedigitale.entity.Gender;

import java.time.LocalDate;

public class PatientDTO {
    private String fullName;
    private String email;
    private String password;
    private Gender gender;
    private LocalDate birthDate;
    private String phone;
    private String cin;
    private String insuranceNumber ;
    private BloodType bloodType;

    public PatientDTO(String email, String password, String fullName, Gender gender, LocalDate birthDate, String phone, String cin, String insuranceNumber, BloodType bloodType) {
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.gender = gender;
        this.birthDate = birthDate;
        this.phone = phone;
        this.cin = cin;
        this.insuranceNumber = insuranceNumber;
        this.bloodType = bloodType;
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



    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public String getInsuranceNumber() {
        return insuranceNumber;
    }

    public void setInsuranceNumber(String insuranceNumber) {
        this.insuranceNumber = insuranceNumber;
    }

    public BloodType getBloodType() {
        return bloodType;
    }

    public void setBloodType(BloodType bloodType) {
        this.bloodType = bloodType;
    }
}