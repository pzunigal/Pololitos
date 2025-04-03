package com.forgedevs.pololitos.dtos;

public class CreateRequestDTO {
    private Long serviceId;
    private String message;

    public Long getServiceId() {
        return serviceId;
    }

    public void setServiceId(Long serviceId) {
        this.serviceId = serviceId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
