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
import com.forgedevs.pololitos.models.Category;
import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.models.User;
import com.forgedevs.pololitos.repositories.CategoryRepository;
import com.forgedevs.pololitos.services.CloudinaryService;

import com.forgedevs.pololitos.services.ServiceService;
import org.springframework.data.domain.Page;

import com.forgedevs.pololitos.services.FileUploadService;
import com.forgedevs.pololitos.services.JwtService;

import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/services")
@CrossOrigin(origins = "http://localhost:3000")
public class ServiceController {

    @Autowired
    private ServiceService serviceService;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private JwtService jwtService;
    @Autowired
    private FileUploadService fileUploadService;
    @Autowired
    private CloudinaryService cloudinaryService;

    @GetMapping("/paginated")
    public ResponseEntity<Page<ServiceDTO>> getPaginatedServices(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size) {

        Page<OfferedService> paginated = serviceService.getPaginatedServices(page, size);
        Page<ServiceDTO> dtoPage = paginated.map(ServiceDTO::new);

        return ResponseEntity.ok(dtoPage);
    }

    @GetMapping("/my-services")
    public ResponseEntity<?> getMyServices(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            Long userId = jwtService.extractUserId(token);

            Page<OfferedService> paged = serviceService.getServicesByUserId(userId, page, size);
            Page<ServiceDTO> dtoPage = paged.map(ServiceDTO::new);
            return ResponseEntity.ok(dtoPage);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token inválido.");
        }
    }

    public record OfferedServiceDTO(
            Long id,
            String name,
            String description,
            Double price,
            String city,
            String imageUrl,
            String categoryName) {
    }

    @PostMapping("/post-service")
    @Transactional
    public ResponseEntity<?> createService(
            @RequestParam("name") String name,
            @RequestParam("description") String description,
            @RequestParam("price") Double price,
            @RequestParam("city") String city,
            @RequestParam("categoryId") Long categoryId,
            @RequestParam("file") MultipartFile file,
            @RequestHeader("Authorization") String authHeader) {

        if (file.isEmpty()) {
            return ResponseEntity.badRequest().body("Debe subir una imagen.");
        }

        try {
            // Extraer ID de usuario desde el token
            String token = authHeader.replace("Bearer ", "");
            Long userId = jwtService.extractUserId(token);

            // Buscar la categoría
            Category category = categoryRepository.findById(categoryId)
                    .orElseThrow(() -> new EntityNotFoundException("Categoría no encontrada"));

            // Subir imagen
            String imageUrl = fileUploadService.uploadFile(file, "servicios");

            // Crear entidad OfferedService
            OfferedService service = new OfferedService();
            service.setName(name);
            service.setDescription(description);
            service.setPrice(price);
            service.setCity(city);
            service.setImageUrl(imageUrl);
            service.setCategory(category);

            User user = new User();
            user.setId(userId);
            service.setUser(user);

            // Guardar y devolver DTO
            OfferedService saved = serviceService.save(service);

            OfferedServiceDTO dto = new OfferedServiceDTO(
                    saved.getId(),
                    saved.getName(),
                    saved.getDescription(),
                    saved.getPrice(),
                    saved.getCity(),
                    saved.getImageUrl(),
                    saved.getCategory().getName());

            return ResponseEntity.ok(dto);

        } catch (ParseException | JOSEException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token inválido.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error al crear el servicio: " + e.getMessage());
        }
    }

    @GetMapping("/my-service/{id}")
    public ResponseEntity<?> getMyServiceById(
            @PathVariable Long id,
            @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            Long userIdFromToken = jwtService.extractUserId(token);

            OfferedService service = serviceService.getById(id);

            if (service == null) {
                return ResponseEntity.notFound().build();
            }

            if (!service.getUser().getId().equals(userIdFromToken)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body("No autorizado para acceder a este servicio.");
            }

            // Convertir a DTO
            ServiceDTO dto = new ServiceDTO(service);
            return ResponseEntity.ok(dto);
        } catch (ParseException | JOSEException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token inválido.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Hubo un error obteniendo el servicio.");
        }
    }

    @GetMapping("/public/service/{id}")
    public ResponseEntity<?> getPublicServiceById(@PathVariable Long id) {
        try {
            OfferedService service = serviceService.getById(id);

            if (service == null) {
                return ResponseEntity.notFound().build();
            }

            ServiceDTO dto = new ServiceDTO(service);

            return ResponseEntity.ok(dto);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error al obtener el servicio público.");
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

    @PostMapping("/search")
    public ResponseEntity<Page<ServiceDTO>> searchServicesByName(
            @RequestParam("keyword") String keyword,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size) {

        Page<OfferedService> result = serviceService.searchByName(keyword, page, size);
        Page<ServiceDTO> dtoPage = result.map(ServiceDTO::new);

        return ResponseEntity.ok(dtoPage);
    }

}
