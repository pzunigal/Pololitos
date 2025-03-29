package com.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.models.Request;
import com.models.Service;
import com.models.User;

@Repository
public interface RequestRepository extends JpaRepository<Request, Long> {

    List<Request> findByRequester(User requester);

    List<Request> findAll();

    List<Request> findByService_User(User provider);

    List<Request> findByService(Service service);

    List<Request> findByRequesterAndStatus(User requester, String status);

    List<Request> findByService_UserAndStatus(User provider, String status);
}
