package com.cliniquedigitale.repository;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entity.Doctor;
import jakarta.persistence.EntityManager;

import java.util.List;

public class DoctorRepository {

    public Doctor findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Doctor.class, id);
        } finally {
            em.close();
        }
    }

    public void save(Doctor doctor) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(doctor);
            em.getTransaction().commit();
            System.out.println("✅ Doctor saved: " + doctor.getUser().getFullName());
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            throw new RuntimeException("Error saving doctor: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    public void edit(Doctor doctor) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            // Utiliser merge pour mettre à jour l'entité détachée
            em.merge(doctor);

            em.getTransaction().commit();
            System.out.println("✅ Doctor updated: " + doctor.getUser().getFullName());

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("Error updating doctor: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    public List<Doctor> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Doctor d JOIN FETCH d.user JOIN FETCH d.specialite", Doctor.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Doctor doctor = em.find(Doctor.class, id);
            if (doctor != null) {
                em.remove(doctor);
                System.out.println("✅ Doctor deleted: " + doctor.getUser().getFullName());
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            throw new RuntimeException("Error deleting doctor: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }
}