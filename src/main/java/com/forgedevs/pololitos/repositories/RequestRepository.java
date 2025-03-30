package com.forgedevs.pololitos.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.forgedevs.pololitos.models.Request;
import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.models.User;

@Repository
public interface RequestRepository extends JpaRepository<Request, Long> {

    List<Request> findByRequester(User requester);

    List<Request> findAll();

    List<Request> findByService_User(User provider);

    List<Request> findByService(OfferedService service);

    List<Request> findByRequesterAndStatus(User requester, String status);

    List<Request> findByService_UserAndStatus(User provider, String status);
    Page<Request> findAllByRequester(User user, Pageable pageable);
    Page<Request> findByServiceUser(User provider, Pageable pageable);

}
