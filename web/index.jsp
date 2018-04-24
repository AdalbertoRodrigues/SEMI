<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.com.uhapp.semi.Usuario"%>
<!DOCTYPE html>
<%  
    String loginErrorMessage = null;
    if(request.getParameter("do-login")!= null){
        String login = request.getParameter("cpf_login");
        String pass = request.getParameter("sen_login");
        try{
            Usuario user = Usuario.getUsuario(login, pass);
            if(user==null){
                loginErrorMessage = "Login e/ou senha não encontrados";
            }else{
                switch(user.getTipo()){
                    case "0":
                        loginErrorMessage = "Sessão indisponivel, por favor entre como administrador";
                        session.setAttribute("me.id", user.getCpf());
                        session.setAttribute("me.name", user.getNome());
                        session.setAttribute("me.login", user.getSenha());
                        session.setAttribute("me.passwordHash", user.getTipo());
                        response.sendRedirect(request.getContextPath()+"/admin/menu.jsp");
                        
                        break;
                    case "1":
                        loginErrorMessage = "Sessão indisponivel, por favor entre como administrador";
                        /*session.setAttribute("me.id", user.getCpf());
                        session.setAttribute("me.name", user.getNome());
                        session.setAttribute("me.login", user.getSenha());
                        session.setAttribute("me.passwordHash", user.getTipo());*/
                        break;
                    case "2":
                        session.setAttribute("me.cpf", user.getCpf());
                        session.setAttribute("me.name", user.getNome());
                        session.setAttribute("me.pass", user.getSenha());
                        session.setAttribute("me.type", user.getTipo());
                        response.sendRedirect(request.getContextPath()+"/admin/menu.jsp");
                        break;
                    case "4":
                        loginErrorMessage = "Login e/ou senha não encontrados";
                        break;
                    case "5":
                        loginErrorMessage = "Login e/ou senha não encontrados";
                        break;
                }
                
                
            }
        }catch(Exception ex){
            loginErrorMessage = ex.getMessage();
        }
    }
%>
<html ng-app="semi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Login</title>
        <script defer src="https://use.fontawesome.com/releases/v5.0.9/js/all.js" integrity="sha384-8iPTk2s/jMVj81dnzb/iFR2sdA7u06vHJyyLlAd4snFpCl/SnyUjRrbdJsw1pGIl" crossorigin="anonymous"></script>
        <link href="<%=request.getContextPath()%>/res/styles/styles.css" rel="stylesheet" type="text/css"/>        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    </head>
    <body ng-controller="loginController">
        <nav class="navbar" id="nav-login">
            <a class="navbar-brand" href="#">
                <img src="<%=request.getContextPath()%>/res/images/logo.png" width="60" height="30" alt="Logo SEMI">
            </a>
        </nav>
        <div class="main">
            <div class="wrapper">
                <div class="card card-login">
                    <div class="card-body card-body-login">
                        <h5 class="card-title">Faça seu login</h5>
                        <form method="post">
                            <div class="form-group">
                                <input type="text" class="form-control cpf" name="cpf_login" id="form-login-email" placeholder="CPF">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" name="sen_login" id="form-login-senha" placeholder="Senha">
                            </div>
                            <div style="margin-bottom: 10px;">
                                <input type="submit" id="btn-focus" class="btn btn-login" name="do-login" value="Entrar">
                            </div>
                            
                            <a class="form-login-link" ng-click="mostrarRecuperarSenha()"><span>Esqueci minha senha</span></a>
                        </form>
                        <%if(loginErrorMessage!=null){%>
                            <div style="color: red;"><%=loginErrorMessage%></div>
                        <%}%>
                    </div>
                    <div class="card-body card-body-senha">
                        
                        <h5 class="card-title">Recupere sua senha</h5>
                        <span class="form-senha-desc">Insira seu e-mail e receberá uma senha nova.</span><br><br>
                        <form>
                            <div class="form-group">
                                <input type="email" class="form-control" id="form-senha-email" placeholder="E-mail">
                            </div>
                            <div class="row">
                                <div class="col-sm-6 col-6 col-md-6 col-lg-6 col-xl-6" style="margin-bottom: 5px;">
                                    <button ng-click="mostrarLogin()" id="btn-focus" class="btn btn-recuperar"><i class="fas fa-arrow-left"></i> Voltar</button>
                                </div>
                                <div class="col-sm-6 col-6 col-md-6 col-lg-6 col-xl-6" style="margin-bottom: 5px;">
                                    <button type="submit" ng-click="recuperarSenha()" id="btn-focus" class="btn btn-senha">Recuperar</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="msg-senha-enviada">
                        <i class="fas fa-check fa-5x"></i><br>
                        O e-mail foi enviado com sucesso!
                    </div>
                    <div class="loader"></div>
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/jspf/footer.jspf"%>
    </body>
</html>
