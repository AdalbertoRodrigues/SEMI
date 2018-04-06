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

//Botoões de Motorista/Funcionário na aba Incluir




//Serviço que pode ser chamado em qualquer controller
app.service('dataService', function ($location) {
    var url_local = $location.path();

    return {
        getUrl_local: function () {
            //Retorna o context path
            return url_local;
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

app.controller("menuAdminController", function ($scope, dataService, $timeout) {
    eventoAnimacao = 'webkitAnimationEnd oanimationend msAnimationEnd animationend';
    $scope.mostrarIncluirUsuario = function () {
        ativa = $(".body-admin-menu").find(".secao-ativa");

        ativa.addClass('animated fadeOutRight').one(eventoAnimacao, function () {
            ativa.removeClass('secao-ativa');
            ativa.removeClass('animated fadeOutRight').hide();
            $(".secao-admin-usuario-incluir").show().addClass('animated fadeInLeft secao-ativa').one(eventoAnimacao, function () {
                $(".secao-admin-usuario-incluir").removeClass('animated fadeInLeft');
            });
        });
    };
});

app.controller("incluirUsuarioAdminController", function ($scope, dataService, $timeout) {
    $scope.voltarMenu = function () {
        ativa = $(".body-admin-menu").find(".secao-ativa");
        ativa.addClass('animated fadeOutLeft').one(eventoAnimacao, function () {
            ativa.removeClass('animated fadeOutLeft secao-ativa').hide();
            $(".secao-admin-usuario").show().addClass('animated fadeInRight secao-ativa').one(eventoAnimacao, function () {
                $(".secao-admin-usuario").removeClass('animated fadeInRight');
            });
        });
    };

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