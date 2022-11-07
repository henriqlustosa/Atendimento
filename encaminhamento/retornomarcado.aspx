<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="retornomarcado.aspx.cs" Inherits="encaminhamento_retornomarcado" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src='<%= ResolveUrl("~/vendors/jquery/dist/jquery.js") %>'
        type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $("input").attr("autocomplete", "off");

            $('.numeric').keyup(function() {
                $(this).val(this.value.replace(/\D/g, ''));
            });

            function validaEspecialidade() {
                $(function() {
                    $('.valida').css("border", "1px solid red");
                });

            }
        });

        function validaCampo() {
            $(function() {
                $('.valida').css("border", "1px solid red");
            });
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div class="x_panel">
        <div class="x_title">
            <h2>
                Encaminhamento/Retorno
                <asp:Label ID="lbProntuario" runat="server" Text="" Style="color: Black"></asp:Label></h2>
            <div class="clearfix">
            </div>
        </div>
        <div class="container">
            <div class="body">
                <div class="form-group row">
                    <label for="txbNomePaciente" class="col-sm-2 col-form-label">
                        Nome Paciente:</label>
                    <div class="col-sm-5">
                        <asp:TextBox ID="txbNomePaciente" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                    </div>
                    <label for="txbProntuario" class="col-sm-1 col-form-label">
                        Prontuário:</label>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txbProntuario" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="lbCodPedido" class="col-sm-2 col-form-label">
                        Código Pedido:</label>
                    <div class="col-sm-10">
                        <asp:Label ID="lbCodPedido" runat="server" Text=""></asp:Label>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="lbStatus" class="col-sm-2 col-form-label">
                        Status:</label>
                    <div class="col-sm-10">
                        <asp:Label ID="lbStatus" runat="server" Text=""></asp:Label>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="txbdtPedido" class="col-sm-2 col-form-label">
                        Data do Pedido:</label>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txbdtPedido" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                    </div>
                    <label for="txbdtCadastrado" class="col-form-label">
                        Data Cadastrada:</label>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txbdtCadastrado" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="txbEspecialidade" class="col-sm-2 col-form-label">
                        Especialidade:</label>
                    <div class="col-sm-10">
                        <asp:TextBox ID="txbEspecialidade" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="txbSolicitante" class="col-sm-2 col-form-label">
                        Solicitante:</label>
                    <div class="col-sm-10">
                        <asp:TextBox ID="txbSolicitante" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label2" for="txbExamesSolicitados" runat="server" Text="Exames Solicitados:"></asp:Label>
                    <asp:TextBox ID="txbExamesSolicitados" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label1" for="txbOutrasInformacoes" runat="server" Text="Outras Informações:"></asp:Label>
                    <asp:TextBox ID="txbOutrasInformacoes" runat="server" Enabled="false" class="form-control"
                        TextMode="MultiLine" Rows="5" required></asp:TextBox>
                </div>
            </div>
        </div>
    </div>
    <div class="x_panel">
        <div class="x_title">
            <h2>
                Dados da Consulta Marcada
                <asp:Label ID="Label3" runat="server" Text="" Style="color: Black"></asp:Label></h2>
            <div class="clearfix">
            </div>
        </div>
        <div class="container">
            <div class="body">
                <div class="form-group row">
                    <label for="txbNrConsulta" class="col-sm-1 col-form-label">
                        Número da Consulta:</label>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txbNrConsulta" runat="server" class="form-control numeric"></asp:TextBox>
                    </div>
                    <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                        <asp:Button ID="btnPesquisa" class="btn btn-primary" runat="server" Text="Pesquisar"
                            OnClick="btngetConsulta_Click" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12 form-group">
                        <asp:Label ID="lbMensagemConsulta" runat="server" Text="" ForeColor="Maroon"></asp:Label>
                    </div>
                </div>
                
                
                <div class="row">
                     <div class="col-sm-2 form-group">
                        <asp:Label ID="lbConMarcada" for="txbConMarcada" runat="server" Text="Consulta:"></asp:Label>
                        <asp:TextBox ID="txbConMarcada" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-2 form-group">
                        <asp:Label ID="lbPront" for="txbProntMarcada" runat="server" Text="Prontuário:"></asp:Label>
                        <asp:TextBox ID="txbProntMarcada" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                    </div>
                    
                    <div class="col-sm-6 form-group">
                        <asp:Label ID="Label5" for="txbNPacienteMarcada" runat="server" Text="Nome Paciente:"></asp:Label>
                        <asp:TextBox ID="txbNPacienteMarcada" runat="server" Enabled="false" class="form-control valida"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-2 form-group">
                        <asp:Label ID="lbDtConsulta" for="txbDtConsultaMarcada" runat="server" Text="Data da Consulta:"></asp:Label>
                        <asp:TextBox ID="txbDtConsultaMarcada" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-4 form-group">
                        <asp:Label ID="lbEspec" for="txbEspecMarcada" runat="server" Text="Especialidade:"></asp:Label>
                        <asp:TextBox ID="txbEspecMarcada" runat="server" Enabled="false" class="form-control valida"></asp:TextBox>
                    </div>
                    <div class="col-sm-4 form-group">
                        <asp:Label ID="lbEquipeMarcada" for="txbEquipeMarcada" runat="server" Text="Equipe:"></asp:Label>
                        <asp:TextBox ID="txbEquipeMarcada" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <asp:Label ID="lbProfissional" for="txbProfissionalMarcada" runat="server" Text="Profissional:"></asp:Label>
                        <asp:TextBox ID="txbProfissionalMarcada" runat="server" Enabled="false" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                        <asp:Button ID="btnGravar" class="btn btn-primary" runat="server" Text="Gravar" OnClick="btnGrava_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
