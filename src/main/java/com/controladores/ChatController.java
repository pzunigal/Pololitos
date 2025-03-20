package com.controladores;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ChatController {

    @GetMapping("/chat")
    public String mostrarChat(@RequestParam(name = "solicitanteId", required = false) Long solicitanteId,
                              @RequestParam(name = "solicitudId", required = false) Long solicitudId,
                              Model model) {
        model.addAttribute("solicitanteId", solicitanteId);
        model.addAttribute("solicitudId", solicitudId);
        return "chat.jsp"; 
    }
}
