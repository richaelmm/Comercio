<%@page import="java.util.List"%>
<%@page import="modelo.Marca"%>
<%@page import="modelo.Categoria"%>
<%@page import="dao.CategoriaDAO"%>
<%@page import="dao.MarcaDAO"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="dao.ProdutoDAO"%>
<%@page import="modelo.Produto"%>
<%@page import="util.Upload"%>

<%@include file="../cabecalho.jsp" %>
<%

    String msg = "", classe = "";
    Integer cont = 0;
    CategoriaDAO cdao = new CategoriaDAO();
    MarcaDAO mdao = new MarcaDAO();
    List<Categoria> clista = cdao.listar();
    List<Marca> mlista = mdao.listar();
    Upload upd = new Upload();
    upd.setFolderUpload("fotos");

    if (request.getMethod().equals("POST")) {

        if (upd.formProcess(getServletContext(), request)) {

            Produto x = new Produto();
            ProdutoDAO dao = new ProdutoDAO();

            if (upd.getForm().get("titulo") != null && !upd.getForm().get("titulo").toString().trim().isEmpty()) {
                x.setTitulo((upd.getForm().get("titulo").toString()));
            }
            if (upd.getForm().get("descricao") != null && !upd.getForm().get("descricao").toString().trim().isEmpty()) {
                x.setDescricao((upd.getForm().get("descricao").toString()));
            }
            if (upd.getForm().get("quant") != null && !upd.getForm().get("quant").toString().trim().isEmpty()) {
                x.setQuant(Integer.parseInt(upd.getForm().get("quant").toString()));
            }
            if (upd.getForm().get("preco") != null && !upd.getForm().get("preco").toString().trim().isEmpty()) {
                x.setPreco(BigDecimal.valueOf(Double.parseDouble(upd.getForm().get("preco").toString())));
            }

            if (upd.getForm().get("codcategoria") != null && !upd.getForm().get("codcategoria").toString().trim().isEmpty()) {

                Categoria citem = cdao.buscarPorChavePrimaria(Integer.parseInt(upd.getForm().get("codcategoria").toString()));
                if (clista.contains(citem)) {
                    x.setCodcategoria(cdao.buscarPorChavePrimaria(Integer.parseInt((upd.getForm().get("codcategoria").toString()))));
                } else {
                    cont++;
                    msg += "Selecione uma categoria valida, ";
                    classe = "alert-danger";
                }

            } else {
                cont++;
                msg += "Selecione uma categoria valida, ";
                classe = "alert-danger";
            }

            if (upd.getForm().get("codmarca") != null && !upd.getForm().get("codmarca").toString().trim().isEmpty()) {

                Marca mitem = mdao.buscarPorChavePrimaria(Integer.parseInt(upd.getForm().get("codmarca").toString()));
                if (mlista.contains(mitem)) {
                    x.setCodmarca(mdao.buscarPorChavePrimaria(Integer.parseInt((upd.getForm().get("codmarca").toString()))));
                } else {
                    cont++;
                    msg += "Selecione uma Marca valida, ";
                    classe = "alert-danger";
                }
            } else {
                cont++;
                msg += "Selecione uma Marca valida, ";
                classe = "alert-danger";
            }
            if (upd.getForm().get("destaque") != null) {
                x.setDestaque(true);
            } else {
                x.setDestaque(false);
            }
            if (upd.getFiles().size() != 0 && upd.getFiles().get(0) != null && !upd.getFiles().get(0).toString().trim().isEmpty()) {
                x.setImagem1((upd.getFiles().get(0).toString()));
            }
            if (upd.getFiles().size() >= 2 && upd.getFiles().get(1) != null && !upd.getFiles().get(1).toString().trim().isEmpty()) {
                x.setImagem2((upd.getFiles().get(1).toString()));
            }
            if (upd.getFiles().size() >= 3 && upd.getFiles().get(2) != null && !upd.getFiles().get(2).toString().trim().isEmpty()) {
                x.setImagem3((upd.getFiles().get(2).toString()));
            }

            if (cont == 0 && dao.incluir(x)) {
                msg = "Incluido com sucesso";
                classe = "alert-success";
            } else {
                msg += "não foi possivel incluir";
                classe = "alert-danger";
            }
        }
    }


%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            Gerenciamento de Produtos

        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"><a href="index.jsp">Listagem de registros</a></i>
            </li>
            <li class="active">
                <i class="fa fa-file"><a href="add.jsp">Adicione uma nova produto</a></i> 
            </li>
        </ol>
    </div>
</div>
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            Adicionar uma Produto
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>"><%=msg%></div>

            <form action="add.jsp" method="post" enctype="multipart/form-data">

                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Titulo</label>
                        <input name="titulo" class="form-control" type="text" required />
                        <label>Descrição</label>
                        <input name="descricao" class="form-control" type="text" required />
                        <label>Quantidade</label>
                        <input name="quant" class="form-control" type="number" min="0" required />
                        <label>Preço</label>
                        <input name="preco" class="form-control" type="number" min="0" step="0.01" required />
                        <label>Categoria</label>
                        <select class="form-control" name="codcategoria">
                            <option></option>
                            <%for (Categoria item : clista) {%>
                            <option value="<%=item.getCodigo()%>"><%=item.getNome()%></option>
                            <%}%>
                        </select>
                        <label>Marca</label>
                        <select  class="form-control" name="codmarca">
                            <option></option>
                            <%for (Marca item : mlista) {%>
                            <option value="<%=item.getCodigo()%>"><%=item.getNome()%></option>
                            <%}%>
                        </select>
                        <label>Destaque</label>
                        <input name="destaque" type="checkbox" class="form-control"/>
                        <label>Imagem 1</label>
                        <input name="imagem1" class="form-control" type="file" required />
                        <label>Imagem 2</label>
                        <input name="imagem2" class="form-control" type="file" />
                        <label>Imagem 3</label>
                        <input name="imagem3" class="form-control" type="file" />
                    </div>
                    <button class="btn btn-primary btn-sm" type="submit">Enviar</button>
                </div>
            </form>
        </div>
    </div>
    <%@include file="../rodape.jsp" %>