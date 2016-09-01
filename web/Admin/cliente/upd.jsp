<%@page import="modelo.Cliente"%>
<%@page import="dao.ClienteDAO"%>
<%@include file="../cabecalho.jsp" %>
<%

    if (request.getParameter("codigo") == null || request.getParameter("codigo").isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    }
    Integer cont = 0;
    String msg = "", classe = "";
    ClienteDAO dao = new ClienteDAO();
    Cliente x = dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("codigo")));

    if ((request.getParameter("nome") != null) && (!request.getParameter("nome").isEmpty())) {

        x.setNome(request.getParameter("nome"));
        x.setEmail(request.getParameter("email"));
        x.setEndereco(request.getParameter("endereco"));
        x.setBairro(request.getParameter("bairro"));
        x.setCidade(request.getParameter("cidade"));
        if (request.getParameter("estado").length() != 2) {
            cont++;
            msg+= "Estado inválido, ";
        } else {
            x.setEstado(request.getParameter("estado"));
        }

        if (request.getParameter("cep").length() != 9) {
            cont++;
            msg+= "Cep inválido, ";
        } else {
            x.setCep(request.getParameter("cep"));
        }

        if (cont == 0 && dao.alterar(x)) {
            msg = "Alterado com sucesso";
            classe = "alert-success";
        } else {
            msg += "Não foi possivel alterar";
            classe = "alert-danger";
        }

    }


%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            Gerenciamento de Clientes

        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"><a href="index.jsp">Listagem de registros</a></i>
            </li>
            <li class="active">
                <i class="fa fa-file"><a href="upd.jsp">Atualize o cliente selecionada</a></i> 
            </li>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            Atualizar um Cliente
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>"><%=msg%></div>

            <form action="upd.jsp" method="post">

                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Código</label>
                        <input name="codigo" value="<%=request.getParameter("codigo")%>" class="form-control" type="text" readonly />
                        <label>Nome</label>
                        <input name="nome" value="<%=x.getNome()%>" class="form-control" type="text" required />
                        <label>Email</label>
                        <input name="email" value="<%=x.getEmail()%>" class="form-control" type="email" required />
                        <label>Senha</label>
                        <input readonly type="text" value="NÃO É POSSIVEL ALTERAR A SENHA" class="form-control">
                        <label>Endereço</label>
                        <input name="endereco" class="form-control" value="<%=x.getEndereco()%>" type="text" required />
                        <label>Bairro</label>
                        <input name="bairro" class="form-control" value="<%=x.getBairro()%>" type="text" required />
                        <label>Cidade</label>
                        <input name="cidade" class="form-control" value="<%=x.getCidade()%>" type="text" required />
                        <label>Estado</label>
                        <input name="estado" class="form-control" type="text" value="<%=x.getEstado()%>" required minlength="2" maxlength="2" />
                        <label>Cep</label>
                        <input name="cep" class="form-control" type="text" value="<%=x.getCep()%>" minlength="9" maxlength="9" required />
                    </div>





                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>

            </form>

        </div>


    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>