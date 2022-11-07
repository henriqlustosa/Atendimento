<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AlterarCadastro.aspx.cs" Inherits="publico_AlterarCadastro" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<h3>Atualização de Login</h3>

  <asp:Label id="lbMsg" ForeColor="maroon" runat="server" /><br />

  <table cellpadding="3" border="0">
    <tr>
      <td>Usuário Antigo:</td>
      <td><asp:TextBox id="LoginAntigoTextBox" MaxLength="128" Columns="30" runat="server" /></td>
      <td><asp:RequiredFieldValidator id="EmailRequiredValidator" runat="server"
                                    ControlToValidate="LoginAntigoTextBox" ForeColor="red"
                                    Display="Static" ErrorMessage="Required" /></td>
    </tr>
    <tr>
      <td>Usuário Novo:</td>
      <td><asp:TextBox id="LoginNovoTextBox" MaxLength="128" Columns="30" runat="server" /></td>
      <td><asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server"
                                    ControlToValidate="LoginNovoTextBox" ForeColor="red"
                                    Display="Static" ErrorMessage="Required" /></td>
    </tr>
    
    <tr>
      <td></td>
      <td><asp:Button id="UpdateUserButton" 
                      Text="Atualizar Login" 
                      OnClick="UpdateUserNameButton_OnClick" 
                      runat="server" class="btn btn-primary" /></td>
    </tr>
  </table>
</asp:Content>

