<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="DeletarUsuario.aspx.cs" Inherits="publico_DeletarUsuario" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <h3>
        Informações do Usuário</h3>
   
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <div class="row">
        <div class="form-group">
            <asp:Label ID="Msg" runat="server" ForeColor="maroon" class="control-label col-md-12" /><br />
        </div>
    </div>
    
            <table border="0" cellspacing="4">
                <tr>
                    <td valign="top">
                        <asp:ListBox ID="UsersListBox" DataTextField="Username" Rows="8" AutoPostBack="true"
                            runat="server" onselectedindexchanged="Selected_IndexChanged" />
                    </td>
                    <td valign="top">
                        <table border="0" cellpadding="4" cellspacing="0">
                            <tr>
                                <td>
                                    Email:
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="EmailLabel" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Online?:
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="IsOnlineLabel" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Último Login:
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="LastLoginDateLabel" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Data de Criação:
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="CreationDateLabel" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Última Atividade:
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="LastActivityDateLabel" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
             <asp:Button ID="YesButton" class="btn btn-danger" Text="Excluir" OnClick="YesButton_OnClick" runat="server" />
             </ContentTemplate>
    </asp:UpdatePanel> 
           
</asp:Content>
