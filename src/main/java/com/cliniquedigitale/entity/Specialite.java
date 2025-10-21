package com.cliniquedigitale.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "specialites")
public class Specialite {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "is_active")
    private boolean isActive = true;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;
    
    public Specialite() {}

    public Specialite(String name, String description, Department department) {
        this.name = name;
        this.description = description;
        this.department = department;
        this.isActive = true;
    }

    // getters/setters...
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    public Department getDepartment() { return department; }
    public void setDepartment(Department department) { this.department = department; }
}
