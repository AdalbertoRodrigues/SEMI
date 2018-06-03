<%-- 
    Document   : escala
    Created on : 02/05/2018, 18:14:53
    Author     : Henrique
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="br.com.uhapp.semi.Endereco"%>
<%@page import="br.com.uhapp.semi.Carga"%>
<%@page import="br.com.uhapp.semi.Viagem"%>
<%@page import="br.com.uhapp.semi.Motorista"%> 
<%@page import="br.com.uhapp.semi.Json_encoder"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="br.com.uhapp.semi.Conexao"%>
<%@page contentType="json" pageEncoding="UTF-8"%>

<%
    String action = request.getParameter("action");

    if (action.equals("escalar")) {
        String resposta = null;

        try {
            String requestData = request.getReader().lines().collect(Collectors.joining());

            requestData = requestData.replace("{", "").replace("}", "");
            int count = requestData.split(",").length;
            for (int indexOfData = 0; indexOfData < count; indexOfData++) {
                //Variaveis para Escala
                int idViagem = Integer.parseInt(requestData.split(",")[indexOfData].split(":")[1].replace("\"", ""));
                String placaVeiculoEscalado = null;
                String cnhMotoristaEscalado = null;
                Date dataViagem = null;
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                //Variaveis para Definir Veiculo
                int idCarga = 0;
                String tipoCarga = null;
                double pesoCarga = 0;
                String unidadeMedida = null;
                int minimoEixos = 1;
                String tipoCapacitacao = "";

                //Variaveis para Definir Motorista
                String mopp = "";
                String cnhPreferencial = null;

                Conexao con = new Conexao();

                ResultSet rsViagem = con.conexao.prepareStatement("SELECT cd_id_carga, dt_prazo_viagem FROM VIAGEM WHERE ic_desativado_viagem = 0 AND cd_id_viagem = " + idViagem).executeQuery();
                if (rsViagem.next()) {
                    idCarga = rsViagem.getInt("cd_id_carga");
                    dataViagem = sdf.parse(rsViagem.getString("dt_prazo_viagem"));

                    ResultSet rsCarga = con.conexao.prepareStatement("SELECT nm_tipo_carga, qt_peso_carga, sg_unidade_medida "
                            + " FROM CARGA WHERE cd_id_carga = " + idCarga).executeQuery();
                    //Informações da carga
                    if (rsCarga.next()) {
                        tipoCarga = rsCarga.getString("nm_tipo_carga");
                        pesoCarga = rsCarga.getDouble("qt_peso_carga");
                        unidadeMedida = rsCarga.getString("sg_unidade_medida");
                        //Verificar quantidade de Eixos
                        if (unidadeMedida != null) {
                            if (unidadeMedida.equals("kg")) {
                                pesoCarga = pesoCarga / 1000;
                                unidadeMedida = "ton";
                            }

                            if (unidadeMedida.equals("ton")) {
                                if (pesoCarga <= 16) {
                                    minimoEixos = 1;
                                } else if (pesoCarga <= 26) {
                                    minimoEixos = 2;
                                } else if (pesoCarga <= 36) {
                                    minimoEixos = 3;
                                } else if (pesoCarga <= 46) {
                                    minimoEixos = 4;
                                } else if (pesoCarga <= 56) {
                                    minimoEixos = 5;
                                } else if (pesoCarga <= 66) {
                                    minimoEixos = 6;
                                } else if (pesoCarga <= 76) {
                                    minimoEixos = 7;
                                }
                            }

                            //Definir Capacitacoes
                            if (tipoCarga != null) {
                                if (tipoCarga.equals("Carga Comum")) {
                                    tipoCapacitacao += " AND (CV.cd_id_capacitacao = 1 OR CV.cd_id_capacitacao = 2)";
                                } else if (tipoCarga.equals("Carga Perigosa")) {
                                    tipoCapacitacao += " AND CV.cd_id_capacitacao = 2";
                                    mopp += " AND ic_mopp_possui_naopossui_motorista = 1";
                                } else if (tipoCarga.equals("Carga Liquida Comum")) {
                                    tipoCapacitacao += " AND (CV.cd_id_capacitacao = 3 OR CV.cd_id_capacitacao = 4)";
                                } else if (tipoCarga.equals("Carga Liquida Perigosa")) {
                                    tipoCapacitacao += " AND CV.cd_id_capacitacao = 4";
                                    mopp += " AND ic_mopp_possui_naopossui_motorista = 1";
                                } else {
                                    resposta = "{\"resposta\":\"INTERNAL-ERROR-CARGATYPEINVALIDO-ID-" + idCarga + "\"}";
                                    break;
                                }

                                //Juntando informações e pesquisando no banco o veiculo ideal
                                ResultSet rsVeiculo = con.conexao.prepareStatement("SELECT V.cd_placa_veiculo, V.cd_cnh_motorista_preferencial_veiculo FROM VEICULO AS V"
                                        + " JOIN CAPACITACAO_VEICULO AS CV ON CV.cd_placa_veiculo = V.cd_placa_veiculo"
                                        + " WHERE V.qt_eixos_veiculo >= " + minimoEixos
                                        + tipoCapacitacao
                                        + " AND V.ic_desativado = 0 "
                                        + " ORDER BY V.qt_eixos_veiculo, CV.cd_id_capacitacao").executeQuery();

                                //Inserir veiculo na variavel se compativel
                                if (rsVeiculo.next()) {
                                    do {
                                        String placaVeiculo = rsVeiculo.getString("V.cd_placa_veiculo");
                                        //ResultSet para verificar se veiculo esta disponivel nessa data
                                        ResultSet rsDataVeiculo = con.conexao.prepareStatement("SELECT V.dt_prazo_viagem"
                                                + " FROM VIAGEM_ESCALADA AS VE"
                                                + " JOIN VIAGEM AS V ON V.cd_id_viagem = VE.cd_id_viagem"
                                                + " WHERE VE.cd_placa_veiculo = '" + placaVeiculo + "'"
                                                + " AND V.ds_status_viagem <> 'Concluida';").executeQuery();
                                        //Se existir alguma escala do veiculo na tabela
                                        if (rsDataVeiculo.next()) {
                                            do {
                                                //Verifica se a data da viagem é depois da data já existente
                                                if (dataViagem.after(sdf.parse(rsDataVeiculo.getString("V.dt_prazo_viagem")))) {
                                                    placaVeiculoEscalado = placaVeiculo;
                                                    if (rsVeiculo.getString("V.cd_cnh_motorista_preferencial_veiculo") != null) {
                                                        cnhPreferencial = " AND M.cd_cnh_motorista = '" + rsVeiculo.getString("V.cd_cnh_motorista_preferencial_veiculo" + "'");
                                                    }
                                                }else{
                                                    placaVeiculoEscalado = null;
                                                }
                                            } while (rsDataVeiculo.next());
                                            //Se não
                                        } else {
                                            placaVeiculoEscalado = placaVeiculo;
                                            if (rsVeiculo.getString("V.cd_cnh_motorista_preferencial_veiculo") != null) {
                                                cnhPreferencial = " AND M.cd_cnh_motorista = '" + rsVeiculo.getString("V.cd_cnh_motorista_preferencial_veiculo" + "'");
                                            }
                                        }
                                    } while (rsVeiculo.next() && placaVeiculoEscalado == null);
                                    
                                    //Verificando motorista Preferencial
                                    //Se existir CNH Preferencial
                                    if (cnhPreferencial != null) {
                                        ResultSet rsMotorista = con.conexao.prepareStatement("SELECT M.cd_cnh_motorista FROM MOTORISTA AS M"
                                                + " JOIN USUARIO AS U ON U.cd_cpf_usuario = M.cd_cpf_usuario"
                                                + " WHERE cd_tipo_usuario < 3" + cnhPreferencial + mopp).executeQuery();
                                        if (rsMotorista.next()) {
                                            ResultSet rsDataMotorista = con.conexao.prepareStatement("SELECT V.dt_prazo_viagem"
                                                    + " FROM VIAGEM_ESCALADA AS VE"
                                                    + " JOIN VIAGEM AS V ON V.cd_id_viagem = VE.cd_id_viagem"
                                                    + " WHERE VE.cd_cnh_motorista = '" + rsMotorista.getString("M.cd_cnh_motorista") + "'"
                                                    + " AND V.ds_status_viagem <> 'Concluida';").executeQuery();
                                            if (rsDataMotorista.next()) {
                                                do {
                                                    if (dataViagem.after(sdf.parse(rsDataMotorista.getString("V.dt_prazo_viagem")))) {
                                                        cnhMotoristaEscalado = rsMotorista.getString("M.cd_cnh_motorista");
                                                    }else{
                                                        cnhMotoristaEscalado = null;
                                                    }
                                                } while (rsDataMotorista.next());
                                            } else {
                                                cnhMotoristaEscalado = rsMotorista.getString("M.cd_cnh_motorista");
                                            }
                                        } else {
                                            cnhPreferencial = null;
                                        }
                                    }
                                    if(cnhMotoristaEscalado == null) cnhPreferencial = null;
                                    //Caso não exista CNH Preferencial
                                    if (cnhPreferencial == null) {
                                        ResultSet rsMotorista = con.conexao.prepareStatement("SELECT M.cd_cnh_motorista FROM MOTORISTA AS M"
                                                + " JOIN USUARIO AS U ON U.cd_cpf_usuario = M.cd_cpf_usuario"
                                                + " WHERE cd_tipo_usuario < 3" + mopp).executeQuery();
                                        if (rsMotorista.next()) {
                                            do {
                                                ResultSet rsDataMotorista = con.conexao.prepareStatement("SELECT V.dt_prazo_viagem"
                                                        + " FROM VIAGEM_ESCALADA AS VE"
                                                        + " JOIN VIAGEM AS V ON V.cd_id_viagem = VE.cd_id_viagem"
                                                        + " WHERE VE.cd_cnh_motorista = '" + rsMotorista.getString("M.cd_cnh_motorista") + "'"
                                                        + " AND V.ds_status_viagem <> 'Concluida';").executeQuery();
                                                if (rsDataMotorista.next()) {
                                                    do {
                                                        if (dataViagem.after(sdf.parse(rsDataMotorista.getString("V.dt_prazo_viagem")))) {
                                                            cnhMotoristaEscalado = rsMotorista.getString("M.cd_cnh_motorista");
                                                        }else{
                                                            cnhMotoristaEscalado = null;
                                                        }
                                                    } while (rsDataMotorista.next());
                                                } else {
                                                    cnhMotoristaEscalado = rsMotorista.getString("M.cd_cnh_motorista");
                                                }
                                            } while (rsMotorista.next() && cnhMotoristaEscalado == null);
                                        } else {
                                            resposta = "{\"resposta\":\"MOTORISTA-NOT-FOUND-ID-" + idViagem + "\"}";
                                            break;
                                        }
                                    }
                                    if(cnhMotoristaEscalado == null){
                                        resposta = "{\"resposta\":\"NO-MOTORISTA-DISPONIVEL-ID-" + idViagem + "\"}";
                                        break;
                                    }else if(placaVeiculoEscalado == null){
                                        resposta = "{\"resposta\":\"NO-VEICULO-DISPONIVEL-ID-" + idViagem + "\"}";
                                        break;
                                    }

                                    //Criando a Escala com as informações adquiridas
                                    PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO VIAGEM_ESCALADA(cd_id_viagem_escalada, cd_cnh_motorista, cd_placa_veiculo, cd_id_viagem) VALUES(DEFAULT, ?, ?, ?)");
                                    ps.setString(1, cnhMotoristaEscalado);
                                    ps.setString(2, placaVeiculoEscalado);
                                    ps.setInt(3, idViagem);
                                    ps.execute();

                                    //Atualizando status Viagem
                                    PreparedStatement psStatus = con.conexao.prepareStatement("UPDATE VIAGEM SET ds_status_viagem = ? WHERE cd_id_viagem = " + idViagem);
                                    psStatus.setString(1, "Pronta");
                                    psStatus.execute();

                                } else {
                                    resposta = "{\"resposta\":\"VEICULO-NOT-FOUND-ID-" + idViagem + "\"}";
                                    break;
                                }
                            } else {
                                resposta = "{\"resposta\":\"INTERNAL-ERROR-CARGATYPENULL-ID-" + idViagem + "\"}";
                                break;
                            }
                        } else {
                            resposta = "{\"resposta\":\"INTERNAL-ERROR-PESOTYPENULL-ID-" + idCarga + "\"}";
                            break;
                        }
                    } else {
                        resposta = "{\"resposta\":\"CARGA-NOT-FOUND-ID-" + idViagem + "\"}";
                        break;
                    }
                } else {
                    resposta = "{\"resposta\":\"VIAGEM-NOT-FOUND-ID-" + idViagem + "\"}";
                    break;
                }
            }//fim do for

            if (resposta == null) {//retornar SUCCESS se não houver erro
                out.println("{\"resposta\":\"SUCCESS\"}");
            } else {//retornar erro
                out.println(resposta);
            }
        } catch (Exception ex) {
            out.println("{\"resposta\":\""+ex.getMessage()+"\"}");
        }

    }

%> 

