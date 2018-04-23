<%-- 
    Document   : menu
    Created on : Mar 30, 2018, 6:27:06 PM
    Author     : Vinícius
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if(session.getAttribute("me.name") == null || !session.getAttribute("me.type").equals("2") || request.getParameter("do-logoff")!= null){
        session.removeAttribute("me.cpf");
        session.removeAttribute("me.name");
        session.removeAttribute("me.pass");
        session.removeAttribute("me.type");
        response.sendRedirect(request.getContextPath()+"/index.jsp");
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
                            <a class="" id="nav-btn">Bem vindo, <%= session.getAttribute("me.name")%></a>
                        </li>
                        <li class="nav-item active col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                            <a class="" id="nav-btn" href="#">Home</a>
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
        <div class="container secao-admin-abas" ng-controller="abasAdminController">
            <div class="row row-btn-admin">
                <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 row-btn-menu">
                    <button ng-click="irSecaoAdminUsuario()" class="btn-menu-admin btn-usuario-admin btn-admin-active row-btn-menu">Usuário</button>
                </div>
                <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 row-btn-menu">
                    <button ng-click="irSecaoAdminVeiculo()" class="btn-menu-admin btn-usuario-admin row-btn-menu">Veículo</button>
                </div>
                <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 row-btn-menu">
                    <button ng-click="irSecaoAdminViagem()" class="btn-menu-admin btn-usuario-admin row-btn-menu">Viagem</button>
                </div>
            </div>
            <hr>
        </div>


        <div class="container">
            <!-- SEÇÃO DE ADMIN USUÁRIO START -->
            <!-- ABA DE MANTER USUÁRIO -->
            <div ng-controller="menuAdminUsuarioController" class="secao-admin-usuario secao-ativa">
                <div class="row row-btn-admin row-crud-admin">
                    <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 row-btn-crud-admin" id="btn-admin-adicionar-usuario">
                        <div ng-click="mostrarIncluirUsuario()" class="btn-admin-adicionar-usuario btn-crud-usuario"><i class="fas fa-user-plus font-menor"></i> Incluir</div>
                    </div>
                </div>

                <!-- SEÇÃO ADMIN - VER USUARIOS -->
                <div class="admin-exibicao-usuario">
                    <div class="row admin-exibicao-filtro-usuario">
                        <div class="form-group col-7 col-sm-7 col-md-7 col-lg-7 col-xl-7">
                            <input type="text" ng-model="pesquisarPor" ng-change="getUsuarios(pesquisarPor, filtrarPor)" ng-model-options="{debounce: 500}" class="form-control" id="form-admin-usuario-filtro" placeholder="Digite um NOME ou um CPF...">
                        </div>
                        <div class="form-group col-5 col-sm-5 col-md-5 col-lg-5 col-xl-5">
                            <select ng-change="getUsuarios(pesquisarPor, filtrarPor)" ng-model="filtrarPor" class="form-control" id="form-admin-usuario-tipo">
                                <option value="">Todos</option>
                                <option value="0">Funcionários</option>
                                <option value="1">Motoristas</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <table class="table table-sm table-bordered table-striped" id="table-admin-usuario">
                            <thead>
                                <tr>
                                    <th scope="col">NOME</th>
                                    <th scope="col">CPF</th>
                                    <th scope="col">DETALHES</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr dir-paginate="usuarios in usuarios | itemsPerPage: 5" pagination-id="usuario" class="linha-tabela-admin">
                                    <td>{{usuarios.nome}}</td>
                                    <td>{{usuarios.cpf}}</td>
                                    <td width="10%" class="col-admin-detalhes" ng-click="mostrarDetalhesUsuario(usuarios)" ><i class="fas fa-eye"></i></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <dir-pagination-controls max-size="10" boundary-links="true" pagination-id="usuario"></dir-pagination-controls>
                </div>
                <div class="loader-usuario" id="loader-tabela-usuario"></div>
                <div class="alert alert-danger" id="alerta-exibicao-usuario" role="alert">{{erro_usuario}}</div>
            </div>
            <!-- SEÇÃO ADMIN - ADICIONAR USUARIO -->
            <div ng-controller="incluirUsuarioAdminController" class="secao-admin-usuario-incluir">
                <form>
                    <div class="form group row align-items-center row-admin-tipo">
                        <div ng-click="voltarMenu()" class="col-2">
                            <i class="fas fa-arrow-left fa-2x" id="seta-voltar"></i>
                        </div>
                        <div class="col-4 btn-admin-incluir-usuario-tipo btn-admin-tipo-active" id="btn-tipo-motorista">
                            Motorista
                        </div>
                        <div class="col-4 btn-admin-incluir-usuario-tipo" id="btn-tipo-funcionario">
                            Funcionário
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="form-incluir-usuario-nome" class="col-sm-2 col-form-label col-form-label-sm">Nome</label>
                        <div class="col-12 col-sm-12    ">
                            <input value="" type="text" ng-model="incluir_usuario_nome" ng-model-options='{debounce: 1000}' ng-change="checkValido()" required class="form-control form-control-sm input-incluir-usuario" id="form-incluir-usuario-nome">
                        </div> 
                    </div>
                    <div class="form-group row form-group-cpf">
                        <label for="form-incluir-usuario-cpf" id="label-usuario-cpf" class="col-sm-2 col-form-label col-form-label-sm">CPF</label>
                        <div class="col-12 col-sm-12">
                            <input value="" type="text" ng-model="incluir_usuario_cpf" ng-model-options='{debounce: 500}' ng-change="checkCpf()" required class="form-control form-control-sm cpf input-incluir-usuario" id="form-incluir-usuario-cpf">
                        </div> 
                    </div>
                    <div class="form-motorista">
                        <div class="form-group row form-group-cnh">
                            <label for="form-incluir-usuario-cnh" id="label-usuario-cnh" class="col-sm-2 col-form-label col-form-label-sm">CNH</label>
                            <div class="col-12 col-sm-12">
                                <input value="" type="text"ng-model="incluir_usuario_cnh" ng-model-options='{debounce: 500}' ng-change="checkValido()" class="form-control form-control-sm cnh input-incluir-usuario" id="form-incluir-usuario-cnh">
                            </div> 
                        </div>
                        <div class="row">
                            <div class="form-check">
                                <div class="col-4 my-auto">
                                    <label for="form-incluir-usuario-mopp" class="form-check-label">
                                        <input type="checkbox" class="form-check-input input-incluir-usuario" ng-model="checkMopp" id="form-incluir-usuario-mopp" value="mopp">
                                        MOPP
                                    </label>
                                </div>
                            </div>
                            <div class="col-8 col-mopp">
                                Validade:
                                <input class="form-control form-control-sm input-incluir-usuario" ng-model="incluir_usuario_validade" ng-disabled="!checkMopp" type="date" id="form-incluir-usuario-validade">
                            </div>    
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="form-incluir-usuario-senha" class="col-sm-2 col-form-label col-form-label-sm">Senha</label>
                        <div class="col-12 col-sm-12">
                            <input value="" type="text" class="form-control form-control-sm input-incluir-usuario" required ng-model-options='{debounce: 1000}' ng-change="checkValido()" ng-model="incluir_usuario_senha" id="form-incluir-usuario-senha">
                        </div> 
                    </div>
                    <div class="row">
                        <div style="margin-bottom: 70px;" class="col-12 col-sm-12">
                            <!-- BOTÃO INSERT USUARIO -->
                            <button class="btn btn-admin-adicionar-usuario-disabled" disabled id="btn-inserir-usuario" type="submit" ng-click="cadastrarUsuario()"><i class="fas fa-user-plus font-menor"></i> Cadastrar</button>
                        </div>
                    </div>
                </form>
            </div>

            <!--SEÇÃO ADMIN - VER DETALHES DO USUARIO-->
            <div ng-controller="detalhesUsuarioAdminController" class="secao-admin-usuario-detalhes">
                <div class="form group row align-items-center row-admin-tipo">
                    <div ng-click="voltarMenu()" class="col-2">
                        <i class="fas fa-arrow-left fa-2x" id="seta-voltar"></i>
                    </div>
                    <div class="col-6">
                        &nbsp;
                    </div>
                    <div ng-click="!cpfValido || deleteUsuario()" id="btn-admin-remover-usuario" class="col-4 btn-admin-remover-usuario">
                        <!-- BOTÃO DELETE USUARIO -->
                        <i class="fas fa-trash"></i> Excluir
                    </div>
                </div>

                <div class="form-group row">
                    <label for="form-detalhes-usuario-nome" class="col-sm-2 col-form-label col-form-label-sm">Nome</label>
                    <div class="col-12 col-sm-12    ">
                        <input type="text" class="form-control form-control-sm" ng-change="checkValido()" ng-model-options='{debounce: 500}' ng-model="detalhes_usuario_nome" id="form-detalhes-usuario-nome" value="">
                    </div> 
                </div>
                <div class="form-group row form-group-cpf">
                    <label for="form-detalhes-usuario-cpf" id="label-usuario-cpf" class="col-sm-2 col-form-label col-form-label-sm">CPF</label>
                    <div class="col-12 col-sm-12">
                        <input type="text" class="form-control form-control-sm cpf" ng-change="checkCpf()" ng-model-options='{debounce: 500}' ng-model="detalhes_usuario_cpf" id="form-detalhes-usuario-cpf" value="">
                    </div> 
                </div>
                <div class="form-motorista">
                    <div class="form-group row form-group-cnh">
                        <label for="form-detalhes-usuario-cnh" id="label-detalhes-usuario-cnh" class="col-sm-2 col-form-label col-form-label-sm">CNH</label>
                        <div class="col-12 col-sm-12">
                            <input type="text" class="form-control form-control-sm cnh" ng-change="checkValido()" ng-model-options='{debounce: 500}' ng-model="detalhes_usuario_cnh" id="form-detalhes-usuario-cnh" value="">
                        </div> 
                    </div>
                    <div class="row">
                        <div class="form-check">
                            <div class="col-4 my-auto">
                                <label for="form-detalhes-usuario-mopp" class="form-check-label" id="label-detalhes-usuario-mopp">
                                    <input type="checkbox" class="form-check-input" ng-model="detalhes_usuario_mopp" id="form-detalhes-usuario-mopp" value="mopp">
                                    MOPP
                                </label>
                            </div>
                        </div>
                        <div class="col-8 col-mopp">
                            <label for="form-detalhes-usuario-validade" id="label-detalhes-usuario-validade" class="col-sm-2 col-form-label col-form-label-sm">Validade</label>
                            <input class="form-control form-control-sm" ng-disabled="!detalhes_usuario_mopp" type="date" id="form-detalhes-usuario-validade">
                        </div>    
                    </div>
                </div>
                <div class="form-group row">
                    <label for="form-detalhes-usuario-senha" class="col-sm-2 col-form-label col-form-label-sm">Senha</label>
                    <div class="col-12 col-sm-12">
                        <input type="text" class="form-control form-control-sm" required ng-change="checkValido()" ng-model-options='{debounce: 500}' ng-model="detalhes_usuario_senha" id="form-detalhes-usuario-senha">
                    </div> 
                </div>
                <div class="row">
                    <div style="margin-bottom: 70px;" class="col-12 col-sm-12">
                        <!-- BOTÃO ALTERAR USUARIO -->
                        <button class="btn btn-admin-alterar-usuario" id="btn-admin-alterar-usuario" ng-click="updateUsuario()" type="submit"><i class="fas fa-edit"></i> Salvar Alterações</button>
                    </div>
                </div>
            </div>
            <!-- SEÇÃO DE ADMIN USUÁRIO END -->

            <!-- SEÇÃO DE ADMIN VEÍCULO START -->
            <div class="secao-admin-veiculo" ng-controller="menuAdminVeiculoController">
                <div class="row row-btn-admin row-crud-admin">
                    <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 row-btn-crud-admin" id="btn-admin-adicionar-usuario">
                        <div  ng-click="mostrarIncluirVeiculo()" class="btn-admin-adicionar-usuario btn-crud-usuario"><i class="fas fa-truck  font-menor"></i> Incluir</div>
                    </div>
                </div>

                <!-- SEÇÃO ADMIN - VER VEICULOS -->
                <div class="admin-exibicao-veiculo">
                    <div class="row">
                        <div class="form-group col-7 col-sm-7 col-md-7 col-lg-7 col-xl-7">
                            <input type="text" ng-model="pesquisarPor" ng-change="getVeiculos(pesquisarPor)" ng-model-options="{debounce: 500}" class="form-control" id="form-admin-veiculo-filtro" placeholder="Digite um modelo ou marca de veículo...">
                        </div>
<!--                        <div class="form-group col-5 col-sm-5 col-md-5 col-lg-5 col-xl-5">
                            <select class="form-control" id="form-admin-veiculo-tipo">
                                <option>Todos</option>
                                <option>Pequeno Porte</option>
                                <option>Grande Porte</option>
                            </select>
                        </div>-->
                    </div>
                    
                    <div class="row">
                        <table class="table table-sm table-bordered table-striped" id="table-admin-veiculo">
                            <thead>
                                <tr>
                                    <th scope="col">MARCA/MODELO</th>
                                    <th scope="col">PLACA</th>
                                    <th scope="col">DETALHES</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr dir-paginate="veiculos in veiculos | itemsPerPage: 5" class="linha-tabela-admin">
                                    <td>{{veiculos.modelo}}</td>
                                    <td>{{veiculos.placa}}</td>
                                    <td width="10%" class="col-admin-detalhes" ng-click="mostrarDetalhesVeiculo(veiculos)"><i class="fas fa-eye"></i></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="loader-veiculo" id="loader-tabela-veiculo"></div>
                <div class="alert alert-danger" id="alerta-exibicao-veiculo" role="alert">{{erro_veiculo}}</div>
            </div>

            <!-- SEÇÃO ADMIN - INCLUIR VEICULOS -->
            <div ng-controller="incluirVeiculoAdminController" class="secao-admin-veiculo-incluir">
                <form>
                    <div class="form group row align-items-center row-admin-tipo">
                        <div ng-click="voltarMenu()" class="col-2">
                            <i class="fas fa-arrow-left fa-2x" id="seta-voltar"></i>
                        </div>
                    </div>
                    <div class="form-row"> 
                        <div class="form-group col-8 col-sm-8">
                            <label for="form-incluir-veiculo-modelo" class="col-form-label-sm">Modelo</label>
                            <input required type="text" class="form-control form-control-sm" ng-model="incluir_veiculo_modelo" ng-change="checkValido()" ng-model-options="{debounce: 500}" id="form-incluir-veiculo-modelo">
                        </div>
                        <div class="form-group col-4 col-sm-4">
                            <label id="label-select-marca" class="col-form-label-sm" for="form-incluir-veiculo-marca">Marca</label>
                            <input required list="form-incluir-veiculo-lista" type="text" ng-model="incluir_veiculo_marca" ng-change="checkValido()" ng-model-options="{debounce: 500}" class="form-control form-control-sm" id="form-incluir-veiculo-marca" value="">
                            <datalist id="form-incluir-veiculo-lista">

                            </datalist>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-2 col-sm-2">
                            <label for="form-incluir-veiculo-ano" class="col-form-label-sm">Ano</label>
                            <input required type="text" class="form-control form-control-sm ano" ng-model="incluir_veiculo_ano" ng-change="checkValido()" ng-model-options="{debounce: 500}" id="form-incluir-veiculo-ano" value="">
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            <label for="form-incluir-veiculo-eixo" class="col-form-label-sm">Eixos</label>
                            <input required type="text" class="form-control form-control-sm medida" ng-model="incluir_veiculo_eixos" ng-change="checkValido()" ng-model-options="{debounce: 500}" id="form-incluir-veiculo-eixo" value="">
                        </div>
                        <div class="form-group col-8 col-sm-8">
                            <label for="form-incluir-veiculo-motoristaPreferencial" class="col-form-label-sm">Motorista Preferencial</label>
                            <input type="text" class="form-control form-control-sm" ng-model="incuir_veiculo_motorista" id="form-incluir-veiculo-motoristaPreferencial" value="">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-4 col-sm-4">
                            <label for="form-incluir-veiculo-placa" class="col-form-label-sm">Placa</label>
                            <input required type="text" class="form-control form-control-sm placa" ng-model="incluir_veiculo_placa" ng-change="checkValido()" ng-model-options="{debounce: 500}" id="form-incluir-veiculo-placa" value="">
                        </div>  
                    </div>
                    <div class="row">
                        <div class="col-10">
                            Capacitações do veículo:<br><br>
                            <ul class="list-group">
                                <li ng-class="{'item-lista-capacitacao-ativo' : incluir_veiculo_capacitacao_a}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="incluir_veiculo_capacitacao_a" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : incluir_veiculo_capacitacao_b}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="incluir_veiculo_capacitacao_b" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : incluir_veiculo_capacitacao_c}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="incluir_veiculo_capacitacao_c" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : incluir_veiculo_capacitacao_d}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="incluir_veiculo_capacitacao_d" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : incluir_veiculo_capacitacao_e}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="incluir_veiculo_capacitacao_e" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                            </ul>
                        </div> 
                    </div>
                    <br>
                    <div class="row">
                        <div style="margin-bottom: 70px;" class="col-12 col-sm-12">
                            <!-- BOTÃO INSERT CAMINHÃO -->
                            <button class="btn btn-admin-adicionar-usuario-disabled" id="btn-admin-incluir-veiculo" ng-click="insertVeiculo()" disabled type="submit"><i class="fas fa-truck"></i> Cadastrar</button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- SEÇÃO ADMIN - DETALHES VEICULOS -->
            <div ng-controller="detalhesVeiculoAdminController" class="secao-admin-veiculo-detalhes">
                <form>
                    <div class="form group row align-items-center row-admin-tipo">
                        <div ng-click="voltarMenu()" class="col-2">
                            <i class="fas fa-arrow-left fa-2x" id="seta-voltar"></i>
                        </div>
                        <div class="col-6">
                            &nbsp;
                        </div>
                        <div id="btn-admin-remover-veiculo" ng-click="!placaValida || deleteVeiculo()" class="col-4 btn-admin-remover-usuario">
                            <!-- BOTÃO DELETE CAMINHÃO -->
                            <i class="fas fa-trash"></i> Excluir
                        </div>
                    </div>
                    <div class="form-row"> 
                        <div class="form-group col-8 col-sm-8">
                            <label for="form-detalhes-veiculo-modelo" class="col-form-label-sm">Modelo</label>
                            <input type="text" class="form-control form-control-sm" ng-model-options='{debounce: 500}' ng-change="checkValido()" ng-model="detalhes_veiculo_modelo" id="form-detalhes-veiculo-modelo" value="">
                        </div>
                        <div class="form-group col-4 col-sm-4">
                            <label id="label-select-marca" class="col-form-label-sm" for="form-detalhes-veiculo-marca">Marca</label>
                            <input list="form-detalhes-veiculo-lista" type="text" ng-model-options='{debounce: 500}' ng-change="checkValido()" ng-model="detalhes_veiculo_marca" class="form-control form-control-sm" id="form-detalhes-veiculo-marca" value="">
                            <datalist id="form-detalhes-veiculo-lista">

                            </datalist>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-2 col-sm-2">
                            <label for="form-detalhes-veiculo-ano" class="col-form-label-sm">Ano</label>
                            <input type="text" class="form-control form-control-sm ano" ng-model-options='{debounce: 500}' ng-change="checkValido()" ng-model="detalhes_veiculo_ano" id="form-detalhes-veiculo-ano" value="">
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            <label for="form-detalhes-veiculo-eixo" class="col-form-label-sm">Eixos</label>
                            <input type="text" class="form-control form-control-sm medida" ng-model-options='{debounce: 500}' ng-change="checkValido()" ng-model="detalhes_veiculo_eixos" id="form-detalhes-veiculo-eixo" value="">
                        </div>
                        <div class="form-group col-8 col-sm-8">
                            <label for="form-detalhes-veiculo-motoristaPreferencial" class="col-form-label-sm">Motorista Preferencial</label>
                            <input type="text" class="form-control form-control-sm" ng-model="detalhes_veiculo_motorista" id="form-detalhes-veiculo-motoristaPreferencial" value="">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-4 col-sm-4">
                            <label for="form-detalhes-veiculo-placa" class="col-form-label-sm">Placa</label>
                            <input type="text" class="form-control form-control-sm placa" ng-model-options='{debounce: 500}' ng-change="checkPlaca()" ng-model="detalhes_veiculo_placa" id="form-detalhes-veiculo-placa" value="">
                        </div>  
                    </div>
                    <div class="row">
                        <div class="col-10">
                            Capacitações do veículo:<br><br>
                            <ul class="list-group">
                                <li ng-class="{'item-lista-capacitacao-ativo' : detalhes_veiculo_capacitacao_a}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="detalhes_veiculo_capacitacao_a" ng-model-options='{debounce: 500}' ng-change="checkValido()" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : detalhes_veiculo_capacitacao_b}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="detalhes_veiculo_capacitacao_b" ng-model-options='{debounce: 500}' ng-change="checkValido()" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : detalhes_veiculo_capacitacao_c}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="detalhes_veiculo_capacitacao_c" ng-model-options='{debounce: 500}' ng-change="checkValido()" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : detalhes_veiculo_capacitacao_d}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="detalhes_veiculo_capacitacao_d" ng-model-options='{debounce: 500}' ng-change="checkValido()" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : detalhes_veiculo_capacitacao_e}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="detalhes_veiculo_capacitacao_e" ng-model-options='{debounce: 500}' ng-change="checkValido()" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                            </ul>
                        </div> 
                    </div>
                    <br>
                    <div class="row">
                        <div style="margin-bottom: 70px;" class="col-12 col-sm-12">
                            <!-- BOTÃO UPDATE CAMINHÃO -->
                            <button class="btn btn-admin-alterar-usuario" id="btn-admin-alterar-veiculo" ng-click="updateVeiculo()" type="submit"><i class="fas fa-edit"></i> Salvar Alterações</button>
                        </div>
                    </div>
                </form>
            </div>
            <!-- SEÇÃO DE ADMIN VEÍCULO END -->

            <!-- SEÇÃO DE ADMIN VIAGEM START -->
            <div class="secao-admin-viagem" ng-controller="viagemAdminController">
                <div class="row row-btn-admin row-crud-admin">
                    <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 row-btn-crud-admin" id="btn-admin-adicionar-usuario">
                        <div ng-click="mostrarIncluirViagem()" class="btn-admin-adicionar-usuario btn-crud-usuario"><i class="fas fa-clipboard "></i> Incluir</div>
                    </div>
                </div>

                <table class="table table-sm table-bordered table-striped" id="table-admin-viagem">
                    <thead>
                        <tr>
                            <th width="3%" scope="col">ID</th>
                            <th scope="col">ENDEREÇO CHEGADA</th>
                            <th scope="col">MERCADORIA</th>
                            <th width="10%" scope="col">DETALHES</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="linha-tabela-admin">
                            <td>1234</td>
                            <td>Santos/SP</td>
                            <td>Laranja</td>
                            <td ng-click='mostrarDetalhesViagem()' class="col-admin-detalhes"><i class="fas fa-eye"></i></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- SEÇÃO ADMIN - INCLUIR VIAGEM -->
            <div class="secao-admin-viagem-incluir" ng-controller="incluirViagemAdminController">
                <div class="form group row align-items-center row-admin-viagem">
                    <div ng-click="voltarMenu()" class="col-2">
                        <i class="fas fa-arrow-left fa-2x" id="seta-voltar"></i>
                    </div>

                    <div class="col-4 btn-admin-incluir-viagem-tipo btn-admin-tipo-active" id="btn-viagem-carga">
                        Carga
                    </div>
                    <div class="col-4 btn-admin-incluir-viagem-tipo" id="btn-viagem-endereco">
                        Endereços
                    </div>
                </div>

                <div class="secao-admin-viagem-incluir-carga">
                    <div class="form-row">
                        <div class="form-group col-6 col-sm-6">
                            <label for="form-incluir-viagem-tipo" class="col-form-label-sm">Tipo: </label>
                            <select class="form-control" id="form-incluir-viagem-tipo">
                                <option>T1</option>
                                <option>T2</option>
                                <option>Tn</option>
                            </select>
                        </div>
                        <div class="form-group col-6 col-sm-6">
                            <label for="form-incluir-viagem-conteudo" class="col-form-label-sm">Conteúdo: </label>
                            <input type="text" class="form-control form-control-sm" id="form-incluir-viagem-conteudo" value="">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-2 col-sm-2">
                            <label for="form-incluir-viagem-peso" class="col-form-label-sm">Peso: </label>
                            <input type="text" class="form-control form-control-sm medida" id="form-detalhes-viagem-peso" value="">
                        </div>
                        <div class="form-group col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            <label for="form-incluir-viagem-tpeso" class="col-form-label-sm">&nbsp;</label>
                            <select class="form-control" id="form-incluir-viagem-tpeso">
                                <option>kg</option>
                                <option>ton</option>
                            </select>
                        </div>
                        <div class="form-group col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            &nbsp;
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            <label for="form-incluir-viagem-altura" class="col-form-label-sm">Dimensões: </label>
                            <input type="text" class="form-control form-control-sm medida" id="form-incluir-viagem-altura" value="">
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            <label class="col-form-label-sm">&nbsp; </label>
                            <br>Altura
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-6 col-sm-6">
                            &nbsp;
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            <input type="text" class="form-control form-control-sm medida" id="form-incluir-viagem-largura" value="">
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            Largura
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-6 col-sm-6">
                            &nbsp;
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            <input type="text" class="form-control form-control-sm medida" id="form-incluir-viagem-comprimento" value="">
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            Comprimento
                        </div>
                    </div>
                </div>

                <div class="secao-admin-viagem-incluir-endereco">
                    <div class="secao-endereco-partida">
                        <div class="secao-admin-viagem-txt-partida">
                            <h4>PARTIDA</h4>
                        </div>
                        <div class="form-row align-items-center">
                            <div class="form-group col-4 col-sm-4">
                                <label for="form-incluir-viagem-cep-partida" class="col-form-label-sm">CEP: </label>
                                <input type="text" class="form-control form-control-sm cep" id="form-incluir-viagem-cep-partida" value="">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-6 col-sm-6">
                                <label for="form-incluir-viagem-rua-partida" class="col-form-label-sm">Rua/Avenida: </label>
                                <input type="text" class="form-control form-control-sm" id="form-incluir-viagem-rua-partida" value="">
                            </div>
                            <div class="form-group col-2 col-sm-2">
                                <label for="form-incluir-viagem-rua-numero-partida" class="col-form-label-sm">Nº: </label>
                                <input type="text" class="form-control form-control-sm medida" id="form-incluir-viagem-rua-numero-partida" value="">
                            </div>
                            <div class="form-group col-2 col-sm-2">
                                <label for="form-incluir-viagem-rua-complemento-partida" class="col-form-label-sm">Complemento: </label>
                                <input type="text" class="form-control form-control-sm" id="form-incluir-viagem-rua-complemento-partida" value="">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-3 col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                <label for="form-incluir-viagem-pais-partida" class="col-form-label-sm">País: </label>
                                <select class="form-control" id="form-incluir-viagem-pais-partida">
                                    <option>P1</option>
                                    <option>P2</option>
                                    <option>Pn</option>
                                </select>
                            </div>
                            <div class="form-group col-1 col-sm-1">
                                &nbsp;
                            </div>
                            <div class="form-group col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                <label for="form-incluir-viagem-estado-partida" class="col-form-label-sm">Distrito: </label>
                                <select class="form-control" id="form-incluir-viagem-estado-partida">
                                    <option>E1</option>
                                    <option>E2</option>
                                    <option>En</option>
                                </select>
                            </div>
                            <div class="form-group col-1 col-sm-1">
                                &nbsp;
                            </div>
                            <div class="form-group col-3 col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                <label for="form-incluir-viagem-cidade-partida" class="col-form-label-sm">Cidade: </label>
                                <select class="form-control" id="form-incluir-viagem-cidade-partida">
                                    <option>C1</option>
                                    <option>C2</option>
                                    <option>Cn</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <br><br>
                    <div class="secao-endereco-destino">
                        <div class="secao-admin-viagem-txt-partida">
                            <h4>DESTINO</h4>
                        </div>
                        <div class="form-row align-items-center">
                            <div class="form-group col-4 col-sm-4">
                                <label for="form-incluir-viagem-cep-destino" class="col-form-label-sm">CEP: </label>
                                <input type="text" class="form-control form-control-sm" id="form-incluir-viagem-cep-destino" value="">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-6 col-sm-6">
                                <label for="form-incluir-viagem-rua-destino" class="col-form-label-sm">Rua/Avenida: </label>
                                <input type="text" class="form-control form-control-sm" id="form-incluir-viagem-rua-destino" value="">
                            </div>
                            <div class="form-group col-2 col-sm-2">
                                <label for="form-incluir-viagem-rua-numero-destino" class="col-form-label-sm">Nº: </label>
                                <input type="text" class="form-control form-control-sm medida" id="form-incluir-viagem-rua-numero-destino" value="">
                            </div>
                            <div class="form-group col-2 col-sm-2">
                                <label for="form-incluir-viagem-rua-complemento-destino" class="col-form-label-sm">Complemento: </label>
                                <input type="text" class="form-control form-control-sm" id="form-incluir-viagem-rua-complemento-destino" value="">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-3 col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                <label for="form-incluir-viagem-pais-destino" class="col-form-label-sm">País: </label>
                                <select class="form-control" id="form-incluir-viagem-pais-destino">
                                    <option>P1</option>
                                    <option>P2</option>
                                    <option>Pn</option>
                                </select>
                            </div>
                            <div class="form-group col-1 col-sm-1">
                                &nbsp;
                            </div>
                            <div class="form-group col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                <label for="form-incluir-viagem-estado-destino" class="col-form-label-sm">Distrito: </label>
                                <select class="form-control" id="form-incluir-viagem-estado-destino">
                                    <option>E1</option>
                                    <option>E2</option>
                                    <option>En</option>
                                </select>
                            </div>
                            <div class="form-group col-1 col-sm-1">
                                &nbsp;
                            </div>
                            <div class="form-group col-3 col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                <label for="form-incluir-viagem-cidade-destino" class="col-form-label-sm">Cidade: </label>
                                <select class="form-control" id="form-incluir-viagem-cidade-destino">
                                    <option>C1</option>
                                    <option>C2</option>
                                    <option>Cn</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-4 col-sm-4">
                            &nbsp;
                        </div>
                        <div class="form-group col-4 col-sm-4">
                            <label for="form-incluir-viagem-prazo" class="col-form-label-sm">Prazo de entrega: </label>
                            <input type="date" class="form-control form-control-sm" id="form-incluir-viagem-prazo" value="">
                        </div>
                        <div class="form-group col-4 col-sm-4">
                            &nbsp;
                        </div>
                    </div>
                    <br>

                </div>
                <div class="row">
                    <div style="margin-bottom: 70px;" class="col-12 col-sm-12">
                        <!-- BOTÃO INSERT VIAGEM -->
                        <button class="btn btn-admin-adicionar-usuario" type="submit"><i class="fas fa-clipboard"></i> Adicionar Viagem</button>
                    </div>
                </div>
            </div>

            <!-- SEÇÃO ADMIN - EDITAR VIAGEM -->
            <div class="secao-admin-viagem-detalhes" ng-controller="detalhesViagemAdminController">
                <div class="form group row align-items-center row-admin-detalhes-viagem">
                    <div ng-click="voltarMenu()" class="col-2">
                        <i class="fas fa-arrow-left fa-2x" id="seta-voltar"></i>
                    </div>

                    <div class="col-4 btn-admin-detalhes-viagem-tipo btn-admin-tipo-active" id="btn-viagem-detalhes-carga">
                        Carga
                    </div>
                    <div class="col-4 btn-admin-detalhes-viagem-tipo" id="btn-viagem-detalhes-endereco">
                        Endereços
                    </div>
                </div>

                <div class="secao-admin-viagem-detalhes-carga">
                    <div class="form-row">
                        <div class="form-group col-6 col-sm-6">
                            <label for="form-detalhes-viagem-tipo" class="col-form-label-sm">Tipo </label>
                            <select class="form-control" id="form-detalhes-viagem-tipo">
                                <option>T1</option>
                                <option>T2</option>
                                <option>Tn</option>
                            </select>
                        </div>
                        <div class="form-group col-6 col-sm-6">
                            <label for="form-detalhes-viagem-conteudo" class="col-form-label-sm">Conteúdo </label>
                            <input type="text" class="form-control form-control-sm" id="form-detalhes-viagem-conteudo" value="">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-2 col-sm-2">
                            <label for="form-detalhes-viagem-peso" class="col-form-label-sm">Peso </label>
                            <input type="text" class="form-control form-control-sm medida" id="form-detalhes-viagem-peso" value="">
                        </div>
                        <div class="form-group col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            <label for="form-detalhes-viagem-tpeso" class="col-form-label-sm">&nbsp;</label>
                            <select class="form-control" id="form-detalhes-viagem-tpeso">
                                <option>kg</option>
                                <option>ton</option>
                            </select>
                        </div>
                        <div class="form-group col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            &nbsp;
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            <label for="form-detalhes-viagem-altura" class="col-form-label-sm">Dimensões </label>
                            <input type="text" class="form-control form-control-sm medida" id="form-detalhes-viagem-altura" value="">
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            <label class="col-form-label-sm">&nbsp; </label>
                            <br>Altura
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-6 col-sm-6">
                            &nbsp;
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            <input type="text" class="form-control form-control-sm medida" id="form-detalhes-viagem-largura" value="">
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            Largura
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-6 col-sm-6">
                            &nbsp;
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            <input type="text" class="form-control form-control-sm medida" id="form-detalhes-viagem-comprimento" value="">
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            Comprimento
                        </div>
                    </div>
                </div>

                <div class="secao-admin-viagem-detalhes-endereco">
                    <div class="secao-endereco-partida">
                        <div class="secao-admin-viagem-txt-partida">
                            <h4>PARTIDA</h4>
                        </div>
                        <div class="form-row align-items-center">
                            <div class="form-group col-4 col-sm-4">
                                <label for="form-detalhes-viagem-cep-partida" class="col-form-label-sm">CEP </label>
                                <input type="text" class="form-control form-control-sm cep" id="form-detalhes-viagem-cep-partida" value="">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-6 col-sm-6">
                                <label for="form-detalhes-viagem-rua-partida" class="col-form-label-sm">Rua/Avenida </label>
                                <input type="text" class="form-control form-control-sm" id="form-detalhes-viagem-rua-partida" value="">
                            </div>
                            <div class="form-group col-2 col-sm-2">
                                <label for="form-detalhes-viagem-rua-numero-partida" class="col-form-label-sm">Nº </label>
                                <input type="text" class="form-control form-control-sm medida" id="form-detalhes-viagem-rua-numero-partida" value="">
                            </div>
                            <div class="form-group col-2 col-sm-2">
                                <label for="form-detalhes-viagem-rua-complemento-partida" class="col-form-label-sm">Complemento </label>
                                <input type="text" class="form-control form-control-sm" id="form-detalhes-viagem-rua-complemento-partida" value="">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-3 col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                <label for="form-detalhes-viagem-pais-partida" class="col-form-label-sm">País </label>
                                <select class="form-control" id="form-detalhes-viagem-pais-partida">
                                    <option>P1</option>
                                    <option>P2</option>
                                    <option>Pn</option>
                                </select>
                            </div>
                            <div class="form-group col-1 col-sm-1">
                                &nbsp;
                            </div>
                            <div class="form-group col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                <label for="form-detalhes-viagem-estado-partida" class="col-form-label-sm">Distrito </label>
                                <select class="form-control" id="form-detalhes-viagem-estado-partida">
                                    <option>E1</option>
                                    <option>E2</option>
                                    <option>En</option>
                                </select>
                            </div>
                            <div class="form-group col-1 col-sm-1">
                                &nbsp;
                            </div>
                            <div class="form-group col-3 col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                <label for="form-detalhes-viagem-cidade-partida" class="col-form-label-sm">Cidade </label>
                                <select class="form-control" id="form-detalhes-viagem-cidade-partida">
                                    <option>C1</option>
                                    <option>C2</option>
                                    <option>Cn</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <br><br>
                    <div class="secao-endereco-destino">
                        <div class="secao-admin-viagem-txt-partida">
                            <h4>DESTINO</h4>
                        </div>
                        <div class="form-row align-items-center">
                            <div class="form-group col-4 col-sm-4">
                                <label for="form-detalhes-viagem-cep-destino" class="col-form-label-sm">CEP </label>
                                <input type="text" class="form-control form-control-sm cep" id="form-detalhes-viagem-cep-destino" value="">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-6 col-sm-6">
                                <label for="form-detalhes-viagem-rua-destino" class="col-form-label-sm">Rua/Avenida </label>
                                <input type="text" class="form-control form-control-sm" id="form-detalhes-viagem-rua-destino" value="">
                            </div>
                            <div class="form-group col-2 col-sm-2">
                                <label for="form-detalhes-viagem-rua-numero-destino" class="col-form-label-sm">Nº </label>
                                <input type="text" class="form-control form-control-sm medida" id="form-detalhes-viagem-rua-numero-destino" value="">
                            </div>
                            <div class="form-group col-2 col-sm-2">
                                <label for="form-detalhes-viagem-rua-complemento-destino" class="col-form-label-sm">Complemento </label>
                                <input type="text" class="form-control form-control-sm" id="form-detalhes-viagem-rua-complemento-destino" value="">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-3 col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                <label for="form-detalhes-viagem-pais-destino" class="col-form-label-sm">País </label>
                                <select class="form-control" id="form-detalhes-viagem-pais-destino">
                                    <option>P1</option>
                                    <option>P2</option>
                                    <option>Pn</option>
                                </select>
                            </div>
                            <div class="form-group col-1 col-sm-1">
                                &nbsp;
                            </div>
                            <div class="form-group col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                <label for="form-detalhes-viagem-estado-destino" class="col-form-label-sm">Distrito </label>
                                <select class="form-control" id="form-detalhes-viagem-estado-destino">
                                    <option>E1</option>
                                    <option>E2</option>
                                    <option>En</option>
                                </select>
                            </div>
                            <div class="form-group col-1 col-sm-1">
                                &nbsp;
                            </div>
                            <div class="form-group col-3 col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                <label for="form-detalhes-viagem-cidade-destino" class="col-form-label-sm">Cidade </label>
                                <select class="form-control" id="form-detalhes-viagem-cidade-destino">
                                    <option>C1</option>
                                    <option>C2</option>
                                    <option>Cn</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-4 col-sm-4">
                            &nbsp;
                        </div>
                        <div class="form-group col-4 col-sm-4">
                            <label for="form-detalhes-viagem-prazo" class="col-form-label-sm">Prazo de entrega </label>
                            <input type="date" class="form-control form-control-sm" id="form-detalhes-viagem-prazo" value="">
                        </div>
                        <div class="form-group col-4 col-sm-4">
                            &nbsp;
                        </div>
                    </div>
                    <br>

                </div>
                <div class="row">
                    <div style="margin-bottom: 70px;" class="col-12 col-sm-12">
                        <!-- BOTÃO UPDATE VIAGEM -->
                        <button class="btn btn-admin-alterar-usuario" type="submit"><i class="fas fa-edit"></i> Salvar alterações</button>
                    </div>
                </div>
                <!-- SEÇÃO DE ADMIN VIAGEM END -->
            </div>

        </div>


        <%@include file="../WEB-INF/jspf/footer.jspf"%>
        <script>var ctx = "<%=request.getContextPath()%>"</script>
    </body>
</html>
