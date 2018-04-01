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
public class Veiculo {
    private Marca marca;
    private String modelo;
    private int ano;
    private Motorista motoristaPreferencial;
    private int qtdEixos;
    private ArrayList<Capacitacao> capacitacao;

    public Veiculo(Marca marca, String modelo, int ano, Motorista motoristaPreferencial, int qtdEixos, ArrayList<Capacitacao> capacitacao) {
        this.marca = marca;
        this.modelo = modelo;
        this.ano = ano;
        this.motoristaPreferencial = motoristaPreferencial;
        this.qtdEixos = qtdEixos;
        this.capacitacao = capacitacao;
    }

    public ArrayList<Capacitacao> getCapacitacao() {
        return capacitacao;
    }

    public void setCapacitacao(ArrayList<Capacitacao> capacitacao) {
        this.capacitacao = capacitacao;
    }

    public Marca getMarca() {
        return marca;
    }

    public void setMarca(Marca marca) {
        this.marca = marca;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public int getAno() {
        return ano;
    }

    public void setAno(int ano) {
        this.ano = ano;
    }

    public Motorista getMotoristaPreferencial() {
        return motoristaPreferencial;
    }

    public void setMotoristaPreferencial(Motorista motoristaPreferencial) {
        this.motoristaPreferencial = motoristaPreferencial;
    }

    public int getQtdEixos() {
        return qtdEixos;
    }

    public void setQtdEixos(int qtdEixos) {
        this.qtdEixos = qtdEixos;
    }
    
    
}
