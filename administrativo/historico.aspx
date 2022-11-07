<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="historico.aspx.cs" Inherits="Paciente_historico" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
    <div class="x_title">
        <h2>
            Histórico de Ativos Atendimento HSPM</h2>
        <div class="clearfix">
        </div>
    </div>
        <div id="demo-form2" data-parsley-validate class="form-horizontal form-label-left input_mask">
            <div class="row">
                <div class="form-group">
                    <asp:Label ID="Msg" runat="server" ForeColor="maroon" class="control-label col-md-12" /><br />
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <label class="control-label col-md-4" for="UsernameTextBox">
                        Prontuário: <span class="required">*</span>
                    </label>
                    <div class="col-md-8">
                        <asp:TextBox ID="txbProntuario" class="form-control" runat="server" AutoPostBack="true" />
                        <asp:RequiredFieldValidator ID="UsernameRequiredValidator" runat="server" ControlToValidate="txbProntuario"
                            ForeColor="red" Display="Static" ErrorMessage="Required" /><br />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-4 col-sm-4 col-xs-8 ">
                        <asp:Button ID="SearchButton" Text="Pesquisar" runat="server" Enabled="true" class="btn btn-primary"
                            OnClick="SearchHistorico_OnClick" />
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-6 col-sm-12 col-xs-12 form-group">
                            <label>
                                Nome</label>
                            <asp:TextBox ID="txbNomePaciente" runat="server" class="form-control" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
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
                </div>
            </div>
            <hr />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="false" AutoGenerateColumns="False"
                        DataKeyNames="Id_consulta" CellPadding="4" ForeColor="#333333" GridLines="None"
                        Width="100%">
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <Columns>
                            <asp:BoundField DataField="Id_consulta" HeaderText="ID CONSULTA" SortExpression="Id_consulta"
                                ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                            <asp:BoundField DataField="Codigo_Consulta" HeaderText="Consulta" SortExpression="Codigo_Consulta"
                                ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                            <asp:BoundField DataField="Dt_Consulta" HeaderText="DATA DA CONSULTA" SortExpression="Dt_consulta"
                                ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                            <asp:BoundField DataField="Grade" HeaderText="Grade" SortExpression="Grade" ItemStyle-CssClass="hidden-xs"
                                HeaderStyle-CssClass="hidden-xs" />
                            <asp:BoundField DataField="Equipe" HeaderText="Equipe" SortExpression="Equipe" ItemStyle-CssClass="hidden-xs"
                                HeaderStyle-CssClass="hidden-xs" />
                            <asp:BoundField DataField="Nome_Profissional" HeaderText="Profissional" SortExpression="Nome_Profissional"
                                ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                            <asp:BoundField DataField="Status" HeaderText="Status Ligação" SortExpression="Status"
                                ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                            <asp:BoundField DataField="Observacao" HeaderText="Observação" SortExpression="Observacao"
                                ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                            <asp:BoundField DataField="Data_Contato" HeaderText="Data de Contato" SortExpression="Data_Contato"
                                ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                            <asp:BoundField DataField="Usuario_Contato" HeaderText="Usuario Contato" SortExpression="Usuario_Contato"
                                ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                            <asp:BoundField DataField="DescricaoRemarcar" HeaderText="Informação Complementar"
                                SortExpression="DescricaoRemarcar" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        </Columns>
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <EditRowStyle BackColor="#999999" />
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
</asp:Content>