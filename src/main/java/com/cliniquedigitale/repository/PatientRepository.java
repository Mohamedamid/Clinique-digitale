package com.cliniquedigitale.repository;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entity.Patient;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class PatientRepository{

    public Patient save(Patient patient){
        EntityManager em  = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try{
            tx.begin();
            em.persist(patient);
            tx.commit();
            return patient;
        }catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            // Optionally translate and throw a custom exception
            throw e;
        } finally {
            em.close();
        }
    }
}