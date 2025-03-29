package com.models;

import java.util.Date;
import java.time.Instant;

public class Message {

    private String id;
    private String content;
    private Long userId;
    private String userName;
    private String createdAt;

    public Message() {
        this.createdAt = Date.from(Instant.now()).toInstant().toString();
    }

    public Message(String content, Long userId, String userName) {
        this.content = content;
        this.userId = userId;
        this.userName = userName;
        this.createdAt = Date.from(Instant.now()).toInstant().toString();
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public Date getCreatedAtAsDate() {
        try {
            return Date.from(Instant.parse(createdAt));
        } catch (Exception e) {
            return null;
        }
    }
}
