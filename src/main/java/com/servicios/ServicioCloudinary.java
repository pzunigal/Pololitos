package com.servicios;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Locale;
import java.util.Map;

@Service
public class ServicioCloudinary {

    @Autowired
    private Cloudinary cloudinary;

    /**
     * Sube un archivo a Cloudinary, mantiene el formato original si es válido (jpg/jpeg/png),
     * y convierte a jpg si es de otro tipo (heic, webp, etc).
     */
    @SuppressWarnings("unchecked")
    public String subirArchivo(MultipartFile archivo, String carpeta) throws IOException {
        String originalFilename = archivo.getOriginalFilename();
        String extension = obtenerExtension(originalFilename).toLowerCase(Locale.ROOT);

        Map<String, Object> params;

        if (extension.equals("jpg") || extension.equals("jpeg") || extension.equals("png")) {
            params = ObjectUtils.asMap("folder", carpeta);
        } else {
            params = ObjectUtils.asMap(
                "folder", carpeta,
                "format", "jpg"
            );
        }

        Map<?, ?> resultado = cloudinary.uploader().upload(archivo.getBytes(), params);
        return resultado.get("secure_url").toString();
    }

    /**
     * Elimina una imagen de Cloudinary si pertenece a /profile-images/ o /servicios/.
     * Ignora las imágenes externas o no gestionadas por Cloudinary.
     */
    public void eliminarArchivo(String urlImagen) {
        try {
            if (!urlImagen.contains("/profile-images/") && !urlImagen.contains("/servicios/")) {
                return;
            }
            String publicId = extraerPublicId(urlImagen);
            cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
        } catch (Exception e) {
            // Silenciar errores para evitar caídas
        }
    }

    /**
     * Extrae el public_id desde una URL completa de Cloudinary.
     */
    private String extraerPublicId(String url) {
        try {
            String sinExtension = url.substring(0, url.lastIndexOf('.'));
            int index = sinExtension.indexOf("/profile-images/");
            if (index == -1) index = sinExtension.indexOf("/servicios/");
            if (index == -1) throw new IllegalArgumentException("URL no válida: no contiene carpetas conocidas");

            return sinExtension.substring(index + 1);
        } catch (Exception e) {
            throw new RuntimeException("No se pudo extraer el public_id desde la URL: " + url, e);
        }
    }

    /**
     * Extrae la extensión del archivo (sin el punto).
     */
    private String obtenerExtension(String nombreArchivo) {
        if (nombreArchivo == null || !nombreArchivo.contains(".")) {
            return "";
        }
        return nombreArchivo.substring(nombreArchivo.lastIndexOf('.') + 1);
    }
}
