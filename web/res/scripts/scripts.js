//Declarando o app
var app = angular.module("semi", [], function ($locationProvider) {
    $locationProvider.html5Mode({
        enabled: true,
        requireBase: false
    });
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
            //Retorna o context path
            return url_local;
        },
        voltarMenuAdminUsuario: function () {
            ativa = $(".body-admin-menu").find(".secao-ativa");
            if (ativa.hasClass('secao-admin-usuario') || ativa.hasClass('secao-admin-usuario-incluir') || ativa.hasClass('secao-admin-usuario-detalhes')) {
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

        },
        voltarMenuAdminVeiculo: function () {
            ativa = $(".body-admin-menu").find(".secao-ativa");
            if (ativa.hasClass('secao-admin-veiculo') || ativa.hasClass('secao-admin-veiculo-incluir') || ativa.hasClass('secao-admin-veiculo-detalhes')) {
                animacaoEntrada = 'fadeInLeft';
                animacaoSaida = 'fadeOutRight';
            } else if (ativa.hasClass('secao-admin-usuario') || ativa.hasClass('secao-admin-usuario-incluir') || ativa.hasClass('secao-usuario-veiculo-detalhes')){
                animacaoSaida = 'fadeOutLeft';
                animacaoEntrada = 'fadeInRight';
            }
            ativa.addClass('animated ' + animacaoSaida).one(eventoAnimacao, function () {
                ativa.removeClass('animated '+ animacaoSaida +' secao-ativa').hide();
                $(".secao-admin-veiculo").show().addClass('animated '+ animacaoEntrada +' secao-ativa').one(eventoAnimacao, function () {
                    $(".secao-admin-veiculo").removeClass('animated ' + animacaoEntrada);
                });
            });
        },
        voltarMenuAdminViagem: function () {
            ativa = $(".body-admin-menu").find(".secao-ativa");
            ativa.addClass('animated fadeOutLeft').one(eventoAnimacao, function () {
                ativa.removeClass('animated fadeOutLeft secao-ativa').hide();
                $(".secao-admin-viagem").show().addClass('animated fadeInRight secao-ativa').one(eventoAnimacao, function () {
                    $(".secao-admin-viagem").removeClass('animated fadeInRight');
                });
            });
        }
    };
});

//Controller da tela de login
app.controller("loginController", function ($scope, dataService, $timeout) {
    //Chamando o serviço e retornando a URL local
    console.log(dataService.getUrl_local());
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

app.controller("menuAdminUsuarioController", function ($scope) {
    eventoAnimacao = 'webkitAnimationEnd oanimationend msAnimationEnd animationend';

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
    $scope.mostrarDetalhesUsuario = function () {
        ativa = $(".body-admin-menu").find(".secao-ativa");

        ativa.addClass('animated fadeOutLeft').one(eventoAnimacao, function () {
            ativa.removeClass('secao-ativa');
            ativa.removeClass('animated fadeOutLeft').hide();

            $(".secao-admin-usuario-detalhes").show().addClass('animated fadeInRight secao-ativa').one(eventoAnimacao, function () {
                $(".secao-admin-usuario-detalhes").removeClass('animated fadeInRight');
            });
        });
    };
});

app.controller("incluirUsuarioAdminController", function ($scope, dataService) {
    //Chama o dataService e executa a função de voltar para o menu
    $scope.voltarMenu = function () {
        dataService.voltarMenuAdminUsuario();
    };

    //Alterna o tipo de usuário, fazendo ou não aparecer o form do MOPP
    $(".btn-admin-incluir-usuario-tipo").click(function () {
        $(this).addClass('btn-admin-tipo-active');
        $(".row-admin-tipo").children().not($(this)).removeClass('btn-admin-tipo-active');

        if ($("#btn-tipo-funcionario").hasClass("btn-admin-tipo-active")) {
            $(".form-motorista").fadeOut();
        } else {
            $(".form-motorista").fadeIn();
        }
    });
});

app.controller("detalhesUsuarioAdminController", function ($scope, dataService) {
    $scope.voltarMenu = function () {
        dataService.voltarMenuAdminUsuario();
    };
});

app.controller("menuAdminVeiculoController", function ($scope) {
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

    $scope.mostrarDetalhesVeiculo = function () {
        ativa = $(".body-admin-menu").find(".secao-ativa");

        ativa.addClass('animated fadeOutLeft').one(eventoAnimacao, function () {
            ativa.removeClass('secao-ativa');
            ativa.removeClass('animated fadeOutLeft').hide();
            $(".secao-admin-veiculo-detalhes").show().addClass('animated fadeInRight secao-ativa').one(eventoAnimacao, function () {
                $(".secao-admin-veiculo-detalhes").removeClass('animated fadeInRight');
            });
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
});

app.controller("incluirVeiculoAdminController", function ($scope, dataService) {
    $scope.voltarMenu = function () {
        dataService.voltarMenuAdminVeiculo();
    };
});

app.controller("detalhesVeiculoAdminController", function ($scope, dataService) {
    $scope.voltarMenu = function () {
        dataService.voltarMenuAdminVeiculo();
    };
});