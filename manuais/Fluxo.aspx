<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Fluxo.aspx.cs" Inherits="manuais_Fluxo" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div role="main">
        <div class="row">
            <div class="col-md-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>
                            Fluxo <small>Sistema de atendimento</small></h2>
                        <ul class="nav navbar-right panel_toolbox">
                            <li><i class="fa fa-file-pdf-o">
                                <asp:LinkButton ID="linkFluxoPdf" CommandName="Download" OnClick="linkFluxoPdf_Click"
                                    runat="server"> Fluxograma de ligações.pdf</asp:LinkButton></i> </li>
                        </ul>
                        <div class="clearfix">
                        </div>
                    </div>
                    <div class="x_content">
                        <div class="col-md-12">
                            <img alt="Fluxo de ligações" src="docs/FLUXOGRAMA_DE_LIGACOES.jpg" class="img-fluid" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
