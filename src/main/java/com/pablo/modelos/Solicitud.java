package com.pablo.modelos;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
public class Solicitud {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String estado;
    private Date fechaSolicitud;
    private String comentarioAdicional;
    
    @ManyToOne
    @JoinColumn(name = "usuario_solicitante_id")
    private Usuario usuarioSolicitante;
    
    @ManyToOne
    @JoinColumn(name = "usuario_oferente_id")
    private Usuario usuarioOferente;
    
    @ManyToOne
    @JoinColumn(name = "servicio_id")
    private Servicio servicio;

}
