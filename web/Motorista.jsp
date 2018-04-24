<%-- 
    Document   : Motorista
    Created on : 18/04/2018, 20:16:46
    Author     : LuizMaciel
--%>


<%@page import="java.util.stream.Collectors"%>
<%@page import="br.com.uhapp.semi.Json_encoder"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.uhapp.semi.Motorista"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="br.com.uhapp.semi.Conexao"%>
<%@page contentType="json" pageEncoding="UTF-8"%>

<%
    String action = request.getParameter("action");

    if (action.equals("select")) {
        try {
            Motorista motorista;
            String json = "{\"motoristas\":[";
            String atual = "";

            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM USUARIO, MOTORISTA WHERE MOTORISTA.cd_cpf_usuario = USUARIO.cd_cpf_usuario").executeQuery();

            while (rs.next()) {

                motorista = new Motorista(rs.getString("cd_cnh_motorista"), rs.getBoolean("ic_mopp_possui_naopossui_motorista"), rs.getDate("dt_validade_mopp_motorista"),
                        rs.getString("cd_cpf_usuario"), rs.getString("USUARIO.nm_nome_usuario"), rs.getString("USUARIO.cd_senha_usuario"),
                        rs.getString("USUARIO.cd_tipo_usuario"));
                if (rs.isLast()) {
                    atual = Json_encoder.encode(motorista);
                } else {
                    atual = Json_encoder.encode(motorista) + ",";
                }

                json += atual;
            }

            con.conexao.close();
            out.println(json + "]}");

        } catch (Exception ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        }

    } else if (action.equals("selectByCnh")) {
        try {
            Motorista motorista;
            String json = "{\"motorista\":[";
            String atual = "";

            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM MOTORISTA, USUARIO WHERE MOTORISTA.cd_cpf_usuario = USUARIO.cd_cpf_usuario AND MOTORISTA.cd_cnh_motorista = " + request.getParameter("cnh")).executeQuery();

            while (rs.next()) {
                motorista = new Motorista(rs.getString("cd_cnh_motorista"), rs.getBoolean("ic_mopp_possui_naopossui_motorista"), rs.getDate("dt_validade_mopp_motorista"),
                        rs.getString("cd_cpf_usuario"), rs.getString("USUARIO.nm_nome_usuario"), rs.getString("USUARIO.cd_senha_usuario"),
                        rs.getString("USUARIO.cd_tipo_usuario"));
                if (rs.isLast()) {
                    atual = Json_encoder.encode(motorista);
                } else {
                    atual = Json_encoder.encode(motorista) + ",";
                }

                json += atual;
            }

            con.conexao.close();
            out.println(json + "]}");

        } catch (Exception ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        }

    } else if (action.equals("selectByCpf")) {
        try {
            Motorista motorista;
            String json = "{\"motorista\":[";
            String atual = "";

            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM MOTORISTA, USUARIO WHERE MOTORISTA.cd_cpf_usuario = USUARIO.cd_cpf_usuario AND MOTORISTA.cd_cpf_usuario = " + request.getParameter("cpf")).executeQuery();

            while (rs.next()) {
                motorista = new Motorista(rs.getString("cd_cnh_motorista"), rs.getBoolean("ic_mopp_possui_naopossui_motorista"), rs.getDate("dt_validade_mopp_motorista"),
                        rs.getString("cd_cpf_usuario"), rs.getString("USUARIO.nm_nome_usuario"), rs.getString("USUARIO.cd_senha_usuario"),
                        rs.getString("USUARIO.cd_tipo_usuario"));
                if (rs.isLast()) {
                    atual = Json_encoder.encode(motorista);
                } else {
                    atual = Json_encoder.encode(motorista) + ",";
                }

                json += atual;
            }

            con.conexao.close();
            out.println(json + "]}");

        } catch (Exception ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        }

    } else if (action.equals("insert")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps;

            String requestData = request.getReader().lines().collect(Collectors.joining());

            requestData = requestData.replace("{", "").replace("}", "");

            String cpf = requestData.split(",")[0].split(":")[1].replace("\"", "");

            String nome = requestData.split(",")[1].split(":")[1].replace("\"", "");

            String senha = requestData.split(",")[2].split(":")[1].replace("\"", "");

            String tipo = requestData.split(",")[3].split(":")[1].replace("\"", "");

            String cnh = requestData.split(",")[4].split(":")[1].replace("\"", "");

            boolean mopp;
            if (requestData.split(",")[5].split(":")[1].replace("\"", "").equals("true")) {
                mopp = true;
            } else {
                mopp = false;
            }

            String validade = requestData.split(",")[6].split(":")[1].replace("\"", "");

            ps = con.conexao.prepareStatement("INSERT INTO USUARIO(cd_cpf_usuario, nm_nome_usuario, cd_senha_usuario, cd_tipo_usuario) VALUES( ?, ?, ?, ?)");
            ps.setString(1, cpf);
            ps.setString(2, nome);
            ps.setString(3, senha);
            ps.setString(4, tipo);
            ps.execute();

            ps = con.conexao.prepareStatement("INSERT INTO MOTORISTA(cd_cnh_motorista, ic_mopp_possui_naopossui_motorista, dt_validade_mopp_motorista, cd_cpf_usuario) VALUES( ?, ?, ?, ?)");
            ps.setString(1, cnh);
            ps.setBoolean(2, mopp);
            if (validade.equals("")) {
                ps.setString(3, null);
            } else {
                ps.setString(3, validade);
            }
            ps.setString(4, cpf);
            ps.execute();

            out.println("{\"status\" : [\"status\":\"SUCCESS\"]}");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("update")) {
        try {
            Conexao con = new Conexao();

            String requestData = request.getReader().lines().collect(Collectors.joining());

            requestData = requestData.replace("{", "").replace("}", "");
            
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE USUARIO SET nm_nome_usuario = ?, cd_senha_usuario  = ? WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
            
            String nome = requestData.split(",")[0].split(":")[1].replace("\"", "");

            String senha = requestData.split(",")[1].split(":")[1].replace("\"", "");
            
            ps.setString(1, nome);
            ps.setString(2, senha);
            ps.execute();
            
            ps = con.conexao.prepareStatement("UPDATE MOTORISTA SET ic_mopp_possui_naopossui_motorista = ? , dt_validade_mopp_motorista = ? WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
            
            boolean mopp;
            if (requestData.split(",")[2].split(":")[1].replace("\"", "").equals("true")) {
                mopp = true;
            } else {
                mopp = false;
            }

            String validade = requestData.split(",")[3].split(":")[1].replace("\"", "");
            
            
            ps.setBoolean(1, mopp);
            if (validade.equals("")) {
                ps.setString(2, null);
            } else {
                ps.setString(2, validade);
            }
            
            ps.execute();
            out.println("{\"status\" : [\"status\":\"SUCCESS\"]}");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("delete")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("DELETE FROM MOTORISTA WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
            ps.execute();
            ps = con.conexao.prepareStatement("DELETE FROM USUARIO WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    }
%>