<%-- 
    Document   : veiculo
    Created on : 18/04/2018, 21:36:29
    Author     : Henrique
--%>

<%@page import="java.util.stream.Collectors"%>
<%@page import="br.com.uhapp.semi.Motorista"%>
<%@page import="br.com.uhapp.semi.Marca"%>
<%@page import="br.com.uhapp.semi.Json_encoder"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.uhapp.semi.Veiculo"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="br.com.uhapp.semi.Conexao"%>
<%@page import="br.com.uhapp.semi.Usuario"%>
<%@page contentType="json" pageEncoding="UTF-8"%>

<%
    String cnhMotoristaPreferencial = "";
    String action = request.getParameter("action");
    String pesquisarPor = request.getParameter("pesquisarPor");
    if (action.equals("select")) {
        try {
            Veiculo veiculo;

            String json = "{\"veiculos\":[";
            String atual = "";

            Conexao con = new Conexao();

            if (pesquisarPor.equals("")) {
                ResultSet rs = con.conexao.prepareStatement("SELECT * FROM VEICULO WHERE ic_desativado = 0").executeQuery();
                while (rs.next()) {
                    veiculo = new Veiculo(rs.getString("cd_placa_veiculo"), new Marca(rs.getString("nm_marca_veiculo")), rs.getString("nm_modelo_veiculo"), rs.getInt("aa_ano_veiculo"), rs.getString("cd_cnh_motorista_preferencial_veiculo"), rs.getInt("qt_eixos_veiculo"));

                    if (rs.isLast()) {
                        atual = Json_encoder.encode(veiculo);
                    } else {
                        atual = Json_encoder.encode(veiculo) + ",";
                    }
                    json += atual;
                }

                con.conexao.close();
                out.println(json + "]}");
            } else if (!pesquisarPor.equals("")) {
                pesquisarPor = "'%" + pesquisarPor + "%'";
                ResultSet rs = con.conexao.prepareStatement("SELECT * FROM VEICULO WHERE (LOWER(nm_marca_veiculo) LIKE LOWER (" + pesquisarPor + ") OR LOWER(nm_modelo_veiculo) LIKE LOWER (" + pesquisarPor + ")) AND ic_desativado = 0;").executeQuery();
                while (rs.next()) {
                    veiculo = new Veiculo(rs.getString("cd_placa_veiculo"), new Marca(rs.getString("nm_marca_veiculo")), rs.getString("nm_modelo_veiculo"), rs.getInt("aa_ano_veiculo"), rs.getString("cd_cnh_motorista_preferencial_veiculo"), rs.getInt("qt_eixos_veiculo"));

                    if (rs.isLast()) {
                        atual = Json_encoder.encode(veiculo);
                    } else {
                        atual = Json_encoder.encode(veiculo) + ",";
                    }
                    json += atual;
                }

                con.conexao.close();
                out.println(json + "]}");
            }

        } catch (Exception ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        }

    } else if (action.equals("selectByPlaca")) {
        try {
            Veiculo veiculo;

            String json = "{\"veiculo\":{";
            String atual = "";

            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM VEICULO WHERE cd_placa_veiculo = '" + request.getParameter("placa") + "'").executeQuery();
            while (rs.next()) {
                veiculo = new Veiculo(rs.getString("cd_placa_veiculo"), new Marca(rs.getString("nm_marca_veiculo")), rs.getString("nm_modelo_veiculo"), rs.getInt("aa_ano_veiculo"), rs.getString("cd_cnh_motorista_preferencial_veiculo"), rs.getInt("qt_eixos_veiculo"));

                json += "\"placa\" : \"" + rs.getString("cd_placa_veiculo") + "\",";//placa
                json += "\"marca\" : \"" + rs.getString("nm_marca_veiculo") + "\",";//placa
                json += "\"modelo\" : \"" + rs.getString("nm_modelo_veiculo") + "\",";//prazo
                json += "\"ano\" : \"" + rs.getInt("aa_ano_veiculo") + "\",";//prazo
                json += "\"cnhPreferencial\" : \"" + rs.getString("cd_cnh_motorista_preferencial_veiculo") + "\",";//status
                json += "\"eixos\" : \"" + rs.getInt("qt_eixos_veiculo") + "\"}";//placa
            }

            con.conexao.close();
            out.println(json + "}");

        } catch (Exception ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        }

    } else if (action.equals("insert")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO VEICULO VALUES( ?, ?, ?, ?, ?, ?, 0)");

            String requestData = request.getReader().lines().collect(Collectors.joining());

            requestData = requestData.replace("{", "").replace("}", "");

            String placa = requestData.split(",")[0].split(":")[1].replace("\"", "");

            String marca = requestData.split(",")[1].split(":")[1].replace("\"", "");

            String modelo = requestData.split(",")[2].split(":")[1].replace("\"", "");

            String ano = requestData.split(",")[3].split(":")[1].replace("\"", "");

            String motoristaPreferencial = requestData.split(",")[4].split(":")[1].replace("\"", "");

            String eixos = requestData.split(",")[5].split(":")[1].replace("\"", "");

            ps.setString(1, placa);
            ps.setString(2, marca);
            ps.setString(3, modelo);
            ps.setInt(4, Integer.parseInt(ano));
            if (motoristaPreferencial.equals("")) {
                ps.setString(5, null);
            } else {
                ps.setString(5, motoristaPreferencial);
            }
            ps.setInt(6, Integer.parseInt(eixos));
            ps.execute();

            out.println("{\"resposta\":\"SUCCESS\"}");
        } catch (Exception ex) {
            out.println("{\"resposta\":\"ERROR\"}");
            out.println(ex.getMessage());
        }
    } else if (action.equals("insertCapacitacaoToVeiculo")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO CAPACITACAO_VEICULO VALUES(?, ?)");

            String requestData = request.getReader().lines().collect(Collectors.joining());

            requestData = requestData.replace("{", "").replace("}", "");

            String idCapacitacao = requestData.split(",")[0].split(":")[1].replace("\"", "");

            String placa = requestData.split(",")[1].split(":")[1].replace("\"", "");

            ps.setInt(1, Integer.parseInt(idCapacitacao));
            ps.setString(2, placa);
            ps.execute();
            out.println("{\"resposta\":\"SUCCESS\"}");
        } catch (Exception ex) {
            out.println("{\"resposta\":\"ERROR\"}");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateMarca")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE VEICULO SET nm_marca_veiculo = ? WHERE cd_placa_veiculo = " + request.getParameter("placa"));
            ps.setString(1, request.getParameter("marca"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateModelo")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE VEICULO SET nm_modelo_veiculo = ? WHERE cd_placa_veiculo = " + request.getParameter("placa"));
            ps.setString(1, request.getParameter("modelo"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateAno")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE VEICULO SET aa_ano_veiculo = ? WHERE cd_placa_veiculo = " + request.getParameter("placa"));
            ps.setString(1, request.getParameter("ano"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateMotoristaPreferencial")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE VEICULO SET qt_eixos_veiculo = ? WHERE cd_placa_veiculo = " + request.getParameter("placa"));
            ps.setString(1, request.getParameter("eixos"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateQtdEixos")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE VEICULO SET cd_cnh_motorista_preferencial_veiculo = ? WHERE cd_placa_veiculo = " + request.getParameter("placa"));
            ps.setString(1, request.getParameter("motoristaPreferencial"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("update")) {
        try {
            Conexao con = new Conexao();

            PreparedStatement ps = con.conexao.prepareStatement("UPDATE VEICULO SET nm_modelo_veiculo = ?, nm_marca_veiculo = ?, aa_ano_veiculo = ?, qt_eixos_veiculo = ?, cd_cnh_motorista_preferencial_veiculo = ? WHERE cd_placa_veiculo = '" + request.getParameter("placa") + "'");
            String requestData = request.getReader().lines().collect(Collectors.joining());

            requestData = requestData.replace("{", "").replace("}", "");

            String modelo = requestData.split(",")[0].split(":")[1].replace("\"", "");
            String marca = requestData.split(",")[1].split(":")[1].replace("\"", "");
            String ano = requestData.split(",")[2].split(":")[1].replace("\"", "");
            String qtdEixos = requestData.split(",")[3].split(":")[1].replace("\"", "");
            cnhMotoristaPreferencial = requestData.split(",")[4].split(":")[1].replace("\"", "");

            if (cnhMotoristaPreferencial.equals("")) {
                cnhMotoristaPreferencial = null;
            }

            ps.setString(1, modelo);
            ps.setString(2, marca);
            ps.setInt(3, Integer.parseInt(ano));
            ps.setInt(4, Integer.parseInt(qtdEixos));
            ps.setString(5, cnhMotoristaPreferencial);
            ps.execute();

            //update das capacitações
            ps = con.conexao.prepareStatement("DELETE FROM CAPACITACAO_VEICULO WHERE cd_placa_veiculo = '" + request.getParameter("placa") + "'");
            ps.execute();
            if (requestData.split(",")[5].split(":")[1].replace("\"", "").equals("true")) {
                ps = con.conexao.prepareStatement("INSERT INTO CAPACITACAO_VEICULO(cd_placa_veiculo, cd_id_capacitacao) VALUES('" + request.getParameter("placa") + "', 1)");
                ps.execute();
            }
            if (requestData.split(",")[6].split(":")[1].replace("\"", "").equals("true")) {
                ps = con.conexao.prepareStatement("INSERT INTO CAPACITACAO_VEICULO(cd_placa_veiculo, cd_id_capacitacao) VALUES('" + request.getParameter("placa") + "', 2)");
                ps.execute();
            }
            if (requestData.split(",")[7].split(":")[1].replace("\"", "").equals("true")) {
                ps = con.conexao.prepareStatement("INSERT INTO CAPACITACAO_VEICULO(cd_placa_veiculo, cd_id_capacitacao) VALUES('" + request.getParameter("placa") + "', 3)");
                ps.execute();
            }
            if (requestData.split(",")[8].split(":")[1].replace("\"", "").equals("true")) {
                ps = con.conexao.prepareStatement("INSERT INTO CAPACITACAO_VEICULO(cd_placa_veiculo, cd_id_capacitacao) VALUES('" + request.getParameter("placa") + "', 4)");
                ps.execute();
            }
            out.println("{\"resposta\":\"SUCCESS\"}");
        } catch (Exception ex) {
            //out.println("{\"resposta\":\"ERROR\"}");
            out.println(ex.getMessage());
        }

    } else if (action.equals("delete")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE VEICULO SET ic_desativado = 1 WHERE cd_placa_veiculo = '" + request.getParameter("placa") + "'");
            ps.execute();
            out.println("{\"resposta\":\"SUCCESS\"}");
        } catch (Exception ex) {
            out.println("{\"resposta\":\"ERROR\"}");
        }
    }

%>
