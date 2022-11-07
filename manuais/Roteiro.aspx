<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Roteiro.aspx.cs" Inherits="documentos_Roteiro" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div role="main">
        <div class="row">
            <div class="col-md-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>
                            Roteiro <small>fluxo de atendimento</small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                            <li><i class="fa fa-file-pdf-o">
                                <asp:LinkButton ID="linkRoteiroPdf" CommandName="Download" OnClick="linkRoteiroPdf_Click"
                                    runat="server"> Roteiro de ligações.pdf</asp:LinkButton></i> </li>
                        </ul>
                        <div class="clearfix">
                        </div>
                    </div>
                    <div class="x_content">
                        <div class="col-md-12">
                            <img alt="Roteiro" src="docs/ROTEIRO_FLUXO.jpg" class="img-fluid" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
