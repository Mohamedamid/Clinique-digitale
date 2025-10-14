package com.cliniquedigitale.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class DepartmentDTO {

    private Long id;
    private String name;
    private boolean active;
    private String description;
    private LocalDateTime createdAt = LocalDateTime.now();

    public DepartmentDTO(Long id, String name, boolean active, String description, LocalDateTime createdAt) {
        this.id = id;
        this.name = name;
        this.active = active;
        this.description = description;
        this.createdAt = LocalDateTime.now();
    }

    public DepartmentDTO() {}

    public Long getId() { return id; }

    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }

    public void setName(String name) { this.name = name; }

    public boolean getActive() { return active; }

    public void setActive(boolean active) { this.active = active; }

    public String getDescription() { return description; }

    public void setDescription(String description) { this.description = description; }

    public LocalDateTime getCreatedAt() { return createdAt; }

    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
