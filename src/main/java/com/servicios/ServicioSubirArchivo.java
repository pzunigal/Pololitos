package com.servicios;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@Service
public class ServicioSubirArchivo {

    @Autowired
    private Cloudinary cloudinary;

    public String uploadFile(MultipartFile file, String carpetaDestino) throws IOException {
        if (file.isEmpty()) return null;

        @SuppressWarnings("rawtypes")
        Map uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.asMap(
                "folder", carpetaDestino // ahora puedes especificar cualquier carpeta desde el backend
        ));

        return (String) uploadResult.get("secure_url"); // usa secure_url para HTTPS
    }
}
