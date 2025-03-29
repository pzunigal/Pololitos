package com.forgedevs.pololitos.controllers;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.forgedevs.pololitos.models.Category;
import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.models.Review;
import com.forgedevs.pololitos.models.Request;
import com.forgedevs.pololitos.models.User;
import com.forgedevs.pololitos.services.CloudinaryService;
import com.forgedevs.pololitos.services.ReviewService;
import com.forgedevs.pololitos.services.ServiceService;
import com.forgedevs.pololitos.services.RequestService;
import com.forgedevs.pololitos.services.FileUploadService;

import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/services")
@CrossOrigin(origins = "http://localhost:3000")
public class ServiceController {

    @Autowired
    private ServiceService serviceService;
   /*  @Autowired
    private CategoryService categoryService; */
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private FileUploadService fileUploadService;
    @Autowired
    private CloudinaryService cloudinaryService;
    @Autowired
    private RequestService requestService;

    @GetMapping("/categories")
    public ResponseEntity<?> getAllCategoriesWithServices() {
        return ResponseEntity.ok(serviceService.getCategoriesWithServices());
    }

    @PostMapping("/create")
    @Transactional
    public ResponseEntity<?> createService(
            @Valid @ModelAttribute("service") OfferedService service,
            @RequestParam("file") MultipartFile file,
            @RequestParam("userId") Long userId) {

        if (file.isEmpty()) {
            return ResponseEntity.badRequest().body("Debe subir una imagen.");
        }

        try {
            String imageUrl = fileUploadService.uploadFile(file, "servicios");
            service.setImageUrl(imageUrl);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error al subir la imagen: " + e.getMessage());
        }

        User user = new User();
        user.setId(userId);
        service.setUser(user);

        return ResponseEntity.ok(serviceService.save(service));
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<?> getServicesByUser(@PathVariable Long userId) {
        return ResponseEntity.ok(serviceService.getServicesByUserId(userId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getServiceById(@PathVariable("id") Long id) {
        try {
            return ResponseEntity.ok(serviceService.getById(id));
        } catch (EntityNotFoundException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PatchMapping("/update/{id}")
    @Transactional
    public ResponseEntity<?> updateService(@PathVariable("id") Long id,
            @Valid @ModelAttribute("service") OfferedService service,
            @RequestParam(value = "image", required = false) MultipartFile image) {
        OfferedService existing = serviceService.getById(id);

        if (existing == null) {
            return ResponseEntity.notFound().build();
        }

        try {
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
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Hubo un error actualizando el servicio.");
        }
    }

    @DeleteMapping("/delete/{id}")
    @Transactional
    public ResponseEntity<?> deleteService(@PathVariable("id") Long id) {
        try {
            OfferedService service = serviceService.getById(id);
            if (service != null) {
                List<Request> requests = requestService.getRequestsByService(service);
                if (requests != null && !requests.isEmpty()) {
                    return ResponseEntity.badRequest()
                            .body("No puedes eliminar este servicio porque tiene solicitudes registradas.");
                }

                cloudinaryService.deleteFile(service.getImageUrl());
                serviceService.delete(id);
            }
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.internalServerError()
                    .body("Hubo un error inesperado al intentar eliminar el servicio: " + e.getMessage());
        }
    }

    @GetMapping("/details/{id}")
    public ResponseEntity<?> getServiceDetails(@PathVariable("id") Long id) {
        OfferedService service = serviceService.getById(id);
        if (service == null)
            return ResponseEntity.notFound().build();

        List<Review> reviews = reviewService.getByService(service);
        Double average = reviewService.getAverageRating(service);

        return ResponseEntity.ok(new ServiceDetailsResponse(service, reviews, average));
    }

    @GetMapping
    public ResponseEntity<?> filterServices(
            @RequestParam(value = "categoryId", required = false) Long categoryId,
            @RequestParam(value = "priceMin", required = false) Double priceMin,
            @RequestParam(value = "priceMax", required = false) Double priceMax) {

        List<Category> categories = serviceService.getCategoriesWithServices();

        if (categoryId != null) {
            categories = categories.stream()
                    .filter(c -> c.getId().equals(categoryId))
                    .collect(Collectors.toList());
        }

        if (priceMin != null || priceMax != null) {
            for (Category category : categories) {
                List<OfferedService> filtered = category.getServices().stream()
                        .filter(s -> (priceMin == null || s.getPrice() >= priceMin) &&
                                (priceMax == null || s.getPrice() <= priceMax))
                        .collect(Collectors.toList());
                category.setServices(filtered);
            }
        }

        return ResponseEntity.ok(categories);
    }

   /*  @GetMapping("/search")
    public ResponseEntity<?> searchServices(@RequestParam("query") String query) {
        List<OfferedService> services = serviceService.searchByName(query);
        List<Category> categories = serviceService.getCategoriesWithServices();
        return ResponseEntity.ok(new ServiceSearchResponse(services, categories));
    }

    // ---------- Custom Response DTOs ----------- */

    public static class ServiceDetailsResponse {
        private final OfferedService service;
        private final List<Review> reviews;
        private final Double averageRating;

        public ServiceDetailsResponse(OfferedService service, List<Review> reviews, Double averageRating) {
            this.service = service;
            this.reviews = reviews;
            this.averageRating = averageRating;
        }

        public OfferedService getService() {
            return service;
        }

        public List<Review> getReviews() {
            return reviews;
        }

        public Double getAverageRating() {
            return averageRating;
        }
    }

    public static class ServiceSearchResponse {
        private final List<OfferedService> services;
        private final List<Category> categories;

        public ServiceSearchResponse(List<OfferedService> services, List<Category> categories) {
            this.services = services;
            this.categories = categories;
        }

        public List<OfferedService> getServices() {
            return services;
        }

        public List<Category> getCategories() {
            return categories;
        }
    }
}
