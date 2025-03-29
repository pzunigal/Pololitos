package com.forgedevs.pololitos.controllers;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.models.Request;
import com.forgedevs.pololitos.models.User;
import com.forgedevs.pololitos.repositories.ChatRepository;
import com.forgedevs.pololitos.services.NotificationService;
import com.forgedevs.pololitos.services.RequestService;
import com.forgedevs.pololitos.services.ServiceService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/requests")
@CrossOrigin(origins = "http://localhost:3000")
public class RequestController {

    @Autowired
    private RequestService requestService;

    @Autowired
    private ServiceService serviceService;

    @Autowired
    private ChatRepository chatRepository;

    @Autowired
    private NotificationService notificationService;

    @PostMapping("/create")
    public String createRequest(@RequestParam("message") String message,
                                 @RequestParam("serviceId") Long serviceId,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            session.setAttribute("pendingUrl", "/services/details/" + serviceId);
            return "redirect:/login";
        }

        OfferedService service = serviceService.getById(serviceId);
        if (service == null) {
            redirectAttributes.addFlashAttribute("error", "Service not found.");
            return "redirect:/services";
        }

        Request newRequest = new Request();
        newRequest.setRequester(loggedInUser);
        newRequest.setService(service);
        newRequest.setStatus("Sent");
        newRequest.setRequestDate(new Date());
        newRequest.setAdditionalComment(message);

        requestService.saveRequest(newRequest);
        notificationService.notifyNewRequest(newRequest);

        redirectAttributes.addFlashAttribute("success", "Request sent successfully.");
        return "redirect:/my-sent-requests";
    }

    @GetMapping("/my-sent")
    public Map<String, Object> viewMySentRequests(HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        Map<String, Object> response = new HashMap<>();

        if (loggedInUser == null) {
            response.put("redirect", "/login");
            return response;
        }

        List<Request> active = requestService.getRequestsByRequester(loggedInUser).stream()
                .filter(r -> r.getStatus().equals("Sent") || r.getStatus().equals("Accepted"))
                .toList();

        List<Request> inactive = requestService.getRequestsByRequester(loggedInUser).stream()
                .filter(r -> r.getStatus().equals("Canceled") || r.getStatus().equals("Completed") || r.getStatus().equals("Rejected"))
                .toList();

        Map<Long, Boolean> chatCreated = new HashMap<>();
        for (Request r : active) {
            chatCreated.put(r.getId(), chatRepository.findByRequestId(r.getId()) != null);
        }

        response.put("activeRequests", active);
        response.put("inactiveRequests", inactive);
        response.put("chatCreated", chatCreated);

        return response;
    }

    @GetMapping("/my-received")
    public Map<String, Object> viewMyReceivedRequests(HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        Map<String, Object> response = new HashMap<>();

        if (loggedInUser == null) {
            response.put("redirect", "/login");
            return response;
        }

        List<Request> active = requestService.getRequestsByProvider(loggedInUser).stream()
                .filter(r -> r.getStatus().equals("Sent") || r.getStatus().equals("Accepted"))
                .toList();

        List<Request> inactive = requestService.getRequestsByProvider(loggedInUser).stream()
                .filter(r -> r.getStatus().equals("Rejected") || r.getStatus().equals("Completed") || r.getStatus().equals("Canceled"))
                .toList();

        Map<Long, Boolean> chatCreated = new HashMap<>();
        for (Request r : active) {
            chatCreated.put(r.getId(), chatRepository.findByRequestId(r.getId()) != null);
        }

        response.put("activeRequests", active);
        response.put("inactiveRequests", inactive);
        response.put("chatCreated", chatCreated);

        return response;
    }

    @PostMapping("/accept")
    public String acceptRequest(@RequestParam("requestId") Long requestId,
                                 RedirectAttributes redirectAttributes) {
        Request request = requestService.getRequestById(requestId);
        if (request == null) {
            redirectAttributes.addFlashAttribute("error", "Request not found.");
        } else if (!"Sent".equals(request.getStatus())) {
            redirectAttributes.addFlashAttribute("error", "Request has already been updated by another action.");
        } else {
            request.setStatus("Accepted");
            requestService.saveRequest(request);
            notificationService.notifyStatusChange(request, "Accepted");
            redirectAttributes.addFlashAttribute("success", "Request accepted successfully.");
        }
        return "redirect:/my-received-requests";
    }

    @PostMapping("/reject")
    public String rejectRequest(@RequestParam("requestId") Long requestId,
                                 RedirectAttributes redirectAttributes) {
        Request request = requestService.getRequestById(requestId);
        if (request == null) {
            redirectAttributes.addFlashAttribute("error", "Request not found.");
        } else if (!"Sent".equals(request.getStatus())) {
            redirectAttributes.addFlashAttribute("error", "Request has already been updated by another action.");
        } else {
            request.setStatus("Rejected");
            requestService.saveRequest(request);
            notificationService.notifyStatusChange(request, "Rejected");
            redirectAttributes.addFlashAttribute("success", "Request rejected successfully.");
        }
        return "redirect:/my-received-requests";
    }

    @PostMapping("/cancel")
    public String cancelRequest(@RequestParam("requestId") Long requestId,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        Request request = requestService.getRequestById(requestId);
        if (request == null) {
            redirectAttributes.addFlashAttribute("error", "Request not found.");
        } else if (!request.getStatus().equals("Sent") && !request.getStatus().equals("Accepted")) {
            redirectAttributes.addFlashAttribute("error", "Request has already been updated by another action.");
        } else {
            request.setStatus("Canceled");
            requestService.saveRequest(request);
            notificationService.notifyStatusChange(request, "Canceled");
            redirectAttributes.addFlashAttribute("success", "Request canceled successfully.");
        }
        return "redirect:/my-sent-requests";
    }

    @PostMapping("/complete")
    public String completeRequest(@RequestParam("requestId") Long requestId,
                                   RedirectAttributes redirectAttributes) {
        Request request = requestService.getRequestById(requestId);
        if (request == null) {
            redirectAttributes.addFlashAttribute("error", "Request not found.");
        } else if ("Completed".equals(request.getStatus())) {
            redirectAttributes.addFlashAttribute("error", "Request has already been marked as completed.");
        } else if (!"Accepted".equals(request.getStatus())) {
            redirectAttributes.addFlashAttribute("error", "Request has already been updated by another action.");
        } else {
            request.setStatus("Completed");
            requestService.saveRequest(request);
            notificationService.notifyStatusChange(request, "Completed");
            redirectAttributes.addFlashAttribute("success", "Work marked as completed.");
        }
        return "redirect:/my-received-requests";
    }
}