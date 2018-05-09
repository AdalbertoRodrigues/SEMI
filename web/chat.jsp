<%-- 
    Document   : chat
    Created on : 06/05/2018, 22:15:41
    Author     : adalberto
--%>

<%@page import="java.util.stream.Collectors"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.uhapp.semi.Usuario"%>
<%@page import="br.com.uhapp.semi.Json_encoder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="br.com.uhapp.semi.Conexao"%>
<%@page import="br.com.uhapp.semi.Mensagem"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>

<%
    String action = request.getParameter("action");

    if (action.equals("getMessagesFromViagem")) {
        try {
            
            int idViagem = Integer.parseInt(request.getParameter("idViagem"));
            
            Mensagem mensagem;
            String json = "{\"mensagens\":[";
            String atual = "";
            
            Conexao con = new Conexao();
            
            ResultSet rs = con.conexao.prepareStatement("SELECT cd_id_chat FROM CHAT WHERE cd_id_viagem = " + idViagem).executeQuery();
            if (rs.next()) {
                int idChat = rs.getInt("cd_id_viagem");
                rs = con.conexao.prepareStatement("SELECT * FROM MENSAGEM WHERE cd_id_chat = " + idChat).executeQuery();
                while (rs.next()) {
                    ResultSet rs2 = con.conexao.prepareStatement("SELECT * FROM USUARIO WHERE cd_cpf_usuario = '" + rs.getString("cd_cpf_remetente_mensagem") + "'").executeQuery();
                    Usuario usuario = new Usuario(rs2.getString("cd_cpf_usuario"), rs2.getString("nm_nome_usuario"), rs2.getString("cd_senha_usuario"), rs2.getString("cd_tipo_usuario"));
                    mensagem = new Mensagem(rs.getString("ds_mensagem"), usuario);
                    if (rs.isLast()) {
                        atual = Json_encoder.encode(mensagem);
                    } else {
                        atual = Json_encoder.encode(mensagem) + ",";
                    }
                    json += atual;
                }

                con.conexao.close();
                out.println(json + "]}");

            }
        } catch (Exception ex) {
            out.println(ex.getMessage());
        }
    } else if (action.equals("getMessagesByChatId")) {
        try {
            int idChat = Integer.parseInt(request.getParameter("idChat"));
            Mensagem mensagem;
            String json = "{\"mensagens\":[";
            String atual = "";

            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM MENSAGEM WHERE cd_id_chat = " + idChat).executeQuery();

            while (rs.next()) {
                ResultSet rs2 = con.conexao.prepareStatement("SELECT * FROM USUARIO WHERE cd_cpf_usuario = '" + rs.getString("cd_cpf_remetente_mensagem") + "'").executeQuery();
                Usuario usuario = new Usuario(rs2.getString("cd_cpf_usuario"), rs2.getString("nm_nome_usuario"), rs2.getString("cd_senha_usuario"), rs2.getString("cd_tipo_usuario"));
                mensagem = new Mensagem(rs.getString("ds_mensagem"), usuario);
                if (rs.isLast()) {
                    atual = Json_encoder.encode(mensagem);
                } else {
                    atual = Json_encoder.encode(mensagem) + ",";
                }
                json += atual;
            }

            con.conexao.close();
            out.println(json + "]}");

        } catch (Exception ex) {
            out.println(ex.getMessage());
        }
    } else if (action.equals("insertChat")) {
        try {
            Conexao con = new Conexao();
            
            int idViagem = Integer.parseInt(request.getParameter("idViagem"));
            String cpfFuncionario = session.getAttribute("me.cpf").toString();
            ResultSet rs = con.conexao.prepareStatement("SELECT cd_cnh_motorista FROM VIAGEM_ESCALADA WHERE cd_id_viagem = " + idViagem).executeQuery();
            rs.next();
            String cnhMotorista = rs.getString("cd_cnh_motorista");
            PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO CHAT(cd_cpf_funcionario, cd_cnh_motorista, cd_id_viagem) VALUES(?, ?, ?)");
            ps.setString(1, cpfFuncionario);
            ps.setString(2, cnhMotorista);
            ps.setInt(3, idViagem);
            ps.execute();
            
            out.println("{\"resposta\":\"SUCCESS\"}");
        } catch (Exception ex) {
            out.println(ex.getMessage());
        }
    } else if (action.equals("insertMessage")) {
        try {
            int idChat = Integer.parseInt(request.getParameter("idChat"));
            Conexao con = new Conexao();

            String requestData = request.getReader().lines().collect(Collectors.joining());

            requestData = requestData.replace("{", "").replace("}", "");

            String cpf = session.getAttribute("me.cpf").toString();
            String mensagem = "";

            PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO MENSAGEM(ds_mensagem, cd_cpf_remetente_mensagem, cd_id_chat) VALUES(?, ?, ?)");
            ps.setString(1, mensagem);
            ps.setString(2, cpf);
            ps.setInt(3, idChat);
            ps.execute();
            
            out.println("{\"resposta\":\"SUCCESS\"}");
        } catch (Exception ex) {
            out.println("{\"resposta\":\"ERROR\"}");
        }
    }
%>