package com.cliniquedigitale.services;

import com.cliniquedigitale.entity.Appointments;
import com.cliniquedigitale.entity.Availability;
import com.cliniquedigitale.entity.Doctor;
import com.cliniquedigitale.entity.Patient;
import com.cliniquedigitale.repository.AppointmentRepository;
import com.cliniquedigitale.repository.DoctorRepository;
import com.cliniquedigitale.repository.PatientRepository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

public class AppointmentService {

    private final DoctorRepository doctorRepo = new DoctorRepository();
    private final PatientRepository patientRepo = new PatientRepository();
    private final AppointmentRepository appointmentRepo = new AppointmentRepository();

    public void makeAppointment(long doctorId, LocalDate date, long userId) {

        Patient patient = patientRepo.findByUserId(userId);
        Doctor doctor = doctorRepo.findDoctor(doctorId);

        if (patient == null || doctor == null) {
            throw new RuntimeException("Patient ou docteur introuvable !");
        }

        List<Availability> availabilities = doctor.getAvailabilities();
        List<Appointments> appointments = doctor.getAppointments();

        for (Availability availability : availabilities) {

            if (!availability.isAvailable()) continue;

            // ✅ تحقق واش التاريخ داخل الفترة و النهار مطابق
            if (date.getDayOfWeek().name().equals(availability.getDayOfWeek().name()) &&
                    !date.isBefore(availability.getStartDate()) &&
                    !date.isAfter(availability.getEndDate())) {

                LocalTime start = availability.getStartTime();
                LocalTime end = availability.getEndTime();

                while (!start.plusMinutes(30).isAfter(end)) {
                    final LocalTime startSlot = start;
                    LocalTime slotEnd = start.plusMinutes(30);

                    boolean taken = appointments.stream().anyMatch(a ->
                            a.getAppointmentDate().equals(date) &&
                                    a.getStartTime().equals(startSlot)
                    );

                    if (!taken) {
                        Appointments appt = new Appointments();
                        appt.setDoctor(doctor);
                        appt.setPatient(patient);
                        appt.setAppointmentDate(date);
                        appt.setStartTime(start);
                        appt.setEndTime(slotEnd);

                        appointmentRepo.save(appt);
                        System.out.println("✅ Rendez-vous créé avec succès !");
                        return;
                    }

                    start = start.plusMinutes(35); // 30 min + 5 min break
                }
            }
        }

        throw new RuntimeException("Aucun créneau disponible pour cette date !");
    }


    public List<Appointments> getAppointmentsByPatient(long userId) {
        Patient patient = patientRepo.findByUserId(userId);
        if (patient == null) {
            throw new RuntimeException("Patient introuvable !");
        }
        return appointmentRepo.findByPatient(patient);
    }
}
