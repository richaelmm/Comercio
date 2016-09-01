<%@page import="modelo.Marca"%>
<%@page import="dao.MarcaDAO"%>
<%@include file="../cabecalho.jsp" %>
<%

    if (request.getParameter("codigo") == null || request.getParameter("codigo").isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    }
    String msg = "", classe = "";
    MarcaDAO dao = new MarcaDAO();
    Marca x = dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("codigo")));

    if ((request.getParameter("nome") != null) && (!request.getParameter("nome").isEmpty())) {

        x.setNome(request.getParameter("nome"));
        if (dao.alterar(x)) {
            msg = "Alterado com sucesso";
            classe = "alert-success";
        } else {
            msg = "N�o foi possivel alterar";
            classe = "alert-danger";
        }

    }


%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            Gerenciamento de Marcas

        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"><a href="index.jsp">Listagem de registros</a></i>
            </li>
            <li class="active">
                <i class="fa fa-file"><a href="upd.jsp">Atualize a marca selecionada</a></i> 
            </li>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            Atualizar a Marca
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>"><%=msg%></div>

            <form action="upd.jsp" method="post">

                <div class="col-lg-6">

                    <div class="form-group">
                        <label>C�digo</label>
                        <input name="codigo" value="<%=request.getParameter("codigo")%>" class="form-control" type="text" readonly />
                    </div>

                    <div class="form-group">
                        <label>Nome</label>
                        <input name="nome" class="form-control" value="<%=x.getNome()%>" type="text" required />
                    </div>



                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>

            </form>

        </div>


    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>