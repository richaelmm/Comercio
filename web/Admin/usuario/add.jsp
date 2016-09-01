<%@page import="dao.UsuarioDAO"%>
<%@page import="modelo.Usuario"%>
<%@include file="../cabecalho.jsp" %>
<%

    String msg = "", classe = "";
    if (request.getParameter("login") != null && !request.getParameter("login").isEmpty()) {

        Usuario x = new Usuario();
        UsuarioDAO dao = new UsuarioDAO();
        x.setLogin(request.getParameter("login"));
        x.setSenha(request.getParameter("senha"));
        if (request.getParameter("admin") != null) {
            x.setAdmin(true);
        } else {
            x.setAdmin(false);
        }
        if (dao.incluir(x)) {
            msg = "Incluido com sucesso";
            classe = "alert-success";
        } else {
            msg = "Não foi possivel incluir";
            classe = "alert-danger";
        }

    }

%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            Gerenciamento de Usuarios

        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"><a href="index.jsp">Listagem de registros</a></i>
            </li>
            <li class="active">
                <i class="fa fa-file"><a href="add.jsp">Adicione uma nova usuario</a></i> 
            </li>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            Adicionar uma nova Usuario
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>"><%=msg%></div>


            <form action="add.jsp" method="post">

                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Login</label>
                        <input name="login" class="form-control" type="text" required />
                        <label>Senha</label>
                        <input name="senha" class="form-control" type="password" required />
                        <label>Admin</label>
                        <input name="admin" class="form-control" type="checkbox"/>
                    </div>



                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>

            </form>

        </div>


    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>