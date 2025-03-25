package com.config;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CloudinaryConfig {

    @Bean
    public Cloudinary cloudinary() {
        return new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "dwz4chwv7",
            "api_key", "961771188463484",
            "api_secret", "4L40owPG510GdO4xjQ2IbE1lDuw"
        ));
    }
}
