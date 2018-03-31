<%-- 
    Document   : menu
    Created on : Mar 30, 2018, 6:27:06 PM
    Author     : Vinícius
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
    <body>
        <!--NAVBAR-->
        <nav class="navbar navbar-expand-lg  navbar-light nav-admin">
            <a class="navbar-brand" href="#">
                <img src="<%=request.getContextPath()%>/res/images/logo.png" width="60" height="30" alt="Logo SEMI">
            </a>
            <button class="navbar-toggler" onclick="corNav()" id="nav-toggle" type="button" data-toggle="collapse" data-target="#nav-toggle-collapse" aria-controls="nav-toggle-collapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="nav-toggle-collapse">
                <div class="navbar-nav mr-auto mt-2 mt-lg-0">
                    <div class="row row-nav">
                        <li class="nav-item active col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                            <a class="" id="nav-btn" href="#">Home</a>
                        </li>
                        <li class="nav-item col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                            <a class="" id="nav-btn" href="#">Link</a>
                        </li>
                        <li class="nav-item col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                            <a class="" id="nav-btn" href="#">Sair</a>
                        </li>

                    </div>
                </div>
            </div>
        </nav>
        <br>
        <!--BOTÕES PARA ALTERAR PÁGINA-->
        <div class="container">
            <div class="row row-btn-admin">
                <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                    <button class="btn-menu-admin btn-usuario-admin btn-admin-active">Usuário</button>
                </div>
                <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                    <button class="btn-menu-admin btn-usuario-admin">Veículo</button>
                </div>
                <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                    <button class="btn-menu-admin btn-usuario-admin">Viagem</button>
                </div>
            </div>
            <hr>
        </div>

        <!-- ABA DE MANTER USUÁRIO -->
        <div class="container">
            <div class="row">
                <div class="form-group col-7 col-sm-7 col-md-7 col-lg-7 col-xl-7">
                    <input type="text" class="form-control" id="form-admin-usuario-filtro" placeholder="Pesquisar por...">
                </div>
                <div class="form-group col-5 col-sm-5 col-md-5 col-lg-5 col-xl-5">
                    <select class="form-control" id="form-admin-usuario-tipo">
                        <option >Todos</option>
                        <option>Funcionários</option>
                        <option>Motoristas</option>

                    </select>
                </div>
            </div>
            
            <div class="row row-btn-admin">
                <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4" id="btn-admin-adicionar-usuario">
                    <div class="btn-admin-adicionar-usuario"><i class="fas fa-plus font-menor"></i> Incluir</div>
                </div>
                <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4" id="btn-admin-remover-usuario">
                    <div class="btn-admin-remover-usuario"><i class="fas fa-minus"></i> Excluir</div>
                </div>
                <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4" id="btn-admin-alterar-usuario">
                    <div class="btn-admin-alterar-usuario"><i class="fas fa-edit"></i> Editar</div>
                </div>
            </div>
            <br>
            
            <!-- TABELA DE USUÁRIOS -->
            <div class="row">
                <table class="table table-sm table-bordered" id="table-admin-usuario">
                    <thead>
                        <tr>
                            <th scope="col">NOME</th>
                            <th scope="col">CPF/CNH</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Ekwueme Linford</td>
                            <td>680.993.700-58</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>234.649.770-30</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>043.598.340-71</td>
                        </tr>
                        <tr>
                            <td>Ekwueme Linford</td>
                            <td>680.993.700-58</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>234.649.770-30</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>043.598.340-71</td>
                        </tr>
                        <tr>
                            <td>Ekwueme Linford</td>
                            <td>680.993.700-58</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>234.649.770-30</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>043.598.340-71</td>
                        </tr>
                        <tr>
                            <td>Ekwueme Linford</td>
                            <td>680.993.700-58</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>234.649.770-30</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>043.598.340-71</td>
                        </tr>
                        <tr>
                            <td>Ekwueme Linford</td>
                            <td>680.993.700-58</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>234.649.770-30</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>043.598.340-71</td>
                        </tr>
                        <tr>
                            <td>Ekwueme Linford</td>
                            <td>680.993.700-58</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>234.649.770-30</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>043.598.340-71</td>
                        </tr>
                        <tr>
                            <td>Ekwueme Linford</td>
                            <td>680.993.700-58</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>234.649.770-30</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>043.598.340-71</td>
                        </tr>
                        <tr>
                            <td>Ekwueme Linford</td>
                            <td>680.993.700-58</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>234.649.770-30</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>043.598.340-71</td>
                        </tr>
                        <tr>
                            <td>Ekwueme Linford</td>
                            <td>680.993.700-58</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>234.649.770-30</td>
                        </tr>
                        <tr>
                            <td>Megumi Roman</td>
                            <td>043.598.340-71</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <%@include file="../WEB-INF/jspf/footer.jspf"%>
    </body>
</html>
