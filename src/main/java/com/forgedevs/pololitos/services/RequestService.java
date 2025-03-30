package com.forgedevs.pololitos.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.models.Request;
import com.forgedevs.pololitos.models.User;
import com.forgedevs.pololitos.repositories.RequestRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
public class RequestService {

    @Autowired
    private RequestRepository requestRepository;

    public void saveRequest(Request request) {
        requestRepository.save(request);
    }

    public List<Request> getRequestsByRequester(User requester) {
        return requestRepository.findByRequester(requester);
    }

    public List<Request> getAllRequests() {
        return requestRepository.findAll();
    }

    public List<Request> getRequestsByProvider(User provider) {
        return requestRepository.findByService_User(provider);
    }

    public Request getRequestById(Long id) {
        Optional<Request> optionalRequest = requestRepository.findById(id);
        return optionalRequest.orElse(null);
    }

    public List<Request> getRequestsByService(OfferedService service) {
        return requestRepository.findByService(service);
    }

    public void changeRequestStatus(Long requestId, String newStatus) {
        Optional<Request> optionalRequest = requestRepository.findById(requestId);
        if (optionalRequest.isPresent()) {
            Request request = optionalRequest.get();
            request.setStatus(newStatus);
            requestRepository.save(request);
        } else {
            throw new EntityNotFoundException("Solicitud no encontrada con ID: " + requestId);
        }
    }

    public List<Request> getRequestsByStatusAndRequester(User requester, String status) {
        return requestRepository.findByRequesterAndStatus(requester, status);
    }

    public List<Request> getRequestsByStatusAndProvider(User provider, String status) {
        return requestRepository.findByService_UserAndStatus(provider, status);
    }
    public Page<Request> getPaginatedRequestsByRequester(User user, Pageable pageable) {
        return requestRepository.findAllByRequester(user, pageable);
    }
    public Page<Request> getPaginatedRequestsByServiceProvider(User provider, Pageable pageable) {
        return requestRepository.findByServiceUser(provider, pageable);
    }
    
    
}
