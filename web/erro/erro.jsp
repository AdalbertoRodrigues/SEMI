<%-- 
    Document   : erro
    Created on : Apr 24, 2018, 4:06:07 PM
    Author     : Vinícius
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%
    String titleErro = null;
    String mensagemErro = null;
    String linkErro = null;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Login</title>
        <script defer src="https://use.fontawesome.com/releases/v5.0.9/js/all.js" integrity="sha384-8iPTk2s/jMVj81dnzb/iFR2sdA7u06vHJyyLlAd4snFpCl/SnyUjRrbdJsw1pGIl" crossorigin="anonymous"></script>
        <link href="<%=request.getContextPath()%>/res/styles/styles.css" rel="stylesheet" type="text/css"/>        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    </head>
    <%
        if (request.getParameter("codigoErro").equals("xceNL1001")) {
            titleErro = "Ocorreu um erro!";
            mensagemErro = "Clique aqui para voltar ao index";
            linkErro = "/index.jsp";
        } else if (request.getParameter("codigoErro").equals("xceAR1002")) {
            titleErro = "Area Restrita!";
            mensagemErro = "Clique aqui para voltar à sua página";
            linkErro = "/menuMotorista.jsp";
        } else if (request.getParameter("codigoErro").equals("xceAR1003")) {
            titleErro = "Pagina não disponivel";
            mensagemErro = "Clique aqui para voltar à sua página";
            linkErro = "/admin/menu.jsp";
        }
    %>
    <body>
        <nav class="navbar" id="nav-login">
            <a class="navbar-brand" href="<%=request.getContextPath() + linkErro%>">
                <img src="<%=request.getContextPath()%>/res/images/logo.png" width="60" height="30" alt="Logo SEMI">
            </a>
        </nav>

        <div class="main">
            <div class="wrapper">
                <div class="card erro-quadrado">
                    <h4 class="msg-erro"><%=titleErro%></h4>
                    <img class="img-erro" src="<%=request.getContextPath()%>/res/images/placa-de-pare.png" width="125" height="150" alt="Placa de pare">
                    <a href="<%=request.getContextPath() + linkErro%>"><%=mensagemErro%></a>
                </div>
            </div>
        </div>

        <%@include file="../WEB-INF/jspf/footer.jspf"%>
        <script>var ctx = "<%=request.getContextPath()%>"</script>
    </body>
</html>
