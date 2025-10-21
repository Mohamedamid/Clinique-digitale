package com.cliniquedigitale.repository;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entity.Staff;
import jakarta.persistence.EntityManager;

import java.util.List;

public class StaffRepository {

    public Staff findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Staff.class, id);
        } finally {
            em.close();
        }
    }

    public void save(Staff staff) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(staff);
            em.getTransaction().commit();
            System.out.println("Staff saved: " + staff.getUser().getFullName());
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            throw new RuntimeException("Error saving staff: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    public void edit(Staff staff) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            em.merge(staff);

            em.getTransaction().commit();
            System.out.println("Staff updated: " + staff.getUser().getFullName());

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("Error updating staff: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    public List<Staff> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT s FROM Staff s", Staff.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Staff staff = em.find(Staff.class, id);
            if (staff != null) {
                em.remove(staff);
                System.out.println("Staff deleted: " + staff.getUser().getFullName());
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            throw new RuntimeException("Error deleting staff: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }
}