<%-- 
    Document   : viagem
    Created on : 22/04/2018, 13:57:15
    Author     : Henrique
--%>

<%@page import="java.util.stream.Collectors"%>
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
                    + " JOIN ENDERECO AS EF ON V.cd_id_endereco_final_viagem = EF.cd_id_endereco"
                    + " JOIN CARGA AS C ON V.cd_id_viagem = C.cd_id_carga WHERE V.ic_desativado_viagem = 0").executeQuery();
            while (rs.next()) {
                enderecoPartida = new Endereco(rs.getString("EP.cd_cep_endereco"), rs.getInt("EP.cd_numero_endereco"),
                        rs.getString("EP.nm_rua_endereco"), 
                        rs.getString("EP.nm_cidade_endereco"), rs.getString("EP.nm_estado_endereco"),
                        rs.getString("EP.nm_pais_endereco"), rs.getString("EP.ds_complemento_endereco"),
                        rs.getString("EP.ds_ponto_referencia_endereco"));
                enderecoDestino = new Endereco(rs.getString("EF.cd_cep_endereco"), rs.getInt("EF.cd_numero_endereco"),
                        rs.getString("EF.nm_rua_endereco"),
                        rs.getString("EF.nm_cidade_endereco"), rs.getString("EF.nm_estado_endereco"),
                        rs.getString("EF.nm_pais_endereco"), rs.getString("EF.ds_complemento_endereco"),
                        rs.getString("EF.ds_ponto_referencia_endereco"));
                String dimensoes = rs.getDouble("qt_altura_carga") + "x" + rs.getDouble("qt_largura_carga") + "x" + rs.getDouble("qt_comprimento_carga");
                Carga carga = new Carga(rs.getString("nm_tipo_carga"), rs.getDouble("qt_peso_carga"), rs.getString("ds_conteudo_carga"), dimensoes, rs.getString("sg_unidade_medida"));
                viagem = new Viagem(enderecoPartida, enderecoDestino, rs.getString("V.dt_prazo_viagem"), rs.getString("V.ds_status_viagem"), carga, rs.getInt("cd_id_viagem"));
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
            Conexao con = new Conexao();
            PreparedStatement ps;
            ResultSet rs;
            //dados recebidos por JSON
            String requestData = request.getReader().lines().collect(Collectors.joining());
            
            requestData = requestData.replace("{", "").replace("}", "");
            //variaveis da carga
            String tipoCarga = requestData.split(",")[0].split(":")[1].replace("\"", "");
            
            String pesoCarga = requestData.split(",")[1].split(":")[1].replace("\"", "");
            double pesoCargaDouble;
            String unidadeMedidaCarga;
            
            if(pesoCarga.substring(pesoCarga.length() - 3, pesoCarga.length() - 1).equals("kg")) {
                pesoCargaDouble = Double.parseDouble(pesoCarga.substring(0, pesoCarga.length() - 3));
                unidadeMedidaCarga = "kg";
            }
            else {
                pesoCargaDouble = Double.parseDouble(pesoCarga.substring(0, pesoCarga.length() - 4));
                unidadeMedidaCarga = "ton";
            }
            String alturaCarga = requestData.split(",")[2].split(":")[1].replace("\"", "");
            String larguraCarga = requestData.split(",")[3].split(":")[1].replace("\"", "");
            String comprimentoCarga = requestData.split(",")[4].split(":")[1].replace("\"", "");
            String conteudoCarga = requestData.split(",")[5].split(":")[1].replace("\"", "");
            
            //cadastrar carga
            ps = con.conexao.prepareStatement("INSERT INTO CARGA(nm_tipo_carga, qt_peso_carga, qt_altura_carga, qt_largura_carga, qt_comprimento_carga, ds_conteudo_carga) VALUES(?, ?, ?, ?, ?, ?)");
            ps.setString(1, tipoCarga);
            ps.setDouble(2, pesoCargaDouble);
            ps.setDouble(3, Double.parseDouble(alturaCarga));
            ps.setDouble(4, Double.parseDouble(larguraCarga));
            ps.setDouble(5, Double.parseDouble(comprimentoCarga));
            ps.setString(6, conteudoCarga);
            ps.execute();
            rs = con.conexao.prepareStatement("SELECT cd_id_carga FROM CARGA ORDER BY cd_id_carga DESC LIMIT 1").executeQuery();
            rs.next();
            int idCarga = rs.getInt("cd_id_carga");
            //variaveis do endereco de partida
            String enderecoCepPartida = requestData.split(",")[7].split(":")[1].replace("\"", "");;
            String enderecoNumeroPartida = requestData.split(",")[8].split(":")[1].replace("\"", "");;
            String enderecoRuaPartida = requestData.split(",")[9].split(":")[1].replace("\"", "");;
            String enderecoCidadePartida = requestData.split(",")[10].split(":")[1].replace("\"", "");;
            String enderecoEstadoPartida = requestData.split(",")[11].split(":")[1].replace("\"", "");;
            String enderecoPaisPartida = requestData.split(",")[12].split(":")[1].replace("\"", "");;
            String enderecoComplementoPartida = requestData.split(",")[13].split(":")[1].replace("\"", "");;
            
            //checando se endereço ja foi cadastrado
            rs = con.conexao.prepareStatement("SELECT * FROM ENDERECO WHERE cd_cep_endereco = '" + enderecoCepPartida + "' AND cd_numero_endereco = '" + enderecoNumeroPartida + "'").executeQuery();
            int idEnderecoPartida;
            if(rs.next()) {
                idEnderecoPartida = rs.getInt("cd_id_endereco");
            }
            else {
                //cadastrando endereço
                ps = con.conexao.prepareStatement("INSERT INTO ENDERECO(cd_cep_endereco, cd_numero_endereco, nm_rua_endereco, nm_cidade_endereco, nm_estado_endereco, nm_pais_endereco, ds_complemento_endereco, ds_ponto_referencia_endereco) VALUES(?, ?, ?, ?, ?, ?, ?, '')");
                ps.setString(1, enderecoCepPartida);
                ps.setString(2, enderecoNumeroPartida);
                ps.setString(3, enderecoRuaPartida);
                ps.setString(4, enderecoCidadePartida);
                ps.setString(5, enderecoEstadoPartida);
                ps.setString(6, enderecoPaisPartida);
                ps.setString(7, enderecoComplementoPartida);
                ps.execute();
                
                rs = con.conexao.prepareStatement("SELECT cd_id_endereco FROM ENDERECO WHERE cd_cep_endereco = '" + enderecoCepPartida + "' AND cd_numero_endereco = '" + enderecoNumeroPartida + "'").executeQuery();
                rs.next();
                idEnderecoPartida = rs.getInt("cd_id_endereco");
            }
            
            
            //variaveis endereço de destino
            String enderecoCepDestino = requestData.split(",")[14].split(":")[1].replace("\"", "");;
            String enderecoNumeroDestino = requestData.split(",")[15].split(":")[1].replace("\"", "");;
            String enderecoRuaDestino = requestData.split(",")[16].split(":")[1].replace("\"", "");;
            String enderecoCidadeDestino = requestData.split(",")[17].split(":")[1].replace("\"", "");;
            String enderecoEstadoDestino = requestData.split(",")[18].split(":")[1].replace("\"", "");;
            String enderecoPaisDestino = requestData.split(",")[19].split(":")[1].replace("\"", "");;
            String enderecoComplementoDestino = requestData.split(",")[20].split(":")[1].replace("\"", "");;
            
            //checando se endereço ja foi cadastrado
            rs = con.conexao.prepareStatement("SELECT * FROM ENDERECO WHERE cd_cep_endereco = '" + enderecoCepDestino + "' AND cd_numero_endereco = '" + enderecoNumeroDestino + "'").executeQuery();
            int idEnderecoDestino;
            if(rs.next()) {
                idEnderecoDestino = rs.getInt("cd_id_endereco");
            }
            else {
                //cadastrando endereço
                ps = con.conexao.prepareStatement("INSERT INTO ENDERECO(cd_cep_endereco, cd_numero_endereco, nm_rua_endereco, nm_cidade_endereco, nm_estado_endereco, nm_pais_endereco, ds_complemento_endereco, ds_ponto_referencia_endereco) VALUES(?, ?, ?, ?, ?, ?, ?, '')");
                ps.setString(1, enderecoCepDestino);
                ps.setString(2, enderecoNumeroDestino);
                ps.setString(3, enderecoRuaDestino);
                ps.setString(4, enderecoCidadeDestino);
                ps.setString(5, enderecoEstadoDestino);
                ps.setString(6, enderecoPaisDestino);
                ps.setString(7, enderecoComplementoDestino);
                ps.execute();
                
                rs = con.conexao.prepareStatement("SELECT cd_id_endereco FROM ENDERECO WHERE cd_cep_endereco = '" + enderecoCepDestino + "' AND cd_numero_endereco = '" + enderecoNumeroDestino + "'").executeQuery();
                rs.next();
                idEnderecoDestino = rs.getInt("cd_id_endereco");
            }
            
            String prazo = requestData.split(",")[6].split(":")[1].replace("\"", "");
            
            ps = con.conexao.prepareStatement("INSERT INTO VIAGEM(cd_id_endereco_partida_viagem, cd_id_endereco_final_viagem, dt_prazo_viagem, ds_status_viagem, cd_id_carga, ic_desativado_viagem) VALUES(?, ?, ?, ?, ?, '0')");
            ps.setInt(1, idEnderecoPartida);
            ps.setInt(2, idEnderecoDestino);
            ps.setString(3, prazo);
            ps.setString(4, "Em espera");
            ps.setInt(5, idCarga);
            ps.execute();
            out.println("{\"resposta\":\"SUCCESS\"}");
        }
        catch(Exception ex) {
            //out.println("{\"resposta\":\"ERROR\"}");
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
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE ENDERECO SET cd_cep_endereco = ?, nm_rua_endereco = ?, "
                    + "nm_cidade_endereco = ? WHERE cd_id_endereco =" + request.getParameter("idEndereco"));
            ps.setString(1, request.getParameter("updateCepPartida"));
            ps.setString(2, request.getParameter("updateRuaPartida"));
            ps.setString(3, request.getParameter("updateCidadePartida"));
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
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE VIAGEM SET ic_desativado_viagem = 1 WHERE cd_id_viagem = '" + request.getParameter("idViagem") + "'");
            ps.execute();
            out.println("{\"resposta\":\"SUCCESS\"}");
        } catch (Exception ex) {
            out.println("{\"resposta\":\"ERROR\"}");
        }
    }

%>