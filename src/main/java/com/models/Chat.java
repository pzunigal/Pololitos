package com.models;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Transient;

import java.util.ArrayList;
import java.util.List;

@Entity
public class Chat {

    @Id
    private String id;

    private String name;

    private long creationTimestamp;

    @Transient
    private List<Message> messages;

    private Long requesterId;
    private Long requestId;

    public Chat() {
        this.messages = new ArrayList<>();
    }

    public Chat(String id, String name, long creationTimestamp, List<Message> messages, Long requesterId, Long requestId) {
        this.id = id;
        this.name = name;
        this.creationTimestamp = creationTimestamp;
        this.messages = messages;
        this.requesterId = requesterId;
        this.requestId = requestId;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getCreationTimestamp() {
        return creationTimestamp;
    }

    public void setCreationTimestamp(long creationTimestamp) {
        this.creationTimestamp = creationTimestamp;
    }

    public List<Message> getMessages() {
        return messages;
    }

    public void setMessages(List<Message> messages) {
        this.messages = messages;
    }

    public Long getRequesterId() {
        return requesterId;
    }

    public void setRequesterId(Long requesterId) {
        this.requesterId = requesterId;
    }

    public Long getRequestId() {
        return requestId;
    }

    public void setRequestId(Long requestId) {
        this.requestId = requestId;
    }
}
