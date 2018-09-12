<%-- 
    Document   : marca
    Created on : 18/04/2018, 20:46:49
    Author     : adalb
--%>

<%@page import="br.com.uhapp.semi.Marca"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="br.com.uhapp.semi.Json_encoder"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.uhapp.semi.Conexao"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>

<%
    String action = request.getParameter("action");
    
    
    
    if(action.equals("select")) {
        try {
            Marca marca;
            String json = "{\"marcas\":[";
            String atual = "";
            
            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM MARCA").executeQuery();
        
            while(rs.next()) {
                marca = new Marca(rs.getString("nm_marca"));
                if(rs.isLast())
                    atual = Json_encoder.encode(marca);
                else
                    atual = Json_encoder.encode(marca) + ",";
                
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
    else if(action.equals("selectByName")) {
        try {
            Marca marca;
            String json = "{\"marca\":[";
            String atual = "";
            
            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM MARCA WHERE nm_marca = '" + request.getParameter("nm_marca") + "'").executeQuery();
        
            while(rs.next()) {
                marca = new Marca(rs.getString("nm_marca"));
                if(rs.isLast())
                    atual = Json_encoder.encode(marca);
                else
                    atual = Json_encoder.encode(marca) + ",";
                
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
           PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO MARCA(nm_marca) VALUES(?)");
           ps.setString(1, request.getParameter("nome"));
           
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
           PreparedStatement ps = con.conexao.prepareStatement("UPDATE MARCA SET nm_marca = ? WHERE cd_id_marca = " + request.getParameter("idmarca"));
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
           PreparedStatement ps = con.conexao.prepareStatement("DELETE FROM MARCA WHERE cd_id_marca = " + request.getParameter("idmarca"));
           ps.execute();
           out.println("SUCCESS");
       }
       catch(Exception ex) {
           out.println("ERROR");
           out.println(ex.getMessage());
       }
    }
%>