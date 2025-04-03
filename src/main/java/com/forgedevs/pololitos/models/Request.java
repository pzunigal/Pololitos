package com.forgedevs.pololitos.models;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "requests")
public class Request {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "requester_id", nullable = false)
    private User requester;

    @ManyToOne
    @JoinColumn(name = "service_id", nullable = false)
    private OfferedService service;

    @NotBlank(message = "El estado de la solicitud es obligatorio")
    private String status;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date requestDate = new Date();

    private String additionalComment;

    @Column(updatable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createdAt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updatedAt;

    public Request() {}

    @PrePersist
    protected void onCreate() {
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = new Date();
    }

    // Getters
    public Long getId() {
        return id;
    }

    public User getRequester() {
        return requester;
    }

    public OfferedService getService() {
        return service;
    }

    public String getStatus() {
        return status;
    }

    public Date getRequestDate() {
        return requestDate;
    }

    public String getAdditionalComment() {
        return additionalComment;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public User getProvider() {
        return service.getUser();
    }

    // Setters
    public void setId(Long id) {
        this.id = id;
    }

    public void setRequester(User requester) {
        this.requester = requester;
    }

    public void setService(OfferedService service) {
        this.service = service;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }

    public void setAdditionalComment(String additionalComment) {
        this.additionalComment = additionalComment;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
}
