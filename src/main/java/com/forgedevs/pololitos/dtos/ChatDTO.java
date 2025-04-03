package com.forgedevs.pololitos.dtos;

import com.forgedevs.pololitos.models.Chat;
import com.forgedevs.pololitos.models.Message;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ChatDTO {

    private String id;
    private String name;
    private Long creationTimestamp;

    private Long requestId;

    private Long requesterId;
    private String requesterName;
    private String requesterPhoto;

    private Long providerId;
    private String providerName;
    private String providerPhoto;

    private String serviceName;
    private String serviceDescription;
    private String serviceImageUrl;
    private Long serviceId;
    private Double servicePrice;

    private String requestStatus;
    private String additionalComment;

    private List<Message> messages;

    public ChatDTO(Chat chat,
                   Long requesterId,
                   String requesterFirstName,
                   String requesterLastName,
                   String requesterPhoto,
                   Long providerId,
                   String providerFirstName,
                   String providerLastName,
                   String providerPhoto,
                   Long serviceId,
                   String serviceName,
                   String serviceDescription,
                   String serviceImageUrl,
                   String requestStatus,
                   String additionalComment,
                   Double servicePrice) {

        this.id = chat.getId();
        this.name = chat.getName();
        this.creationTimestamp = chat.getCreationTimestamp();

        this.requestId = chat.getRequestId();

        this.requesterId = requesterId;
        this.requesterName = requesterFirstName + " " + requesterLastName;
        this.requesterPhoto = requesterPhoto;

        this.providerId = providerId;
        this.providerName = providerFirstName + " " + providerLastName;
        this.providerPhoto = providerPhoto;

        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.serviceDescription = serviceDescription;
        this.serviceImageUrl = serviceImageUrl;
        this.servicePrice = servicePrice;

        this.requestStatus = requestStatus;
        this.additionalComment = additionalComment;

        this.messages = chat.getMessages();
    }
}
