package com.cliniquedigitale.repository;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entity.Department;
import jakarta.persistence.EntityManager;
import java.util.List;

public class DepartmentRepository {

    public void save(Department department) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(department);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw new RuntimeException("Error saving department", e);
        } finally {
            em.close();
        }
    }

    public Department findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Department.class, id);
        } finally {
            em.close();
        }
    }

    public List<Department> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Department d", Department.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void edit(Department department) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            
            Department existing = em.find(Department.class, department.getId());
            if (existing != null) {
                em.merge(department);
                em.getTransaction().commit();
            } else {
                em.getTransaction().rollback();
                throw new RuntimeException("Department not found with id: " + department.getId());
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Error updating department", e);
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Department dept = em.find(Department.class, id);
            if (dept != null) {
                em.remove(dept);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw new RuntimeException("Error deleting department", e);
        } finally {
            em.close();
        }
    }
}
