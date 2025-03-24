package com.repositorios;
import org.springframework.data.jpa.repository.JpaRepository;
import com.modelos.Chat;

public interface RepositorioChatMySQL extends JpaRepository<Chat, String> {
    Chat findBySolicitudId(Long solicitudId);
}

