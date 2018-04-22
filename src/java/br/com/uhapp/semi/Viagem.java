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
    private Date prazo;
    private int tempoEstimado;
    private String status;
    private Chat chat;
    private Carga carga;

    public Viagem(Endereco partida, Endereco destino, Date prazo, int tempoEstimado, String status, Carga carga) {
        this.partida = partida;
        this.destino = destino;
        this.prazo = prazo;
        this.tempoEstimado = tempoEstimado;
        this.status = status;
        this.carga = carga;
    }

    public Carga getCarga() {
        return carga;
    }

    public void setCarga(Carga carga) {
        this.carga = carga;
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

    public Date getPrazo() {
        return prazo;
    }

    public void setPrazo(Date prazo) {
        this.prazo = prazo;
    }

    public int getTempoEstimado() {
        return tempoEstimado;
    }

    public void setTempoEstimado(int tempoEstimado) {
        this.tempoEstimado = tempoEstimado;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Chat getChat() {
        return chat;
    }

    public void setChat(Chat chat) {
        this.chat = chat;
    }
    
    
}
