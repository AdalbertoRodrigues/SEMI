<%-- 
    Document   : Usuario
    Created on : 12/04/2018, 11:30:18
    Author     : adalberto
--%>


<%@page import="br.com.uhapp.semi.Json_encoder"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.uhapp.semi.Usuario"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="br.com.uhapp.semi.Conexao"%>
<%@page contentType="json" pageEncoding="UTF-8"%>
 
<%
    String action = request.getParameter("action");
   
    if(action.equals("select")) {
       try {
            Usuario usuario;
            String json = "{\"usuarios\":[";
            String atual = "";
            
            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM usuario").executeQuery();
        
            while(rs.next()) {
                usuario = new Usuario(rs.getString("cd_cpf_usuario"), rs.getString("nm_nome_usuario"), rs.getString("cd_senha_usuario"), rs.getString("cd_tipo_usuario"));
                if(rs.isLast())
                    atual = Json_encoder.encode(usuario);
                else
                    atual = Json_encoder.encode(usuario) + ",";
                
                json += atual;
            }
            
            con.conexao.close();
            out.println(json + "]}");
            
        }
        catch(Exception ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        }
        
       
    }
    else if(action.equals("selectByCpf")) {
       try {
            Usuario usuario;
            String json = "{\"usuario\":[";
            String atual = "";
            
            Conexao con = new Conexao();
            
            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM usuario WHERE cd_cpf_usuario = " + request.getParameter("cpf")).executeQuery();
        
            while(rs.next()) {
                usuario = new Usuario(rs.getString("cd_cpf_usuario"), rs.getString("nm_nome_usuario"), rs.getString("cd_senha_usuario"), rs.getString("cd_tipo_usuario"));
                if(rs.isLast())
                    atual = Json_encoder.encode(usuario);
                else
                    atual = Json_encoder.encode(usuario) + ",";
                
                json += atual;
            }
            
            con.conexao.close();
            out.println(json + "]}");
            
        }
        catch(Exception ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        }
    }
    else if(action.equals("insert")) {
       try {
           Conexao con = new Conexao();
           PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO usuario(cd_cpf_usuario, nm_nome_usuario, cd_senha_usuario, cd_tipo_usuario) VALUES( ?, ?, ?, ?)");
           ps.setString(1, request.getParameter("cpf"));
           ps.setString(2, request.getParameter("nome"));
           ps.setString(3, request.getParameter("senha"));
           ps.setString(4, request.getParameter("tipo"));
           ps.execute();
           out.println("SUCCESS");
       }
       catch(Exception ex) {
           out.println("ERROR");
           out.println(ex.getMessage());
       }
    }
    else if(action.equals("updateNome")) {
       try {
           Conexao con = new Conexao();
           PreparedStatement ps = con.conexao.prepareStatement("UPDATE usuario SET nm_nome_usuario = ? WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
           ps.setString(1, request.getParameter("nome"));
           ps.execute();
           out.println("SUCCESS");
       }
       catch(Exception ex) {
           out.println("ERROR");
           out.println(ex.getMessage());
       }
    }
    else if(action.equals("delete")) {
       try {
           Conexao con = new Conexao();
           PreparedStatement ps = con.conexao.prepareStatement("DELETE FROM usuario WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
           ps.execute();
           out.println("SUCCESS");
       }
       catch(Exception ex) {
           out.println("ERROR");
           out.println(ex.getMessage());
       }
    }
%>