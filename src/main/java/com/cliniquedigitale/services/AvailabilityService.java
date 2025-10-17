package com.cliniquedigitale.services;

import com.cliniquedigitale.entity.Availability;
import com.cliniquedigitale.entity.Doctor;
import com.cliniquedigitale.repository.AvailabilityRepository;
import com.cliniquedigitale.repository.DoctorRepository;
import com.cliniquedigitale.util.Validator;
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
        System.out.println("=== Saving availability for user ID: " + userId + " ===");

        // Récupérer le doctorId à partir du userId
//        Doctor doctor = doctorRepository.findByUserId(userId);
//        if (doctor == null) {
//            System.out.println("ERROR: Doctor not found for user ID: " + userId);
//            return Map.of("doctor", "Doctor profile not found for this user"+userId);
//        }

//        Long doctorId = doctor.getId();
//        System.out.println("Found doctor ID: " + doctorId + " for user ID: " + userId);

        // DEBUG: Afficher tous les paramètres
        System.out.println("=== DEBUG PARAMETERS ===");
        for (Map.Entry<String, String[]> entry : parameters.entrySet()) {
            System.out.println(entry.getKey() + ": " + Arrays.toString(entry.getValue()));
        }
        System.out.println("========================");

        Validator validator = new Validator();

        // Validate dates
        String startDateStr = getParameterValue(parameters, "start_date");
        String endDateStr = getParameterValue(parameters, "end_date");

        if (startDateStr == null || endDateStr == null) {
            return Map.of("date_required", "Start date and end date are required");
        }

        System.out.println("Raw start_date: '" + startDateStr + "'");
        System.out.println("Raw end_date: '" + endDateStr + "'");

        validator.required("start_date", startDateStr, "Start date is required");
        validator.required("end_date", endDateStr, "End date is required");

        if (validator.hasErrors()) {
            return validator.getErrors();
        }

        try {
            // Utilisez LocalDate avec parsing robuste
            LocalDate startDate = parseLocalDate(startDateStr);
            LocalDate endDate = parseLocalDate(endDateStr);

            System.out.println("Parsed startDate: " + startDate);
            System.out.println("Parsed endDate: " + endDate);

            if (endDate.isBefore(startDate)) {
                return Map.of("date_range", "End date must be after start date");
            }

            System.out.println("Looking for doctor with ID: " + userId);
            // Vérifier à nouveau le docteur (optionnel)
            Doctor doctorCheck = doctorRepository.findById(userId);
            if (doctorCheck == null) {
                System.out.println("ERROR: Doctor not found in database with ID: " + userId);
                return Map.of("doctor", "Doctor not found with ID: " + userId);
            }

            System.out.println("Found doctor: " + doctorCheck.getMatricule() + " - User: " +
                    (doctorCheck.getUser() != null ? doctorCheck.getUser().getFullName() : "No user"));

            // Delete existing availability for this date range
            availabilityRepository.deleteByDoctorAndDateRange(userId, startDate, endDate);

            // Create new availabilities
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

                        // Validate time range
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
                System.out.println("Successfully saved " + availabilities.size() + " availability records");
            } else {
                System.out.println("No availability records to save");
            }

            return Map.of();

        } catch (DateTimeParseException e) {
            System.out.println("Date parse error: " + e.getMessage());
            return Map.of("date_format", "Invalid date format. Use DD/MM/YYYY, DD-MM-YYYY or YYYY-MM-DD");
        } catch (IllegalArgumentException e) {
            System.out.println("Illegal argument error: " + e.getMessage());
            return Map.of("day_format", "Invalid day format: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return Map.of("system", "Error saving availability: " + e.getMessage());
        }
    }

    // Méthode utilitaire pour parser LocalDate
    private LocalDate parseLocalDate(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Date string is empty");
        }

        dateStr = dateStr.trim();
        System.out.println("Parsing date: '" + dateStr + "'");

        // Essayer différents formats
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
                System.out.println("Successfully parsed with format: " + format);
                return date;
            } catch (DateTimeParseException e) {
                System.out.println("Failed with format: " + format);
            }
        }

        throw new DateTimeParseException("Unsupported date format: " + dateStr, dateStr, 0);
    }

    // Méthode utilitaire pour récupérer les paramètres
    private String getParameterValue(Map<String, String[]> parameters, String key) {
        String[] values = parameters.get(key);
        return (values != null && values.length > 0) ? values[0] : null;
    }

    // Autres méthodes du service
    public List<Availability> getDoctorAvailability(Long doctorId) {
        return availabilityRepository.findByDoctorId(doctorId);
    }

    public Availability getAvailabilityById(Long id) {
        return availabilityRepository.findById(id);
    }

    public List<Availability> getAllAvailabilities() {
        return availabilityRepository.findAll();
    }

    public void deleteAvailability(Long id) {
        availabilityRepository.deleteById(id);
    }

    public boolean existsByDoctorAndDateRange(Long doctorId, LocalDate startDate, LocalDate endDate) {
        return availabilityRepository.existsByDoctorAndDateRange(doctorId, startDate, endDate);
    }
}