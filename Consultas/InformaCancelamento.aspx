<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="InformaCancelamento.aspx.cs" Inherits="Consultas_InformaCancelamento"
    Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div class="container">
        <div class="body">
            
            <div class="form-group row">
                <label for="txbNomePaciente" class="col-sm-2 col-form-label">
                    Nome Paciente:</label>
                <div class="col-sm-5">
                    <asp:TextBox ID="txbNomePaciente" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                </div>
                
                <label for="txbNomeProntuario" class="col-sm-1 col-form-label">
                    Prontuário:</label>
                <div class="col-sm-2">
                    <asp:TextBox ID="txbNomeProntuario" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                    
                </div>
                <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                    <label>
                        Telefone 1</label>
                    <asp:TextBox ID="txbTelefone1" runat="server" class="form-control" Enabled="false"></asp:TextBox>
                </div>
                <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                    <label>
                        Telefone 2</label>
                    <asp:TextBox ID="txbTelefone2" runat="server" class="form-control" Enabled="false"></asp:TextBox>
                </div>
                <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                    <label>
                        Telefone 3</label>
                    <asp:TextBox ID="txbTelefone3" runat="server" class="form-control" Enabled="false"></asp:TextBox>
                </div>
                <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                    <label>
                        Telefone 4</label>
                    <asp:TextBox ID="txbTelefone4" runat="server" class="form-control" Enabled="false"></asp:TextBox>
                </div>
            </div>
            
             <div class="form-group row">
                <label for="txtUserID" class="col-sm-2 col-form-label">
                    Id Cancelamento:</label>
                <div class="col-sm-10">
                    <asp:Label ID="lbConCancelada" runat="server" Text=""></asp:Label>
                </div>
            </div>
            
            <div class="form-group row">
                <label for="txtUserID" class="col-sm-2 col-form-label">
                    Id Consulta:</label>
                <div class="col-sm-10">
                    <asp:Label ID="txbID" runat="server" Text=""></asp:Label>
                </div>
            </div>
            
            <div class="form-group row">
                <label for="txtUserID" class="col-sm-2 col-form-label">
                    Status:</label>
                <div class="col-sm-10">
                    <asp:Label ID="lbStatus" runat="server" Text=""></asp:Label>
                </div>
            </div>
            
            
            
            <div class="form-group row">
                <label for="txbdtConsulta" class="col-sm-2 col-form-label">
                    Data da Consulta:</label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txbdtConsulta" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                </div>
                <label for="txbCodConsulta" class="col-sm-2 col-form-label">
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
                <asp:Label ID="Label1" for="txbObservacao" runat="server" Text="Observação da Tentativa de Ligação:"></asp:Label>
                <asp:TextBox ID="txbObservacao" runat="server" class="form-control" TextMode="MultiLine"
                    Rows="4" Enabled="false"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label2" for="txbInformacao" runat="server" Text="* Informação adicional:"></asp:Label>
                <asp:TextBox ID="txbInformacao" runat="server" class="form-control" TextMode="MultiLine"
                    Rows="4" required ></asp:TextBox>
            </div>
            <div class="row">
                    <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                        <asp:Button ID="btnGravar" class="btn btn-primary" runat="server" Text="Gravar" 
                            onclick="btnGravar_Click" />
                    </div>
                </div>
        </div>
    </div>
</asp:Content>