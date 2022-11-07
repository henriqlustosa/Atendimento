<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CadastraStatusLigacao.aspx.cs" Inherits="Restrito_CadastraStatusLigacao"
    Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="x_title">
        <h2>
            Cadastro<small>Status de ligações</small></h2>
        <div class="clearfix">
        </div>
    </div>
    <div class="x_content">
     <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
        <!-- start form for validation -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div id="demo-form" class="col-sm-4" data-parsley-validate>
                    <label for="descricaoStatus">
                        Descrição * :</label>
                    <input type="text" id="descricaoStatus" class="form-control" name="descricaoStatus"
                        required />
                    <label style="padding-top: 20px;">
                        Tentativa de Ligação? *:</label>
                    <p>
                        Sim:<input type="radio" class="flat" name="tenta" id="tentaS" value="S" checked=""
                            required />
                        Não:
                        <input type="radio" class="flat" name="tenta" id="tentaN" value="N" />
                    </p>
                    <label style="padding-top: 10px;">
                        Ativo? *:</label>
                    <p>
                        Sim:<input type="radio" class="flat" name="ativo" id="ativoS" value="S" checked=""
                            required />
                        Não:
                        <input type="radio" class="flat" name="ativo" id="ativoN" value="N" />
                    </p>
                    <br />
                    <asp:Button ID="btnCadastrar" class="btn btn-primary" runat="server" Text="Cadastrar"
                        OnClick="btnCadastrar_Click" />
                </div>
                <!-- end form for validations -->
                <table class="table table-striped jambo_table bulk_action">
                    <asp:Repeater ID="rpt" runat="server">
                        <HeaderTemplate>
                            <thead>
                                <tr>
                                    <th>
                                        ID
                                    </th>
                                    <th>
                                        DESCRIÇÃO
                                    </th>
                                    <th>
                                        TENTATIVA
                                    </th>
                                    <th>
                                        ATIVO
                                    </th>
                                </tr>
                            </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <%# Eval("Id_status")%>
                                </td>
                                <td>
                                    <%# Eval("Descricao")%>
                                </td>
                                <td>
                                    <%# Eval("Tentativa")%>
                                </td>
                                <td>
                                    <%# Eval("Ativo")%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        
        <!-- Modal -->
       
        
        <div class="modal fade" id="modalMsg" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Mensagem</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                  <asp:Label ID="lbMensagem" runat="server" Text=""></asp:Label>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
              </div>
            </div>
          </div>
        </div>
        </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
