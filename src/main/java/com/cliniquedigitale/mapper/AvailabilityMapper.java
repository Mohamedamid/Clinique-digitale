package com.cliniquedigitale.mapper;

import com.cliniquedigitale.dto.AvailabilityDTO;
import com.cliniquedigitale.entity.Availability;
import com.cliniquedigitale.entity.Doctor;

public class AvailabilityMapper {

    public static Availability toEntity(AvailabilityDTO dto, Doctor doctor) {
        if (dto == null) {
            return null;
        }

        Availability availability = new Availability();
        availability.setId(dto.getId());
        availability.setDayOfWeek(dto.getDayOfWeek());
        availability.setStartTime(dto.getStartTime());
        availability.setEndTime(dto.getEndTime());
        availability.setAvailable(dto.isAvailable());
        availability.setSlotDuration(dto.getSlotDuration());
        availability.setStartDate(dto.getStartDate());
        availability.setEndDate(dto.getEndDate());
        availability.setDoctor(doctor);
        return availability;
    }

    public static AvailabilityDTO toDTO(Availability availability) {
        if (availability == null) {
            return null;
        }

        String doctorName = "";
        if (availability.getDoctor() != null &&
                availability.getDoctor().getUser() != null) {
            doctorName = availability.getDoctor().getUser().getFullName();
        }

        return new AvailabilityDTO(
                availability.getId(),
                availability.getDayOfWeek(),
                availability.getStartTime(),
                availability.getEndTime(),
                availability.isAvailable(),
                availability.getSlotDuration(),
                availability.getStartDate(),
                availability.getEndDate(),
                availability.getDoctor() != null ? availability.getDoctor().getId() : null,
                doctorName
        );
    }
}