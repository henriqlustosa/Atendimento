<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="pedidospendentes.aspx.cs" Inherits="encaminhamento_pedidospendentes" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <link href="../build/css/jquery.dataTable.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <h3>
                <asp:Label ID="lbTitulo" runat="server" Text="Pedidos de Consultas Pendentes"></asp:Label></h3>
            
           
           <asp:GridView ID="GridView1" runat="server"  AutoGenerateColumns="False"
                 DataKeyNames="cod_pedido" OnRowCommand="grdMain_RowCommand"
                CellPadding="4" ForeColor="#333333" GridLines="Horizontal" BorderColor="#e0ddd1" Width="100%" >
                <RowStyle BackColor="#f7f6f3" ForeColor="#333333" />
                <Columns>
                    <asp:BoundField DataField="cod_pedido" HeaderText="Código do Pedido" SortExpression="cod_pedido"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                    <asp:BoundField DataField="prontuario" HeaderText="Prontuário" SortExpression="prontuario"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />    
                    <asp:BoundField DataField="nome_paciente" HeaderText="Paciente" SortExpression="nome_paciente" ItemStyle-CssClass="hidden-md"
                        HeaderStyle-CssClass="hidden-md" />
                    <asp:BoundField DataField="data_pedido" HeaderText="Data Pedido" SortExpression="data_pedido"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                    <asp:BoundField DataField="data_cadastro" HeaderText="Data Cadastro" SortExpression="data_cadastro"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                    <asp:BoundField DataField="descricao_espec" HeaderText="Especialidade" SortExpression="descricao_espec"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                    <asp:BoundField DataField="exames_solicitados" HeaderText="Exames Solicitados" SortExpression="exames_solicitados"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                    <asp:BoundField DataField="outras_informacoes" HeaderText="Outras Informações" SortExpression="outras_informacoes"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                    <asp:BoundField DataField="solicitante" HeaderText="Solicitante" SortExpression="solicitante"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                    
                    
                    <asp:TemplateField HeaderStyle-CssClass="sorting_disabled">
                        <ItemTemplate>
                            <div class="form-inline">
                                <asp:LinkButton ID="gvlnkEdit" CommandName="editRecord" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                    CssClass="btn btn-info" runat="server">
                                    <i class="fa fa-pencil-square-o" title="Informação"></i> 
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#ffffff" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#999999" />
            </asp:GridView>
    
 
   
  <script src='<%= ResolveUrl("~/vendors/jquery/dist/jquery.js") %>' type="text/javascript"></script>
  
  <script src='<%= ResolveUrl("~/build/js/jquery.dataTables.js") %>' type="text/javascript"></script>
  

        <script type="text/javascript">
            $(document).ready(function() {
                $.noConflict();

                $('#<%= GridView1.ClientID %>').prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
                    language: {
                        search: "<i class='fa fa-search' aria-hidden='true'></i>",
                        processing: "Processando...",
                        lengthMenu: "Mostrando _MENU_ registros por páginas",
                        info: "Mostrando página _PAGE_ de _PAGES_",
                        infoEmpty: "Nenhum registro encontrado",
                        infoFiltered: "(filtrado de _MAX_ registros no total)"
                    }
                });

            });
         </script>
</asp:Content>

