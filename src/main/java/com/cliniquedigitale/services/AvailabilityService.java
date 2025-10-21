package com.cliniquedigitale.services;

import com.cliniquedigitale.entity.Appointments;
import com.cliniquedigitale.entity.Availability;
import com.cliniquedigitale.entity.Doctor;
import com.cliniquedigitale.repository.AvailabilityRepository;
import com.cliniquedigitale.repository.DoctorRepository;
import com.cliniquedigitale.util.Validator;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.*;

public class AvailabilityService {
    private final AvailabilityRepository availabilityRepository;
    private final DoctorRepository doctorRepository;

    public AvailabilityService() {
        this.availabilityRepository = new AvailabilityRepository();
        this.doctorRepository = new DoctorRepository();
    }

    public Map<String, String> saveWeeklyAvailability(Map<String, String[]> parameters, Long userId) {

        Validator validator = new Validator();

        String startDateStr = getParameterValue(parameters, "start_date");
        String endDateStr = getParameterValue(parameters, "end_date");

        if (startDateStr == null || endDateStr == null) {
            return Map.of("date_required", "Start date and end date are required");
        }

        validator.required("start_date", startDateStr, "Start date is required");
        validator.required("end_date", endDateStr, "End date is required");

        if (validator.hasErrors()) {
            return validator.getErrors();
        }

        try {
            LocalDate startDate = parseLocalDate(startDateStr);
            LocalDate endDate = parseLocalDate(endDateStr);

            if (endDate.isBefore(startDate)) {
                return Map.of("date_range", "End date must be after start date");
            }

            Doctor doctorCheck = doctorRepository.findById(userId);
            if (doctorCheck == null) {
                return Map.of("doctor", "Doctor not found with ID: " + userId);
            }

            availabilityRepository.deleteByDoctorAndDateRange(userId, startDate, endDate);

            List<Availability> availabilities = new ArrayList<>();
            String[] days = {"MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"};

            for (String day : days) {
                String isAvailableStr = getParameterValue(parameters, day + "_is_available");
                if (isAvailableStr == null) {
                    continue;
                }

                boolean isAvailable = "true".equals(isAvailableStr) || "on".equals(isAvailableStr);

                if (isAvailable) {
                    String startTimeStr = getParameterValue(parameters, day + "_start_time");
                    String endTimeStr = getParameterValue(parameters, day + "_end_time");
                    String slotDurationStr = getParameterValue(parameters, day + "_slot_duration");

                    if (startTimeStr == null || endTimeStr == null || slotDurationStr == null) {
                        return Map.of("time_missing", "Missing time parameters for " + day);
                    }

                    try {
                        LocalTime startTime = LocalTime.parse(startTimeStr);
                        LocalTime endTime = LocalTime.parse(endTimeStr);
                        int slotDuration = Integer.parseInt(slotDurationStr);

                        if (startTime.isAfter(endTime)) {
                            return Map.of("time_range", "Start time must be before end time for " + day);
                        }

                        if (slotDuration <= 0 || slotDuration > 240) {
                            return Map.of("slot_duration", "Slot duration must be between 1 and 240 minutes for " + day);
                        }

                        Availability availability = new Availability();
                        availability.setDayOfWeek(Availability.DayOfWeekEnum.valueOf(day));
                        availability.setStartTime(startTime);
                        availability.setEndTime(endTime);
                        availability.setAvailable(true);
                        availability.setSlotDuration(slotDuration);
                        availability.setStartDate(startDate);
                        availability.setEndDate(endDate);
                        availability.setDoctor(doctorCheck);

                        availabilities.add(availability);

                    } catch (Exception e) {
                        return Map.of("time_format", "Invalid time format for " + day);
                    }
                }
            }

            if (!availabilities.isEmpty()) {
                availabilityRepository.saveAll(availabilities);
            } else {
            }

            return Map.of();

        } catch (DateTimeParseException e) {
            return Map.of("date_format", "Invalid date format. Use DD/MM/YYYY, DD-MM-YYYY or YYYY-MM-DD");
        } catch (IllegalArgumentException e) {
            return Map.of("day_format", "Invalid day format: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return Map.of("system", "Error saving availability: " + e.getMessage());
        }
    }

    private LocalDate parseLocalDate(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Date string is empty");
        }

        dateStr = dateStr.trim();

        DateTimeFormatter[] formats = {
                DateTimeFormatter.ofPattern("dd/MM/yyyy"),
                DateTimeFormatter.ofPattern("dd-MM-yyyy"),
                DateTimeFormatter.ofPattern("yyyy-MM-dd"),
                DateTimeFormatter.ofPattern("dd/MM/yy"),
                DateTimeFormatter.ofPattern("dd.MM.yyyy")
        };

        for (DateTimeFormatter format : formats) {
            try {
                LocalDate date = LocalDate.parse(dateStr, format);
                return date;
            } catch (DateTimeParseException e) {
            }
        }

        throw new DateTimeParseException("Unsupported date format: " + dateStr, dateStr, 0);
    }

    private String getParameterValue(Map<String, String[]> parameters, String key) {
        String[] values = parameters.get(key);
        return (values != null && values.length > 0) ? values[0] : null;
    }

    public List<Availability> getDoctorAvailability(Long doctorId) {
        return availabilityRepository.findByDoctorId(doctorId);
    }

    public void toggleAvailability(Long id) {
        availabilityRepository.toggleAvailability(id);
    }

    public void deleteAvailability(Long id) {
        availabilityRepository.deleteById(id);
    }

    public List<LocalDate> generateAvailableDays(long doctorId) {
        Doctor doctor = doctorRepository.findDoctor(doctorId);

        List<Availability> availabilities = doctor.getAvailabilities();
        List<Appointments> appointments = doctor.getAppointments();

        List<LocalDate> availableDays = new ArrayList<>();

        for (Availability a : availabilities) {
            if (!a.isAvailable()) continue;

            // 👇 نستخدم التاريخ اللي الطبيب حدده فـ availability
            LocalDate startDate = a.getStartDate();
            LocalDate endDate = a.getEndDate();

            for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
                DayOfWeek dayEnum = DayOfWeek.valueOf(a.getDayOfWeek().name());

                // غير الأيام اللي الطبيب خدام فيها (مثلاً الإثنين أو السبت)
                if (date.getDayOfWeek().equals(dayEnum)) {
                    LocalTime start = a.getStartTime();
                    LocalTime end = a.getEndTime();
                    boolean hasFreeSlot = false;

                    // نحترم المدة اللي الطبيب محددها فـ slotDuration
                    int slotDuration = a.getSlotDuration();
                    int breakDuration = 5; // تقدر تبدلها ولا تخليها param

                    for (LocalTime slotStart = start;
                         slotStart.plusMinutes(slotDuration).isBefore(end);
                         slotStart = slotStart.plusMinutes(slotDuration + breakDuration)) {

                        LocalTime finalSlotStart = slotStart;
                        LocalDate finalDate = date;

                        boolean isTaken = appointments.stream().anyMatch(appt ->
                                appt.getAppointmentDate().equals(finalDate)
                                        && appt.getStartTime().equals(finalSlotStart)
                        );

                        if (!isTaken) {
                            hasFreeSlot = true;
                            break;
                        }
                    }

                    if (hasFreeSlot && !availableDays.contains(date)) {
                        availableDays.add(date);
                    }
                }
            }
        }

        System.out.println("availableDays: " + availableDays.size());
        return availableDays;
    }

}