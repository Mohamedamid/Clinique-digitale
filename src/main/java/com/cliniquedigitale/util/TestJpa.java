package com.cliniquedigitale.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class TestJpa {
    public static  void main(String args[]){
        try {
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("cliniquePU");
            EntityManager em = emf.createEntityManager();
            System.out.println("JPA SUCCESS: connexion & persistence.xml OK");

            em.close();
            emf.close();
        } catch (Exception e) {
//            resp.getWriter().println("JPA FAILED: " + e.getMessage());
//            e.printStackTrace(resp.getWriter());
            System.out.println(e.getMessage());
        }
    }
}
