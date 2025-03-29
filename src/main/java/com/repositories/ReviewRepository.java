package com.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.models.Review;
import com.models.Service;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findByServiceOrderByCreatedAtDesc(Service service);

    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.service = :service")
    Double getAverageByService(Service service);
}
