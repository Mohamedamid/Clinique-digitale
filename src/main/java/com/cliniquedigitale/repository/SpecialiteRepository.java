package com.cliniquedigitale.repository;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entity.Specialite;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class SpecialiteRepository {

    public Specialite findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Specialite.class, id);
        } finally {
            em.close();
        }
    }

    public List<Specialite> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Specialite> query = em.createQuery(
                    "SELECT s FROM Specialite s LEFT JOIN FETCH s.department ORDER BY s.name",
                    Specialite.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void save(Specialite specialite) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(specialite);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw new RuntimeException("Error saving specialite", e);
        } finally {
            em.close();
        }
    }

    public void edit(Specialite specialite) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            
            Specialite existing = em.find(Specialite.class, specialite.getId());
            if (existing != null) {
                em.merge(specialite);
                em.getTransaction().commit();
            } else {
                em.getTransaction().rollback();
                throw new RuntimeException("Specialite not found with id: " + specialite.getId());
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Error updating specialite", e);
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Specialite dept = em.find(Specialite.class, id);
            if (dept != null) {
                em.remove(dept);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw new RuntimeException("Error deleting specialite", e);
        } finally {
            em.close();
        }
    }
}
