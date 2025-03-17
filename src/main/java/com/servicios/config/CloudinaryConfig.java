package com.servicios.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CloudinaryConfig {

    @Value("${cloudinary.folder}")
    private String folder;

    @Bean
    public String cloudinaryFolder() {
        return folder;
    }
}
