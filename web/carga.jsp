<%-- 
    Document   : carga
    Created on : 22/04/2018, 11:51:36
    Author     : LuizMaciel
--%>


<%@page import="br.com.uhapp.semi.Json_encoder"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.uhapp.semi.Carga"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="br.com.uhapp.semi.Conexao"%>
<%@page contentType="json" pageEncoding="UTF-8"%>

<%
    String action = request.getParameter("action");
   
    if(action.equals("select")) {
       try {
            Carga carga;
            String json = "{\"Cargas\":[";
            String atual = "";
            
            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM CARGA").executeQuery();
        
            while(rs.next()) {
                carga = new Carga(rs.getString("nm_tipo_carga"), rs.getDouble("qt_peso_carga"), rs.getString("ds_conteudo_carga"), 
                                          rs.getString("qt_altura_carga") + "x" + rs.getString("qt_largura_carga") + "x" + rs.getString("qt_comprimento_carga"), rs.getString("sg_unidade_medida"));
                if(rs.isLast())
                    atual = Json_encoder.encode(carga);
                else
                    atual = Json_encoder.encode(carga) + ",";
                
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
    if(action.equals("selectById")) {
       try {
            Carga carga;
            String json = "{\"cargas\":[";
            String atual = "";
            
            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM CARGA WHERE cd_id_carga = " + request.getParameter("idcarga")).executeQuery();
        
            while(rs.next()) {
                carga = new Carga(rs.getString("nm_tipo_carga"), rs.getDouble("qt_peso_carga"), rs.getString("ds_conteudo_carga"), 
                                         rs.getString("qt_altura_carga") + "x" + rs.getString("qt_largura_carga") + "x" + rs.getString("qt_comprimento_carga"), rs.getString("sg_unidade_medida"));
                if(rs.isLast())
                    atual = Json_encoder.encode(carga);
                else
                    atual = Json_encoder.encode(carga) + ",";
                
                json += atual;
            }
            
            con.conexao.close();
            out.println(json + "]}");
            
        }
        catch(Exception ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        }
        
       
    }if(action.equals("selectID")) {
       try {
            int idCarga = 0;
            String json = "{\"Cargas\":[";
            String atual = "";
            
            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT cd_id_carga FROM CARGA").executeQuery();
        
            while(rs.next()) {
                idCarga = rs.getInt("cd_id_carga");
            }
            
            con.conexao.close();
            out.println(idCarga);
            
        }
        catch(Exception ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        }
        
       
    }
    
    else if(action.equals("insert")) {
       try {
           Conexao con = new Conexao();
           PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO CARGA(cd_id_carga, nm_tipo_carga, qt_peso_carga, qt_altura_carga, qt_largura_carga, qt_comprimento_carga, ds_conteudo_carga) VALUES(DEFAULT, ?, ?, ?, ?, ?, ?)");
           ps.setString(1, request.getParameter("tipocarga"));
           ps.setString(2, request.getParameter("pesocarga"));
           ps.setString(3, request.getParameter("alturacarga"));
           ps.setString(4, request.getParameter("larguracarga"));
           ps.setString(5, request.getParameter("comprimentocarga"));
           ps.setString(6, request.getParameter("conteudo"));
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
           PreparedStatement ps = con.conexao.prepareStatement("UPDATE CARGA SET nm_tipo_carga = ? , qt_peso_carga = ? , qt_altura_carga = ? , qt_largura_carga = ? , qt_comprimento_carga = ? , ds_conteudo_carga = ? WHERE cd_id_carga = " + request.getParameter("idcarga"));
           ps.setString(1, request.getParameter("tipocarga"));
           ps.setString(2, request.getParameter("pesocarga"));
           ps.setString(3, request.getParameter("alturacarga"));
           ps.setString(4, request.getParameter("larguracarga"));
           ps.setString(5, request.getParameter("comprimentocarga"));
           ps.setString(6, request.getParameter("conteudo"));
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
           PreparedStatement ps = con.conexao.prepareStatement("DELETE FROM CARGA WHERE cd_id_carga = " + request.getParameter("idcarga"));
           ps.execute();
           ps = con.conexao.prepareStatement("DELETE FROM CARGA WHERE cd_id_carga = " + request.getParameter("idcarga"));
           ps.execute();
           out.println("SUCCESS");
       }
       catch(Exception ex) {
           out.println("ERROR");
           out.println(ex.getMessage());
       }
    }
%>