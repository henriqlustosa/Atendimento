<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ResetSenha.aspx.cs" Inherits="publico_ResetSenha" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="x_title">
        <h2>
            Recuperar Senha</h2>
        <div class="clearfix">
        </div>
    </div>
    <div class="x_content">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div id="demo-form2" data-parsley-validate class="form-horizontal form-label-left input_mask">
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Msg" runat="server" ForeColor="maroon" class="control-label col-md-12" /><br />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <label class="control-label col-md-3" for="UsernameTextBox">
                                Usuário: <span class="required">*</span>
                            </label>
                            <div class="col-md-6">
                                <asp:TextBox ID="UsernameTextBox" class="form-control" runat="server" AutoPostBack="true" />
                                <asp:RequiredFieldValidator ID="UsernameRequiredValidator" runat="server" ControlToValidate="UsernameTextBox"
                                    ForeColor="red" Display="Static" ErrorMessage="Required" /><br />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                <asp:Button ID="ResetPasswordButton" Text="Reset Senha" OnClick="ResetPassword_OnClick"
                                    runat="server" Enabled="true" class="btn btn-primary" />
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
