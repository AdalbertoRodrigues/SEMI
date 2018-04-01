/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.uhapp.semi;
import java.util.ArrayList;
import java.util.Date;
/**
 *
 * @author adalberto
 */
public class Motorista extends Usuario {
    private String cnh;
    private boolean mopp;
    private Date validadeMopp;
    private ArrayList<Viagem> viagens;

    public Motorista(String cnh, boolean mopp, Date validadeMopp, String cpf, String nome, String senha, String tipo) {
        super(cpf, nome, senha, tipo);
        this.cnh = cnh;
        this.mopp = mopp;
        this.validadeMopp = validadeMopp;
    }

    public Date getValidadeMopp() {
        return validadeMopp;
    }

    public void setValidadeMopp(Date validadeMopp) {
        this.validadeMopp = validadeMopp;
    }

    public String getCnh() {
        return cnh;
    }

    public void setCnh(String cnh) {
        this.cnh = cnh;
    }

    public boolean isMopp() {
        return mopp;
    }

    public void setMopp(boolean mopp) {
        this.mopp = mopp;
    }

    public ArrayList<Viagem> getViagens() {
        return viagens;
    }

    public void setViagens(ArrayList<Viagem> viagens) {
        this.viagens = viagens;
    }
    
    
}
