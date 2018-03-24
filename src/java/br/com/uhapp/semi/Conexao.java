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
        conexao.close();
    }
}

