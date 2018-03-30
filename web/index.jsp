<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Login</title>
        <link href="res/styles/styles.css" rel="stylesheet" type="text/css"/>        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    </head>
    <body>
        <nav class="navbar">
            <a class="navbar-brand" href="#">
                <img src="res/images/logo.png" width="60" height="30" alt="Logo SEMI">
            </a>
        </nav>
        <div class="main">
            <div class="wrapper">
                <div class="card card-login">
                    <div class="card-body">
                        <h5 class="card-title">Faça seu login</h5>
                        <form>
                            <div class="form-group">
                                <input type="email" class="form-control" id="form-login-email" placeholder="E-mail">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" id="form-login-senha" placeholder="Senha">
                            </div>
                            <div class="btn-login">
                                <button type="submit" class="btn" id="btn-login">Entrar</button>
                            </div>
                            <a><span>Esqueci minha senha</span></a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/jspf/footer.jspf"%>
    </body>
</html>
