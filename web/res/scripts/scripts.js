//Declarando o app
var app = angular.module("semi", ['angularUtils.directives.dirPagination'], function ($locationProvider) {
    $locationProvider.html5Mode({
        enabled: true,
        requireBase: false
    });
});
var ctx;
$('.cpf').mask('000.000.000-00');
$('.cnh').mask('00000000000');
$('.placa').mask('AAA-0000');
$('.ano').mask('0000');
$('.medida').mask('0#');
$('.cep').mask('00000-000');
app.config(function (paginationTemplateProvider) {
    paginationTemplateProvider.setPath(ctx + '/res/scripts/dirPagination.tpl.html');
});
//Muda a cor da nav-bar ao clicar no botão
function corNav() {
    if ($("#nav-toggle").attr('aria-expanded') === 'false') {
        $(".nav-admin").attr('id', 'nav-bg');
    } else {
        $(".nav-admin").attr('id', 'nav');
    }
}
;

//Botões de admin (usuario, caminhão, viagem)
$(".btn-usuario-admin").click(function () {
    $(this).addClass('btn-admin-active');
    $('.row-btn-menu').children().not($(this)).removeClass('btn-admin-active');
});

//Serviço que pode ser chamado em qualquer controller
app.service('dataService', function ($location) {
    var url_local = $location.path();

    return {
        getUrl_local: function () {
            //Retorna o url atual
            return url_local;
        },
        voltarMenuAdminUsuario: function () {
            ativa = $(".body-admin-menu").find(".secao-ativa");
            if (!$(".secao-ativa").hasClass('secao-admin-usuario')) {
                if (ativa.hasClass('secao-admin-usuario-incluir') || ativa.hasClass('secao-admin-usuario-detalhes')) {
                    animacaoEntrada = 'fadeInLeft';
                    animacaoSaida = 'fadeOutRight';
                } else {
                    animacaoEntrada = 'fadeInLeft';
                    animacaoSaida = 'fadeOutRight';
                }
                ativa.addClass('animated ' + animacaoSaida).one(eventoAnimacao, function () {
                    ativa.removeClass('animated ' + animacaoSaida + ' secao-ativa').hide();
                    $(".secao-admin-usuario").show().addClass('animated ' + animacaoEntrada + ' secao-ativa').one(eventoAnimacao, function () {
                        $(".secao-admin-usuario").removeClass('animated ' + animacaoEntrada);
                    });
                });

            }
        },
        voltarMenuAdminVeiculo: function () {
            ativa = $(".body-admin-menu").find(".secao-ativa");
            if (!$(".secao-ativa").hasClass('secao-admin-veiculo')) {
                if (ativa.hasClass('secao-admin-veiculo-incluir') || ativa.hasClass('secao-admin-veiculo-detalhes')) {
                    animacaoEntrada = 'fadeInLeft';
                    animacaoSaida = 'fadeOutRight';
                } else if (ativa.hasClass('secao-admin-usuario') || ativa.hasClass('secao-admin-usuario-incluir') || ativa.hasClass('secao-usuario-detalhes')) {
                    animacaoEntrada = 'fadeInRight';
                    animacaoSaida = 'fadeOutLeft';
                } else if (ativa.hasClass('secao-admin-viagem') || ativa.hasClass('secao-admin-viagem-incluir') || ativa.hasClass('secao-admin-viagem-detalhes')) {
                    animacaoEntrada = 'fadeInLeft';
                    animacaoSaida = 'fadeOutRight';
                }
                ativa.addClass('animated ' + animacaoSaida).one(eventoAnimacao, function () {
                    ativa.removeClass('animated ' + animacaoSaida + ' secao-ativa').hide();
                    $(".secao-admin-veiculo").show().addClass('animated ' + animacaoEntrada + ' secao-ativa').one(eventoAnimacao, function () {
                        $(".secao-admin-veiculo").removeClass('animated ' + animacaoEntrada);
                    });
                });
            }
        },
        voltarMenuAdminViagem: function () {
            ativa = $(".body-admin-menu").find(".secao-ativa");
            if (!$(".secao-ativa").hasClass('secao-admin-viagem')) {
                if (ativa.hasClass('secao-admin-usuario') || ativa.hasClass('secao-admin-veiculo')) {
                    animacaoEntrada = 'fadeInRight';
                    animacaoSaida = 'fadeOutLeft';
                } else {
                    animacaoEntrada = 'fadeInLeft';
                    animacaoSaida = 'fadeOutRight';
                }
                ativa.addClass('animated ' + animacaoSaida).one(eventoAnimacao, function () {
                    ativa.removeClass('animated ' + animacaoSaida + ' secao-ativa').hide();
                    $(".secao-admin-viagem").show().addClass('animated ' + animacaoEntrada + ' secao-ativa').one(eventoAnimacao, function () {
                        $(".secao-admin-viagem").removeClass('animated ' + animacaoEntrada);
                    });
                });
            }
        },
        voltarMenuAdminEscala: function () {
            ativa = $(".body-admin-menu").find(".secao-ativa");
            if (!$(".secao-ativa").hasClass('secao-admin-escala')) {
                if (ativa.hasClass('secao-admin-usuario') || ativa.hasClass('secao-admin-veiculo')) {
                    animacaoEntrada = 'fadeInRight';
                    animacaoSaida = 'fadeOutLeft';
                } else {
                    animacaoEntrada = 'fadeInLeft';
                    animacaoSaida = 'fadeOutRight';
                }
                ativa.addClass('animated ' + animacaoSaida).one(eventoAnimacao, function () {
                    ativa.removeClass('animated ' + animacaoSaida + ' secao-ativa').hide();
                    $(".secao-admin-escala").show().addClass('animated ' + animacaoEntrada + ' secao-ativa').one(eventoAnimacao, function () {
                        $(".secao-admin-escala").removeClass('animated ' + animacaoEntrada);
                    });
                });
            }
        },
        testarCpf: function (strCPF) {
            var Soma;
            var Resto;
            Soma = 0;
            if (strCPF === "00000000000")
                return false;

            for (i = 1; i <= 9; i++)
                Soma = Soma + parseInt(strCPF.substring(i - 1, i)) * (11 - i);
            Resto = (Soma * 10) % 11;

            if ((Resto === 10) || (Resto === 11))
                Resto = 0;
            if (Resto !== parseInt(strCPF.substring(9, 10)))
                return false;

            Soma = 0;
            for (i = 1; i <= 10; i++)
                Soma = Soma + parseInt(strCPF.substring(i - 1, i)) * (12 - i);
            Resto = (Soma * 10) % 11;

            if ((Resto === 10) || (Resto === 11))
                Resto = 0;
            if (Resto !== parseInt(strCPF.substring(10, 11)))
                return false;
            return true;
        },
        abrirModalAcao: function (item_acao, acao) {
            $('#item-acao').html(item_acao).removeClass();
            $('#acao').html(acao).removeClass();

            if (acao == 'editado') {
                $("#item-acao").addClass('item-editado');
                $("#acao").addClass('item-editado');
            } else if (acao == 'incluído') {
                $("#item-acao").addClass('item-incluido');
                $("#acao").addClass('item-incluido');
            } else if (acao == 'removido') {
                $("#item-acao").addClass('item-removido');
                $("#acao").addClass('item-removido');
            }

            $('#modal-acao').modal('toggle');

        }
    };
});

