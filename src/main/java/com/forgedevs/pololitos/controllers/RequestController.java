package com.forgedevs.pololitos.controllers;

import java.util.Date;
import java.util.HashMap;

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

    @GetMapping("/my-sent/active")
    public ResponseEntity<?> viewMySentActiveRequests(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "2") int size,
            @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            Long userId = jwtService.extractUserId(token);
            User loggedInUser = userService.findById(userId);

            Pageable pageable = PageRequest.of(page, size, Sort.by("requestDate").descending());
            Page<Request> activePage = requestService.getPaginatedActiveRequestsByRequester(loggedInUser, pageable);

            // Convertimos a DTO sin agregar 'chatCreated'
            Page<RequestDTO> dtoPage = activePage.map(RequestDTO::new);
            return ResponseEntity.ok(dtoPage);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("Error al obtener solicitudes activas: " + e.getMessage());
        }
    }

    @GetMapping("/my-sent/inactive")
    public ResponseEntity<?> viewMySentInactiveRequests(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "2") int size,
            @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            Long userId = jwtService.extractUserId(token);
            User loggedInUser = userService.findById(userId);

            Pageable pageable = PageRequest.of(page, size, Sort.by("requestDate").descending());
            Page<Request> inactivePage = requestService.getPaginatedInactiveRequestsByRequester(loggedInUser, pageable);

            Page<RequestDTO> dtoPage = inactivePage.map(RequestDTO::new);
            return ResponseEntity.ok(dtoPage);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("Error al obtener solicitudes inactivas: " + e.getMessage());
        }
    }

    @GetMapping("/my-received/active")
    public ResponseEntity<?> viewMyReceivedActiveRequests(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "4") int size,
            @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            Long userId = jwtService.extractUserId(token);
            User loggedInUser = userService.findById(userId);

            Pageable pageable = PageRequest.of(page, size, Sort.by("requestDate").descending());
            Page<Request> activePage = requestService.getPaginatedActiveRequestsByProvider(loggedInUser, pageable);

            // Convertimos a DTO
            Page<RequestDTO> dtoPage = activePage.map(RequestDTO::new);
            return ResponseEntity.ok(dtoPage);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("Error al obtener solicitudes recibidas activas: " + e.getMessage());
        }
    }

    @GetMapping("/my-received/inactive")
    public ResponseEntity<?> viewMyReceivedInactiveRequests(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "4") int size,
            @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            Long userId = jwtService.extractUserId(token);
            User loggedInUser = userService.findById(userId);

            Pageable pageable = PageRequest.of(page, size, Sort.by("requestDate").descending());
            Page<Request> inactivePage = requestService.getPaginatedInactiveRequestsByProvider(loggedInUser, pageable);

            Page<RequestDTO> dtoPage = inactivePage.map(RequestDTO::new);
            return ResponseEntity.ok(dtoPage);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("Error al obtener solicitudes recibidas inactivas: " + e.getMessage());
        }
    }

    @PatchMapping("/{requestId}/accept")
public ResponseEntity<?> acceptRequest(@PathVariable Long requestId) {
    try {
        String message = requestService.updateRequestStatus(requestId, "Enviada", "Aceptada");
        return ResponseEntity.ok(message);
    } catch (Exception e) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
    }
}

@PatchMapping("/{requestId}/reject")
public ResponseEntity<?> rejectRequest(@PathVariable Long requestId) {
    try {
        String message = requestService.updateRequestStatus(requestId, "Enviada", "Rechazada");
        return ResponseEntity.ok(message);
    } catch (Exception e) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
    }
}

@PatchMapping("/{requestId}/complete")
public ResponseEntity<?> completeRequest(@PathVariable Long requestId) {
    try {
        String message = requestService.updateRequestStatus(requestId, "Aceptada", "Completada");
        return ResponseEntity.ok(message);
    } catch (Exception e) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
    }
}

@PatchMapping("/{requestId}/cancel")
public ResponseEntity<?> cancelRequest(@PathVariable Long requestId,
        @RequestHeader("Authorization") String authHeader) {
    try {
        String token = authHeader.replace("Bearer ", "");
        Long userId = jwtService.extractUserId(token);
        User user = userService.findById(userId);
        String message = requestService.cancelRequest(requestId, user);
        return ResponseEntity.ok(message);
    } catch (Exception e) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
    }
}

}