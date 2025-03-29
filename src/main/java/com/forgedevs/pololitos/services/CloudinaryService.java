package com.forgedevs.pololitos.services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Locale;
import java.util.Map;

@Service
public class CloudinaryService {

    @Autowired
    private Cloudinary cloudinary;

    @SuppressWarnings("unchecked")
    public String uploadFile(MultipartFile file, String folder) throws IOException {
        String originalFilename = file.getOriginalFilename();
        String extension = getExtension(originalFilename).toLowerCase(Locale.ROOT);

        Map<String, Object> params;

        if (extension.equals("jpg") || extension.equals("jpeg") || extension.equals("png")) {
            params = ObjectUtils.asMap("folder", folder);
        } else {
            params = ObjectUtils.asMap(
                "folder", folder,
                "format", "jpg"
            );
        }

        Map<?, ?> result = cloudinary.uploader().upload(file.getBytes(), params);
        return result.get("secure_url").toString();
    }

    public void deleteFile(String imageUrl) {
        try {
            if (!imageUrl.contains("/profile-images/") && !imageUrl.contains("/servicios/")) {
                return;
            }
            String publicId = extractPublicId(imageUrl);
            cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
        } catch (Exception e) {
            // Silenciar errores para evitar caídas
        }
    }

    private String extractPublicId(String url) {
        try {
            String withoutExtension = url.substring(0, url.lastIndexOf('.'));
            int index = withoutExtension.indexOf("/profile-images/");
            if (index == -1) index = withoutExtension.indexOf("/servicios/");
            if (index == -1) throw new IllegalArgumentException("URL no válida: no contiene carpetas conocidas");

            return withoutExtension.substring(index + 1);
        } catch (Exception e) {
            throw new RuntimeException("No se pudo extraer el public_id desde la URL: " + url, e);
        }
    }

    private String getExtension(String fileName) {
        if (fileName == null || !fileName.contains(".")) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf('.') + 1);
    }
}
