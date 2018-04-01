/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.uhapp.semi;

import java.util.ArrayList;

/**
 *
 * @author adalberto
 */
public class Chat {
    private Motorista motorista;
    private Usuario funcionario;
    private ArrayList<Mensagem> mensagens;

    public Chat(Motorista motorista, Usuario funcionario, ArrayList<Mensagem> mensagens) {
        this.motorista = motorista;
        this.funcionario = funcionario;
        this.mensagens = mensagens;
    }

    public ArrayList<Mensagem> getMensagens() {
        return mensagens;
    }

    public void setMensagens(ArrayList<Mensagem> mensagens) {
        this.mensagens = mensagens;
    }

    public Motorista getMotorista() {
        return motorista;
    }

    public void setMotorista(Motorista motorista) {
        this.motorista = motorista;
    }

    public Usuario getFuncionario() {
        return funcionario;
    }

    public void setFuncionario(Usuario funcionario) {
        this.funcionario = funcionario;
    }
    
}
