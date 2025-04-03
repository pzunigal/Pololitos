package com.forgedevs.pololitos.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.models.User;
import com.forgedevs.pololitos.models.Category;

@Repository
public interface ServiceRepository extends JpaRepository<OfferedService, Long> {

    Page<OfferedService> findAll(Pageable pageable);

    Page<OfferedService> findByUserId(Long userId, Pageable pageable);

    Page<OfferedService> findByNameContainingIgnoreCase(String keyword, Pageable pageable);



    


    List<OfferedService> findAll();

    // Search services by name (case-insensitive)
    List<OfferedService> findByNameContainingIgnoreCase(String name);

    // Find services by user (used in user profile view)
    List<OfferedService> findByUser(User user);

    // Filter by category
    List<OfferedService> findByCategory(Category category);

    // Filter by price (less than or equal)
    List<OfferedService> findByPriceLessThanEqual(Double price);

    // Get services ordered by ID descending (most recent first)
    List<OfferedService> findByOrderByIdDesc();

    // Find services by user ID
    List<OfferedService> findByUserId(Long userId);
    

}
