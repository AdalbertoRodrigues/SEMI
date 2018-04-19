<%-- 
    Document   : marca
    Created on : 18/04/2018, 20:46:49
    Author     : adalb
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.uhapp.semi.Conexao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String action = request.getParameter("action");
    
    if(action.equals("insert")) {
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