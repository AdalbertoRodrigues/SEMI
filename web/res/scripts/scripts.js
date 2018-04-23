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
$('cep').mask('00000-000');
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
                    animacaoSaida = 'fadeOutRight';
                    animacaoEntrada = 'fadeInLeft';
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
                    animacaoSaida = 'fadeOutLeft';
                    animacaoEntrada = 'fadeInRight';
                } else if (ativa.hasClass('secao-admin-viagem') || ativa.hasClass('secao-admin-viagem-incluir') || ativa.hasClass('secao-admin-viagem-detalhes')) {
                    animacaoSaida = 'fadeOutRight';
                    animacaoEntrada = 'fadeInLeft';
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
                    animacaoSaida = 'fadeOutLeft';
                    animacaoEntrada = 'fadeInRight';
                } else {
                    animacaoSaida = 'fadeOutRight';
                    animacaoEntrada = 'fadeInLeft';
                }
                ativa.addClass('animated ' + animacaoSaida).one(eventoAnimacao, function () {
                    ativa.removeClass('animated ' + animacaoSaida + ' secao-ativa').hide();
                    $(".secao-admin-viagem").show().addClass('animated ' + animacaoEntrada + ' secao-ativa').one(eventoAnimacao, function () {
                        $(".secao-admin-viagem").removeClass('animated ' + animacaoEntrada);
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
});

app.controller("menuAdminUsuarioController", function ($scope, dataService, $document, $http) {
    eventoAnimacao = 'webkitAnimationEnd oanimationend msAnimationEnd animationend';
    $document.ready(function () {
        $scope.getUsuarios();
    });

    $scope.getUsuarios = function (pesquisarPor, filtrarPor) {
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
            $(".admin-exibicao-usuario").show();
            if ($scope.usuarios.length !== 0) {
                $("#form-admin-usuario-filtro").focus();
                $("#alerta-exibicao-usuario").hide();
            } else {
                $scope.erro_usuario = 'Nenhum usuário encontrado com o respectivo filtro!';
                $("#alerta-exibicao-usuario").show();
                $("#form-admin-usuario-filtro").focus();
                $(".admin-exibicao-filtro-usuario").show();
            }

        }, function errorCallback(response) {
            $scope.erro_usuario = 'Ocorreu um erro ao conectar com a base de dados dos usuários.<br> Atualize a página e, se o erro persistir, contate o suporte.';
            $(".loader-usuario").hide();
            $(".admin-exibicao-usuario").hide();
            $("#alerta-exibicao-usuario").show();
        });


    }

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
        $("#form-detalhes-usuario-nome").val(usuario.nome).trigger('input');
        $("#form-detalhes-usuario-cpf").val(usuario.cpf).trigger('input');
        $("#form-detalhes-usuario-cnh").val(usuario.cnh).trigger('input');
        $("#form-detalhes-usuario-senha").val(usuario.senha).trigger('input');
    };
});

app.controller("incluirUsuarioAdminController", function ($scope, dataService, $http) {
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
                alert(response.data);

            }, function errorCallback(response) {
                console.log('Error');
            });
        }
    };

});
app.controller("detalhesUsuarioAdminController", function ($scope, dataService) {
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
        alert('Aqui irá a função de requisição p/ update');
    };

    $scope.deleteUsuario = function () {
        alert('Aqui irá a função de requisição p/ deletar');
    };

});
app.controller("menuAdminVeiculoController", function ($scope, $http) {

    $http({
        method: 'GET',
        url: ctx + '/veiculo.jsp?action=select'
    }).then(function successCallback(response) {
        $scope.veiculos = response.data.veiculos;
        $(".loader-veiculo").hide();
        $(".admin-exibicao-veiculo").show();

    }, function errorCallback(response) {
        $(".loader-veiculo").hide();
        $("#alerta-exibicao-veiculo").show();
    });


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
        $("#form-detalhes-veiculo-eixos").val(veiculo.qtdEixos).trigger('input');
        $("#form-detalhes-veiculo-placa").val(veiculo.placa).trigger('input');
        $("#form-detalhes-veiculo-motorista").val(veiculo.motorista).trigger('input');


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
});
app.controller("incluirVeiculoAdminController", function ($scope, dataService) {
    $scope.voltarMenu = function () {
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
        alert('Aqui vai a função p/ inserir veiculo');
    };

});
app.controller("detalhesVeiculoAdminController", function ($scope, dataService) {
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
        $scope.detalhes_veiculo_eixos = $("#form-detalhes-veiculo-eixos").val();
        $scope.detalhes_veiculo_motorista = $("#form-detalhes-veiculo-motorista").val();

        if ($scope.detalhes_veiculo_modelo == '' || $scope.detalhes_veiculo_marca == '' || $scope.detalhes_veiculo_placa == '' || $scope.detalhes_veiculo_ano == '' || $scope.detalhes_veiculo_eixos == '' || $scope.placaValida == false || $scope.detalhes_veiculo_placa.length < 8) {
            $("#btn-admin-alterar-veiculo").addClass('btn-admin-alterar-usuario-disabled').removeClass('btn-admin-alterar-usuario').prop('disabled', true).css('cursor', 'not-allowed');
        } else {
            $("#btn-admin-alterar-veiculo").addClass('btn-admin-alterar-usuario').removeClass('btn-admin-alterar-usuario-disabled').prop('disabled', false).css('cursor', 'pointer');
        }
    };

    $scope.deleteVeiculo = function () {
        alert("Aqui vai a função p/ deletar veiculo");
    };

    $scope.updateVeiculo = function () {
        alert("Aqui vai a função p/ atualizar veiculo");
    };
});
app.controller("viagemAdminController", function ($scope) {
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
    $scope.mostrarDetalhesViagem = function () {
        ativa = $(".body-admin-menu").find(".secao-ativa");
        ativa.addClass('animated fadeOutLeft').one(eventoAnimacao, function () {
            ativa.removeClass('secao-ativa');
            ativa.removeClass('animated fadeOutLeft').hide();
            $(".secao-admin-viagem-detalhes").show().addClass('animated fadeInRight secao-ativa').one(eventoAnimacao, function () {
                $(".secao-admin-viagem-detalhes").removeClass('animated fadeInRight');
            });
        });
    };
});
app.controller("incluirViagemAdminController", function ($scope, dataService, $http) {
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

    $http({
        method: 'GET',
        url: ctx + '/marca.jsp?action=select'
    }).then(function successCallback(response) {
        $scope.marcas = response.data.marcas;

        for (i = 0; i < $scope.marcas.length; i++) {

            $("#form-incluir-veiculo-lista").append("<option value=" + $scope.marcas[i].nome + ">");
        }

    }, function errorCallback(response) {
        console.log('Error');
    });


});
app.controller("detalhesViagemAdminController", function ($scope, dataService, $http) {
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

    $http({
        method: 'GET',
        url: ctx + '/marca.jsp?action=select'
    }).then(function successCallback(response) {
        $scope.marcas = response.data.marcas;

        for (i = 0; i < $scope.marcas.length; i++) {

            $("#form-detalhes-veiculo-lista").append("<option value=" + $scope.marcas[i].nome + ">");
        }

    }, function errorCallback(response) {
        console.log('Error');
    });
});

