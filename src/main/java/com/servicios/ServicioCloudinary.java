package com.servicios;

import java.io.IOException;
import java.util.Map;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

@Service
public class ServicioCloudinary {

    private final Cloudinary cloudinary;

    public ServicioCloudinary(@Value("${cloudinary.cloud_name}") String cloudName,
                              @Value("${cloudinary.api_key}") String apiKey,
                              @Value("${cloudinary.api_secret}") String apiSecret) {
        this.cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", cloudName,
            "api_key", apiKey,
            "api_secret", apiSecret,
            "secure", true));
    }

    public String uploadFile(MultipartFile file) {
        try {
            if (file.isEmpty()) {
                throw new IllegalArgumentException("El archivo está vacío");
            }
            
            // Verificar si el tipo de archivo es una imagen
            String contentType = file.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                throw new IllegalArgumentException("El archivo debe ser una imagen");
            }

            // Verificar las extensiones de la imagen
            @SuppressWarnings("null")
            String fileName = file.getOriginalFilename().toLowerCase();
            if (!(fileName.endsWith(".jpg") || fileName.endsWith(".jpeg") || fileName.endsWith(".png"))) {
                throw new IllegalArgumentException("El archivo debe ser JPG, JPEG o PNG");
            }

            // Parametros para subir el archivo a Cloudinary
            @SuppressWarnings("unchecked")
            Map<String, Object> uploadParams = ObjectUtils.asMap(
                "folder", "servicios",
                "resource_type", "image",
                "use_filename", true,
                "unique_filename", false
            );

            // Subir el archivo a Cloudinary
            @SuppressWarnings("unchecked")
            Map<String, Object> uploadResult = cloudinary.uploader().upload(file.getBytes(), uploadParams);
            return (String) uploadResult.get("secure_url");

        } catch (IOException e) {
            throw new RuntimeException("Error al subir la imagen a Cloudinary", e);
        }
    }
}
