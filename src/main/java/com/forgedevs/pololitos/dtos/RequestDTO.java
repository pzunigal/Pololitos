package com.forgedevs.pololitos.dtos;

import com.forgedevs.pololitos.models.Request;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class RequestDTO {
    private Long id;
    private String status;
    private String additionalComment;
    private Date requestDate;

    private Long serviceId;
    private String serviceName;
    private String serviceImageUrl;

    private Long requesterId;
    private String requesterName;

    private Long providerId;
    private String providerName;

    private boolean chatCreated;
    private String chatId;

    public RequestDTO(Request r) {
        this.id = r.getId();
        this.status = r.getStatus();
        this.additionalComment = r.getAdditionalComment();
        this.requestDate = r.getRequestDate();

        this.serviceId = r.getService().getId();
        this.serviceName = r.getService().getName();
        this.serviceImageUrl = r.getService().getImageUrl();

        this.requesterId = r.getRequester().getId();
        this.requesterName = r.getRequester().getFirstName() + " " + r.getRequester().getLastName();

        this.providerId = r.getService().getUser().getId();
        this.providerName = r.getService().getUser().getFirstName() + " " + r.getService().getUser().getLastName();
    }
}
