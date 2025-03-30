package com.forgedevs.pololitos.dtos;

import java.util.List;
import java.util.stream.Collectors;

import com.forgedevs.pololitos.models.Category;

public class CategoryDTO {

    private Long id;
    private String name;
    private List<ServiceDTO> services;

    public CategoryDTO(Category category) {
        this.id = category.getId();
        this.name = category.getName();
        this.services = category.getServices()
                .stream()
                .map(ServiceDTO::new)
                .collect(Collectors.toList());
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public List<ServiceDTO> getServices() {
        return services;
    }
}
