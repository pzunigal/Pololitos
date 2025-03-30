package com.forgedevs.pololitos.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.forgedevs.pololitos.models.Category;
import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.models.User;
import com.forgedevs.pololitos.repositories.CategoryRepository;
import com.forgedevs.pololitos.repositories.ServiceRepository;

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
            List<OfferedService> services = serviceRepository.findByCategory(category);
            category.setServices(services);
        }

        categories.sort((c1, c2) -> Integer.compare(c2.getServices().size(), c1.getServices().size()));
        return categories;
    }

    public List<OfferedService> getAllServices() {
        return (List<OfferedService>) serviceRepository.findAll();
    }

    
    
    public boolean existsById(Long id) {
        return serviceRepository.existsById(id);
    }

    public OfferedService getById(Long id) {
        return serviceRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Servicio con ID " + id + " no encontrado"));
    }

    public OfferedService save(OfferedService service) {
        return serviceRepository.save(service);
    }

    public void delete(Long id) {
        serviceRepository.deleteById(id);
    }

    public List<OfferedService> searchByName(String query) {
        return serviceRepository.findByNameContainingIgnoreCase(query);
    }

    public List<OfferedService> findByUser(User user) {
        return serviceRepository.findByUser(user);
    }

    public List<OfferedService> findByCategory(Category category) {
        return serviceRepository.findByCategory(category);
    }

    public List<OfferedService> findByPrice(Double price) {
        return serviceRepository.findByPriceLessThanEqual(price);
    }

    public void assignUserToService(Long serviceId, User user) {
        Optional<OfferedService> optionalService = serviceRepository.findById(serviceId);
        if (optionalService.isPresent()) {
            OfferedService foundService = optionalService.get();
            foundService.setUser(user);
            serviceRepository.save(foundService);
        }
    }

    public List<OfferedService> getLatestServices(int count) {
        Pageable pageable = PageRequest.of(0, count, Sort.by("id").descending());
        return serviceRepository.findAll(pageable).getContent();
    }

    public List<OfferedService> getServicesByUserId(Long userId) {
        return serviceRepository.findByUserId(userId);
    }
}
