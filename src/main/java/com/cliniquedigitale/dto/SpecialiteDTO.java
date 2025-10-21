package com.cliniquedigitale.dto;

public class SpecialiteDTO {
    private Long id;
    private String name;
    private boolean active;
    private String description;
    private Long departmentId;
    private String departmentName;

    public SpecialiteDTO(Long id, String name, boolean active, String description,
                         Long departmentId, String departmentName) {
        this.id = id;
        this.name = name;
        this.active = active;
        this.description = description;
        this.departmentId = departmentId;
        this.departmentName = departmentName;
    }

    public SpecialiteDTO(Long id, String name, boolean active, String description,
                         Long departmentId) {
        this(id, name, active, description, departmentId, null);
    }

    // Getters et setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public boolean getActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Long getDepartmentId() { return departmentId; }
    public void setDepartmentId(Long departmentId) { this.departmentId = departmentId; }

    public String getDepartmentName() { return departmentName; }
    public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }
}