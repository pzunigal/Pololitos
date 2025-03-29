package com.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.models.Review;
import com.models.Service;
import com.repositories.ReviewRepository;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    public void save(Review review) {
        reviewRepository.save(review);
    }

    public List<Review> getByService(Service service) {
        return reviewRepository.findByServiceOrderByCreatedAtDesc(service);
    }

    public Double getAverageRating(Service service) {
        return reviewRepository.getAverageByService(service);
    }

    public Review getById(Long id) {
        return reviewRepository.findById(id).orElse(null);
    }

    public void delete(Long id) {
        reviewRepository.deleteById(id);
    }
}
