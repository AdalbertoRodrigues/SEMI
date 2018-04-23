/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.uhapp.semi;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author adalberto
 */
public class Usuario {
    private String cpf;
    private String nome;
    private String senha;
    private String tipo;

    public Usuario(String cpf, String nome, String senha, String tipo) {
        this.cpf = cpf;
        this.nome = nome;
        this.senha = senha;
        this.tipo = tipo;
    }
    
    public static Usuario getUsuario(String cpf, String pass) throws SQLException{
        Conexao con = new Conexao();
        ResultSet rs = con.conexao.prepareStatement("SELECT * FROM USUARIO "
                + "WHERE cd_cpf_usuario = '"+cpf+"'"
                + "AND cd_senha_usuario = '"+pass/*.hashCode()*/+"'").executeQuery();
        Usuario user = null;
        if(rs.next()){
            user = new Usuario(rs.getString("cd_cpf_usuario"),
                     rs.getString("nm_nome_usuario"),
                     rs.getString("cd_senha_usuario"),
                     rs.getString("cd_tipo_usuario"));
        }
        rs.close();
        return user;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
    
}
