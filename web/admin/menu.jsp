<%-- 
    Document   : menu
    Created on : Mar 30, 2018, 6:27:06 PM
    Author     : Vinícius
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if (session.getAttribute("me.name") == null) {
        response.sendRedirect(request.getContextPath() + "/erro/erro.jsp?codigoErro=xceNL1001");
    }else if(!session.getAttribute("me.type").equals("0") && !session.getAttribute("me.type").equals("2")){
        response.sendRedirect(request.getContextPath() + "/erro/erro.jsp?codigoErro=xceAR1002");
    }
%>
<html ng-app="semi" >
    <head>
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Menu</title>
        <script defer src="https://use.fontawesome.com/releases/v5.0.9/js/all.js" integrity="sha384-8iPTk2s/jMVj81dnzb/iFR2sdA7u06vHJyyLlAd4snFpCl/SnyUjRrbdJsw1pGIl" crossorigin="anonymous"></script>
        <link href="<%=request.getContextPath()%>/res/styles/styles.css" rel="stylesheet" type="text/css"/>        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/res/styles/animate.css">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    </head>
    <body class="body-admin-menu">
        <input type="hidden" id="cpfSession" value="<%=session.getAttribute("me.cpf")%>">
        <!--NAVBAR-->
        <%@include file="../WEB-INF/jspf/header.jspf"%>
        <br>
        <!--BOTÕES PARA ALTERAR SECAO-->
        <%@include file="../WEB-INF/jspf/secao/botoes-guia.jspf"%>

        <div class="container">
            <%if(session.getAttribute("me.type").equals("2")){%>
            <!--//////////////////// USUÁRIO ////////////////////  -->
            
            <!-- MENU USUÁRIO -->
            <%@include file="../WEB-INF/jspf/secao/usuario/menu-usuario.jspf"%>
            
            <!-- ADICIONAR USUARIO -->
            <%@include file="../WEB-INF/jspf/secao/usuario/adicionar-usuario.jspf"%>

            <!-- DETALHES/DELETAR USUARIO-->
            <%@include file="../WEB-INF/jspf/secao/usuario/detalhes-usuario.jspf"%>
            <%}%>
            
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
            
            <!--//////////////////// ESCALA ////////////////////  -->
            
            <!-- MENU ESCALA -->
            <%@include file="../WEB-INF/jspf/secao/escala/menu-escala.jspf"%>
        </div>

        <br><br>
        <%@include file="../WEB-INF/jspf/modal_veiculo.jspf"%>
        <%@include file="../WEB-INF/jspf/modal_motorista.jspf"%>
        <%@include file="../WEB-INF/jspf/modal_acoes.jspf"%>
        <div ng-controller="chatViagemFuncionario">
            <%@include file="../WEB-INF/jspf/secao/tela-motorista/modal-status.jspf"%>
        </div>
        <%@include file="../WEB-INF/jspf/footer.jspf"%>
        <script>var ctx = "<%=request.getContextPath()%>"</script>
    </body>
</html>
