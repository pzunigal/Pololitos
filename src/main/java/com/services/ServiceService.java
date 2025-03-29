package com.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.models.Category;
import com.models.Service;
import com.models.User;
import com.repositories.CategoryRepository;
import com.repositories.ServiceRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
public class ServiceService {

    @Autowired
    private ServiceRepository serviceRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    public List<Category> getCategoriesWithServices() {
        List<Category> categories = categoryRepository.findAll();
        for (Category category : categories) {
            List<Service> services = serviceRepository.findByCategory(category);
            category.setServices(services);
        }

        categories.sort((c1, c2) -> Integer.compare(c2.getServices().size(), c1.getServices().size()));
        return categories;
    }

    public List<Service> getAllServices() {
        return (List<Service>) serviceRepository.findAll();
    }

    public boolean existsById(Long id) {
        return serviceRepository.existsById(id);
    }

    public Service getById(Long id) {
        return serviceRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Servicio con ID " + id + " no encontrado"));
    }

    public Service save(Service service) {
        return serviceRepository.save(service);
    }

    public void delete(Long id) {
        serviceRepository.deleteById(id);
    }

    public List<Service> searchByName(String query) {
        return serviceRepository.findByNameContainingIgnoreCase(query);
    }

    public List<Service> findByUser(User user) {
        return serviceRepository.findByUser(user);
    }

    public List<Service> findByCategory(Category category) {
        return serviceRepository.findByCategory(category);
    }

    public List<Service> findByPrice(Double price) {
        return serviceRepository.findByPriceLessThanEqual(price);
    }

    public void assignUserToService(Long serviceId, User user) {
        Optional<Service> optionalService = serviceRepository.findById(serviceId);
        if (optionalService.isPresent()) {
            Service foundService = optionalService.get();
            foundService.setUser(user);
            serviceRepository.save(foundService);
        }
    }

    public List<Service> getLatestServices(int count) {
        Pageable pageable = PageRequest.of(0, count, Sort.by("id").descending());
        return serviceRepository.findAll(pageable).getContent();
    }

    public List<Service> getServicesByUserId(Long userId) {
        return serviceRepository.findByUserId(userId);
    }
}
