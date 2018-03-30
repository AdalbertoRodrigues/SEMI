/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.uhapp.semi;

/**
 *
 * @author adalb
 */
import java.sql.*;

public class Conexao {
    public static void main(String[] args) throws SQLException {
        Connection conexao = DriverManager.getConnection(
                    "jdbc:mysql://200.147.61.75/semi_database","semi_dba","admin1@");
        System.out.println("Conectado!");
//        PreparedStatement st = conexao.prepareStatement("INSERT INTO USUARIO (cd_cpf_usuario, nm_nome_usuario, cd_senha_usuario, cd_tipo_usuario) VALUES (?,?,?,?)");
//        st.setInt(1, 1234);
//        st.setString(2, "Vinícius");
//        st.setString(3, "betinholixo");
//        st.setInt(4, 0);
//        st.executeUpdate();
        conexao.close();
    }
}

