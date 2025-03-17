package com.controladores;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@RestController
public class FileUploadController {

    @Autowired
    private Cloudinary cloudinary;

    @PostMapping("/upload")
    public String uploadFile(@RequestParam("file") MultipartFile file) {
        try {
            if (file.isEmpty()) {
                return "No se ha seleccionado ningún archivo.";
            }

            // Subir el archivo a Cloudinary
            Map<String, String> uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.emptyMap());

            // Retornar la URL de la imagen subida
            String imageUrl = uploadResult.get("url");
            return imageUrl;  // Aquí puedes hacer algo más si necesitas la URL
        } catch (Exception e) {
            return "Error al subir el archivo: " + e.getMessage();
        }
    }
}
