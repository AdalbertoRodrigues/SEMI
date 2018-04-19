<%-- 
    Document   : Motorista
    Created on : 18/04/2018, 20:16:46
    Author     : LuizMaciel
--%>


<%@page import="br.com.uhapp.semi.Json_encoder"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.uhapp.semi.Motorista"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="br.com.uhapp.semi.Conexao"%>
<%@page contentType="json" pageEncoding="UTF-8"%>

<%
    String action = request.getParameter("action");
   
    if(action.equals("select")) {
       try {
            Motorista motorista;
            String json = "{\"motoristas\":[";
            String atual = "";
            
            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM USUARIO, MOTORISTA WHERE MOTORISTA.cd_cpf_usuario = USUARIO.cd_cpf_usuario").executeQuery();
        
            while(rs.next()) {
                motorista = new Motorista(rs.getString("cd_cnh_motorista"), rs.getBoolean("ic_mopp_possui_naopossui_motorista"), rs.getDate("dt_validade_mopp_motorista"), 
                                          rs.getString("cd_cpf_usuario"), rs.getString("USUARIO.nm_nome_usuario"),rs.getString("USUARIO.cd_senha_usuario"),
                                          rs.getString("USUARIO.cd_tipo_usuario"));
                if(rs.isLast())
                    atual = Json_encoder.encode(motorista);
                else
                    atual = Json_encoder.encode(motorista) + ",";
                
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
    if(action.equals("selectByCnh")) {
       try {
            Motorista motorista;
            String json = "{\"motorista\":[";
            String atual = "";
            
            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM MOTORISTA, USUARIO WHERE MOTORISTA.cd_cpf_usuario = USUARIO.cd_cpf_usuario AND MOTORISTA.cd_cnh_motorista = " + request.getParameter("cnh")).executeQuery();
        
            while(rs.next()) {
                motorista = new Motorista(rs.getString("cd_cnh_motorista"), rs.getBoolean("ic_mopp_possui_naopossui_motorista"), rs.getDate("dt_validade_mopp_motorista"), 
                                          rs.getString("cd_cpf_usuario"), rs.getString("USUARIO.nm_nome_usuario"),rs.getString("USUARIO.cd_senha_usuario"),
                                          rs.getString("USUARIO.cd_tipo_usuario"));
                if(rs.isLast())
                    atual = Json_encoder.encode(motorista);
                else
                    atual = Json_encoder.encode(motorista) + ",";
                
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
           PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO MOTORISTA(cd_cnh_motorista, ic_mopp_possui_naopossui_motorista, dt_validade_mopp_motorista, cd_cpf_usuario) VALUES( ?, ?, ?, ?)");
           ps.setString(1, request.getParameter("cnh"));
           ps.setString(2, request.getParameter("mopp"));
           ps.setString(3, request.getParameter("dtvalidademopp"));
           ps.setString(4, request.getParameter("cpf"));
           ps.execute();
           out.println("SUCCESS");
       }
       catch(Exception ex) {
           out.println("ERROR");
           out.println(ex.getMessage());
       }
    }
    else if(action.equals("update")) {
       try {
           Conexao con = new Conexao();
           PreparedStatement ps = con.conexao.prepareStatement("UPDATE MOTORISTA SET ic_mopp_possui_naopossui_motorista = ? , dt_validade_mopp_motorista = ? WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
           ps.setString(1, request.getParameter("mopp"));
           ps.setString(2, request.getParameter("dtvalidademopp"));
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
           PreparedStatement ps = con.conexao.prepareStatement("DELETE FROM MOTORISTA WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
           ps.execute();
           ps = con.conexao.prepareStatement("DELETE FROM USUARIO WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
           ps.execute();
           out.println("SUCCESS");
       }
       catch(Exception ex) {
           out.println("ERROR");
           out.println(ex.getMessage());
       }
    }
%>