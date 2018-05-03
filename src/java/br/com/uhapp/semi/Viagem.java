/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.uhapp.semi;
import java.util.Date;
/**
 *
 * @author adalberto
 */
public class Viagem {
    private Endereco partida;
    private Endereco destino;
    private String prazo;
    private String status;
    private Carga carga;
    private int id;

    public Viagem(Endereco partida, Endereco destino, String prazo, String status, Carga carga, int id) {
        this.partida = partida;
        this.destino = destino;
        this.prazo = prazo;
        this.status = status;
        this.carga = carga;
        this.id = id;
    }

    public Endereco getPartida() {
        return partida;
    }

    public void setPartida(Endereco partida) {
        this.partida = partida;
    }

    public Endereco getDestino() {
        return destino;
    }

    public void setDestino(Endereco destino) {
        this.destino = destino;
    }

    public String getPrazo() {
        return prazo;
    }

    public void setPrazo(String prazo) {
        this.prazo = prazo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Carga getCarga() {
        return carga;
    }

    public void setCarga(Carga carga) {
        this.carga = carga;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    
    
}
