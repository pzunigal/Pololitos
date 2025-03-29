package com.forgedevs.pololitos.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forgedevs.pololitos.models.Review;
import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.repositories.ReviewRepository;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    public void save(Review review) {
        reviewRepository.save(review);
    }

    public List<Review> getByService(OfferedService service) {
        return reviewRepository.findByServiceOrderByCreatedAtDesc(service);
    }

    public Double getAverageRating(OfferedService service) {
        return reviewRepository.getAverageByService(service);
    }

    public Review getById(Long id) {
        return reviewRepository.findById(id).orElse(null);
    }

    public void delete(Long id) {
        reviewRepository.deleteById(id);
    }
}
