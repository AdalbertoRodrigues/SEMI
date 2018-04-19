<%-- 
    Document   : veiculo
    Created on : 18/04/2018, 21:36:29
    Author     : Henrique
--%>

<%@page import="br.com.uhapp.semi.Json_encoder"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.uhapp.semi.Veiculo"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="br.com.uhapp.semi.Conexao"%>
<%@page contentType="json" pageEncoding="UTF-8"%>
 
<%
    String action = request.getParameter("action");
   
    if(action.equals("select")) {
       try {
            Veiculo veiculo;
            String json = "{\"veiculos\":[";
            String atual = "";
            
            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM VEICULO").executeQuery();
        
            while(rs.next()) {
                veiculo = new Veiculo(rs.getString("nm_marca_veiculo"), rs.getString("nm_modelo_veiculo"),
                rs.getInt("aa_ano_veiculo"), rs.getString("cd_cnh_motorista_preferencial_veiculo"), rs.getInt("qt_eixos_veiculo")
                );
                if(rs.isLast())
                    atual = Json_encoder.encode(veiculo);
                else
                    atual = Json_encoder.encode(veiculo) + ",";
                
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
            
            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM USUARIO WHERE cd_cpf_usuario = " + request.getParameter("cpf")).executeQuery();
        
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
           PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO USUARIO(cd_cpf_usuario, nm_nome_usuario, cd_senha_usuario, cd_tipo_usuario) VALUES( ?, ?, ?, ?)");
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
           PreparedStatement ps = con.conexao.prepareStatement("UPDATE USUARIO SET nm_nome_usuario = ? WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
           ps.setString(1, request.getParameter("nome"));
           ps.execute();
           out.println("SUCCESS");
       }
       catch(Exception ex) {
           out.println("ERROR");
           out.println(ex.getMessage());
       }
    }
    else if(action.equals("updateSenha")) {
       try {
           Conexao con = new Conexao();
           PreparedStatement ps = con.conexao.prepareStatement("UPDATE USUARIO SET cd_senha_usuario = ? WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
           ps.setString(1, request.getParameter("senha"));
           ps.execute();
           out.println("SUCCESS");
       }
       catch(Exception ex) {
           out.println("ERROR");
           out.println(ex.getMessage());
       }
    }
    else if(action.equals("updateTipo")) {
       try {
           Conexao con = new Conexao();
           PreparedStatement ps = con.conexao.prepareStatement("UPDATE USUARIO SET cd_tipo_usuario = ? WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
           ps.setString(1, request.getParameter("tipo"));
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
           PreparedStatement ps = con.conexao.prepareStatement("DELETE FROM USUARIO WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
           ps.execute();
           out.println("SUCCESS");
       }
       catch(Exception ex) {
           out.println("ERROR");
           out.println(ex.getMessage());
       }
    }
%>
