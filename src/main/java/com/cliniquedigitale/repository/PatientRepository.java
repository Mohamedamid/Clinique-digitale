package com.cliniquedigitale.repository;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entity.Patient;
import jakarta.persistence.EntityManager;

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

}