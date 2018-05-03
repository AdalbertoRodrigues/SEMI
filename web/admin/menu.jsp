<%-- 
    Document   : menu
    Created on : Mar 30, 2018, 6:27:06 PM
    Author     : Vinícius
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
//    if(session.getAttribute("me.name") == null || !session.getAttribute("me.type").equals("2") || request.getParameter("do-logoff")!= null){
//        session.removeAttribute("me.cpf");
//        session.removeAttribute("me.name");
//        session.removeAttribute("me.pass");
//        session.removeAttribute("me.type");
//        response.sendRedirect(request.getContextPath()+"/index.jsp");
//    }
%>

<%
    if (session.getAttribute("me.name") == null) {
        response.sendRedirect(request.getContextPath() + "/erro/erro.jsp");
    }
%>
<html ng-app="semi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Menu</title>
        <script defer src="https://use.fontawesome.com/releases/v5.0.9/js/all.js" integrity="sha384-8iPTk2s/jMVj81dnzb/iFR2sdA7u06vHJyyLlAd4snFpCl/SnyUjRrbdJsw1pGIl" crossorigin="anonymous"></script>
        <link href="<%=request.getContextPath()%>/res/styles/styles.css" rel="stylesheet" type="text/css"/>        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/res/styles/animate.css">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    </head>
    <body class="body-admin-menu">
        <!--NAVBAR-->
        <%@include file="../WEB-INF/jspf/header.jspf"%>
        <br>
        <!--BOTÕES PARA ALTERAR SECAO-->
        <%@include file="../WEB-INF/jspf/secao/botoes-guia.jspf"%>

        <div class="container">
            <!--//////////////////// USUÁRIO ////////////////////  -->
            
            <!-- MENU USUÁRIO -->
            <%@include file="../WEB-INF/jspf/secao/usuario/menu-usuario.jspf"%>
            
            <!-- ADICIONAR USUARIO -->
            <%@include file="../WEB-INF/jspf/secao/usuario/adicionar-usuario.jspf"%>

            <!-- DETALHES/DELETAR USUARIO-->
            <%@include file="../WEB-INF/jspf/secao/usuario/detalhes-usuario.jspf"%>

            <!--//////////////////// VEÍCULO ////////////////////  -->
            
            <!-- MENU VEÍCULO -->
            <%@include file="../WEB-INF/jspf/secao/veiculo/menu-veiculo.jspf"%>
            
            <!-- ADICIONAR VEÍCULO -->
            <%@include file="../WEB-INF/jspf/secao/veiculo/adicionar-veiculo.jspf"%>

            <!-- DETALHES/DELETAR VEÍCULO -->
            <%@include file="../WEB-INF/jspf/secao/veiculo/detalhes-veiculo.jspf"%>

            <!--//////////////////// VIAGEM ////////////////////  -->
            
            <!-- MENU VIAGEM -->
            <%@include file="../WEB-INF/jspf/secao/viagem/menu-viagem.jspf"%>

            <!-- ADICIONAR VIAGEM -->
            <%@include file="../WEB-INF/jspf/secao/viagem/incluir-viagem.jspf"%>

            <!-- DETALHES/DELETAR VIAGEM -->
            <%@include file="../WEB-INF/jspf/secao/viagem/detalhes-viagem.jspf"%>
        </div>

        <br><br>
        <%@include file="../WEB-INF/jspf/modal_acoes.jspf"%>
        <%@include file="../WEB-INF/jspf/footer.jspf"%>
        <script>var ctx = "<%=request.getContextPath()%>"</script>
    </body>
</html>
