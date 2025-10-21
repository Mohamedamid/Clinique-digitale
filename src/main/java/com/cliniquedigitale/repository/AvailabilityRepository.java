package com.cliniquedigitale.repository;

import com.cliniquedigitale.entity.Availability;
import com.cliniquedigitale.config.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.time.LocalDate;
import java.util.List;

public class AvailabilityRepository {

    public void save(Availability availability) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (availability.getId() == null) {
                em.persist(availability);
            } else {
                em.merge(availability);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Error saving availability", e);
        } finally {
            em.close();
        }
    }

    public void saveAll(List<Availability> availabilities) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            for (Availability availability : availabilities) {
                if (availability.getId() == null) {
                    em.persist(availability);
                } else {
                    em.merge(availability);
                }
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Error saving availabilities", e);
        } finally {
            em.close();
        }
    }

    public void deleteByDoctorAndDateRange(Long doctorId, LocalDate startDate, LocalDate endDate) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            int deletedCount = em.createQuery(
                            "DELETE FROM Availability a WHERE a.doctor.id = :doctorId " +
                                    "AND a.startDate = :startDate AND a.endDate = :endDate")
                    .setParameter("doctorId", doctorId)
                    .setParameter("startDate", startDate)
                    .setParameter("endDate", endDate)
                    .executeUpdate();

            em.getTransaction().commit();
            System.out.println("Deleted " + deletedCount + " existing availability records");

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Error deleting availabilities", e);
        } finally {
            em.close();
        }
    }

    public List<Availability> findByDoctorId(Long doctorId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT a FROM Availability a WHERE a.doctor.id = :doctorId ORDER BY a.dayOfWeek, a.startTime",
                            Availability.class)
                    .setParameter("doctorId", doctorId)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Error finding availabilities by doctor id", e);
        } finally {
            em.close();
        }
    }

    public Availability findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Availability.class, id);
        } finally {
            em.close();
        }
    }

    public List<Availability> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT a FROM Availability a ORDER BY a.doctor.id, a.dayOfWeek, a.startTime",
                            Availability.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void deleteById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Availability availability = em.find(Availability.class, id);
            if (availability != null) {
                em.remove(availability);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Error deleting availability", e);
        } finally {
            em.close();
        }
    }

    public boolean existsByDoctorAndDateRange(Long doctorId, LocalDate startDate, LocalDate endDate) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            Long count = em.createQuery(
                            "SELECT COUNT(a) FROM Availability a WHERE a.doctor.id = :doctorId " +
                                    "AND a.startDate = :startDate AND a.endDate = :endDate", Long.class)
                    .setParameter("doctorId", doctorId)
                    .setParameter("startDate", startDate)
                    .setParameter("endDate", endDate)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }

    public void toggleAvailability(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            Availability availability = em.find(Availability.class, id);
            if (availability != null) {
                availability.setAvailable(!availability.isAvailable());
                em.merge(availability);
            }

            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}