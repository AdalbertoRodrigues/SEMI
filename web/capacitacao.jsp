<%-- 
    Document   : capacitacao
    Created on : 18/04/2018, 21:57:21
    Author     : Henrique
--%>

<%@page import="br.com.uhapp.semi.Json_encoder"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.uhapp.semi.Capacitacao"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="br.com.uhapp.semi.Conexao"%>
<%@page contentType="json" pageEncoding="UTF-8"%>
 
<%
String action = request.getParameter("action");
   
if(action.equals("select")) {
       try {
            Capacitacao capacitacao;
            String json = "{\"capacitacao\":[";
            String atual = "";
            
            Conexao con = new Conexao();
            
            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM CAPACITACAO").executeQuery();
            
            while(rs.next()) {
                capacitacao = new Capacitacao(rs.getInt("cd_id_capacitacao"), rs.getString("nm_tipo_capacitacao"));
                if(rs.isLast())
                    atual = Json_encoder.encode(capacitacao);
                else
                    atual = Json_encoder.encode(capacitacao) + ",";
                
                json += atual;
            }
            
            con.conexao.close();
            out.println(json + "]}");
            
        }
        catch(Exception ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        }
    }else if(action.equals("selectByVeiculo")) {
        try {
            Capacitacao capacitacao;
            String json = "{\"capacitacao\":[";
            String atual = "";
            
            Conexao con = new Conexao();
            
            ResultSet rs = con.conexao.prepareStatement("SELECT CAPACITACAO.cd_id_capacitacao , nm_tipo_capacitacao "
                    + "FROM CAPACITACAO, CAPACITACAO_VEICULO, VEICULO "
                    + "WHERE CAPACITACAO_VEICULO.cd_placa_veiculo = VEICULO.cd_placa_veiculo "
                    + "AND CAPACITACAO_VEICULO.cd_id_capacitacao = CAPACITACAO.cd_id_CAPACITACAO "
                    + "AND CAPACITACAO_VEICULO.cd_placa_veiculo = '" + request.getParameter("placa") + "'").executeQuery();
            
            while(rs.next()) {
                capacitacao = new Capacitacao(rs.getInt("CAPACITACAO.cd_id_capacitacao"), rs.getString("nm_tipo_capacitacao"));
                if(rs.isLast())
                    atual = Json_encoder.encode(capacitacao);
                else
                    atual = Json_encoder.encode(capacitacao) + ",";
                
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
           PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO CAPACITACAO VALUES(DEFAULT, ?)");
           ps.setString(1, request.getParameter("descricaoCapacitacao"));
           ps.execute();
           out.println("SUCCESS");
       }
       catch(Exception ex) {
           out.println("ERROR");
           out.println(ex.getMessage());
       }
    }
    else if(action.equals("updateById")) {
       try {
           Conexao con = new Conexao();
           PreparedStatement ps = con.conexao.prepareStatement("UPDATE CAPACITACAO SET nm_tipo_capacitacao = ? WHERE cd_id_capacitacao = " + request.getParameter("idCapacitacao"));
           ps.setString(1, request.getParameter("tipoCapacitacao"));
           ps.execute();
           out.println("SUCCESS");
       }
       catch(Exception ex) {
           out.println("ERROR");
           out.println(ex.getMessage());
       }
    }else if(action.equals("delete")) {
       try {
           Conexao con = new Conexao();
           PreparedStatement ps = con.conexao.prepareStatement("DELETE FROM CAPACITACAO WHERE cd_id_capacitacao = " + request.getParameter("idCapacitacao"));
           ps.execute();
           out.println("SUCCESS");
       }
       catch(Exception ex) {
           out.println("ERROR");
           out.println(ex.getMessage());
       }
    }

%>