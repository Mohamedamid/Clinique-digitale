package com.cliniquedigitale.controllers.patient;

import com.cliniquedigitale.dto.DoctorDTO;
import com.cliniquedigitale.dto.SpecialiteDTO;
import com.cliniquedigitale.entity.Appointments;
import com.cliniquedigitale.entity.Doctor;
import com.cliniquedigitale.repository.DoctorRepository;
import com.cliniquedigitale.services.AppointmentService;

import com.cliniquedigitale.services.DoctorService;
import com.cliniquedigitale.services.SpecialiteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;


@WebServlet("/patient/appointments")
public class AppointmentPageServlet  extends HttpServlet {
    private final AppointmentService appointmentService = new AppointmentService();
    private final DoctorRepository doctorRepository = new DoctorRepository();
    private final SpecialiteService specialiteService = new SpecialiteService();
    private final DoctorService doctorService = new DoctorService();

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String userRole = (String) session.getAttribute("userRole");

        if (!"PATIENT".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        Long userId = (Long) session.getAttribute("userId");

        List<Appointments> appointmentsPatient = appointmentService.getAppointmentsByPatient(userId);

        List<SpecialiteDTO> specialties = specialiteService.getAllSpecialites();
        List<DoctorDTO> doctors = doctorService.getAllDoctors();
        req.setAttribute("doctors",doctors);
        req.setAttribute("specialties", specialties);
        req.setAttribute("appointmentsPatient",appointmentsPatient);
        req.getRequestDispatcher("/views/patient/index.jsp").forward(req, resp);

    }


    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("doctorId"));
        LocalDate dateAppointment = LocalDate.parse(req.getParameter("date"));

        try{
            HttpSession session = req.getSession(false);

            if (session == null || session.getAttribute("user") == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            String userRole = (String) session.getAttribute("userRole");

            if (!"PATIENT".equals(userRole)) {
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            }

            Long userId = (Long) session.getAttribute("userId");

            Doctor doctor = doctorRepository.findById(id);

            Long doctorId = doctor.getId();

            System.out.println("idddddddd: "+ doctorId);
            System.out.println("makeAppointment");
            appointmentService.makeAppointment(id,dateAppointment,userId);
            req.setAttribute("success","appointment  taking successfully!");
            resp.sendRedirect(req.getContextPath() + "/patient/doctors/"+id);
        }catch(Exception e) {
            System.out.println("pas makeAppointment");
            req.setAttribute("error", "Error taking appointment: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/patient/doctors/"+id);
        }
    }
}