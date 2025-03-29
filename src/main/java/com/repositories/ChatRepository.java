package com.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.models.Chat;

public interface ChatRepository extends JpaRepository<Chat, String> {
    
    Chat findByRequestId(Long requestId);
}
