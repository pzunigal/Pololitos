package com.forgedevs.pololitos.dtos;

import com.forgedevs.pololitos.models.OfferedService;

import java.util.Date;

public class ServiceDTO {

    private Long id;
    private String name;
    private String description;
    private Double price;
    private String city;
    private String imageUrl;
    private String userFullName;
    private Long userId;
    private Long categoryId;
    private String categoryName;
    private Date publishDate;
    private Date createdAt;
    private Date updatedAt;

    public ServiceDTO(OfferedService service) {
        this.id = service.getId();
        this.name = service.getName();
        this.description = service.getDescription();
        this.price = service.getPrice();
        this.city = service.getCity();
        this.imageUrl = service.getImageUrl();
        this.userFullName = service.getUser().getFirstName() + " " + service.getUser().getLastName();
        this.userId = service.getUser().getId();
        this.categoryId = service.getCategory().getId();
        this.categoryName = service.getCategory().getName();
        this.publishDate = service.getPublishDate();
        this.createdAt = service.getCreatedAt();
        this.updatedAt = service.getUpdatedAt();
    }

    // Getters

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public Double getPrice() {
        return price;
    }

    public String getCity() {
        return city;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public String getUserFullName() {
        return userFullName;
    }

    public Long getUserId() {
        return userId;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }
}
