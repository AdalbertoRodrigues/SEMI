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
public class Capacitacao {
    
    private int id;
    private String categoria;
    
    public Capacitacao(int id, String categoria) {
        this.id = id;
        this.categoria = categoria;
        
    }

    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
}