//Controller da tela de login
app.controller("loginController", function ($scope, dataService, $timeout, $http) {
    //Alterna pro conteúdo de recuperar senha
    $scope.mostrarRecuperarSenha = function () {
        $(".card-body-login").fadeTo(400, 0, function () {
            $(".card-body-login").hide();
            $(".card-body-senha").fadeTo(400, 1);
        });
    };
    //Alterna pro conteúdo de Login
    $scope.mostrarLogin = function () {
        $(".card-body-senha").fadeTo(400, 0, function () {
            $(".card-body-senha").hide();
            $(".card-body-login").fadeTo(400, 1);
        });
    };
    //Faz a animação de loader e sucesso
    $scope.recuperarSenha = function () {
        $(".card-body-senha").fadeTo(300, 0, function () {
            $(".card-body-senha").hide();
            $(".loader").fadeTo(300, 1);
            $timeout(function () {
                $(".loader").fadeTo(300, 0, function () {
                    $(".loader").css('display', 'none');
                    $(".msg-senha-enviada").fadeTo(300, 1);
                    $timeout(function () {
                        $(".msg-senha-enviada").fadeTo(300, 0, function () {
                            $(".msg-senha-enviada").hide();
                            $(".card-body-login").fadeTo(300, 1);
                        });
                    }, 2000);
                });
            }, 2000);
        });
    };

    $scope.fazerLogin = function () {
        if (dataService.testarCpf($("#form-login-cpf").cleanVal()) == true && $("#form-login-senha").val().length > 0) {
            $(".card-body-login").hide();
            $(".loader-login").show();
            $("#form-login-cpf").removeClass('error-input');
            $("#form-login-senha").removeClass('error-input');
            $scope.erro_login = "";
            $http({
                method: 'GET',
                url: ctx + '/Usuario.jsp?action=login&cpf=' + $("#form-login-cpf").cleanVal() + '&senha=' + $("#form-login-senha").val()
            }).then(function successCallback(response) {
                $scope.resposta = response.data;
                console.log($scope.resposta);
                if (($scope.resposta).indexOf("Sucesso") >= 0) {
                    $(location).attr('href', ctx + '/admin/menu.jsp');
                } else {
                    $scope.erro_login = $scope.resposta;
                    $(".card-body-login").show();
                    $(".loader-login").hide();
                }

            }, function errorCallback(response) {
                alert('Erro ao se conectar com o servidor.');
                $scope.erro_login = "Usuário inválido.";
                $(".card-body-login").show();
                $(".loader-login").hide();

            });
        } else if (dataService.testarCpf($("#form-login-cpf").cleanVal()) == false) {
            $("#form-login-cpf").addClass('error-input');
            $scope.erro_login = "CPF inválido!";
        } else if ($("#form-login-senha").val().length < 1) {
            $("#form-login-cpf").removeClass('error-input');
            $("#form-login-senha").addClass('error-input');
            $scope.erro_login = "Preencha a senha"
        }
    };
});

app.controller("navAdminController", function ($scope, dataService, $http) {
    $scope.fazerLogout = function () {
        $http({
            method: 'GET',
            url: ctx + '/Usuario.jsp?action=logout'
        }).then(function successCallback(response) {
            $scope.resposta = response.data;
            if (($scope.resposta).indexOf("Sucesso") >= 0) {
                $(location).attr('href', ctx + '/index.jsp');
            }
        }, function errorCallback(response) {
            alert('Falha na conexão com o servidor.');
        });
    };
});

app.controller("menuAdminUsuarioController", function ($scope, dataService, $document, $http, $rootScope) {
    eventoAnimacao = 'webkitAnimationEnd oanimationend msAnimationEnd animationend';
    $document.ready(function () {
        $rootScope.getUsuarios();
    });

    $(".card-body-login").show();
    $(".loader-login").hide();


    $rootScope.getUsuarios = function (pesquisarPor, filtrarPor) {
        $(".admin-exibicao-usuario").hide();
        $(".loader-usuario").show();

        if (filtrarPor == null)
            filtrarPor = '';

        if (pesquisarPor == null)
            pesquisarPor = '';
        $http({
            method: 'GET',
            url: ctx + '/Usuario.jsp?action=select&pesquisarPor=' + pesquisarPor + '&filtrarPor=' + filtrarPor
        }).then(function successCallback(response) {
            $scope.usuarios = response.data.usuarios;
            $(".loader-usuario").hide();
            $("#form-admin-usuario-filtro").focus();
            $(".admin-exibicao-usuario").show();
            if ($scope.usuarios.length !== 0 && $scope.usuarios !== null) {
                $("#alerta-exibicao-usuario").hide();
                $("#form-admin-usuario-filtro").focus();
            } else {
                $scope.erro_usuario = 'Nenhum usuário encontrado com o respectivo filtro!';
                $("#alerta-exibicao-usuario").show();
                $(".admin-exibicao-filtro-usuario").show();
                $("#form-admin-usuario-filtro").focus();
            }

        }, function errorCallback(response) {
            $scope.erro_usuario = 'Ocorreu um erro ao conectar com a base de dados dos usuários. Atualize a página e, se o erro persistir, contate o suporte.';
            $(".loader-usuario").hide();
            $(".admin-exibicao-usuario").hide();
            $("#alerta-exibicao-usuario").show();
        });
    };

    //Some a tela de menu e aparece a de INCLUIR usuário
    $scope.mostrarIncluirUsuario = function () {
        ativa = $(".body-admin-menu").find(".secao-ativa");
        ativa.addClass('animated fadeOutLeft').one(eventoAnimacao, function () {
            ativa.removeClass('secao-ativa');
            ativa.removeClass('animated fadeOutLeft').hide();
            $(".secao-admin-usuario-incluir").show().addClass('animated fadeInRight secao-ativa').one(eventoAnimacao, function () {
                $(".secao-admin-usuario-incluir").removeClass('animated fadeInRight');
            });
        });
    };

    //Some a tela de menu e aparece a de DETALHES do usuário
    $scope.mostrarDetalhesUsuario = function (usuario) {
        ativa = $(".body-admin-menu").find(".secao-ativa");
        ativa.addClass('animated fadeOutLeft').one(eventoAnimacao, function () {
            ativa.removeClass('secao-ativa');
            ativa.removeClass('animated fadeOutLeft').hide();

            $(".secao-admin-usuario-detalhes").show().addClass('animated fadeInRight secao-ativa').one(eventoAnimacao, function () {
                $(".secao-admin-usuario-detalhes").removeClass('animated fadeInRight');
            });
        });
        if (usuario.tipo == 0 || usuario.tipo == 2) {
            $("#form-detalhes-usuario-nome").val(usuario.nome).trigger('input');
            $("#form-detalhes-usuario-cpf").val(usuario.cpf).trigger('input');
            $("#form-detalhes-usuario-senha").val(usuario.senha).trigger('input');

            $("#form-detalhes-usuario-cnh").hide().val("");
            $("#label-detalhes-usuario-cnh").hide();

            $('#form-detalhes-usuario-mopp').hide();
            $('#label-detalhes-usuario-mopp').hide();

            $('#form-detalhes-usuario-validade').hide();
            $('#label-detalhes-usuario-validade').hide();

        } else if (usuario.tipo == 1) {
            $http({
                method: 'GET',
                url: ctx + '/Motorista.jsp?action=selectByCpf&cpf=' + usuario.cpf,

            }).then(function successCallback(response) {
                $("#form-detalhes-usuario-nome").val(usuario.nome).trigger('input');
                $("#form-detalhes-usuario-cpf").val(usuario.cpf).trigger('input');
                $("#form-detalhes-usuario-senha").val(usuario.senha).trigger('input');

                $("#form-detalhes-usuario-cnh").val(response.data.motorista[0].cnh).trigger('input').fadeIn().show();
                $("#label-detalhes-usuario-cnh").show();

                $('#label-detalhes-usuario-mopp').show();

                if (response.data.motorista[0].mopp == "true") {
                    $('#form-detalhes-usuario-mopp').show().prop('checked', true);
                    $("#form-detalhes-usuario-validade").show().val(response.data.motorista[0].validadeMopp).prop("disabled", false);
                } else {
                    $('#form-detalhes-usuario-mopp').show().prop('checked', false);
                    $("#form-detalhes-usuario-validade").show().val(response.data.motorista[0].validadeMopp).prop("disabled", true);
                }

            }, function errorCallback(response) {
                console.log('Error');
            });
        }
    };
});

