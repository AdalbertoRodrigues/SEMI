<%-- 
    Document   : Usuario
    Created on : 12/04/2018, 11:30:18
    Author     : adalberto
--%>


<%@page import="java.util.stream.Collectors"%>
<%@page import="br.com.uhapp.semi.Json_encoder"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.uhapp.semi.Usuario"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="br.com.uhapp.semi.Conexao"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>

<%
    String action = request.getParameter("action");
    String pesquisarPor = request.getParameter("pesquisarPor");
    String filtrarPor = request.getParameter("filtrarPor");
    if(action.equals("count")) {
        try {
            Conexao con = new Conexao();
            if(!pesquisarPor.equals("") && !filtrarPor.equals("")) {
                pesquisarPor = "'%" + pesquisarPor + "%'";
                ResultSet rs = con.conexao.prepareStatement("SELECT COUNT(cd_cpf_usuario) AS x FROM USUARIO WHERE cd_tipo_usuario BETWEEN 0 AND 2 AND (LOWER(nm_nome_usuario) LIKE LOWER(" + pesquisarPor + ") OR cd_cpf_usuario LIKE " + pesquisarPor + ") AND cd_tipo_usuario = " + filtrarPor + ";").executeQuery();
                rs.next();
                out.println("{\"count\" : \"" + rs.getInt("x") + "\"}");
                con.conexao.close();
            } else if (!pesquisarPor.equals("")) {
                pesquisarPor = "'%" + pesquisarPor + "%'";
                ResultSet rs = con.conexao.prepareStatement("SELECT COUNT(cd_cpf_usuario) AS x FROM USUARIO WHERE cd_tipo_usuario BETWEEN 0 AND 2 AND (LOWER(nm_nome_usuario) LIKE LOWER(" + pesquisarPor + ") OR cd_cpf_usuario LIKE " + pesquisarPor + ");").executeQuery();
                rs.next();
                out.println("{\"count\" : \"" + rs.getInt("x") + "\"}");
                con.conexao.close();
            } else if (filtrarPor.equals("") && pesquisarPor.equals("")) {
                ResultSet rs = con.conexao.prepareStatement("SELECT COUNT(cd_cpf_usuario) AS x FROM USUARIO WHERE cd_tipo_usuario BETWEEN 0 AND 2 ;").executeQuery();
                rs.next();
                out.println("{\"count\" : \"" + rs.getInt("x") + "\"}");
                con.conexao.close();
            } else if (!filtrarPor.equals("")) {
                ResultSet rs = con.conexao.prepareStatement("SELECT COUNT(cd_cpf_usuario) AS x FROM USUARIO WHERE cd_tipo_usuario BETWEEN 0 AND 2 AND cd_tipo_usuario = " + filtrarPor + ";").executeQuery();
                rs.next();
                out.println("{\"count\" : \"" + rs.getInt("x") + "\"}");
                con.conexao.close();
            }
        }
        catch(Exception ex) {
            out.println("{\"status\" : \"ERROR\"}");
            
        }
    } else if (action.equals("select")) {
        try {
            Usuario usuario;
            String json = "{\"usuarios\":[";
            String atual = "";
            int pageNumber = Integer.parseInt(request.getParameter("page"));

            Conexao con = new Conexao();
            if (!pesquisarPor.equals("") && !filtrarPor.equals("")) {
                pesquisarPor = "'%" + pesquisarPor + "%'";
                ResultSet rs = con.conexao.prepareStatement("SELECT * FROM USUARIO WHERE cd_tipo_usuario BETWEEN 0 AND 2 AND (LOWER(nm_nome_usuario) LIKE LOWER(" + pesquisarPor + ") OR cd_cpf_usuario LIKE " + pesquisarPor + ") AND cd_tipo_usuario = " + filtrarPor + " LIMIT " + (0 + ((pageNumber - 1) * 5)) + ", 5").executeQuery();
                while (rs.next()) {
                    usuario = new Usuario(rs.getString("cd_cpf_usuario"), rs.getString("nm_nome_usuario"), rs.getString("cd_senha_usuario"), rs.getString("cd_tipo_usuario"));
                    if (rs.isLast()) {
                        atual = Json_encoder.encode(usuario);
                    } else {
                        atual = Json_encoder.encode(usuario) + ",";
                    }

                    json += atual;
                }

                con.conexao.close();
                out.println(json + "]}");
            } else if (!pesquisarPor.equals("")) {
                pesquisarPor = "'%" + pesquisarPor + "%'";
                ResultSet rs = con.conexao.prepareStatement("SELECT * FROM USUARIO WHERE cd_tipo_usuario BETWEEN 0 AND 2 AND (LOWER(nm_nome_usuario) LIKE LOWER(" + pesquisarPor + ") OR cd_cpf_usuario LIKE " + pesquisarPor + ") LIMIT " + (0 + ((pageNumber - 1) * 5)) + ", 5").executeQuery();
                while (rs.next()) {
                    usuario = new Usuario(rs.getString("cd_cpf_usuario"), rs.getString("nm_nome_usuario"), rs.getString("cd_senha_usuario"), rs.getString("cd_tipo_usuario"));
                    if (rs.isLast()) {
                        atual = Json_encoder.encode(usuario);
                    } else {
                        atual = Json_encoder.encode(usuario) + ",";
                    }

                    json += atual;
                }

                con.conexao.close();
                out.println(json + "]}");
            } else if (filtrarPor.equals("") && pesquisarPor.equals("")) {
                ResultSet rs = con.conexao.prepareStatement("SELECT * FROM USUARIO WHERE cd_tipo_usuario BETWEEN 0 AND 2 LIMIT " + (0 + ((pageNumber - 1) * 5)) + ", 5").executeQuery();
                while (rs.next()) {
                    usuario = new Usuario(rs.getString("cd_cpf_usuario"), rs.getString("nm_nome_usuario"), rs.getString("cd_senha_usuario"), rs.getString("cd_tipo_usuario"));
                    if (rs.isLast()) {
                        atual = Json_encoder.encode(usuario);
                    } else {
                        atual = Json_encoder.encode(usuario) + ",";
                    }

                    json += atual;
                }

                con.conexao.close();
                out.println(json + "]}");
            } else if (!filtrarPor.equals("")) {
                ResultSet rs = con.conexao.prepareStatement("SELECT * FROM USUARIO WHERE cd_tipo_usuario BETWEEN 0 AND 2 AND cd_tipo_usuario = " + filtrarPor + " LIMIT " + (0 + ((pageNumber - 1) * 5)) + ", 5").executeQuery();
                while (rs.next()) {
                    usuario = new Usuario(rs.getString("cd_cpf_usuario"), rs.getString("nm_nome_usuario"), rs.getString("cd_senha_usuario"), rs.getString("cd_tipo_usuario"));
                    if (rs.isLast()) {
                        atual = Json_encoder.encode(usuario);
                    } else {
                        atual = Json_encoder.encode(usuario) + ",";
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

    } else if (action.equals("selectByCpf")) {
        try {
            Usuario usuario;
            String json = "{\"usuario\":[";
            String atual = "";

            Conexao con = new Conexao();

            ResultSet rs = con.conexao.prepareStatement("SELECT * FROM USUARIO WHERE cd_tipo_usuario BETWEEN 0 AND 2 AND cd_cpf_usuario = " + request.getParameter("cpf")).executeQuery();

            while (rs.next()) {
                usuario = new Usuario(rs.getString("cd_cpf_usuario"), rs.getString("nm_nome_usuario"), rs.getString("cd_senha_usuario"), rs.getString("cd_tipo_usuario"));
                if (rs.isLast()) {
                    atual = Json_encoder.encode(usuario);
                } else {
                    atual = Json_encoder.encode(usuario) + ",";
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
            PreparedStatement ps = con.conexao.prepareStatement("INSERT INTO USUARIO(cd_cpf_usuario, nm_nome_usuario, cd_senha_usuario, cd_tipo_usuario) VALUES( ?, ?, ?, ?)");

            String requestData = request.getReader().lines().collect(Collectors.joining());

            requestData = requestData.replace("{", "").replace("}", "");

            String cpf = requestData.split(",")[0].split(":")[1].replace("\"", "");

            String nome = requestData.split(",")[1].split(":")[1].replace("\"", "");

            String senha = requestData.split(",")[2].split(":")[1].replace("\"", "");

            String tipo = requestData.split(",")[3].split(":")[1].replace("\"", "");

            ps.setString(1, cpf);
            ps.setString(2, nome);
            ps.setString(3, senha);
            ps.setString(4, tipo);
            ps.execute();
            out.println("{\"resposta\":\"SUCCESS\"}");
        } catch (Exception ex) {
            out.println("{\"resposta\":\"ERROR\"}");
            out.println(ex.getMessage());
        }
    } else if (action.equals("update")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE USUARIO SET nm_nome_usuario = ?, cd_senha_usuario  = ? WHERE cd_cpf_usuario = " + request.getParameter("cpf"));

            String requestData = request.getReader().lines().collect(Collectors.joining());

            requestData = requestData.replace("{", "").replace("}", "");

            String nome = requestData.split(",")[0].split(":")[1].replace("\"", "");

            String senha = requestData.split(",")[1].split(":")[1].replace("\"", "");

            ps.setString(1, nome);
            ps.setString(2, senha);
            ps.execute();
            out.println("{\"resposta\":\"SUCCESS\"}");
        }
        catch (Exception ex) {
            out.println("{\"resposta\":\"ERROR\"}");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateNome")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE USUARIO SET nm_nome_usuario = ? WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
            ps.setString(1, request.getParameter("nome"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateSenha")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE USUARIO SET cd_senha_usuario = ? WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
            ps.setString(1, request.getParameter("senha"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("updateTipo")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE USUARIO SET cd_tipo_usuario = ? WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
            ps.setString(1, request.getParameter("tipo"));
            ps.execute();
            out.println("SUCCESS");
        } catch (Exception ex) {
            out.println("ERROR");
            out.println(ex.getMessage());
        }
    } else if (action.equals("delete")) {
        try {
            Conexao con = new Conexao();
            PreparedStatement ps = con.conexao.prepareStatement("UPDATE USUARIO SET cd_tipo_usuario = 3 WHERE cd_cpf_usuario = " + request.getParameter("cpf"));
            ps.execute();
            out.println("{\"resposta\":\"SUCCESS\"}");
        } catch (Exception ex) {
            out.println("{\"resposta\":\"ERROR\"}");
            //out.println(ex.getMessage());
        }
    }

    if (action.equals("login")) {
        String loginErrorMessage = null;
        String cpf = request.getParameter("cpf");
        String senha = request.getParameter("senha");
        try {
            Usuario user = Usuario.getUsuario(cpf, senha);
            if (user == null) {
                loginErrorMessage = "Login e/ou senha nao encontrados";
            } else {
                switch (user.getTipo()) {
                    case "0":
                        session.setAttribute("me.cpf", user.getCpf());
                        session.setAttribute("me.name", user.getNome());
                        session.setAttribute("me.login", user.getSenha());
                        session.setAttribute("me.type", user.getTipo());
                        loginErrorMessage = "Funcionario";
                        break;
                    case "1":
                        session.setAttribute("me.cpf", user.getCpf());
                        session.setAttribute("me.name", user.getNome());
                        session.setAttribute("me.login", user.getSenha());
                        session.setAttribute("me.type", user.getTipo());
                        loginErrorMessage = "Motorista";
                        break;
                    case "2":
                        session.setAttribute("me.cpf", user.getCpf());
                        session.setAttribute("me.name", user.getNome());
                        session.setAttribute("me.pass", user.getSenha());
                        session.setAttribute("me.type", user.getTipo());
                        loginErrorMessage = "Admin";
                        break;
                    case "3":
                        loginErrorMessage = "Login e/ou senha não encontrados";
                        break;
                    case "4":
                        loginErrorMessage = "Login e/ou senha não encontrados";
                        break;
                }

            }
            out.println(loginErrorMessage);
        } catch (Exception ex) {
            loginErrorMessage = ex.getMessage();
        }
    }

    if (action.equals("logout")) {
        if (session != null) {
            session.invalidate();
            out.println("Sucesso");
        }
    }
%>
