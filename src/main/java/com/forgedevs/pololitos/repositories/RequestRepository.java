package com.forgedevs.pololitos.repositories;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.forgedevs.pololitos.models.Request;
import com.forgedevs.pololitos.models.User;

@Repository
public interface RequestRepository extends JpaRepository<Request, Long> {

    // Para solicitudes enviadas (por el requester)
    Page<Request> findByRequesterAndStatusIn(User requester, List<String> statuses, Pageable pageable);

    // Para solicitudes recibidas (por el proveedor), filtrando por un conjunto de estados
    Page<Request> findByServiceUserAndStatusIn(User provider, List<String> statuses, Pageable pageable);
}
