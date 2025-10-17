package com.cliniquedigitale.repository;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entity.Doctor;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

import java.util.List;

public class DoctorRepository {

    public Doctor findByUserId(Long userId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT d FROM Doctor d WHERE d.user.id = :userId", Doctor.class)
                    .setParameter("userId", userId)
                    .getSingleResult();
        } catch (NoResultException e) {
            System.out.println("No doctor found for user ID: " + userId);
            return null;
        } catch (Exception e) {
            System.err.println("Error finding doctor by user id: " + e.getMessage());
            throw new RuntimeException("Error finding doctor by user id", e);
        } finally {
            em.close();
        }
    }

    public Doctor findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            Doctor doctor = em.find(Doctor.class, id);
            if (doctor != null && doctor.getUser() != null) {
                // Force l'initialisation du user pour éviter LazyInitializationException
                doctor.getUser().getEmail();
            }
            return doctor;
        } catch (Exception e) {
            System.err.println("Error finding doctor by id: " + e.getMessage());
            throw new RuntimeException("Error finding doctor by id", e);
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