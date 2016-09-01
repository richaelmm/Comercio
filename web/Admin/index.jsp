<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="util.Criptografia"%>
<%@page import="modelo.Usuario"%>
<%@page import="dao.UsuarioDAO"%>
<%@page import="modelo.Categoria"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoriaDAO"%>
<%
    String msg = "Efetue Login";
    String classe = "alert-danger";
    UsuarioDAO dao = new UsuarioDAO();
    Criptografia cri = new Criptografia();
    if (request.getParameter("login") != null) {
        Usuario obj = dao.buscarPorChavePrimaria(request.getParameter("login"));
        if (obj != null) {
            if (cri.convertPasswordToMD5(request.getParameter("senha")).equals(obj.getSenha())) {
                msg = "Login efetuado com sucesso";
                classe = "alert-success";
            } else {
                msg = "Senha Errada";
                classe = "alert-danger";
            }
        } else {
            msg = "Conta não existente";
            classe = "alert-danger";
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comércio</title>
    </head>
    <body>
        <div class="row">
            <div class="panel panel-default">

                <div class="panel-body">

                    <div class="alert <%=classe%>">
                        <%=msg%>
                        <%
                            if (msg.equals("Login efetuado com sucesso")) {
                                response.sendRedirect("home/");
                            }
                        %>
                    </div>

                    <a  href="add.jsp" class="btn  btn-primary btn-sm fa fa-plus-square-o">Criar nova conta</a>

                </div>
            </div>
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="panel panel-default">
                <div class="panel-body">

                    <form action="#" method="post">

                        <div class="col-lg-6">

                            <div class="table-responsive">
                                <div class="form-group">
                                    <label>Login</label>
                                    <input class="form-control" type="text" name="login" required />
                                </div>
                                <div class="form-group">
                                    <label>Senha</label>
                                    <input class="form-control" type="password" name="senha" required />
                                </div>
                                <button class="btn btn-primary btn-sm" type="submit">Enviar</button>

                                </form>
                            </div>

                        </div>
                        </body>
                        </html>
