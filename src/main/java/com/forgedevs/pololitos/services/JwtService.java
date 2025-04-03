package com.forgedevs.pololitos.services;

import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import com.forgedevs.pololitos.models.User;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.util.Date;

@Service
public class JwtService {

    // Cambia la clave secreta por una clave de al menos 256 bits
    private final String SECRET_KEY = "supersecretkeythatshouldbe256bitlong!"; // 256 bits

    // Generar el JWT
    public String generateToken(User user) throws JOSEException {
        JWTClaimsSet claimsSet = new JWTClaimsSet.Builder()
                .subject(user.getEmail())
                .claim("userId", user.getId()) // <-- Aquí agregamos el ID del usuario
                .claim("firstName", user.getFirstName())
                .claim("lastName", user.getLastName())
                .issuer("your-issuer")
                .issueTime(new Date())
                .expirationTime(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 24))
                .build();

        SignedJWT signedJWT = new SignedJWT(
                new JWSHeader(JWSAlgorithm.HS256),
                claimsSet);

        MACSigner signer = new MACSigner(SECRET_KEY);
        signedJWT.sign(signer);

        return signedJWT.serialize();
    }

    // Verificar el JWT y obtener los datos del usuario (si es necesario)
    public String extractEmail(String token) throws ParseException, JOSEException {
        SignedJWT signedJWT = SignedJWT.parse(token);

        // Verifica la firma del JWT con la clave secreta
        MACVerifier verifier = new MACVerifier(SECRET_KEY);
        if (!signedJWT.verify(verifier)) {
            throw new JOSEException("La firma del JWT es inválida.");
        }

        // Si la firma es válida, extraemos los claims
        JWTClaimsSet claimsSet = signedJWT.getJWTClaimsSet();
        return claimsSet.getSubject(); // Aquí extraemos el email del JWT
    }
    public Long extractUserId(String token) throws ParseException, JOSEException {
        SignedJWT signedJWT = SignedJWT.parse(token);
    
        MACVerifier verifier = new MACVerifier(SECRET_KEY);
        if (!signedJWT.verify(verifier)) {
            throw new JOSEException("La firma del JWT es inválida.");
        }
    
        JWTClaimsSet claimsSet = signedJWT.getJWTClaimsSet();
        return claimsSet.getLongClaim("userId");
    }
    public boolean isTokenValid(String token) throws ParseException, JOSEException {
        SignedJWT signedJWT = SignedJWT.parse(token);
        MACVerifier verifier = new MACVerifier(SECRET_KEY);
    
        if (!signedJWT.verify(verifier)) return false;
    
        Date expirationTime = signedJWT.getJWTClaimsSet().getExpirationTime();
        return expirationTime.after(new Date()); // true si el token NO está expirado
    }
    
    
}
