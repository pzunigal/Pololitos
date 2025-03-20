package com.repositorios;
import org.springframework.data.jpa.repository.JpaRepository;
import com.modelos.Chat;

public interface RepositorioChatMySQL extends JpaRepository<Chat, Long> {
    // Aquí puedes agregar un método que te permita obtener el chat por solicitudId
    Chat findBySolicitudId(Long solicitudId);
}
