package com.pablo.modelos;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Review {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private int calificacion;
    private String comentario;

    @ManyToOne
    @JoinColumn(name = "usuario_reseniador_id")
    private Usuario usuarioReseniador;

    @ManyToOne
    @JoinColumn(name = "usuario_reseniado_id")
    private Usuario usuarioReseniado;

    @ManyToOne
    @JoinColumn(name = "servicio_id")
    private Servicio servicio;

}
