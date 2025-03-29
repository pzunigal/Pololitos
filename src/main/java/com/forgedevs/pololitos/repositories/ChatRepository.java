package com.forgedevs.pololitos.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.forgedevs.pololitos.models.Chat;

public interface ChatRepository extends JpaRepository<Chat, String> {
    
    Chat findByRequestId(Long requestId);
}
