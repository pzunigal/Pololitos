package com.forgedevs.pololitos.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.database.FirebaseDatabase;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

@Configuration
public class FirebaseConfig {

    @Value("${FIREBASE_DATABASE_URL}")
    private String firebaseDatabaseUrl;

    @Value("${FIREBASE_CONFIG:}") // solo se usa en producción
    private String firebaseConfigFromEnv;

    @Value("${FIREBASE_CREDENTIALS_FILE:}") // fallback para local
    private Resource firebaseCredentialsFile;

    @Bean
    public FirebaseApp firebaseApp() throws IOException {
        InputStream credentialsStream;

        if (!firebaseConfigFromEnv.isEmpty()) {
            credentialsStream = new ByteArrayInputStream(firebaseConfigFromEnv.getBytes(StandardCharsets.UTF_8));
        } else {
            credentialsStream = firebaseCredentialsFile.getInputStream();
        }

        FirebaseOptions options = FirebaseOptions.builder()
                .setCredentials(GoogleCredentials.fromStream(credentialsStream))
                .setDatabaseUrl(firebaseDatabaseUrl)
                .build();

        return FirebaseApp.initializeApp(options);
    }

    @Bean
    public FirebaseDatabase firebaseDatabase(FirebaseApp firebaseApp) {
        return FirebaseDatabase.getInstance(firebaseApp);
    }
}
