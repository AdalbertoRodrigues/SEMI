<%-- 
    Document   : Usuario
    Created on : 12/04/2018, 11:30:18
    Author     : adalberto
--%>


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
                    atual = "{\"cpf\":\"" + usuario.getCpf() + "\",\"nome\":\"" + usuario.getNome() + "\",\"senha\":\"" + usuario.getSenha() + "\",\"tipo\":\"" + usuario.getTipo() + "\"}";
                else
                    atual = "{\"cpf\":\"" + usuario.getCpf() + "\",\"nome\":\"" + usuario.getNome() + "\",\"senha\":\"" + usuario.getSenha() + "\",\"tipo\":\"" + usuario.getTipo() + "\"},";
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
    else if(action.equals("selectById")) {
       
    }
    else if(action.equals("insert")) {
       
    }
    else if(action.equals("update")) {
       
    }
    else if(action.equals("delete")) {
       
    }
%>