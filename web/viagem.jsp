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
 
   
    if(action.equals("select")) {
       try {
            Viagem viagem;
            
            String json = "{\"viagens\":[";
            String atual = "";
            
            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM VIAGEM AS V"
                    + " JOIN ENDERECO AS EP ON V.cd_cpf_endereco_partida_viagem = EP.cd_cpf_endereco"
                    + " JOIN ENDERECO AS EF ON V.cd_cpf_endereco_final_viagem = EF.cd_cpf_endereco;").executeQuery();
            while(rs.next()) {
                viagem = new Viagem(
                        new Endereco(rs.getString("EP.cd_cep_endereco"), rs.getInt("EP.cd_numero_endereco"),
                                rs.getString("EP.nm_rua_endereco"),rs.getString("EP.nm_bairro_endereco"),
                                rs.getString("EP.nm_cidade_endereco"),rs.getString("EP.nm_estado_endereco"),
                                rs.getString("EP.nm_pais_endereco"),rs.getString("EP.ds_complemento_endereco"),
                                rs.getString("EP.ds_ponto_referencia_endereco")),
                        new Endereco(rs.getString("EF.cd_cep_endereco"), rs.getInt("EF.cd_numero_endereco"),
                                rs.getString("EF.nm_rua_endereco"),rs.getString("EF.nm_bairro_endereco"),
                                rs.getString("EF.nm_cidade_endereco"),rs.getString("EF.nm_estado_endereco"),
                                rs.getString("EF.nm_pais_endereco"),rs.getString("EF.ds_complemento_endereco"),
                                rs.getString("EF.ds_ponto_referencia_endereco")),
                        rs.getDate("dt_prazo_viagem"), rs.getInt("qt_tempo_estimado_viagem"),
                        rs.getString("ds_status_viagem"),
                        new Carga("")
                
                
                );
                if(rs.isLast())
                    atual = Json_encoder.encode(viagem);
                else
                    atual = Json_encoder.encode(viagem) + ",";
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
    
%>