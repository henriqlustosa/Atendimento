<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="cargaMailling.aspx.cs" Inherits="administracao_cargaMailling" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
      <div id="main">
            <div class="header">
                <h1>
                    Carga de Consultas</h1>
                <h2>
                    Mailling de consultas para realizar o Ativo</h2>
            </div>
            <div class="content">
                <div class="alinha">
                    <asp:FileUpload ID="fupArquivo" runat="server" Width="350px" class="btn btn-primary" />
                    <asp:Label ID="lblSaida" runat="server" Text=""></asp:Label>
                    <asp:Button ID="btnLerExcel" runat="server" class="btn btn-success" Text="Ler Excel" 
                        onclick="btnLerExcel_Click" /><br />
                    Obs.: Selecione um arquivo (.xls) Microsoft Office 2003.
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Text="Carregue um arquivo!"
                        ControlToValidate="fupArquivo"></asp:RequiredFieldValidator>
                    <asp:GridView ID="gvExcel" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                        <RowStyle BackColor="#E3EAEB" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <EditRowStyle BackColor="#7C6F57" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                </div>
            </div>
        </div>

</asp:Content>

