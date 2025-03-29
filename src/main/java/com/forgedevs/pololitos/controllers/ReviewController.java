package com.forgedevs.pololitos.controllers;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.forgedevs.pololitos.models.Review;
import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.models.User;
import com.forgedevs.pololitos.services.ReviewService;
import com.forgedevs.pololitos.services.ServiceService;

@RestController
@RequestMapping("/api/reviews")
public class ReviewController {

    @Autowired
    private ServiceService serviceService;

    @Autowired
    private ReviewService reviewService;

    @PostMapping("/publish")
    public ResponseEntity<?> publishReview(@RequestParam("serviceId") Long serviceId,
            @RequestParam("rating") Integer rating,
            @RequestParam("comment") String comment,
            @RequestParam("userId") Long userId) {
        OfferedService service = serviceService.getById(serviceId);
        if (service == null) {
            return ResponseEntity.badRequest().body("El servicio no existe.");
        }

        Review newReview = new Review();
        newReview.setService(service);
        newReview.setUser(new User(userId));
        newReview.setRating(rating);
        newReview.setComment(comment);
        newReview.setCreatedAt(new Date());

        reviewService.save(newReview);
        return ResponseEntity.ok("Reseña publicada.");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteReview(@PathVariable("id") Long reviewId,
            @RequestParam("userId") Long userId) {
        Review review = reviewService.getById(reviewId);
        if (review == null || !review.getUser().getId().equals(userId)) {
            return ResponseEntity.status(403).body("No tienes permiso para eliminar esta reseña.");
        }

        reviewService.delete(reviewId);
        return ResponseEntity.ok("Reseña eliminada correctamente.");
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateReview(@PathVariable("id") Long reviewId,
            @RequestParam("rating") Integer rating,
            @RequestParam("comment") String comment,
            @RequestParam("userId") Long userId) {
        Review review = reviewService.getById(reviewId);
        if (review == null || !review.getUser().getId().equals(userId)) {
            return ResponseEntity.status(403).body("No tienes permiso para editar esta reseña.");
        }

        review.setRating(rating);
        review.setComment(comment);
        review.setUpdatedAt(new Date());
        reviewService.save(review);

        return ResponseEntity.ok("Reseña actualizada correctamente.");
    }
}
