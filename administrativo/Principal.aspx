<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Principal.aspx.cs" Inherits="administrativo_Principal" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <div class="x_title">
                <h2>
                    Ativo de Consultas</h2>
                <div class="clearfix">
                </div>
            </div>
            <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <a>
                    <div class="tile-stats">
                        <div class="icon">
                            <span style="color: #337ab7;"><i class="fa fa-folder"></i></span>
                        </div>
                        <div class="count">
                            <asp:Label ID="lbConsultas1Tentativa" runat="server" Text="Label"></asp:Label></div>
                        <a href="ListaAtivos.aspx">
                            <h3>
                                Consultas Marcadas</h3>
                        </a>
                        <p style="font-size: 17px">
                            1ª Tentativa de Contato.
                        </p>
                    </div>
                </a>
            </div>
            <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="tile-stats">
                    <div class="icon">
                        <span style="color: #f0ad4e;"><i class="fa fa-folder"></i></span>
                    </div>
                    <div class="count">
                        <asp:Label ID="lbConsultas2Tentativa" runat="server" Text="Label"></asp:Label></div>
                    <a href="ListaAtivos2.aspx">
                        <h3>
                            Consultas Marcadas</h3>
                    </a>
                    <p style="font-size: 17px">
                        2ª Tentativa de Contato.</p>
                </div>
            </div>
             
            <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="tile-stats">
                    <div class="icon">
                        <span style="color: #d9534f;"><i class="fa fa-folder"></i></span>
                    </div>
                    <div class="count">
                        <asp:Label ID="lbConsultas3Tentativa" runat="server" Text="Label"></asp:Label></div>
                    <a href="ListaAtivos3.aspx">
                        <h3>
                            Consultas Marcadas</h3>
                    </a>
                    <p style="font-size: 17px">
                        3ª Tentativa de Contato.</p>
                </div>
            </div>
            
        </div>
    </div>
</asp:Content>