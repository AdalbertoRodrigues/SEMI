<%-- 
    Document   : viagem
    Created on : 22/04/2018, 13:57:15
    Author     : Henrique
--%>

<%@page import="br.com.uhapp.semi.Endereco"%>
<%@page import="br.com.uhapp.semi.Carga"%>
<%@page import="br.com.uhapp.semi.Json_encoder"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.uhapp.semi.Viagem"%> 
<%@page import="java.sql.ResultSet"%>
<%@page import="br.com.uhapp.semi.Conexao"%>
<%@page contentType="json" pageEncoding="UTF-8"%>

<%
    String action = request.getParameter("action");

    if (action.equals("select")) {
        try {
            Viagem viagem;
            Endereco enderecoPartida;
            Endereco enderecoDestino;

            String json = "{\"viagens\":[";
            String atual = "";

            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM VIAGEM AS V"
                    + " JOIN ENDERECO AS EP ON V.cd_id_endereco_partida_viagem = EP.cd_id_endereco"
                    + " JOIN ENDERECO AS EF ON V.cd_id_endereco_final_viagem = EF.cd_id_endereco;").executeQuery();
            while (rs.next()) {
                enderecoPartida = new Endereco(rs.getString("EP.cd_cep_endereco"), rs.getInt("EP.cd_numero_endereco"),
                        rs.getString("EP.nm_rua_endereco"), rs.getString("EP.nm_bairro_endereco"),
                        rs.getString("EP.nm_cidade_endereco"), rs.getString("EP.nm_estado_endereco"),
                        rs.getString("EP.nm_pais_endereco"), rs.getString("EP.ds_complemento_endereco"),
                        rs.getString("EP.ds_ponto_referencia_endereco"));
                enderecoDestino = new Endereco(rs.getString("EF.cd_cep_endereco"), rs.getInt("EF.cd_numero_endereco"),
                        rs.getString("EF.nm_rua_endereco"), rs.getString("EF.nm_bairro_endereco"),
                        rs.getString("EF.nm_cidade_endereco"), rs.getString("EF.nm_estado_endereco"),
                        rs.getString("EF.nm_pais_endereco"), rs.getString("EF.ds_complemento_endereco"),
                        rs.getString("EF.ds_ponto_referencia_endereco"));
                viagem = new Viagem(enderecoPartida, enderecoDestino, rs.getString("V.dt_prazo_viagem"), rs.getInt("V.qt_tempo_estimado_viagem"), rs.getString("V.ds_status_viagem"));
                if (rs.isLast()) {
                    atual = Json_encoder.encode(viagem);
                } else {
                    atual = Json_encoder.encode(viagem) + ",";
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
            int idPartida = 0;
            int idDestino = 0;
            Conexao con = new Conexao();

            PreparedStatement psEnderecoPartida = con.conexao.prepareStatement("INSERT INTO ENDERECO VALUES(DEFAULT,?, ?, ?, ?, ?, ?, ?, ?, ?)");
            psEnderecoPartida.setString(1, request.getParameter("cepPartida"));
            psEnderecoPartida.setInt(2, Integer.parseInt(request.getParameter("numeroPartida")));
            psEnderecoPartida.setString(3, request.getParameter("ruaPartida"));
            psEnderecoPartida.setString(4, request.getParameter("bairroPartida"));
            psEnderecoPartida.setString(5, request.getParameter("cidadePartida"));
            psEnderecoPartida.setString(6, request.getParameter("estadoPartida"));
            psEnderecoPartida.setString(7, request.getParameter("paisPartida"));
            psEnderecoPartida.setString(8, request.getParameter("complementoPartida"));
            psEnderecoPartida.setString(9, request.getParameter("pontoReferenciaPartida"));
            psEnderecoPartida.execute();
            psEnderecoPartida.close();

            try {
                ResultSet rsPartida = con.conexao.prepareStatement("SELECT cd_id_endereco FROM ENDERECO"
                        + " WHERE cd_cep_endereco = '" + request.getParameter("cepPartida")
                        + "' AND cd_numero_endereco = " + Integer.parseInt(request.getParameter("numeroPartida"))).executeQuery();
                while (rsPartida.next()) {
                    idPartida = rsPartida.getInt("cd_id_endereco");
                }
            } catch (Exception ex) {
                out.println(ex.getMessage());
            }

            PreparedStatement psEnderecoDestino = con.conexao.prepareStatement("INSERT INTO ENDERECO VALUES(DEFAULT,?, ?, ?, ?, ?, ?, ?, ?, ?)");
            psEnderecoDestino.setString(1, request.getParameter("cepDestino"));
            psEnderecoDestino.setInt(2, Integer.parseInt(request.getParameter("numeroDestino")));
            psEnderecoDestino.setString(3, request.getParameter("ruaDestino"));
            psEnderecoDestino.setString(4, request.getParameter("bairroDestino"));
            psEnderecoDestino.setString(5, request.getParameter("cidadeDestino"));
            psEnderecoDestino.setString(6, request.getParameter("estadoDestino"));
            psEnderecoDestino.setString(7, request.getParameter("paisDestino"));
            psEnderecoDestino.setString(8, request.getParameter("complementoDestino"));
            psEnderecoDestino.setString(9, request.getParameter("pontoReferenciaDestino"));
            psEnderecoDestino.execute();
            psEnderecoDestino.close();

            try {
                ResultSet rsDestino = con.conexao.prepareStatement("SELECT cd_id_endereco FROM ENDERECO"
                        + " WHERE cd_cep_endereco = '" + request.getParameter("cepDestino")
                        + "' AND cd_numero_endereco = " + Integer.parseInt(request.getParameter("numeroDestino"))).executeQuery();
                while (rsDestino.next()) {
                    idDestino = rsDestino.getInt("cd_id_endereco");
                }

            } catch (Exception ex) {
                out.println(ex.getMessage());
            }
            //Viagem
            PreparedStatement psViagem = con.conexao.prepareStatement("INSERT INTO VIAGEM VALUES(DEFAULT, ?, ?, ?, ?, ?, ?)");
            psViagem.setInt(1, idPartida);
            psViagem.setInt(2, idDestino);
            psViagem.setString(3, request.getParameter("prazo"));
            psViagem.setInt(4, Integer.parseInt(request.getParameter("tempoEstimado")));
            psViagem.setString(5, request.getParameter("status"));
            psViagem.setInt(6, Integer.parseInt(request.getParameter("carga")));
            psViagem.execute();

            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updatePrazo")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE VIAGEM SET dt_prazo_viagem = ? WHERE cd_id_viagem = " + request.getParameter("idViegem"));
            ps.setString(1, request.getParameter("prazo"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateTempo")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE VIAGEM SET qt_tempo_estimado_viagem = ? WHERE cd_id_viagem = " + request.getParameter("idViagem"));
            ps.setString(1, request.getParameter("tempo"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateStatus")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE VIAGEM SET ds_status_viagem = ? WHERE cd_id_viagem = " + request.getParameter("idViagem"));
            ps.setString(1, request.getParameter("status"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateNumero")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE ENDERECO SET cd_numero_endereco = ?  WHERE cd_id_endereco = " + request.getParameter("idEndereco"));
            ps.setString(1, request.getParameter("numero"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateCep")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE ENDERECO SET cd_cep_endereco = ?, nm_rua_endereco = ?, nm_bairro_endereco = ?"
                    + "nm_cidade_endereco = ? WHERE cd_id_endereco =" + request.getParameter("idEndereco"));
            ps.setString(1, request.getParameter("updateCepPartida"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateComplemento")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE ENDERECO SET ds_complemento_endereco = ?  WHERE cd_id_viagem = " + request.getParameter("idEndereco"));
            ps.setString(1, request.getParameter("complemento"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateEstado")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE ENDERECO SET nm_estado_endereco = ? WHERE cd_id_endereco = " + request.getParameter("idEndereco"));
            ps.setString(1, request.getParameter("estado"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updatePais")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE ENDERECO SET nm_pais_endereco = ? WHERE cd_id_endereco = " + request.getParameter("idEndereco"));
            ps.setString(1, request.getParameter("pais"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updatePontoReferencia")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE ENDERECO SET ds_ponto_referencia_endereco = ? WHERE cd_id_endereco = " + request.getParameter("idEndereco"));
            ps.setString(1, request.getParameter("pontoReferencia"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("delete")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement psViagem = con.conexao.prepareStatement("DELETE FROM VIAGEM WHERE cd_id_viagem = " + request.getParameter("idViagem"));
            psViagem.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    }

%>