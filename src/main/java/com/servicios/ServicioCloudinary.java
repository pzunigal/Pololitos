package com.servicios; // Asegúrate que este sea el paquete correcto

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@Service
public class ServicioCloudinary {

    @Autowired
    private Cloudinary cloudinary;

    public String subirArchivo(MultipartFile archivo, String carpeta) throws IOException {
        Map<String, Object> params = ObjectUtils.asMap("folder", carpeta);
        Map<?, ?> resultado = cloudinary.uploader().upload(archivo.getBytes(), params);
        return resultado.get("secure_url").toString();
    }

    public void eliminarArchivo(String urlImagen) {
        String publicId = extraerPublicId(urlImagen);
        try {
            cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String extraerPublicId(String url) {
        // Extrae el public_id de una URL como: https://res.cloudinary.com/tu_cloud/image/upload/v1234567890/servicios/archivo.jpg
        try {
            String sinExtension = url.substring(0, url.lastIndexOf('.')); // quita .jpg o .png
            int indexFolder = sinExtension.indexOf("/servicios/");
            if (indexFolder == -1) {
                throw new IllegalArgumentException("URL no contiene el path esperado /servicios/");
            }
            return sinExtension.substring(indexFolder + 1); // devuelve "servicios/archivo"
        } catch (Exception e) {
            throw new RuntimeException("No se pudo extraer el public_id desde la URL: " + url, e);
        }
    }
}
