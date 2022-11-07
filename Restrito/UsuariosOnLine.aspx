<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="UsuariosOnLine.aspx.cs" Inherits="publico_UsuariosOnLine" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <h3>
        Informações dos Usuários</h3>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Timer ID="Timer1" runat="server" Interval="10000">
            </asp:Timer>
            
            <div class="row tile_count">
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> Usuários</span>
              <div class="count"><asp:Label ID="lbQuantidadeOnline" runat="server" Text="" class="count"></asp:Label></div>
            </div>
            </div>
          
           
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
       
            <table class="table table-striped jambo_table">
                <asp:Repeater ID="rpt" runat="server">
                    <HeaderTemplate>
                        <thead>
                            <tr>
                                <th>
                                    Online
                                </th>
                                <th>
                                    Usuário
                                </th>
                                <th>
                                    Email
                                </th>
                                <th>
                                    Bloqueado
                                </th>
                                <th>
                                    Último Login
                                </th>
                                <th>
                                    Última Atividade
                                </th>
                                
                            </tr>
                        </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# (bool)Eval("IsOnline") == true ? "<i class='fa fa-user' style='color: #1ABB9C;' ></i> Online" : "<i class='fa fa-user' style='color: #BAB8B8;' ></i> Offline"%>
                            </td>
                            <td>
                                <%# Eval("Username")%>
                            </td>
                            <td>
                                <%# Eval("Email")%>
                            </td>
                            <td>
                                <%# (bool)Eval("IsLockedOut") == true ? "Sim" : "Não" %>
                            </td>
                            <td>
                                <%# Eval("LastLoginDate")%>
                            </td>
                            <td>
                                <%# Eval("LastActivityDate")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>