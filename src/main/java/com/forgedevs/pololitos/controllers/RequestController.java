package com.forgedevs.pololitos.controllers;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.forgedevs.pololitos.dtos.RequestDTO;
import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.models.Request;
import com.forgedevs.pololitos.models.User;
import com.forgedevs.pololitos.repositories.ChatRepository;
import com.forgedevs.pololitos.services.JwtService;
import com.forgedevs.pololitos.services.NotificationService;
import com.forgedevs.pololitos.services.RequestService;
import com.forgedevs.pololitos.services.ServiceService;
import com.forgedevs.pololitos.services.UserService;

@RestController
@RequestMapping("/api/requests")
@CrossOrigin(origins = "http://localhost:3000")
public class RequestController {

    @Autowired
    private RequestService requestService;

    @Autowired
    private ServiceService serviceService;

    @Autowired
    private ChatRepository chatRepository;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private JwtService jwtService;

    @Autowired
    private UserService userService;

    @PostMapping("/create")
    public ResponseEntity<?> createRequest(@RequestBody Map<String, Object> payload,
            @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            Long userId = jwtService.extractUserId(token);
            User requester = userService.findById(userId);

            Long serviceId = Long.valueOf(payload.get("serviceId").toString());
            String message = payload.get("message").toString();

            OfferedService service = serviceService.getById(serviceId);
            if (service == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Servicio no encontrado.");
            }

            Request newRequest = new Request();
            newRequest.setRequester(requester);
            newRequest.setService(service);
            newRequest.setStatus("Enviada");
            newRequest.setRequestDate(new Date());
            newRequest.setAdditionalComment(message);

            requestService.saveRequest(newRequest);
            notificationService.notifyNewRequest(newRequest);

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Solicitud creada exitosamente.");
            response.put("requestId", newRequest.getId());

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error al crear solicitud: " + e.getMessage());
        }
    }

    @GetMapping("/my-sent")
    public ResponseEntity<?> viewMySentRequests(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "2") int size,
            @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            Long userId = jwtService.extractUserId(token);
            User loggedInUser = userService.findById(userId);

            Pageable pageable = PageRequest.of(page, size, Sort.by("requestDate").descending());

            Page<Request> allRequests = requestService.getPaginatedRequestsByRequester(loggedInUser, pageable);

            List<RequestDTO> active = allRequests.getContent().stream()
                    .filter(r -> r.getStatus().equals("Enviada") || r.getStatus().equals("Aceptada"))
                    .map(RequestDTO::new)
                    .toList();

            List<RequestDTO> inactive = allRequests.getContent().stream()
                    .filter(r -> r.getStatus().equals("Cancelada") || r.getStatus().equals("Completada")
                            || r.getStatus().equals("Rechazada"))
                    .map(RequestDTO::new)
                    .toList();

            Map<Long, Boolean> chatCreated = new HashMap<>();
            for (RequestDTO dto : active) {
                chatCreated.put(dto.getId(), chatRepository.findByRequestId(dto.getId()) != null);
            }

            Map<String, Object> response = new HashMap<>();
            response.put("active", active);
            response.put("inactive", inactive);
            response.put("chatCreated", chatCreated);
            response.put("total", allRequests.getTotalElements());
            response.put("page", page);
            response.put("size", size);

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("Error al obtener solicitudes: " + e.getMessage());
        }
    }

    @GetMapping("/my-received")
    public ResponseEntity<?> viewMyReceivedRequests(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "4") int size,
            @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            Long userId = jwtService.extractUserId(token);
            User loggedInUser = userService.findById(userId);

            Pageable pageable = PageRequest.of(page, size, Sort.by("requestDate").descending());

            Page<Request> allRequests = requestService.getPaginatedRequestsByServiceProvider(loggedInUser, pageable);

            List<RequestDTO> active = allRequests.getContent().stream()
                    .filter(r -> r.getStatus().equals("Enviada") || r.getStatus().equals("Aceptada"))
                    .map(RequestDTO::new)
                    .toList();

            List<RequestDTO> inactive = allRequests.getContent().stream()
                    .filter(r -> r.getStatus().equals("Rechazada") || r.getStatus().equals("Completada"))
                    .map(RequestDTO::new)
                    .toList();

            Map<Long, Boolean> chatCreated = new HashMap<>();
            for (RequestDTO dto : active) {
                chatCreated.put(dto.getId(), chatRepository.findByRequestId(dto.getId()) != null);
            }

            Map<String, Object> response = new HashMap<>();
            response.put("active", active);
            response.put("inactive", inactive);
            response.put("chatCreated", chatCreated);
            response.put("total", allRequests.getTotalElements());
            response.put("page", page);
            response.put("size", size);

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("Error al obtener solicitudes recibidas: " + e.getMessage());
        }
    }

    private ResponseEntity<?> updateRequestStatus(Long requestId, String expectedStatus, String newStatus) {
        Request request = requestService.getRequestById(requestId);
        if (request == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Solicitud no encontrada.");
        }

        if (!request.getStatus().equals(expectedStatus)) {
            return ResponseEntity.badRequest().body("La solicitud ya fue actualizada.");
        }

        request.setStatus(newStatus);
        requestService.saveRequest(request);
        notificationService.notifyStatusChange(request, newStatus);

        return ResponseEntity.ok("Estado actualizado correctamente.");
    }

    @PatchMapping("/{requestId}/accept")
    public ResponseEntity<?> acceptRequest(@PathVariable Long requestId) {
        return updateRequestStatus(requestId, "Enviada", "Aceptada");
    }

    @PatchMapping("/{requestId}/reject")
    public ResponseEntity<?> rejectRequest(@PathVariable Long requestId) {
        return updateRequestStatus(requestId, "Enviada", "Rechazada");
    }

    @PatchMapping("/{requestId}/complete")
    public ResponseEntity<?> completeRequest(@PathVariable Long requestId) {
        return updateRequestStatus(requestId, "Aceptada", "Completada");
    }

    @PatchMapping("/{requestId}/cancel")
    public ResponseEntity<?> cancelRequest(@PathVariable Long requestId,
            @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            Long userId = jwtService.extractUserId(token);
            User user = userService.findById(userId);

            Request request = requestService.getRequestById(requestId);
            if (request == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Solicitud no encontrada.");
            }

            if (!request.getRequester().getId().equals(user.getId())) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("No tienes permiso para cancelar esta solicitud.");
            }

            if (!request.getStatus().equals("Enviada") && !request.getStatus().equals("Aceptada")) {
                return ResponseEntity.badRequest().body("La solicitud ya fue actualizada.");
            }

            request.setStatus("Cancelada");
            requestService.saveRequest(request);
            notificationService.notifyStatusChange(request, "Cancelada");

            return ResponseEntity.ok("Solicitud cancelada correctamente.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error al cancelar solicitud: " + e.getMessage());
        }
    }

}