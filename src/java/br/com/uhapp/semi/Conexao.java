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
import java.sql.*;

public class Conexao {

    private String host = "localhost:3306"; //200.147.61.75
    private String dataBase = "semi_database"; //semi_databse
    private String login = "semi_dba"; //semi_dba
    private String senha = "admin1@"; // admin1@
    public Connection conexao;

    public Conexao() {
        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            this.conexao = DriverManager.getConnection(
                    "jdbc:mysql://semi-database.mysql.uhserver.com:3306/semi_database", this.login, this.senha);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    public static void main(String args[]) {

        try {
            Usuario usuario;
            String json = "{";
            String atual = "";
            Conexao con = new Conexao();
            ResultSet rs = con.conexao.createStatement().executeQuery("SELECT * FROM usuario");

            while (rs.next()) {
                usuario = new Usuario(rs.getString("cd_cpf_usuario"), rs.getString("nm_nome_usuario"), rs.getString("cd_senha_usuario"), rs.getString("cd_tipo_usuario"));
                if (rs.isLast()) {
                    atual = "{\"cpf\":\"" + usuario.getCpf() + "\",\"nome\":\"" + usuario.getNome() + "\",\"senha\":\"" + usuario.getSenha() + "\",\"tipo\":\"" + usuario.getTipo() + "\"}";
                } else {
                    atual = "{\"cpf\":\"" + usuario.getCpf() + "\",\"nome\":\"" + usuario.getNome() + "\",\"senha\":\"" + usuario.getSenha() + "\",\"tipo\":\"" + usuario.getTipo() + "\"},";
                }
                json += atual;
            }

            con.conexao.close();
            System.out.println(json + "}");
            /*Conexao con = new Conexao();
            PreparedStatement st = con.conexao.prepareStatement("INSERT INTO USUARIO (cd_cpf_usuario, nm_nome_usuario, cd_senha_usuario, cd_tipo_usuario) VALUES (?,?,?,?)");
            st.setInt(1, 12);
            st.setString(2, "Vinícius");
            st.setString(3, "betinholixo");
            st.setInt(4, 0);
            st.execute();
            st.close();
            con.conexao.close();*/
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

        //       Connection conexao = DriverManager.getConnection(
        //                   "jdbc:mysql://200.147.61.75/semi_database","semi_dba","admin1@");
        //       System.out.println("Conectado!");
//        PreparedStatement st = conexao.prepareStatement("INSERT INTO USUARIO (cd_cpf_usuario, nm_nome_usuario, cd_senha_usuario, cd_tipo_usuario) VALUES (?,?,?,?)");
//        st.setInt(1, 1234);
//        st.setString(2, "Vinícius");
//        st.setString(3, "betinholixo");
//        st.setInt(4, 0);
//        st.executeUpdate();
//        conexao.close();
    }

}
