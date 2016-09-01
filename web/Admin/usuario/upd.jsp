<%@page import="modelo.Usuario"%>
<%@page import="dao.UsuarioDAO"%>
<%@include file="../cabecalho.jsp" %>
<%

    if (request.getParameter("login") == null || request.getParameter("login").isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    }
    String msg = "", classe = "";
    UsuarioDAO dao = new UsuarioDAO();
    Usuario x = dao.buscarPorChavePrimaria(request.getParameter("login"));

    if (request.getMethod().equals("POST")) {

        x.setLogin(request.getParameter("login"));
        x.setSenha(request.getParameter("senha"));
        if(request.getParameter("admin") != null){
            x.setAdmin(true);
        }else{
            x.setAdmin(false);
        }
        
        
        if (dao.alterar(x)) {
            msg = "Alterado com sucesso";
            classe = "alert-success";
        } else {
            msg = "Não foi possivel alterar";
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
                <i class="fa fa-file"><a href="upd.jsp">Atualize a usuario selecionada</a></i> 
            </li>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            Atualizar a Usuario
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>"><%=msg%></div>

            <form action="upd.jsp" method="post">

                <div class="col-lg-6">

                    <label>Login</label>
                    <input name="login" value="<%=x.getLogin()%>" class="form-control" type="text" required />
                    <label>Senha</label>
                    <input name="senha" value="<%=x.getSenha()%>" class="form-control" type="password" required />
                    <label>Admin</label>
                    <input name="admin" <%if (x.getAdmin()) {
                            out.print("checked");
                        }%> class="form-control" type="checkbox"/>



                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>

            </form>

        </div>


    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>