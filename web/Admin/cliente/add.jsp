<%@page import="dao.ClienteDAO"%>
<%@page import="modelo.Cliente"%>
<%@page import="util.Criptografia"%>
<%@include file="../cabecalho.jsp" %>
<%

    String msg = "", classe = "";
    Integer cont = 0;
    if (request.getParameter("nome") != null && !request.getParameter("nome").isEmpty()) {

        Cliente x = new Cliente();
        ClienteDAO dao = new ClienteDAO();
        x.setNome(request.getParameter("nome"));
        x.setEmail(request.getParameter("email"));
        x.setSenha(Criptografia.convertPasswordToMD5(request.getParameter("senha")));
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


        if (cont == 0 && dao.incluir(x)) {
            msg = "Incluido com sucesso";
            classe = "alert-success";
        } else {
            msg+= "Não foi possivel incluir";
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
                <i class="fa fa-file"><a href="add.jsp">Adicione um novo cliente</a></i> 
            </li>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            Adicionar um Cliente
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>"><%=msg%></div>


            <form action="add.jsp" method="post">

                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Nome</label>
                        <input name="nome" class="form-control" type="text" required />
                        <label>Email</label>
                        <input name="email" class="form-control" type="email" required />
                        <label>Senha</label>
                        <input name="senha" class="form-control" type="text" required />
                        <label>Endereço</label>
                        <input name="endereco" class="form-control" type="text" required />
                        <label>Bairro</label>
                        <input name="bairro" class="form-control" type="text" required />
                        <label>Cidade</label>
                        <input name="cidade" class="form-control" type="text" required />
                        <label>Estado</label>
                        <input name="estado" class="form-control" type="text" required minlength="2" maxlength="2" />
                        <label>Cep</label>
                        <input name="cep" class="form-control" type="text" minlength="9" maxlength="9" required />

                    </div>



                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>

            </form>

        </div>


    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>