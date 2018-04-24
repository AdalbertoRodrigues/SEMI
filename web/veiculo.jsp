<%-- 
    Document   : veiculo
    Created on : 18/04/2018, 21:36:29
    Author     : Henrique
--%>

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
    String action = request.getParameter("action");
    String pesquisarPor = request.getParameter("pesquisarPor");

    if (action.equals("select")) {
        try {
            Veiculo veiculo;

            String json = "{\"veiculos\":[";
            String atual = "";

            Conexao con = new Conexao();

            if (pesquisarPor.equals("")) {
                ResultSet rs = con.conexao.prepareStatement("SELECT * FROM VEICULO").executeQuery();
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
                ResultSet rs = con.conexao.prepareStatement("SELECT * FROM VEICULO WHERE LOWER(nm_marca_veiculo) LIKE LOWER (" + pesquisarPor + ") OR LOWER(nm_modelo_veiculo) LIKE LOWER (" + pesquisarPor + ");").executeQuery();
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

    } else if (action.equals("insert")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO VEICULO VALUES( ?, ?, ?, ?, ?, ?)");
            String placa = request.getParameter("placa");
            String marca = request.getParameter("marca");
            String modelo = request.getParameter("modelo");
            String ano = request.getParameter("ano");
            String motoristaPreferencial = request.getParameter("motoristaPreferencial");
            String eixos = request.getParameter("eixos");
            ps.setString(1, placa);
            ps.setString(2, marca);
            ps.setString(3, modelo);
            ps.setInt(4, Integer.parseInt(ano));
            ps.setString(5, motoristaPreferencial);
            ps.setInt(6, Integer.parseInt(eixos));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("insertCapacitacaoToVeiculo")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO CAPACITACAO_VEICULO VALUES(?, ?)");
            ps.setInt(1, Integer.parseInt(request.getParameter("idCapacitacao")));
            ps.setString(2, request.getParameter("placa"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    }else if (action.equals("updateMarca")) {
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
    } else if (action.equals("delete")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("DELETE FROM VEICULOS WHERE cd_placa_veiculo = " + request.getParameter("placa"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    }

%>
