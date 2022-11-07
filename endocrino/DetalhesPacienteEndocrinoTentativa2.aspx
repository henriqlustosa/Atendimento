<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="DetalhesPacienteEndocrinoTentativa2.aspx.cs" Inherits="endocrino_DetalhesPacienteEndocrinoTentativa2" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
    <div class="x_title">
        <h2>
            Informações do Paciente
            <asp:Label ID="lbProntuario" runat="server" Text="" Style="color: Black"></asp:Label></h2>
        <div class="clearfix">
        </div>
    </div>
    <!-- page content -->
    <div class="x_content">
        <div class="row">
            <div class="col-md-6 col-sm-12 col-xs-12 form-group">
                <label>
                    Nome</label>
                <asp:TextBox ID="txbNomePaciente" runat="server" class="form-control" Enabled="false"></asp:TextBox>
            </div>
            
        </div>
        
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
        <div class="row">
            <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                <label>
                    Telefone 1</label>
                <asp:TextBox ID="txbTelefone1" runat="server" class="form-control"></asp:TextBox>
            </div>
            <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                <label>
                    Telefone 2</label>
                <asp:TextBox ID="txbTelefone2" runat="server" class="form-control"></asp:TextBox>
            </div>
            <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                <label>
                    Telefone 3</label>
                <asp:TextBox ID="txbTelefone3" runat="server" class="form-control"></asp:TextBox>
            </div>
            <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                <label>
                    Telefone 4</label>
                <asp:TextBox ID="txbTelefone4" runat="server" class="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="row">
                    <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                        <asp:Button ID="btnAtualizaTelefones" class="btn btn-primary" runat="server" Text="Atualizar Telefones"
                            OnClick="btnAtualizaTelefones_Click" />
                    </div>
                </div>
                </ContentTemplate>
        </asp:UpdatePanel>
        
          <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        <div class="x_title">
            <h2>
                Tentativas de Contato</h2>
            <div class="clearfix">
            </div>
            
            <!-- Adicionar grid com as tentaticas de ligações -->
            
        </div>
       
        
        <div class="x_title" style="margin-top: 25px">
            <h2>
                Consultas Marcadas</h2>
            <div class="clearfix">
            </div>
        </div>
      
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataKeyNames="Id_consulta" CellPadding="4" ForeColor="#333333" GridLines="None"
                    OnRowCommand="grdMain_RowCommand" Width="100%">
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <Columns>
                    <asp:BoundField DataField="Id_ativo" HeaderText="ID ATIVO" SortExpression="Id_ativo"
                            ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        <asp:BoundField DataField="Id_consulta" HeaderText="ID CONSULTA" SortExpression="Id_consulta"
                            ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        <asp:BoundField DataField="Prontuario" HeaderText="PRONTUÁRIO/RH" SortExpression="Prontuario"
                            HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Dt_consulta" HeaderText="DATA DA CONSULTA" SortExpression="Dt_consulta"
                            ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        <asp:BoundField DataField="Grade" HeaderText="GRADE" SortExpression="Grade" ItemStyle-CssClass="hidden-xs"
                            HeaderStyle-CssClass="hidden-xs" />
                        <asp:BoundField DataField="Equipe" HeaderText="EQUIPE" SortExpression="Equipe" ItemStyle-CssClass="hidden-xs"
                            HeaderStyle-CssClass="hidden-xs" />
                        <asp:BoundField DataField="Nome_Profissional" HeaderText="PROFISSIONAL" SortExpression="Nome_Profissional"
                            ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        <asp:BoundField DataField="Codigo_Consulta" HeaderText="Código Consulta" SortExpression="Codigo_Consulta"
                            ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        <asp:TemplateField HeaderStyle-CssClass="sorting_disabled">
                            <ItemTemplate>
                                <div class="form-inline">
                                    <asp:LinkButton ID="gvlnkEdit" CommandName="editRecord" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                        CssClass="btn btn-info" runat="server">
                                    <i class="fa fa-edit" title="Detalhar"></i> 
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerSettings FirstPageText="First" LastPageText="Last" PageButtonCount="10" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#999999" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:GridView>
                <!-- Large modal -->
                <div class="modal fade bs-example-modal-lg" id="editModal" tabindex="-1" role="dialog"
                    aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title" id="myModalLabel">
                                    Detalhes da Consulta</h4>
                                <button type="button" class="close" data-dismiss="modal">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="container">
                                    <div class="modal-body">
                                    <div class="form-group row">
                                            <label class="col-sm-2 col-form-label">
                                                ID Ativo:</label>
                                            <div class="col-sm-10">
                                                <asp:Label ID="txbIDAtivo" runat="server" Text=""></asp:Label>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 col-form-label">
                                                ID Consulta:</label>
                                            <div class="col-sm-10">
                                                <asp:Label ID="txbIDConsulta" runat="server" Text=""></asp:Label>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="txbNomePacienteModal" class="col-sm-2 col-form-label">
                                                Nome Paciente:</label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txbNomePacienteModal" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                                            </div>
                                            
                                        </div>
                                        <div class="form-group row">
                                            <label for="txbdtConsulta" class="col-sm-3 col-form-label">
                                                Data da Consulta:</label>
                                            <div class="col-sm-4">
                                                <asp:TextBox ID="txbdtConsulta" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                                            </div>
                                            <label for="txbCodConsulta" class="col-sm-3 col-form-label">
                                                Código da Consulta:</label>
                                            <div class="col-sm-2">
                                                <asp:TextBox ID="txbCodConsulta" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="txbEquipe" class="col-sm-2 col-form-label">
                                                Equipe:</label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txbEquipe" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="txbProfissional" class="col-sm-2 col-form-label">
                                                Profissional:</label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txbProfissional" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <asp:Label ID="Label1" for="txbObservacao" runat="server" Text="Observação:"></asp:Label>
                                            <asp:TextBox ID="txbObservacao" runat="server" class="form-control" TextMode="MultiLine"
                                                Rows="4"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <asp:Label ID="Label2" for="ddlStatus" runat="server" Text="Status:"></asp:Label>
                                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control col-4" 
                                                DataSourceID="SqlDataSource1" DataTextField="status" 
                                                DataValueField="id_status" >
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:gtaConnectionString %>" 
                                                SelectCommand="SELECT [id_status], [status] FROM [status_consulta] WHERE ativo = 'S'">
                                            </asp:SqlDataSource>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="Button1" runat="server" Text="Gravar" class="btn btn-primary" onclick="btnGravar_Click"  />
                                
                                <button type="button" class="btn btn-secondary" data-dismiss="modal" >
                                    Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- fim modal large -->
            </ContentTemplate>
        </asp:UpdatePanel>
        <hr />
        <div class="x_content">
            <asp:Button ID="Button2" runat="server" Text="Lista 2ª Tentativa" class="btn btn-warning" onclick="btnVoltar2_Click" />
        </div>
    </div>
    <!-- /page content -->
</asp:Content>

