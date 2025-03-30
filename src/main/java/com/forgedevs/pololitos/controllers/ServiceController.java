package com.forgedevs.pololitos.controllers;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.text.ParseException;
import com.nimbusds.jose.JOSEException;
import com.forgedevs.pololitos.dtos.ServiceDTO;
import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.models.User;
import com.forgedevs.pololitos.services.CloudinaryService;

import com.forgedevs.pololitos.services.ServiceService;

import com.forgedevs.pololitos.services.FileUploadService;
import com.forgedevs.pololitos.services.JwtService;
import jakarta.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/services")
@CrossOrigin(origins = "http://localhost:3000")
public class ServiceController {

    @Autowired
    private ServiceService serviceService;

    @Autowired
    private JwtService jwtService;
    @Autowired
    private FileUploadService fileUploadService;
    @Autowired
    private CloudinaryService cloudinaryService;

    @GetMapping("/public")
    public List<ServiceDTO> getAllPublicServices() {
        return serviceService.getAllServices().stream()
                .map(ServiceDTO::new)
                .collect(Collectors.toList());
    }

    @PostMapping("/post-service")
@Transactional
public ResponseEntity<?> createService(
        @Valid @ModelAttribute("service") OfferedService service,
        @RequestParam("file") MultipartFile file,
        @RequestHeader("Authorization") String authHeader) {

    if (file.isEmpty()) {
        return ResponseEntity.badRequest().body("Debe subir una imagen.");
    }

    try {
        String token = authHeader.replace("Bearer ", "");
        Long userIdFromToken = jwtService.extractUserId(token);

        String imageUrl = fileUploadService.uploadFile(file, "servicios");
        service.setImageUrl(imageUrl);

        User user = new User();
        user.setId(userIdFromToken);
        service.setUser(user);

        OfferedService saved = serviceService.save(service);
        return ResponseEntity.ok(saved);
    } catch (ParseException | JOSEException e) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token inválido.");
    } catch (Exception e) {
        return ResponseEntity.badRequest().body("Error al crear el servicio.");
    }
}


    @PatchMapping("/update/{id}")
    @Transactional
    public ResponseEntity<?> updateService(
            @PathVariable("id") Long id,
            @Valid @ModelAttribute("service") OfferedService service,
            @RequestParam(value = "image", required = false) MultipartFile image,
            @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            Long userIdFromToken = jwtService.extractUserId(token);

            OfferedService existing = serviceService.getById(id);

            if (existing == null) {
                return ResponseEntity.notFound().build();
            }

            if (!existing.getUser().getId().equals(userIdFromToken)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body("No puedes editar este servicio.");
            }

            if (image != null && !image.isEmpty()) {
                cloudinaryService.deleteFile(existing.getImageUrl());
                String newUrl = cloudinaryService.uploadFile(image, "servicios");
                existing.setImageUrl(newUrl);
            }

            existing.setName(service.getName());
            existing.setDescription(service.getDescription());
            existing.setPrice(service.getPrice());
            existing.setCategory(service.getCategory());
            existing.setCity(service.getCity());

            serviceService.save(existing);
            return ResponseEntity.ok(existing);

        } catch (ParseException | JOSEException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token inválido.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Hubo un error actualizando el servicio.");
        }
    }

    @DeleteMapping("/delete/{id}")
    @Transactional
    public ResponseEntity<?> deleteService(
            @PathVariable("id") Long id,
            @RequestHeader("Authorization") String authHeader) {

        try {
            String token = authHeader.replace("Bearer ", "");
            Long userIdFromToken = jwtService.extractUserId(token);

            OfferedService existing = serviceService.getById(id);
            if (existing == null) {
                return ResponseEntity.notFound().build();
            }

            if (!existing.getUser().getId().equals(userIdFromToken)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body("No puedes eliminar este servicio.");
            }

            // Eliminar imagen de Cloudinary si existe
            if (existing.getImageUrl() != null) {
                cloudinaryService.deleteFile(existing.getImageUrl());
            }

            // Eliminar el servicio
            serviceService.delete(id);
            return ResponseEntity.ok("Servicio eliminado exitosamente.");
        } catch (ParseException | JOSEException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token inválido.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error al eliminar servicio.");
        }
    }
}
