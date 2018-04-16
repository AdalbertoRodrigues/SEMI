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

                <div class="row">
                    <div class="form-group col-7 col-sm-7 col-md-7 col-lg-7 col-xl-7">
                        <input type="text" class="form-control" id="form-admin-usuario-filtro" placeholder="Pesquisar...">
                    </div>
                    <div class="form-group col-5 col-sm-5 col-md-5 col-lg-5 col-xl-5">
                        <select class="form-control" id="form-admin-usuario-tipo">
                            <option >Todos</option>
                            <option>Funcionários</option>
                            <option>Motoristas</option>

                        </select>
                    </div>
                </div>
                <div class="row">
                    <table class="table table-sm table-bordered table-striped" id="table-admin-usuario">
                        <thead>
                            <tr>
                                <th scope="col">NOME</th>
                                <th scope="col">CPF/CNH</th>
                                <th scope="col">DETALHES</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr class="linha-tabela-admin">
                                <td>Ekwueme Linford</td>
                                <td>680.993.700-58</td>
                                <td class="col-admin-detalhes" ng-click="mostrarDetalhesUsuario()" ><i class="fas fa-eye"></i></td>
                            </tr>
                            <tr class="linha-tabela-admin">
                                <td>Ekwueme Linford</td>
                                <td>680.993.700-58</td>
                                <td class="col-admin-detalhes" ng-click="mostrarDetalhesUsuario()" ><i class="fas fa-eye"></i></td>
                            </tr>
                            <tr class="linha-tabela-admin">
                                <td>Ekwueme Linford</td>
                                <td>680.993.700-58</td>
                                <td class="col-admin-detalhes" ng-click="mostrarDetalhesUsuario()" ><i class="fas fa-eye"></i></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
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
                            <input type="text" class="form-control form-control-sm" id="form-incluir-usuario-nome">
                        </div> 
                    </div>
                    <div class="form-group row form-group-cpf">
                        <label for="form-incluir-usuario-cpf" id="label-usuario-cpf" class="col-sm-2 col-form-label col-form-label-sm">CPF</label>
                        <div class="col-12 col-sm-12">
                            <input type="text" class="form-control form-control-sm" id="form-incluir-usuario-cpf">
                        </div> 
                    </div>
                    <div class="form-motorista">
                        <div class="form-group row form-group-cnh">
                            <label for="form-incluir-usuario-cnh" id="label-usuario-cnh" class="col-sm-2 col-form-label col-form-label-sm">CNH</label>
                            <div class="col-12 col-sm-12">
                                <input type="text" class="form-control form-control-sm" id="form-incluir-usuario-cnh">
                            </div> 
                        </div>
                        <div class="row">
                            <div class="form-check">
                                <div class="col-4 my-auto">
                                    <label for="form-incluir-usuario-mopp" class="form-check-label">
                                        <input type="checkbox" class="form-check-input" ng-model="checkMopp" id="form-incluir-usuario-mopp" value="mopp">
                                        MOPP
                                    </label>
                                </div>
                            </div>
                            <div class="col-8 col-mopp">
                                Validade:
                                <input class="form-control form-control-sm" ng-disabled="!checkMopp" type="date" id="form-incluir-usuario-validade">
                            </div>    
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="form-incluir-usuario-senha" class="col-sm-2 col-form-label col-form-label-sm">Senha</label>
                        <div class="col-12 col-sm-12">
                            <input type="text" class="form-control form-control-sm" id="form-incluir-usuario-senha">
                        </div> 
                    </div>
                    <div class="row">
                        <div style="margin-bottom: 70px;" class="col-12 col-sm-12">
                            <!-- BOTÃO INSERT USUARIO -->
                            <button class="btn btn-admin-adicionar-usuario" type="submit">Cadastrar</button>
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
                    <div class="col-4 btn-admin-remover-usuario">
                        <!-- BOTÃO DELETE USUARIO -->
                        <i class="fas fa-trash"></i> Excluir
                    </div>
                </div>

                <div class="form-group row">
                    <label for="form-incluir-usuario-nome" class="col-sm-2 col-form-label col-form-label-sm">Nome</label>
                    <div class="col-12 col-sm-12    ">
                        <input type="text" class="form-control form-control-sm" id="form-incluir-usuario-nome" value="Nome do usuário">
                    </div> 
                </div>
                <div class="form-group row form-group-cpf">
                    <label for="form-incluir-usuario-cpf" id="label-usuario-cpf" class="col-sm-2 col-form-label col-form-label-sm">CPF</label>
                    <div class="col-12 col-sm-12">
                        <input type="text" class="form-control form-control-sm" id="form-incluir-usuario-cpf" value="XX-XX-XX-XX-XX">
                    </div> 
                </div>
                <div class="form-motorista">
                    <div class="form-group row form-group-cnh">
                        <label for="form-incluir-usuario-cnh" id="label-usuario-cnh" class="col-sm-2 col-form-label col-form-label-sm">CNH</label>
                        <div class="col-12 col-sm-12">
                            <input type="text" class="form-control form-control-sm" id="form-incluir-usuario-cnh" value="XX-XX-XX-XX-XX">
                        </div> 
                    </div>
                    <div class="row">
                        <div class="form-check">
                            <div class="col-4 my-auto">
                                <label for="form-incluir-usuario-mopp" class="form-check-label">
                                    <input type="checkbox" class="form-check-input" ng-model="checkMopp" id="form-incluir-usuario-mopp" value="mopp">
                                    MOPP
                                </label>
                            </div>
                        </div>
                        <div class="col-8 col-mopp">
                            Validade:
                            <input class="form-control form-control-sm" ng-disabled="!checkMopp" type="date" id="form-incluir-usuario-validade">
                        </div>    
                    </div>
                </div>
                <div class="form-group row">
                    <label for="form-incluir-usuario-senha" class="col-sm-2 col-form-label col-form-label-sm">Senha</label>
                    <div class="col-12 col-sm-12">
                        <input type="text" class="form-control form-control-sm" id="form-incluir-usuario-senha">
                    </div> 
                </div>
                <div class="row">
                    <div style="margin-bottom: 70px;" class="col-12 col-sm-12">
                        <!-- BOTÃO ALTERAR USUARIO -->
                        <button class="btn btn-admin-alterar-usuario" type="submit"><i class="fas fa-edit"></i> Salvar Alterações</button>
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
                <div class="row">
                    <div class="form-group col-7 col-sm-7 col-md-7 col-lg-7 col-xl-7">
                        <input type="text" class="form-control" id="form-admin-veiculo-filtro" placeholder="Pesquisar...">
                    </div>
                    <div class="form-group col-5 col-sm-5 col-md-5 col-lg-5 col-xl-5">
                        <select class="form-control" id="form-admin-veiculo-tipo">
                            <option >Todos</option>
                            <option>Pequeno Porte</option>
                            <option>Grande Porte</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <table class="table table-sm table-bordered table-striped" id="table-admin-usuario">
                        <thead>
                            <tr>
                                <th scope="col">MARCA/MODELO</th>
                                <th scope="col">PLACA</th>
                                <th scope="col">DETALHES</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="linha-tabela-admin">
                                <td>Volks 24250</td>
                                <td>AJO-3996</td>
                                <td ng-click='mostrarDetalhesVeiculo()' class="col-admin-detalhes"><i class="fas fa-eye"></i></td>
                            </tr>
                            <tr class="linha-tabela-admin">
                                <td>Mercedes 710</td>
                                <td>IBS-5908</td>
                                <td ng-click='mostrarDetalhesVeiculo()' class="col-admin-detalhes"><i class="fas fa-eye"></i></td>
                            </tr>
                            <tr class="linha-tabela-admin">
                                <td>Volvo FH 460</td>
                                <td>DRP-4995</td>
                                <td ng-click='mostrarDetalhesVeiculo()' class="col-admin-detalhes"><i class="fas fa-eye"></i></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
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
                            <input type="text" class="form-control form-control-sm" id="form-incluir-veiculo-modelo" value="Modelo do veículo">
                        </div>
                        <div class="form-group col-4 col-sm-4">
                            <label id="label-select-marca" class="col-form-label-sm" for="form-incluir-veiculo-marca">Marca</label>
                            <input list="form-incluir-veiculo-lista" type="text" class="form-control form-control-sm" id="form-incluir-veiculo-marca" value="">
                            <datalist id="form-incluir-veiculo-lista">
                                <option>Marca</option>
                                <option>MAN (VW)</option>
                                <option>Ford</option>
                                <option>Volvo</option>
                                <option>Scania</option>
                                <option>Iveco</option>
                                <option>DAF</option>
                                <option>Agrale</option>
                                <option>International</option>
                                <option>Hyundai</option>
                                <option>Foton</option>
                            </datalist>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-2 col-sm-2">
                            <label for="form-incluir-veiculo-ano" class="col-form-label-sm">Ano</label>
                            <input type="number" class="form-control form-control-sm" id="form-incluir-veiculo-ano" value="">
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            <label for="form-incluir-veiculo-eixo" class="col-form-label-sm">Eixos</label>
                            <input type="number" class="form-control form-control-sm" id="form-incluir-veiculo-eixo" value="">
                        </div>
                        <div class="form-group col-8 col-sm-8">
                            <label for="form-incluir-veiculo-motoristaPreferencial" class="col-form-label-sm">Motorista Preferencial</label>
                            <input type="text" class="form-control form-control-sm" id="form-incluir-veiculo-motoristaPreferencial" value="">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-10">
                            Capacitações do veículo:<br><br>
                            <ul class="list-group">
                                <li ng-class="{'item-lista-capacitacao-ativo' : capacitacao_a}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="capacitacao_a" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : capacitacao_b}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="capacitacao_b" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : capacitacao_c}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="capacitacao_c" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : capacitacao_d}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="capacitacao_d" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : capacitacao_e}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="capacitacao_e" class="form-check-input" type="checkbox" value="">
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
                            <button class="btn btn-admin-adicionar-usuario" type="submit"><i class="fas fa-edit"></i> Salvar Alterações</button>
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
                        <div class="col-4 btn-admin-remover-usuario">
                            <!-- BOTÃO DELETE CAMINHÃO -->
                            <i class="fas fa-trash"></i> Excluir
                        </div>
                    </div>
                    <div class="form-row"> 
                        <div class="form-group col-8 col-sm-8">
                            <label for="form-incluir-veiculo-modelo" class="col-form-label-sm">Modelo</label>
                            <input type="text" class="form-control form-control-sm" id="form-detalhes-veiculo-modelo" value="">
                        </div>
                        <div class="form-group col-4 col-sm-4">
                            <label id="label-select-marca" class="col-form-label-sm" for="form-incluir-veiculo-marca">Marca</label>
                            <input list="form-incluir-veiculo-lista" type="text" class="form-control form-control-sm" id="form-detalhes-veiculo-marca" value="">
                            <datalist id="form-incluir-veiculo-lista">
                                <option>Marca</option>
                                <option>MAN (VW)</option>
                                <option>Ford</option>
                                <option>Volvo</option>
                                <option>Scania</option>
                                <option>Iveco</option>
                                <option>DAF</option>
                                <option>Agrale</option>
                                <option>International</option>
                                <option>Hyundai</option>
                                <option>Foton</option>
                            </datalist>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-2 col-sm-2">
                            <label for="form-incluir-veiculo-ano" class="col-form-label-sm">Ano</label>
                            <input type="number" class="form-control form-control-sm" id="form-detalhes-veiculo-ano" value="">
                        </div>
                        <div class="form-group col-2 col-sm-2">
                            <label for="form-incluir-veiculo-eixo" class="col-form-label-sm">Eixos</label>
                            <input type="number" class="form-control form-control-sm" id="form-detalhes-veiculo-eixo" value="">
                        </div>
                        <div class="form-group col-8 col-sm-8">
                            <label for="form-incluir-veiculo-motoristaPreferencial" class="col-form-label-sm">Motorista Preferencial</label>
                            <input type="text" class="form-control form-control-sm" id="form-detalhes-veiculo-motoristaPreferencial" value="">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-10">
                            Capacitações do veículo:<br><br>
                            <ul class="list-group">
                                <li ng-class="{'item-lista-capacitacao-ativo' : capacitacao_a}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="capacitacao_a" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : capacitacao_b}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="capacitacao_b" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : capacitacao_c}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="capacitacao_c" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : capacitacao_d}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="capacitacao_d" class="form-check-input" type="checkbox" value="">
                                            Transporte de explosivos
                                        </label>
                                    </div>
                                </li>
                                <li ng-class="{'item-lista-capacitacao-ativo' : capacitacao_e}" class="item-lista-capacitacao">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input ng-model="capacitacao_e" class="form-check-input" type="checkbox" value="">
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
                            <button class="btn btn-admin-alterar-usuario" type="submit"><i class="fas fa-edit"></i> Salvar Alterações</button>
                        </div>
                    </div>
                </form>
            </div>
            <!-- SEÇÃO DE ADMIN VEÍCULO END -->
        </div>


        <%@include file="../WEB-INF/jspf/footer.jspf"%>
    </body>
</html>
