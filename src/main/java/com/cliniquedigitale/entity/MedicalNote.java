package com.cliniquedigitale.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "medical_notes")
public class MedicalNote {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private String symptoms;
    @Column(nullable = false)
    private String prescription;
    @Column
    private String notes;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="created_at")
    private Date createdAt = new Date();
    @ManyToOne
    @JoinColumn(name = "appointment_id", nullable = false)
    private Appointment appointment;

    public MedicalNote() {}
    public MedicalNote(Long id, String symptoms, String prescription, String notes, Date createdAt, Appointment appointment) {
        this.id = id; this.symptoms = symptoms; this.prescription = prescription; this.notes = notes; this.createdAt = createdAt; this.appointment = appointment;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(String symptoms) {
        this.symptoms = symptoms;
    }

    public String getPrescription() {
        return prescription;
    }

    public void setPrescription(String prescription) {
        this.prescription = prescription;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }
}