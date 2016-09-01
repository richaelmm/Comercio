<%@page import="dao.MarcaDAO"%>
<%@page import="modelo.Marca"%>
<%@include file="../cabecalho.jsp" %>
<%

    
     String msg = "", classe = "";
    if (request.getParameter("nome") != null && !request.getParameter("nome").isEmpty()) {
       
        Marca x = new Marca();
        MarcaDAO dao = new MarcaDAO();
        x.setNome(request.getParameter("nome"));
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
            Gerenciamento de Marcas

        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"><a href="index.jsp">Listagem de registros</a></i>
            </li>
            <li class="active">
                <i class="fa fa-file"><a href="add.jsp">Adicione uma nova marca</a></i> 
            </li>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
           Adicionar uma nova Marca
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>"><%=msg%></div>


            <form action="add.jsp" method="post">

                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Nome</label>
                        <input name="nome" class="form-control" type="text" required />
                    </div>



                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>

            </form>

        </div>


    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>