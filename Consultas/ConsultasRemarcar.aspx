<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ConsultasRemarcar.aspx.cs" Inherits="publico_ConsultasRemarcar" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

  
    <link href="../build/css/jquery.dataTable.css" rel="stylesheet" type="text/css" />
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
            <h3>
                <asp:Label ID="lbTitulo" runat="server" Text="CONSULTAS PARA CANCELAR/REMARCAR"></asp:Label></h3>
            <div class="x_content">
                <div class="row">
                    <div class="col-md-2 col-sm-6  form-group">
                        <label>
                            Status de Ligação <span class="required">*</span></label>
                        <asp:DropDownList ID="ddlStatus" class="form-control" runat="server" 
                            AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="status" 
                            DataValueField="id_status">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:gtaConnectionString %>" 
                            SelectCommand="SELECT [id_status], [status] FROM [status_consulta] WHERE [id_status] IN (2,3,4,7,8) ">
                        </asp:SqlDataSource>
                        
                    </div>
                   
                </div>
            </div>
           
           <asp:GridView ID="GridView1" runat="server"  AutoGenerateColumns="False"
                 DataKeyNames="Id_consulta" OnRowCommand="grdMain_RowCommand"
                CellPadding="4" ForeColor="#333333" GridLines="Horizontal" BorderColor="#e0ddd1" Width="100%" OnPreRender="GridView1_PreRender" >
                <RowStyle BackColor="#f7f6f3" ForeColor="#333333" />
                <Columns>
                    <asp:BoundField DataField="Id_consulta" HeaderText="ID CONSULTA" SortExpression="Id_consulta"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                    <asp:BoundField DataField="Nome" HeaderText="Paciente" SortExpression="Nome" ItemStyle-CssClass="hidden-md"
                        HeaderStyle-CssClass="hidden-md" />
                    <asp:BoundField DataField="Prontuario" HeaderText="PRONTUÁRIO/RH" SortExpression="Prontuario"
                        HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                    <asp:BoundField DataField="Dt_Consulta" HeaderText="DATA DA CONSULTA" SortExpression="Dt_consulta"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                    <asp:BoundField DataField="Grade" HeaderText="Grade" SortExpression="Grade"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                    <asp:BoundField DataField="Equipe" HeaderText="Equipe" SortExpression="Equipe"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                     <asp:BoundField DataField="Data_Contato" HeaderText="Data da ligacao" SortExpression="Data_Contato"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                     <asp:BoundField DataField="Status" HeaderText="Status da ligacao" SortExpression="Status"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />   
                    <asp:BoundField DataField="Observacao" HeaderText="Observacao" SortExpression="Observacao"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                    <asp:BoundField DataField="Usuario_Contato" HeaderText="Contato" SortExpression="Usuario_Contato"
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
