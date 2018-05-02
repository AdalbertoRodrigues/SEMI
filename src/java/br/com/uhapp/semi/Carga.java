/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.uhapp.semi;

/**
 *
 * @author adalberto
 */
public class Carga {
    private String tipo;
    private double peso;
    private String conteudo;
    private String dimensoes;
    private String unidadeMedida;

    public Carga(String tipo, double peso, String conteudo, String dimensoes, String unidadeMedida) {
        this.tipo = tipo;
        this.peso = peso;
        this.conteudo = conteudo;
        this.dimensoes = dimensoes;
        this.unidadeMedida = unidadeMedida;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public String getConteudo() {
        return conteudo;
    }

    public void setConteudo(String conteudo) {
        this.conteudo = conteudo;
    }

    public String getDimensoes() {
        return dimensoes;
    }

    public void setDimensoes(String dimensoes) {
        this.dimensoes = dimensoes;
    }

    public String getUnidadeMedida() {
        return unidadeMedida;
    }

    public void setUnidadeMedida(String unidadeMedida) {
        this.unidadeMedida = unidadeMedida;
    }
    
}
