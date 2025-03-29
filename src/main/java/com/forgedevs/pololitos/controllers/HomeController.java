package com.forgedevs.pololitos.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.forgedevs.pololitos.models.Category;
import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.services.ServiceService;

@RestController
@RequestMapping("/api")
public class HomeController {

    @Autowired
    private ServiceService serviceService;

    // Endpoint para obtener todas las categorías con sus servicios
    @GetMapping("/categories")
    public ResponseEntity<List<Category>> getAllCategoriesWithServices() {
        List<Category> categories = serviceService.getCategoriesWithServices();
        return ResponseEntity.ok(categories);
    }

    // Endpoint para obtener los últimos servicios (limit configurable)
    @GetMapping("/services/latest")
    public ResponseEntity<List<OfferedService>> getLatestServices(@RequestParam(defaultValue = "8") int limit) {
        List<OfferedService> latest = serviceService.getLatestServices(limit);
        return ResponseEntity.ok(latest);
    }
}
