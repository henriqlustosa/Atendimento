<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ComplementoUsuario.aspx.cs" Inherits="publico_ComplementoUsuario" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
   <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="x_title">
        <h2>
            Cadastro<small>Complemento de usuário</small></h2>
        <div class="clearfix">
        </div>
    </div>
    <div class="x_content">
        <!-- start form for validation -->
       
                <div id="demo-form" class="col-sm-4" data-parsley-validate>
                    <label for="login">Login :</label>
                    <asp:TextBox ID="txbLogin" class="form-control" name="login" runat="server" Enabled="false"></asp:TextBox>
                    
                    <label for="nomeCompleto" style="padding-top: 20px;">Nome completo*:</label>
                    <asp:TextBox ID="txbnomeCompleto" runat="server" class="form-control" name="nomeCompleto" required></asp:TextBox>
                    
                    <label for="setor" style="padding-top: 20px;">Setor:</label>
                    <asp:TextBox ID="txbSetor" runat="server" class="form-control" name="setor"></asp:TextBox>
                    
                    <label for="cargo" style="padding-top: 20px;">Cargo:</label>
                    <asp:TextBox ID="txbCargo" runat="server" class="form-control" name="cargo" style="margin-bottom: 20px;"></asp:TextBox>
                    
                    <div class="row">
                    <label for="FileUpload1" style="margin-left: 10px;">Imagem do avatar:</label>
                    </div>
                    
                    <asp:FileUpload ID="FileUpload1" runat="server" class="btn btn-success" style="margin-bottom: 30px;"  />
                    <asp:Label ID="lbMsg" runat="server" Text=""></asp:Label>
                    <br />
                    <asp:Button ID="btnCadastrar" runat="server" class="btn btn-primary" 
                        Text="Cadastrar" onclick="btnGravar_Click" />
                </div>
               
    </div>
</asp:Content>
