package com.cliniquedigitale.repository;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entity.Patient;
import com.cliniquedigitale.entity.Patient;
import com.cliniquedigitale.entity.Patient;
import com.cliniquedigitale.entity.Patient;
import jakarta.persistence.EntityManager;

import java.util.List;

public class PatientRepository{

    /**
     * Save a new patient
     */
    public void save(Patient patient) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(patient);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Error saving patient", e);
        } finally {
            em.close();
        }
    }

    public void edit(Patient patient) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            em.merge(patient);

            em.getTransaction().commit();
            System.out.println("✅ Patient updated: " + patient.getUser().getFullName());

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("Error updating patient: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Patient patient = em.find(Patient.class, id);
            if (patient != null) {
                em.remove(patient);
                System.out.println("✅ Patient deleted: " + patient.getUser().getFullName());
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            throw new RuntimeException("Error deleting patient: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    public Patient findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Patient.class, id);
        } finally {
            em.close();
        }
    }

    public List<Patient> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Patient p", Patient.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

}