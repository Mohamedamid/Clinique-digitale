package com.cliniquedigitale.entity;

import jakarta.persistence.*;
import java.util.Date;
import java.time.LocalTime;

@Entity
@Table(name = "appointments")
public class Appointment {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "appointment_number", nullable = false, unique = true)
    private String appointmentNumber;
    @Temporal(TemporalType.DATE)
    @Column(name = "appointment_date", nullable = false)
    private Date appointmentDate;
    @Column(name = "start_time", nullable = false)
    private LocalTime startTime;
    @Column(name = "end_time", nullable = false)
    private LocalTime endTime;
    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private AppointmentStatusEnum status = AppointmentStatusEnum.PLANNED;
    @Column(name = "canceled_by")
    private String canceledBy;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "canceled_at")
    private Date canceledAt;
    @Column(name = "cancellation_reason")
    private String cancellationReason;

    @ManyToOne
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;
    @ManyToOne
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;
    @ManyToOne
    @JoinColumn(name = "staff_id")
    private Staff staff;

    public enum AppointmentStatusEnum { CANCELED, DONE, PLANNED }

    public Appointment() {}
    public Appointment(Long id, String appointmentNumber, Date appointmentDate, LocalTime startTime, LocalTime endTime,
                       AppointmentStatusEnum status, String canceledBy, Date canceledAt, String cancellationReason,
                       Doctor doctor, Patient patient, Staff staff) {
        this.id = id; this.appointmentNumber = appointmentNumber; this.appointmentDate = appointmentDate; this.startTime = startTime; this.endTime = endTime;
        this.status = status; this.canceledBy = canceledBy; this.canceledAt = canceledAt; this.cancellationReason = cancellationReason;
        this.doctor = doctor; this.patient = patient; this.staff = staff;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAppointmentNumber() {
        return appointmentNumber;
    }

    public void setAppointmentNumber(String appointmentNumber) {
        this.appointmentNumber = appointmentNumber;
    }

    public Date getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(Date appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public AppointmentStatusEnum getStatus() {
        return status;
    }

    public void setStatus(AppointmentStatusEnum status) {
        this.status = status;
    }

    public String getCanceledBy() {
        return canceledBy;
    }

    public void setCanceledBy(String canceledBy) {
        this.canceledBy = canceledBy;
    }

    public Date getCanceledAt() {
        return canceledAt;
    }

    public void setCanceledAt(Date canceledAt) {
        this.canceledAt = canceledAt;
    }

    public String getCancellationReason() {
        return cancellationReason;
    }

    public void setCancellationReason(String cancellationReason) {
        this.cancellationReason = cancellationReason;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }
}