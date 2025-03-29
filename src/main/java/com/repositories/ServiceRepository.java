package com.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.models.Service;
import com.models.User;
import com.models.Category;

@Repository
public interface ServiceRepository extends JpaRepository<Service, Long> {

    // Search services by name (case-insensitive)
    List<Service> findByNameContainingIgnoreCase(String name);

    // Find services by user (used in user profile view)
    List<Service> findByUser(User user);

    // Filter by category
    List<Service> findByCategory(Category category);

    // Filter by price (less than or equal)
    List<Service> findByPriceLessThanEqual(Double price);

    // Get services ordered by ID descending (most recent first)
    List<Service> findByOrderByIdDesc();

    // Find services by user ID
    List<Service> findByUserId(Long userId);
}
