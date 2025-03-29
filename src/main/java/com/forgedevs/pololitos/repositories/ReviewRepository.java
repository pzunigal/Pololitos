package com.forgedevs.pololitos.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.forgedevs.pololitos.models.Review;
import com.forgedevs.pololitos.models.OfferedService;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findByServiceOrderByCreatedAtDesc(OfferedService service);

    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.service = :service")
    Double getAverageByService(OfferedService service);
}
