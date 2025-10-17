package com.cliniquedigitale.dto;

import com.cliniquedigitale.entity.Availability.DayOfWeekEnum;
import java.time.LocalTime;
import java.time.LocalDate;

public class AvailabilityDTO {
    private Long id;
    private DayOfWeekEnum dayOfWeek;
    private LocalTime startTime;
    private LocalTime endTime;
    private boolean isAvailable = true;
    private Integer slotDuration;
    private LocalDate startDate;
    private LocalDate endDate;
    private Long doctorId;
    private String doctorName;

    // Constructeurs
    public AvailabilityDTO() {}

    public AvailabilityDTO(Long id, DayOfWeekEnum dayOfWeek, LocalTime startTime, LocalTime endTime,
                           boolean isAvailable, Integer slotDuration, LocalDate startDate, LocalDate endDate,
                           Long doctorId, String doctorName) {
        this.id = id;
        this.dayOfWeek = dayOfWeek;
        this.startTime = startTime;
        this.endTime = endTime;
        this.isAvailable = isAvailable;
        this.slotDuration = slotDuration;
        this.startDate = startDate;
        this.endDate = endDate;
        this.doctorId = doctorId;
        this.doctorName = doctorName;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public DayOfWeekEnum getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(DayOfWeekEnum dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
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

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public Integer getSlotDuration() {
        return slotDuration;
    }

    public void setSlotDuration(Integer slotDuration) {
        this.slotDuration = slotDuration;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public Long getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(Long doctorId) {
        this.doctorId = doctorId;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    @Override
    public String toString() {
        return "AvailabilityDTO{" +
                "id=" + id +
                ", dayOfWeek=" + dayOfWeek +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", isAvailable=" + isAvailable +
                ", slotDuration=" + slotDuration +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", doctorId=" + doctorId +
                ", doctorName='" + doctorName + '\'' +
                '}';
    }
}