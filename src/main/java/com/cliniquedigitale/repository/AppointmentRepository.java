package com.cliniquedigitale.repository;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entity.Appointments;
import com.cliniquedigitale.entity.Patient;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class AppointmentRepository {



    public void save(Appointments appointment) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            if (appointment.getId() == null) {
                em.persist(appointment);
            } else {
                em.merge(appointment);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new RuntimeException("Error saving appointment", e);
        }finally {
            em.close();
        }
    }

    public List<Appointments> findByPatient(Patient patient) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT a FROM Appointments a WHERE a.patient = :patient",
                            Appointments.class)
                    .setParameter("patient", patient)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
