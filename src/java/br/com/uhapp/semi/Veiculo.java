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
    private String placa;
    private Marca marca;
    private String modelo;
    private int ano;
    private String cnhMotoristaPreferencial;
    private int qtdEixos;
    private ArrayList<Capacitacao> capacitacao;

    public Veiculo(String placa, Marca marca, String modelo, int ano, String cnhMotoristaPreferencial, int qtdEixos) {
        this.placa = placa;
        this.marca = marca;
        this.modelo = modelo;
        this.ano = ano;
        this.cnhMotoristaPreferencial = cnhMotoristaPreferencial;
        this.qtdEixos = qtdEixos;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
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

    public String getCnhMotoristaPreferencial() {
        return cnhMotoristaPreferencial;
    }

    public void setCnhMotoristaPreferencial(String cnhMotoristaPreferencial) {
        this.cnhMotoristaPreferencial = cnhMotoristaPreferencial;
    }

    public int getQtdEixos() {
        return qtdEixos;
    }

    public void setQtdEixos(int qtdEixos) {
        this.qtdEixos = qtdEixos;
    }
    
    
}
