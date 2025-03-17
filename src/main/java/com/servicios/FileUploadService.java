/* package com.servicios;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@Service
public class FileUploadService {

    @Autowired
    private Cloudinary cloudinary;

    public String uploadFile(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            return null; // Si el archivo está vacío, retorna null
        }

        // Subir archivo a Cloudinary
        Map<String, String> uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.emptyMap());

        // Devuelve la URL de la imagen subida
        return uploadResult.get("url");
    }
}
 */