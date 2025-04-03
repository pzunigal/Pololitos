package com.forgedevs.pololitos.services;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.forgedevs.pololitos.models.Request;
import com.forgedevs.pololitos.models.User;
import com.forgedevs.pololitos.repositories.RequestRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
public class RequestService {

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private RequestRepository requestRepository;

    // Para solicitudes enviadas: activas ("Enviada" o "Aceptada")
    public Page<Request> getPaginatedActiveRequestsByRequester(User requester, Pageable pageable) {
        List<String> activeStatuses = Arrays.asList("Enviada", "Aceptada");
        return requestRepository.findByRequesterAndStatusIn(requester, activeStatuses, pageable);
    }

    // Para solicitudes enviadas: inactivas ("Cancelada", "Completada", "Rechazada")
    public Page<Request> getPaginatedInactiveRequestsByRequester(User requester, Pageable pageable) {
        List<String> inactiveStatuses = Arrays.asList("Cancelada", "Completada", "Rechazada");
        return requestRepository.findByRequesterAndStatusIn(requester, inactiveStatuses, pageable);
    }

    // Para solicitudes recibidas: activas ("Enviada" o "Aceptada")
    public Page<Request> getPaginatedActiveRequestsByProvider(User provider, Pageable pageable) {
        List<String> activeStatuses = Arrays.asList("Enviada", "Aceptada");
        return requestRepository.findByServiceUserAndStatusIn(provider, activeStatuses, pageable);
    }

    // Para solicitudes recibidas: inactivas ("Rechazada", "Completada",
    // "Cancelada")
    public Page<Request> getPaginatedInactiveRequestsByProvider(User provider, Pageable pageable) {
        List<String> inactiveStatuses = Arrays.asList("Rechazada", "Completada", "Cancelada");
        return requestRepository.findByServiceUserAndStatusIn(provider, inactiveStatuses, pageable);
    }

    // Guarda o actualiza una solicitud
    public void saveRequest(Request request) {
        requestRepository.save(request);
    }

    // Obtiene una solicitud por su id
    public Request getRequestById(Long id) {
        Optional<Request> optionalRequest = requestRepository.findById(id);
        return optionalRequest.orElse(null);

    }

    public String updateRequestStatus(Long requestId, String expectedStatus, String newStatus) {
    Request request = getRequestById(requestId);
    if (request == null) {
        throw new EntityNotFoundException("Solicitud no encontrada.");
    }
    if (!request.getStatus().equals(expectedStatus)) {
        throw new IllegalArgumentException("La solicitud ya fue actualizada.");
    }
    request.setStatus(newStatus);
    saveRequest(request);
    notificationService.notifyStatusChange(request, newStatus);
    return "Estado actualizado correctamente.";
}

public String cancelRequest(Long requestId, User user) {
    Request request = getRequestById(requestId);
    if (request == null) {
        throw new EntityNotFoundException("Solicitud no encontrada.");
    }
    if (!request.getRequester().getId().equals(user.getId())) {
        throw new SecurityException("No tienes permiso para cancelar esta solicitud.");
    }
    if (!request.getStatus().equals("Enviada") && !request.getStatus().equals("Aceptada")) {
        throw new IllegalArgumentException("La solicitud ya fue actualizada.");
    }
    request.setStatus("Cancelada");
    saveRequest(request);
    notificationService.notifyStatusChange(request, "Cancelada");
    return "Solicitud cancelada correctamente.";
}
}