app.controller("incluirUsuarioAdminController", function ($scope, dataService, $http, $rootScope) {
//Chama o dataService e executa a função de voltar para o menu
    $scope.voltarMenu = function () {
        dataService.voltarMenuAdminUsuario();
    };

    $scope.checkCpf = function () {
        if (!dataService.testarCpf($("#form-incluir-usuario-cpf").cleanVal())) {
            $("#form-incluir-usuario-cpf").addClass('error-input');
            $scope.cpfValido = false;
            $scope.checkValido();
        } else {
            $("#form-incluir-usuario-cpf").removeClass('error-input');
            $scope.cpfValido = true;
            $scope.checkValido();
        }
    };

    $scope.checkValido = function () {
        if ($("#btn-tipo-motorista").hasClass('btn-admin-tipo-active')) {
            if (!$scope.cpfValido || $scope.incluir_usuario_nome == null || $scope.incluir_usuario_cpf == null || $scope.incluir_usuario_cnh == null || $scope.incluir_usuario_senha == null) {
                $("#btn-inserir-usuario").addClass('btn-admin-adicionar-usuario-disabled').removeClass('btn-admin-adicionar-usuario').prop('disabled', true).css('cursor', 'not-allowed');
            } else {
                $("#btn-inserir-usuario").addClass('btn-admin-adicionar-usuario').removeClass('btn-admin-adicionar-usuario-disabled').prop('disabled', false).css('cursor', 'pointer');
            }
        } else {
            if (!$scope.cpfValido || $scope.incluir_usuario_nome == null || $scope.incluir_usuario_cpf == null || $scope.incluir_usuario_senha == null) {
                $("#btn-inserir-usuario").addClass('btn-admin-adicionar-usuario-disabled').removeClass('btn-admin-adicionar-usuario').prop('disabled', true).css('cursor', 'not-allowed');
            } else {
                $("#btn-inserir-usuario").addClass('btn-admin-adicionar-usuario').removeClass('btn-admin-adicionar-usuario-disabled').prop('disabled', false).css('cursor', 'pointer');
            }
        }
    };
    //Alterna o tipo de usuário, fazendo ou não aparecer o form do MOPP
    $(".btn-admin-incluir-usuario-tipo").click(function () {
        $(this).addClass('btn-admin-tipo-active');
        $(".row-admin-tipo").children().not($(this)).removeClass('btn-admin-tipo-active');
        if ($("#btn-tipo-funcionario").hasClass("btn-admin-tipo-active")) {
            $(".form-motorista").fadeOut();
            $("#form-incluir-usuario-cnh").val('');
            $scope.incluir_usuario_cnh = null;
        } else {
            $(".form-motorista").fadeIn();
        }
    });

    $(".btn-admin-incluir-usuario-tipo").click(function () {
        $scope.checkValido();
    });

    //incluir usuário
    $scope.cadastrarUsuario = function () {
        if ($("#btn-tipo-funcionario").hasClass("btn-admin-tipo-active")) {
            $http({
                method: 'POST',
                url: ctx + '/Usuario.jsp?action=insert',
                data: {"cpf": $("#form-incluir-usuario-cpf").cleanVal(), "nome": $("#form-incluir-usuario-nome").val(), "senha": $("#form-incluir-usuario-senha").val(), "tipo": "0"}
            }).then(function successCallback(response) {
                if (response.data.resposta == "SUCCESS") {
                    dataService.abrirModalAcao('funcionário', 'inserido');
                    dataService.voltarMenuAdminUsuario();
                    $rootScope.getUsuarios();

                } else {
                    alert("Ocorreu um erro ao cadastrar o funcionário, se persistirem os erros favor relatar ao suporte")
                }

            }, function errorCallback(response) {
                console.log('Error');
            });
        } else if ($("#btn-tipo-motorista").hasClass("btn-admin-tipo-active")) {
            $http({
                method: 'POST',
                url: ctx + '/Motorista.jsp?action=insert',
                data: {"cpf": $("#form-incluir-usuario-cpf").cleanVal(), "nome": $("#form-incluir-usuario-nome").val(), "senha": $("#form-incluir-usuario-senha").val(), "tipo": "1", "cnh": $("#form-incluir-usuario-cnh").cleanVal(), "MOPP": $("#form-incluir-usuario-mopp").is(":checked"), "validadeMopp": $("#form-incluir-usuario-validade").val()}
            }).then(function successCallback(response) {
                if (response.data.resposta == "SUCCESS") {
                    dataService.abrirModalAcao('motorista', 'inserido');
                    dataService.voltarMenuAdminUsuario();
                    $rootScope.getUsuarios();
                } else {
                    alert("Ocorreu um erro ao cadastrar o motorista, se persistirem os erros favor relatar ao suporte")
                }

            }, function errorCallback(response) {
                console.log('Error');
            });
        }

    };

});
app.controller("detalhesUsuarioAdminController", function ($scope, dataService, $http, $rootScope) {
    $scope.cpfValido = true;
    $scope.voltarMenu = function () {
        dataService.voltarMenuAdminUsuario();
    };
    $scope.checkCpf = function () {
        if (!dataService.testarCpf($("#form-detalhes-usuario-cpf").cleanVal())) {
            $("#form-detalhes-usuario-cpf").addClass('error-input');
            $("#btn-admin-remover-usuario").removeClass('btn-admin-remover-usuario').addClass('btn-admin-remover-usuario-disabled').prop('disabled', true);
            $scope.cpfValido = false;
            $scope.checkValido();
        } else {
            $("#form-detalhes-usuario-cpf").removeClass('error-input');
            $("#btn-admin-remover-usuario").removeClass('btn-admin-remover-usuario-disabled').addClass('btn-admin-remover-usuario').prop('disabled', false);
            $scope.cpfValido = true;
            $scope.checkValido();
        }
    };
    $scope.checkValido = function () {
        $scope.detalhes_usuario_nome = $("#form-detalhes-usuario-nome").val();
        $scope.detalhes_usuario_cpf = $("#form-detalhes-usuario-cpf").val();
        $scope.detalhes_usuario_senha = $("#form-detalhes-usuario-senha").val();
        $scope.detalhes_usuario_cnh = $("#form-detalhes-usuario-cnh").val();
        if ($scope.cpfValido == false || $scope.detalhes_usuario_nome == '' || $scope.detalhes_usuario_cpf == '' || $scope.detalhes_usuario_senha == '') {
            $("#btn-admin-alterar-usuario").addClass('btn-admin-alterar-usuario-disabled').removeClass('btn-admin-alterar-usuario').prop('disabled', true).css('cursor', 'not-allowed');
        } else {
            $("#btn-admin-alterar-usuario").addClass('btn-admin-alterar-usuario').removeClass('btn-admin-alterar-usuario-disabled').prop('disabled', false).css('cursor', 'pointer');
        }
    };

    $scope.updateUsuario = function () {
        if ($("#form-detalhes-usuario-cnh").val() == "") {
            $http({
                method: 'POST',
                url: ctx + '/Usuario.jsp?action=update&cpf=' + $("#form-detalhes-usuario-cpf").cleanVal(),
                data: {"nome": $("#form-detalhes-usuario-nome").val(), "senha": $("#form-detalhes-usuario-senha").val()}
            }).then(function successCallback(response) {
                if (response.data.resposta == "SUCCESS") {
                    dataService.abrirModalAcao('motorista', 'editado');
                    dataService.voltarMenuAdminUsuario();
                    $rootScope.getUsuarios();
                } else {
                    alert("Ocorreu um erro ao alterar o funcionário, se persistirem os erros favor relatar ao suporte")
                }

            }, function errorCallback(response) {
                console.log('Error');
            });
        } else {
            $http({
                method: 'POST',
                url: ctx + '/Motorista.jsp?action=update&cpf=' + $("#form-detalhes-usuario-cpf").cleanVal() + '&cnh=' + $("#form-detalhes-usuario-cnh").cleanVal(),
                data: {"nome": $("#form-detalhes-usuario-nome").val(), "senha": $("#form-incluir-usuario-senha").val(), "MOPP": $("#form-detalhes-usuario-mopp").is(":checked"), "validadeMopp": $("#form-detalhes-usuario-validade").val()}
            }).then(function successCallback(response) {
                if (response.data.resposta == "SUCCESS") {
                    dataService.abrirModalAcao('motorista', 'editado');
                    dataService.voltarMenuAdminUsuario();
                    $rootScope.getUsuarios();
                } else {
                    alert("Ocorreu um erro ao alterar o motorista, se persistirem os erros favor relatar ao suporte")
                }

            }, function errorCallback(response) {
                console.log('Error');
            });
        }

    };

    $scope.deleteUsuario = function () {
        if ($("#form-detalhes-usuario-cnh").val() == "") {
            $http({
                method: 'POST',
                url: ctx + '/Usuario.jsp?action=delete&cpf=' + $("#form-detalhes-usuario-cpf").cleanVal(),
            }).then(function successCallback(response) {
                if (response.data.resposta == "SUCCESS") {
                    dataService.abrirModalAcao('funcionário', 'removido');
                    dataService.voltarMenuAdminUsuario();
                    $rootScope.getUsuarios();
                } else {
                    alert("Ocorreu um erro ao remover o funcionário, se persistirem os erros favor relatar ao suporte")
                }

            }, function errorCallback(response) {
                console.log('Error');
            });
        } else {
            $http({
                method: 'POST',
                url: ctx + '/Motorista.jsp?action=delete&cpf=' + $("#form-detalhes-usuario-cpf").cleanVal(),
            }).then(function successCallback(response) {
                if (response.data.resposta == "SUCCESS") {
                    dataService.abrirModalAcao('motorista', 'removido');
                    dataService.voltarMenuAdminUsuario();
                    $rootScope.getUsuarios();
                } else {
                    alert("Ocorreu um erro ao remover o motorista, se persistirem os erros favor relatar ao suporte");
                }

            }, function errorCallback(response) {
                console.log('Error');
            });
        }

    };


});
app.controller("menuAdminVeiculoController", function ($scope, $http, $document, $rootScope) {
    $document.ready(function () {
        $rootScope.getVeiculos();
        $rootScope.getCapacitacao();
        $rootScope.getMarcas();
    });

    $rootScope.getVeiculos = function (pesquisarPor) {
        $(".loader-veiculo").show();
        $("#alerta-exibicao-veiculo").hide();
        if (pesquisarPor == null)
            pesquisarPor = '';

        $http({
            method: 'GET',
            url: ctx + '/veiculo.jsp?action=select&pesquisarPor=' + pesquisarPor
        }).then(function successCallback(response) {
            $scope.veiculos = response.data.veiculos;
            $(".loader-veiculo").hide();
            $("#form-admin-veiculo-filtro").focus();
            $(".admin-exibicao-veiculo").show();

            if ($scope.veiculos.length == 0) {
                $scope.erro_veiculo = 'Nenhum veículo encontrado com o respectivo filtro!';
                $("#alerta-exibicao-veiculo").show();
            }

        }, function errorCallback(response) {
            $(".loader-veiculo").hide();
            $scope.erro_veiculo = 'Ocorreu um erro ao conectar com a base de dados dos veículos. Atualize a página e, se o erro persistir, contate o suporte.';
            $("#alerta-exibicao-veiculo").show();
        });
    };

    $rootScope.getMarcas = function () {
        $http({
            method: 'GET',
            url: ctx + '/marca.jsp?action=select'
        }).then(function successCallback(response) {
            $rootScope.marcas = response.data.marcas;

//            for (i = 0; i < $scope.marcas.length; i++) {
//                $("#form-incluir-veiculo-lista").append($("<option value='" + $scope.marcas[i].nome + "'></option>"));
//                $("#form-detalhes-veiculo-lista").append($("<option value='" + $scope.marcas[i].nome + "'></option>"));
//            }

        }, function errorCallback(response) {
            $(".loader-veiculo").hide();
            $scope.erro_veiculo = 'Ocorreu um erro ao conectar com a base de dados dos veículos. Atualize a página e, se o erro persistir, contate o suporte.';
            $("#alerta-exibicao-veiculo").show();
        });
    };

    $rootScope.getCapacitacao = function () {
        $.ajax({
            type: 'POST',
            url: '../capacitacao.jsp?action=select',
            async: false,
            dataType: 'json',
            success: function (result) {
                var buffer = "";
                $.each(result, function (index, val) {

                    for (var i = 0; i < val.length; i++) {
                        var item = val[i];
                        buffer += "<li ng-class=\"{'item-lista-capacitacao-ativo' : incluir_veiculo_capacitacao_a}\" class=\"item-lista-capacitacao\"><div class=\"form-check\"><label class=\"form-check-label\"><input ng-model=\"incluir_veiculo_capacitacao_a\" class=\"form-check-input checkbox-veiculo\"  type=\"checkbox\" value=" + item.id + ">" + item.categoria + "</label></div></li>";
                    }
                    $("#list-capacitacao").html(buffer);
                });
            }
        });
    };

    $scope.mostrarIncluirVeiculo = function () {
        ativa = $(".body-admin-menu").find(".secao-ativa");
        ativa.addClass('animated fadeOutLeft').one(eventoAnimacao, function () {
            ativa.removeClass('secao-ativa');
            ativa.removeClass('animated fadeOutLeft').hide();
            $(".secao-admin-veiculo-incluir").show().addClass('animated fadeInRight secao-ativa').one(eventoAnimacao, function () {
                $(".secao-admin-veiculo-incluir").removeClass('animated fadeInRight');
            });
        });
    };
    $scope.mostrarDetalhesVeiculo = function (veiculo) {
        ativa = $(".body-admin-menu").find(".secao-ativa");
        ativa.addClass('animated fadeOutLeft').one(eventoAnimacao, function () {
            ativa.removeClass('secao-ativa');
            ativa.removeClass('animated fadeOutLeft').hide();
            $(".secao-admin-veiculo-detalhes").show().addClass('animated fadeInRight secao-ativa').one(eventoAnimacao, function () {
                $(".secao-admin-veiculo-detalhes").removeClass('animated fadeInRight');
            });
        });

        $("#form-detalhes-veiculo-modelo").val(veiculo.modelo).trigger('input');
        $("#form-detalhes-veiculo-marca").val(veiculo.marca.nome).trigger('input');
        $("#form-detalhes-veiculo-ano").val(veiculo.ano).trigger('input');
        $("#form-detalhes-veiculo-eixo").val(veiculo.qtdEixos);
        $("#form-detalhes-veiculo-placa").val(veiculo.placa).trigger('input');
        $("#form-detalhes-veiculo-motoristaPreferencial").val(veiculo.cnhMotoristaPreferencial);


        $http({
            method: 'GET',
            url: ctx + '/capacitacao.jsp?action=selectByVeiculo&placa=' + $("#form-detalhes-veiculo-placa").cleanVal(),
        }).then(function successCallback(response) {
            $scope.capacitacaoAtual = response.data.capacitacao;
            for (i = 0; i < $scope.capacitacaoAtual.length; i++) {
                if ($scope.capacitacaoAtual[i].id == 1)
                    $("#form-detalhes-capacitacao-1").prop("checked", true);
                if ($scope.capacitacaoAtual[i].id == 2)
                    $("#form-detalhes-capacitacao-2").prop("checked", true);
                if ($scope.capacitacaoAtual[i].id == 3)
                    $("#form-detalhes-capacitacao-3").prop("checked", true);
                if ($scope.capacitacaoAtual[i].id == 4)
                    $("#form-detalhes-capacitacao-4").prop("checked", true);
            }

        }, function errorCallback(response) {
            console.log('Error');
        });



    };
});
app.controller("abasAdminController", function ($scope, dataService) {
    $scope.irSecaoAdminUsuario = function () {
        dataService.voltarMenuAdminUsuario();
    };
    $scope.irSecaoAdminVeiculo = function () {
        dataService.voltarMenuAdminVeiculo();
    };
    $scope.irSecaoAdminViagem = function () {
        dataService.voltarMenuAdminViagem();
    };
    $scope.irSecaoAdminEscala = function () {
        dataService.voltarMenuAdminEscala();
    };
});
app.controller("incluirVeiculoAdminController", function ($scope, dataService, $http, $rootScope) {
    $scope.voltarMenu = function () {
        $("#form-incluir-veiculo-placa").val("");
        $("#form-incluir-veiculo-marca").val("");
        $("#form-incluir-veiculo-modelo").val("");
        $("#form-incluir-veiculo-ano").val("");
        $("#form-incluir-veiculo-motoristaPreferencial").val("");
        $("#form-incluir-veiculo-eixo").val("");
        dataService.voltarMenuAdminVeiculo();
    };

    $scope.checkValido = function () {
        if ($scope.incluir_veiculo_modelo == null || $scope.incluir_veiculo_marca == null || $scope.incluir_veiculo_placa == null || $scope.incluir_veiculo_placa.length < 8 || $scope.incluir_veiculo_eixos == null || $scope.incluir_veiculo_ano == null) {
            $("#btn-admin-incluir-veiculo").addClass('btn-admin-adicionar-usuario-disabled').removeClass('btn-admin-adicionar-usuario').prop('disabled', true).css('cursor', 'not-allowed');
        } else {
            $("#btn-admin-incluir-veiculo").addClass('btn-admin-adicionar-usuario').removeClass('btn-admin-adicionar-usuario-disabled').prop('disabled', false).css('cursor', 'pointer');
        }
    };

    $scope.insertVeiculo = function () {
        console.log('Entrou');
        $http({
            method: 'POST',
            url: ctx + '/veiculo.jsp?action=insert',
            data: {"placa": $("#form-incluir-veiculo-placa").cleanVal(), "marca": $("#form-incluir-veiculo-marca").val(), "modelo": $("#form-incluir-veiculo-modelo").val(), "ano": $("#form-incluir-veiculo-ano").val(), "motoristaPreferencial": $("#form-incluir-veiculo-motoristaPreferencial").cleanVal(), "eixos": $("#form-incluir-veiculo-eixo").val()}
        }).then(function successCallback(response) {
            console.log('Success');
        }, function errorCallback(response) {
            console.log('Error');
        });


        $('.checkbox-veiculo:checked').each(function () {
            console.log("Entrou capa");
            var capacitacao = {
                "idCapacitacao": $(this).val(),
                "placa": $("#form-incluir-veiculo-placa").cleanVal()
            };
            $http({
                method: 'POST',
                url: ctx + '/veiculo.jsp?action=insertCapacitacaoToVeiculo',
                data: capacitacao
            }).then(function successCallback(response) {
                if (response.data.resposta == "SUCCESS") {
                    dataService.abrirModalAcao('veiculo', 'inserido');
                    dataService.voltarMenuAdminVeiculo();
                    $rootScope.getVeiculos();
                    $rootScope.getCapacitacao();
                    console.log("Success Capa");
                }
            }, function errorCallback(response) {
                console.log('Error');
                console.log("Error capa");
            });
        });
    };

});
app.controller("detalhesVeiculoAdminController", function ($scope, dataService, $http, $rootScope) {
    $scope.placaValida = true;

    $scope.voltarMenu = function () {
        dataService.voltarMenuAdminVeiculo();
    };

    $scope.checkPlaca = function () {
        if ($scope.detalhes_veiculo_placa == '' || $scope.detalhes_veiculo_placa.length < 8) {
            $("#form-detalhes-veiculo-placa").addClass('error-input');
            $("#btn-admin-remover-veiculo").removeClass('btn-admin-remover-usuario').addClass('btn-admin-remover-usuario-disabled').prop('disabled', true);
            $scope.placaValida = false;
            $scope.checkValido();
        } else {
            $("#form-detalhes-veiculo-placa").removeClass('error-input');
            $("#btn-admin-remover-veiculo").removeClass('btn-admin-remover-usuario-disabled').addClass('btn-admin-remover-usuario').prop('disabled', false);
            $scope.placaValida = true;
            $scope.checkValido();
        }
    };

    $scope.checkValido = function () {
        $scope.detalhes_veiculo_modelo = $("#form-detalhes-veiculo-modelo").val();
        $scope.detalhes_veiculo_marca = $("#form-detalhes-veiculo-marca").val();
        $scope.detalhes_veiculo_ano = $("#form-detalhes-veiculo-ano").val();
        $scope.detalhes_veiculo_eixos = $("#form-detalhes-veiculo-eixo").val();
        $scope.detalhes_veiculo_motorista = $("#form-detalhes-veiculo-motoristaPreferencial").val();
        $scope.detalhes_veiculo_placa = $("#form-detalhes-veiculo-placa").val();

        if ($scope.detalhes_veiculo_modelo == '' || $scope.detalhes_veiculo_marca == '' || $scope.detalhes_veiculo_placa == '' || $scope.detalhes_veiculo_ano == '' || $scope.detalhes_veiculo_eixos == '' || $scope.placaValida == false || $scope.detalhes_veiculo_placa.length < 8) {
            $("#btn-admin-alterar-veiculo").addClass('btn-admin-alterar-usuario-disabled').removeClass('btn-admin-alterar-usuario').prop('disabled', true).css('cursor', 'not-allowed');
        } else {
            $("#btn-admin-alterar-veiculo").addClass('btn-admin-alterar-usuario').removeClass('btn-admin-alterar-usuario-disabled').prop('disabled', false).css('cursor', 'pointer');
        }
    };

    $scope.deleteVeiculo = function () {
        $http({
            method: 'POST',
            url: ctx + '/veiculo.jsp?action=delete&placa=' + $("#form-detalhes-veiculo-placa").cleanVal(),
        }).then(function successCallback(response) {
            if (response.data.resposta == "SUCCESS") {
                dataService.abrirModalAcao('veículo', 'removido');
                dataService.voltarMenuAdminVeiculo();
                $rootScope.getVeiculos();
                $rootScope.getCapacitacao();
            } else {
                alert("Ocorreu um erro ao remover o veiculo, se persistirem os erros favor relatar ao suporte")
            }

        }, function errorCallback(response) {
            console.log('Error');
        });
    };

    $scope.updateVeiculo = function () {
        $http({
            method: 'POST',
            url: ctx + '/veiculo.jsp?action=update&placa=' + $("#form-detalhes-veiculo-placa").cleanVal(),
            data: {"modelo": $("#form-detalhes-veiculo-modelo").val(), "marca": $("#form-detalhes-veiculo-marca").val(), "ano": $("#form-detalhes-veiculo-ano").val(), "eixos": $("#form-detalhes-veiculo-eixo").val(), "motoristaPreferencial": $("#form-detalhes-veiculo-motoristaPreferencial").val(), "capacitacao1": $("#form-detalhes-capacitacao-1").is("checked"), "capacitacao2": $("#form-detalhes-capacitacao-2").is("checked"), "capacitacao3": $("#form-detalhes-capacitacao-3").is("checked"), "capacitacao4": $("#form-detalhes-capacitacao-4").is("checked")}
        }).then(function successCallback(response) {
            if (response.data.resposta == "SUCCESS") {
                dataService.abrirModalAcao('veículo', 'editado');
                dataService.voltarMenuAdminVeiculo();
                $rootScope.getVeiculos();
                $rootScope.getCapacitacao();

            } else {
                alert("Ocorreu um erro ao remover o veiculo, se persistirem os erros favor relatar ao suporte");
            }

        }, function errorCallback(response) {
            console.log('Error');
        });
    };
});
app.controller("viagemAdminController", function ($scope, $rootScope, $document, $http) {
    $document.ready(function () {
        $rootScope.getTiposCarga();
        $rootScope.getViagens();
    });

    $(".btn-admin-escala-tipo").click(function () {
        $(this).addClass('btn-escala-active');
        $(".row-admin-escala-tipo").children().not($(this)).removeClass('btn-escala-active');
        if ($("#btn-escala-realizada").hasClass("btn-escala-active")) {
            $(".secao-viagem-pendente").fadeTo("fast", 0, function () {
                $(".secao-viagem-pendente").hide();
                $(".secao-viagem-escalada").show().fadeTo("fast", 1);
            });
        } else {
            $(".secao-viagem-escalada").fadeTo("fast", 0, function () {
                $(".secao-viagem-escalada").hide();
                $(".secao-viagem-pendente").show().fadeTo("fast", 1);
            });
        }
    });

    $scope.mostrarIncluirViagem = function () {
        ativa = $(".body-admin-menu").find(".secao-ativa");
        ativa.addClass('animated fadeOutLeft').one(eventoAnimacao, function () {
            ativa.removeClass('secao-ativa');
            ativa.removeClass('animated fadeOutLeft').hide();
            $(".secao-admin-viagem-incluir").show().addClass('animated fadeInRight secao-ativa').one(eventoAnimacao, function () {
                $(".secao-admin-viagem-incluir").removeClass('animated fadeInRight');
            });
        });
    };
    $scope.mostrarDetalhesViagem = function (viagem) {
        ativa = $(".body-admin-menu").find(".secao-ativa");
        ativa.addClass('animated fadeOutLeft').one(eventoAnimacao, function () {
            ativa.removeClass('secao-ativa');
            ativa.removeClass('animated fadeOutLeft').hide();
            $(".secao-admin-viagem-detalhes").show().addClass('animated fadeInRight secao-ativa').one(eventoAnimacao, function () {
                $(".secao-admin-viagem-detalhes").removeClass('animated fadeInRight');
            });
        });

        $("#form-detalhes-viagem-tipo").val(viagem.carga.tipo);
        $("#form-detalhes-viagem-conteudo").val(viagem.carga.conteudo);
        $("#form-detalhes-viagem-peso").val(viagem.carga.peso);
        $("#form-detalhes-viagem-tpeso").val(viagem.carga.unidadeMedida);

        $("#form-detalhes-viagem-altura").val(viagem.carga.dimensoes.split("x")[0]);
        $("#form-detalhes-viagem-largura").val(viagem.carga.dimensoes.split("x")[0]);
        $("#form-detalhes-viagem-comprimento").val(viagem.carga.dimensoes.split("x")[0]);

        $("#form-detalhes-viagem-cep-partida").val(viagem.partida.cep).trigger('input');
        $("#form-detalhes-viagem-rua-partida").val(viagem.partida.rua).trigger('input');
        $("#form-detalhes-viagem-rua-numero-partida").val(viagem.partida.numero).trigger('input');
        $("#form-detalhes-viagem-rua-complemento-partida").val(viagem.partida.complemento).trigger('input');
        $("#form-detalhes-viagem-pais-partida").val(viagem.partida.pais).trigger('input');
        $("#form-detalhes-viagem-estado-partida").val(viagem.partida.estado).trigger('input');
        $("#form-detalhes-viagem-cidade-partida").val(viagem.partida.cidade).trigger('input');

        $("#form-detalhes-viagem-cep-destino").val(viagem.destino.cep).trigger('input');
        $("#form-detalhes-viagem-rua-destino").val(viagem.destino.rua).trigger('input');
        $("#form-detalhes-viagem-rua-numero-destino").val(viagem.destino.numero).trigger('input');
        $("#form-detalhes-viagem-cidade-destino").val(viagem.destino.cidade).trigger('input');
        $("#form-detalhes-viagem-rua-complemento-destino").val(viagem.destino.complemento).trigger('input');
        $("#form-detalhes-viagem-pais-destino").val(viagem.destino.pais).trigger('input');
        $("#form-detalhes-viagem-estado-destino").val(viagem.destino.estado).trigger('input');


        $("#form-detalhes-viagem-prazo").val(viagem.prazo);
        $("#form-detalhes-viagem-id").val(viagem.id);
        $("#form-detalhes-viagem-carga-id").val(viagem.carga.id);

    };

    $rootScope.getViagens = function () {
        $(".loader-viagem").show();
        $("#alerta-exibicao-viagem").hide();

        $http({
            method: 'GET',
            url: ctx + '/viagem.jsp?action=select'
        }).then(function successCallback(response) {

            $scope.viagens = response.data.viagens;
            $(".loader-viagem").hide();
            $("#form-admin-veiculo-filtro").focus();
            $(".admin-exibicao-veiculo").show();
            console.log($scope.viagens);

            if ($scope.viagens.length == 0) {
                $scope.erro_viagem = 'Nenhum veículo encontrado com o respectivo filtro!';
                $("#alerta-exibicao-veiculo").show();
            }

        }, function errorCallback(response) {
            $(".loader-veiculo").hide();
            $scope.erro_viagem = 'Ocorreu um erro ao conectar com a base de dados dos veículos. Atualize a página e, se o erro persistir, contate o suporte.';
            $("#alerta-exibicao-veiculo").show();
        });
    }
    $rootScope.getTiposCarga = function () {
        $http({
            method: 'GET',
            url: ctx + '/capacitacao.jsp?action=select'
        }).then(function successCallback(response) {
            $rootScope.tiposCarga = response.data.capacitacao;
        }, function errorCallback(response) {
            $(".loader-viagem").hide();
            $scope.erro_veiculo = 'Ocorreu um erro ao conectar com a base de dados dos veículos. Atualize a página e, se o erro persistir, contate o suporte.';
            $("#alerta-exibicao-viagem").show();
        });
    };
});
app.controller("incluirViagemAdminController", function ($scope, dataService, $http, $rootScope) {
    $scope.voltarMenu = function () {

        dataService.voltarMenuAdminViagem();
    };
    $(".btn-admin-incluir-viagem-tipo").click(function () {
        $(this).addClass('btn-admin-tipo-active');
        $(".row-admin-viagem").children().not($(this)).removeClass('btn-admin-tipo-active');
        if ($("#btn-viagem-carga").hasClass("btn-admin-tipo-active")) {
            $(".secao-admin-viagem-incluir-endereco").fadeTo(100, 0, function () {
                $(".secao-admin-viagem-incluir-endereco").hide();
                $(".secao-admin-viagem-incluir-carga").fadeTo(100, 1);
            });
        } else {
            $(".secao-admin-viagem-incluir-carga").fadeTo(100, 0, function () {
                $(".secao-admin-viagem-incluir-carga").hide();
                $(".secao-admin-viagem-incluir-endereco").fadeTo(100, 1);
            });
        }
    });

    $scope.checkValido = function () {
        $scope.incluir_viagem_tipo = $("#form-incluir-viagem-tipo").val();
        $scope.incluir_viagem_conteudo = $("#form-incluir-viagem-conteudo").val();
        $scope.incluir_viagem_peso = $("#form-incluir-viagem-peso").val();
        $scope.incluir_viagem_altura = $("#form-incluir-viagem-altura").val();
        $scope.incluir_viagem_largura = $("#form-incluir-viagem-largura").val();
        $scope.incluir_viagem_comprimento = $("#form-incluir-viagem-comprimento").val();
        $scope.incluir_viagem_prazo = $("#form-incluir-viagem-prazo").val();

        $scope.incluir_viagem_cep_partida = $("#form-incluir-viagem-cep-partida").val();
        $scope.incluir_viagem_rua_partida = $("#form-incluir-viagem-rua-partida").val();
        $scope.incluir_viagem_rua_numero_partida = $("#form-incluir-viagem-rua-numero-partida").val();
        $scope.incluir_viagem_pais_partida = $("#form-incluir-viagem-pais-partida").val();
        $scope.incluir_viagem_estado_partida = $("#form-incluir-viagem-estado-partida").val();
        $scope.incluir_viagem_cidade_partida = $("#form-incluir-viagem-cidade-partida").val();
        
        $scope.incluir_viagem_cep_destino = $("#form-incluir-viagem-cep-destino").val();
        $scope.incluir_viagem_rua_destino = $("#form-incluir-viagem-rua-destino").val();
        $scope.incluir_viagem_rua_numero_destino = $("#form-incluir-viagem-rua-numero-destino").val();
        $scope.incluir_viagem_pais_destino = $("#form-incluir-viagem-pais-destino").val();
        $scope.incluir_viagem_estado_destino = $("#form-incluir-viagem-estado-destino").val();
        $scope.incluir_viagem_cidade_destino = $("#form-incluir-viagem-cidade-destino").val();

        if ($scope.incluir_viagem_tipo == '' || $scope.incluir_viagem_conteudo == '' || $scope.incluir_viagem_peso == '' || $scope.incluir_viagem_altura == '' || $scope.incluir_viagem_largura == '' || $scope.incluir_viagem_comprimento == '' || $scope.incluir_viagem_cep_partida == '' || $scope.incluir_viagem_cep_partida.length < 9 || $scope.incluir_viagem_rua_partida == '' || $scope.incluir_viagem_rua_numero_partida == '' || $scope.incluir_viagem_pais_partida == '' || $scope.incluir_viagem_estado_partida == '' || $scope.incluir_viagem_cidade_partida == '' || $scope.incluir_viagem_cep_destino == '' || $scope.incluir_viagem_cep_destino.length < 9 || $scope.incluir_viagem_rua_destino == '' || $scope.incluir_viagem_rua_numero_destino == '' || $scope.incluir_viagem_pais_destino == '' || $scope.incluir_viagem_estado_destino == '' || $scope.incluir_viagem_cidade_destino == '' || $scope.incluir_viagem_prazo == '') {
            console.log("desativado");
            $("#btn-admin-adicionar-viagem").addClass('btn-admin-adicionar-usuario-disabled').removeClass('btn-admin-adicionar-usuario').prop('disabled', true).css('cursor', 'not-allowed');           
        } else {
            console.log("ativado");
            $("#btn-admin-adicionar-viagem").addClass('btn-admin-adicionar-usuario').removeClass('btn-admin-adicionar-usuario-disabled').prop('disabled', false).css('cursor', 'pointer');
        }
    };

    $scope.insertViagem = function () {

        $scope.viagem = {
            "tipocarga": $("#form-incluir-viagem-tipo").val(),
            "pesocarga": ($("#form-incluir-viagem-peso").val()) + ($("#form-incluir-viagem-tpeso").val()),
            "alturacarga": $("#form-incluir-viagem-altura").val(),
            "larguracarga": $("#form-incluir-viagem-largura").val(),
            "comprimentocarga": $("#form-incluir-viagem-comprimento").val(),
            "conteudo": $("#form-incluir-viagem-conteudo").val(),
            "prazo": $("#form-incluir-viagem-prazo").val(),
            "enderecoCepPartida": $("#form-incluir-viagem-cep-partida").val(),
            "enderecoNumeroPartida": $("#form-incluir-viagem-rua-numero-partida").val(),
            "enderecoRuaPartida": $("#form-incluir-viagem-rua-partida").val(),
            "enderecoCidadePartida": $("#form-incluir-viagem-cidade-partida").val(),
            "enderecoEstadoPartida": $("#form-incluir-viagem-estado-partida").val(),
            "enderecoPaisPartida": $("#form-incluir-viagem-pais-partida").val(),
            "enderecoComplementoPartida": "-" + $("#form-incluir-viagem-rua-complemento-partida").val(),
            "enderecoCepDestino": $("#form-incluir-viagem-cep-destino").val(),
            "enderecoNumeroDestino": $("#form-incluir-viagem-rua-numero-destino").val(),
            "enderecoRuaDestino": $("#form-incluir-viagem-rua-destino").val(),
            "enderecoCidadeDestino": $("#form-incluir-viagem-cidade-destino").val(),
            "enderecoEstadoDestino": $("#form-incluir-viagem-estado-destino").val(),
            "enderecoPaisDestino": $("#form-incluir-viagem-pais-destino").val(),
            "enderecoComplementoDestino": "-" + $("#form-incluir-viagem-rua-complemento-destino").val()
        };
        $http({
            method: 'POST',
            url: ctx + '/viagem.jsp?action=insert',
            data: $scope.viagem
        }).then(function successCallback(response) {
            if (response.data.resposta == "SUCCESS") {
                dataService.abrirModalAcao('viagem', 'inserida');
                dataService.voltarMenuAdminViagem();
                $rootScope.getViagens();
            } else {
                alert("Ocorreu um erro ao remover o veiculo, se persistirem os erros favor relatar ao suporte");
            }
        }, function errorCallback(response) {
            console.log('Error');
        });

    };
});
app.controller("detalhesViagemAdminController", function ($scope, dataService, $http, $rootScope, $document) {
    $document.ready(function () {
        $scope.getTiposCarga();
    });

    $scope.voltarMenu = function () {
        dataService.voltarMenuAdminViagem();
    };
    $(".btn-admin-detalhes-viagem-tipo").click(function () {
        $(this).addClass('btn-admin-tipo-active');
        $(".row-admin-detalhes-viagem").children().not($(this)).removeClass('btn-admin-tipo-active');
        if ($("#btn-viagem-detalhes-carga").hasClass("btn-admin-tipo-active")) {
            $(".secao-admin-viagem-detalhes-endereco").fadeTo(100, 0, function () {
                $(".secao-admin-viagem-detalhes-endereco").hide();
                $(".secao-admin-viagem-detalhes-carga").fadeTo(100, 1);
            });
        } else {
            $(".secao-admin-viagem-detalhes-carga").fadeTo(100, 0, function () {
                $(".secao-admin-viagem-detalhes-carga").hide();
                $(".secao-admin-viagem-detalhes-endereco").fadeTo(100, 1);
            });
        }
    });
        
    $scope.checkValido = function () {
        $scope.detalhes_viagem_tipo = $("#form-detalhes-viagem-tipo").val();
        $scope.detalhes_viagem_conteudo = $("#form-detalhes-viagem-conteudo").val();
        $scope.detalhes_viagem_peso = $("#form-detalhes-viagem-peso").val();
        $scope.detalhes_viagem_altura = $("#form-detalhes-viagem-altura").val();
        $scope.detalhes_viagem_largura = $("#form-detalhes-viagem-largura").val();
        $scope.detalhes_viagem_comprimento = $("#form-detalhes-viagem-comprimento").val();
        $scope.detalhes_viagem_prazo = $("#form-detalhes-viagem-prazo").val();

        $scope.detalhes_viagem_cep_partida = $("#form-detalhes-viagem-cep-partida").val();
        $scope.detalhes_viagem_rua_partida = $("#form-detalhes-viagem-rua-partida").val();
        $scope.detalhes_viagem_rua_numero_partida = $("#form-detalhes-viagem-rua-numero-partida").val();
        $scope.detalhes_viagem_pais_partida = $("#form-detalhes-viagem-pais-partida").val();
        $scope.detalhes_viagem_estado_partida = $("#form-detalhes-viagem-estado-partida").val();
        $scope.detalhes_viagem_cidade_partida = $("#form-detalhes-viagem-cidade-partida").val();
        
        $scope.detalhes_viagem_cep_destino = $("#form-detalhes-viagem-cep-destino").val();
        $scope.detalhes_viagem_rua_destino = $("#form-detalhes-viagem-rua-destino").val();
        $scope.detalhes_viagem_rua_numero_destino = $("#form-detalhes-viagem-rua-numero-destino").val();
        $scope.detalhes_viagem_pais_destino = $("#form-detalhes-viagem-pais-destino").val();
        $scope.detalhes_viagem_estado_destino = $("#form-detalhes-viagem-estado-destino").val();
        $scope.detalhes_viagem_cidade_destino = $("#form-detalhes-viagem-cidade-destino").val();

        if ($scope.detalhes_viagem_tipo == '' || $scope.detalhes_viagem_conteudo == '' || $scope.detalhes_viagem_peso == '' || $scope.detalhes_viagem_altura == '' || $scope.detalhes_viagem_largura == '' || $scope.detalhes_viagem_comprimento == '' || $scope.detalhes_viagem_cep_partida == '' || $scope.detalhes_viagem_cep_partida.length < 9 || $scope.detalhes_viagem_rua_partida == '' || $scope.detalhes_viagem_rua_numero_partida == '' || $scope.detalhes_viagem_pais_partida == '' || $scope.detalhes_viagem_estado_partida == '' || $scope.detalhes_viagem_cidade_partida == '' || $scope.detalhes_viagem_cep_destino == '' || $scope.detalhes_viagem_cep_destino.length < 9 || $scope.detalhes_viagem_rua_destino == '' || $scope.detalhes_viagem_rua_numero_destino == '' || $scope.detalhes_viagem_pais_destino == '' || $scope.detalhes_viagem_estado_destino == '' || $scope.detalhes_viagem_cidade_destino == '' || $scope.detalhes_viagem_prazo == '') {
            $("#btn-admin-alterar-viagem").addClass('btn-admin-alterar-usuario-disabled').removeClass('btn-admin-alterar-usuario').prop('disabled', true).css('cursor', 'not-allowed');           
        } else {
            $("#btn-admin-alterar-viagem").addClass('btn-admin-alterar-usuario').removeClass('btn-admin-alterar-usuario-disabled').prop('disabled', false).css('cursor', 'pointer');
        }
    };

    $scope.updateViagem = function () {

        $scope.viagem = {
            "tipocarga": $("#form-detalhes-viagem-tipo").val(),
            "pesocarga": ($("#form-detalhes-viagem-peso").val()) + ($("#form-detalhes-viagem-tpeso").val()),
            "alturacarga": $("#form-detalhes-viagem-altura").val(),
            "larguracarga": $("#form-detalhes-viagem-largura").val(),
            "comprimentocarga": $("#form-detalhes-viagem-comprimento").val(),
            "conteudo": $("#form-detalhes-viagem-conteudo").val(),
            "prazo": $("#form-detalhes-viagem-prazo").val(),
            "enderecoCepPartida": $("#form-detalhes-viagem-cep-partida").val(),
            "enderecoNumeroPartida": $("#form-detalhes-viagem-rua-numero-partida").val(),
            "enderecoRuaPartida": $("#form-detalhes-viagem-rua-partida").val(),
            "enderecoCidadePartida": $("#form-detalhes-viagem-cidade-partida").val(),
            "enderecoEstadoPartida": $("#form-detalhes-viagem-estado-partida").val(),
            "enderecoPaisPartida": $("#form-detalhes-viagem-pais-partida").val(),
            "enderecoComplementoPartida": "-" + $("#form-detalhes-viagem-rua-complemento-partida").val(),
            "enderecoCepDestino": $("#form-detalhes-viagem-cep-destino").val(),
            "enderecoNumeroDestino": $("#form-detalhes-viagem-rua-numero-destino").val(),
            "enderecoRuaDestino": $("#form-detalhes-viagem-rua-destino").val(),
            "enderecoCidadeDestino": $("#form-detalhes-viagem-cidade-destino").val(),
            "enderecoEstadoDestino": $("#form-detalhes-viagem-estado-destino").val(),
            "enderecoPaisDestino": $("#form-detalhes-viagem-pais-destino").val(),
            "enderecoComplementoDestino": "-" + $("#form-detalhes-viagem-rua-complemento-destino").val()
        };

        $http({
            method: 'POST',
            url: ctx + '/viagem.jsp?action=update&idViagem=' + $("#form-detalhes-viagem-id").val() + "&idCarga=" + $("#form-detalhes-viagem-carga-id").val(),
            data: $scope.viagem
        }).then(function successCallback(response) {
            if (response.data.resposta == "SUCCESS") {
                dataService.abrirModalAcao('viagem', 'atualizada');
                dataService.voltarMenuAdminViagem();
                $rootScope.getViagens();
            } else {
                alert(response.data);
            }

        }, function errorCallback(response) {
            console.log('Error');
        });
    };

    
    $scope.deleteViagem = function () {

        $http({
            method: 'POST',
            url: ctx + '/viagem.jsp?action=delete&idViagem=' + $("#form-detalhes-viagem-id").val() + '&idCarga=' + $("#form-detalhes-viagem-carga-id").val(),
            data: $scope.viagem
        }).then(function successCallback(response) {
            if (response.data.resposta == "SUCCESS") {
                dataService.abrirModalAcao('viagem', 'removida');
                dataService.voltarMenuAdminViagem();
                $rootScope.getViagens();
            } else {
                //alert("Ocorreu um erro ao remover a viagem, se persistirem os erros favor relatar ao suporte");
                alert(response.data);
            }

        }, function errorCallback(response) {
            console.log('Error');
        });
    };

});

app.controller("menuAdminEscalaController", function ($scope, dataService) {

});

