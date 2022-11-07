<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AlterarSenha.aspx.cs" Inherits="publico_AlterarSenha" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:Label ID="Msg" ForeColor="maroon" runat="server" />
    <div class="x_title">
        <h2>
            Alteração de senha para
            <%=User.Identity.Name%></h2>
        <div class="clearfix">
        </div>
    </div>
    <div class="x_content">
    <asp:Label id="Label1" ForeColor="maroon" runat="server" />
        <table cellpadding="3" border="0">
    <tr>
      <td>Senha antiga:</td>
      <td><asp:Textbox id="OldPasswordTextbox" class="form-control" runat="server" TextMode="Password" /></td>
      <td><asp:RequiredFieldValidator id="OldPasswordRequiredValidator" runat="server"
                                      ControlToValidate="OldPasswordTextbox" ForeColor="red"
                                      Display="Static" ErrorMessage="Required" /></td>
    </tr>
    <tr>
      <td>Nova senha:</td>
      <td><asp:Textbox id="PasswordTextbox" class="form-control" runat="server" TextMode="Password" /></td>
      <td><asp:RequiredFieldValidator id="PasswordRequiredValidator" runat="server"
                                      ControlToValidate="PasswordTextbox" ForeColor="red"
                                      Display="Static" ErrorMessage="Required" /></td>
    </tr>
    <tr>
      <td>Consirma senha:</td>
      <td><asp:Textbox id="PasswordConfirmTextbox" class="form-control" runat="server" TextMode="Password" /></td>
      <td><asp:RequiredFieldValidator id="PasswordConfirmRequiredValidator" runat="server"
                                      ControlToValidate="PasswordConfirmTextbox" ForeColor="red"
                                      Display="Static" ErrorMessage="Required" />
          <asp:CompareValidator id="PasswordConfirmCompareValidator" runat="server"
                                      ControlToValidate="PasswordConfirmTextbox" ForeColor="red"
                                      Display="Static" ControlToCompare="PasswordTextBox"
                                      ErrorMessage="Confirm password must match password." />
      </td>
    </tr>
    <tr>
      <td></td>
      <td><asp:Button id="ChangePasswordButton" Text="Mudar Senha" class="btn btn-primary"
                      OnClick="ChangePassword_OnClick" runat="server" /></td>
    </tr>
  </table>
    </div>
</asp:Content>
