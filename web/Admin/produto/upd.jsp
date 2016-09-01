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
    upd.setFolderUpload("set");
    ProdutoDAO dao = new ProdutoDAO();
    Produto x = new Produto();
    if (request.getMethod().equals("get")) {
        x = dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("codigo")));

    }

    if (request.getMethod().equals("POST")) {

        if (upd.formProcess(getServletContext(), request)) {
            x = dao.buscarPorChavePrimaria(Integer.parseInt(upd.getForm().get("codigo").toString()));

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
            if (cont== 0 && dao.alterar(x)) {
                msg = "Alterado com sucesso";
                classe = "alert-success";
            } else {
                msg += "Não foi possivel alterar";
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
                <i class="fa fa-file"><a href="upd.jsp">Atualize a produto selecionada</a></i> 
            </li>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            Atualizar uma Produto
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>"><%=msg%></div>



            <form action="upd.jsp" method="post" enctype="multipart/form-data">

                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Codigo</label>
                        <input name="codigo" value="<%=x.getCodigo()%>" class="form-control" type="text" required readonly />
                        <label>Titulo</label>
                        <input name="titulo" value="<%=x.getTitulo()%>" class="form-control" type="text" required />
                        <label>Descrição</label>
                        <input name="descricao" value="<%=x.getDescricao()%>" class="form-control" type="text" required />
                        <label>Quantidade</label>
                        <input name="quant" value="<%=x.getQuant()%>" class="form-control" type="number" required />
                        <label>Preço</label>
                        <input name="preco" value="<%=x.getPreco()%>" class="form-control" type="number" required />
                        <label>Categoria</label>
                        <select class="form-control" name="codcategoria">
                            <option disabled selected="selected" value="<%=x.getCodcategoria().getCodigo()%>"><%=x.getCodcategoria().getNome()%></option>
                            <%for (Categoria item : clista) {%>
                            <option value="<%=item.getCodigo()%>"><%=item.getNome()%></option>
                            <%}%>
                        </select>
                        <label>Marca</label>
                        <select class="form-control" name="codmarca">
                            <option readonly selected="selected" value="<%=x.getCodmarca().getCodigo()%>"><%=x.getCodmarca().getNome()%></option>
                            <%for (Marca item : mlista) {%>
                            <option value="<%=item.getCodigo()%>"><%=item.getNome()%></option>
                            <%}%>
                        </select>
                        <label>Destaque</label>
                        <input name="destaque" type="checkbox" <%if (x.getDestaque()) {
                                out.print("checked");
                            }%> class="form-control" />
                        <div class="row">

                            <label>Imagem 1</label>
                            <input name="imagem1" class="form-control" type="file"/>
                            </br>
                            <img class="img-thumbnail center-block" <%if (x.getImagem1() != null) {%>src="../../fotos/<%=x.getImagem1()%><%}%>"/>


                        </div>

                        <div class="row">

                            <label>Imagem 2</label>
                            <input name="imagem2" class="form-control" type="file"/>
                            </br>

                            <img class="img-thumbnail center-block" <%if (x.getImagem2() != null) {%>src="../../fotos/<%=x.getImagem2()%><%}%>"/>

                        </div>
                        <div class="row">

                            <label>Imagem 3</label>
                            <input name="imagem3" class="form-control" type="file"/>
                            </br>
                            <img class="img-thumbnail center-block"  <%if (x.getImagem2() != null) {%>src="../../fotos/<%=x.getImagem3()%><%}%>"/>

                        </div>
                        </br>
                        <button class="btn btn-primary btn-sm" type="submit">Salvar</button>
                    </div>
                </div>
        </div>
        </form>
    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>