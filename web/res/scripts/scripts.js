//Declarando o app
var app = angular.module("semi", [], function ($locationProvider) {
    $locationProvider.html5Mode({
        enabled: true,
        requireBase: false
    });
});

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
    $scope.mostrarRecuperarSenha = function () {
        $(".card-body-login").fadeTo(400, 0, function () {
            $(".card-body-login").hide();
            $(".card-body-senha").fadeTo(400, 1);
        });
    };

    $scope.mostrarLogin = function () {
        $(".card-body-senha").fadeTo(400, 0, function () {
            $(".card-body-senha").hide();
            $(".card-body-login").fadeTo(400, 1);
        });
    };

    $scope.recuperarSenha = function () {
        $(".card-body-senha").fadeTo(300, 0, function () {
            $(".card-body-senha").hide();
            $(".loader").fadeTo(300,1);
            $timeout(function () {
                $(".loader").fadeTo(300, 0, function() {
                    $(".loader").css('display','none');
                    $(".msg-senha-enviada").fadeTo(300, 1);
                    $timeout(function() {
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