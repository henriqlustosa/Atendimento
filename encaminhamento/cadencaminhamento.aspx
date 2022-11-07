<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="cadencaminhamento.aspx.cs" Inherits="publico_cadencaminhamento" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <script src='<%= ResolveUrl("~/vendors/jquery/dist/jquery.js") %>'
        type="text/javascript"></script>
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet" />
    
    <script type="text/javascript">
        $(document).ready(function() {
            $("input").attr("autocomplete", "off");

            $('input').iCheck({
                checkboxClass: 'icheckbox_flat-green',
                radioClass: 'iradio_flat-green',
                increaseArea: '20%' // optional
            });

            $('.numeric').keyup(function() {
                $(this).val(this.value.replace(/\D/g, ''));
            });
        });

    </script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <h3>
        <asp:Label ID="lbTitulo" runat="server" Text="Encaminhamento/Retorno"></asp:Label></h3>
    <div class="x_panel">
        <div class="x_title">
            <h2>
                Informações do Paciente
                <asp:Label ID="lbProntuario" runat="server" Text="" Style="color: Black"></asp:Label></h2>
            <div class="clearfix">
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <label class="control-label col-md-4" for="UsernameTextBox">
                    Prontuário: <span class="required">*</span>
                </label>
                <div class="col-md-8">
                    <asp:TextBox ID="txbProntuario" class="form-control numeric" runat="server" AutoPostBack="true" />
                    <asp:RequiredFieldValidator ID="UsernameRequiredValidator" runat="server" ControlToValidate="txbProntuario"
                        ForeColor="red" Display="Static" ErrorMessage="Required" /><br />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-4 col-sm-4 col-xs-8 ">
                    <asp:Button ID="SearchButton" Text="Pesquisar" runat="server" Enabled="true" class="btn btn-primary"
                        OnClick="btnPesquisapaciente_Click" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-sm-12 col-xs-12 form-group">
                <label>
                    Nome</label>
                <asp:TextBox ID="txbNomePaciente" runat="server" Enabled="false" class="form-control"></asp:TextBox>
            </div>
        </div>
    </div>
    <div class="x_panel">
        <div class="x_title">
            <h2>
                Informações do Pedido
                <asp:Label ID="Label1" runat="server" Text="" Style="color: Black"></asp:Label></h2>
            <div class="clearfix">
            </div>
        </div>
        <div class="col-md-6 col-xs-12">
            <div class="x_content">
                <div class="row">
                    <div class="col-md-4 col-sm-12 col-xs-12 form-group">
                        <label for="ex3">
                            Data do pedido</label>
                        <asp:TextBox ID="txbDtPedido" runat="server" class="form-control" data-inputmask="'mask': '99/99/9999'"></asp:TextBox> 
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-8">
                        <asp:DropDownList ID="ddlEspecialidade" runat="server" class="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
               <%-- 
                <div class="w-30 p-4">
                    <div class="col-md-9 col-sm-9 col-xs-12">
                            <asp:RadioButtonList ID="rbExame" RepeatDirection="Horizontal" runat="server">
                                <asp:ListItem Text="Sem Exame" Value="0" Selected></asp:ListItem>
                                <asp:ListItem Text="Com Exame" Value="1"></asp:ListItem>
                            </asp:RadioButtonList>
                    </div>
                </div>--%>
                <div class="w-30 p-3">
                    <div class="col-md-9 col-sm-9 col-xs-12">
                        <asp:CheckBoxList ID="cblExames" runat="server">
                            <asp:ListItem>LABORATÓRIO</asp:ListItem>
                            <asp:ListItem>TIPAGEM</asp:ListItem>
                            <asp:ListItem>RECEITAS</asp:ListItem>
                            <asp:ListItem>ECOCARDIOGRAMA</asp:ListItem>
                            <asp:ListItem>USG</asp:ListItem>
                            <asp:ListItem>RNM</asp:ListItem>
                            <asp:ListItem>ELETRO C/LAUDO</asp:ListItem>
                            <asp:ListItem>ELETRO(PRÉ-OPERATÓRIO)</asp:ListItem>
                            <asp:ListItem>MAMOGRAFIA</asp:ListItem>
                            <asp:ListItem>ENDOSCOPIA</asp:ListItem>
                            <asp:ListItem>DESINTOMETRIA ÓSSEA</asp:ListItem>
                            <asp:ListItem>CINTILOGRAFIA</asp:ListItem>
                            <asp:ListItem>TOMOGRAFIA</asp:ListItem>
                            <asp:ListItem>SWAB</asp:ListItem>
                            <asp:ListItem>ANESTESIA</asp:ListItem>
                            <asp:ListItem>RAIO X</asp:ListItem>
                            <asp:ListItem>MAPA</asp:ListItem>
                            <asp:ListItem>HOLTER</asp:ListItem>
                            <asp:ListItem>KIT COLONO</asp:ListItem>
                            <asp:ListItem>EEG</asp:ListItem>
                            <asp:ListItem>PET CT</asp:ListItem>
                            <asp:ListItem>ENM</asp:ListItem>
                            <asp:ListItem>CATETERISMO</asp:ListItem>
                            <asp:ListItem>ENCAMINHAMENTO:</asp:ListItem>
                             <asp:ListItem>PED.CONS.:</asp:ListItem>
                            <asp:ListItem>OUTROS:</asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-md-9 col-sm-9 col-xs-12">
                    <asp:TextBox ID="txbOb" runat="server" class="form-control" TextMode="MultiLine" Text="Retorno solicitado pelo médico para: __/__/____&#10;Agendamento Laboratório para__/__/____&#10;Outras:" Rows="6" Columns="10" Width="500px"></asp:TextBox>
                </div>
                </div>
                
            </div>
        </div>
    </div>
    <div class="x_panel">
        <div class="x_title">
            <h2>
                Informações do Solicitante
                <asp:Label ID="Label2" runat="server" Text="" Style="color: Black"></asp:Label></h2>
            <div class="clearfix">
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-sm-6 col-xs-12 form-group">
                <label>
                    Médico/Profissional</label>
                <asp:TextBox ID="txbprofissional" runat="server" class="form-control"></asp:TextBox>
            </div>
        </div>
        <%-- <div class="row">
            <div class="col-md-6 col-sm-6 col-xs-12 form-group">
                <label>
                    Conselho</label>
                <input type="text" id="idConselho" class="form-control" placeholder="Conselho" />
            </div>
        </div>--%>
    </div>
    <div class="x_content">
        <asp:Button ID="btnBravar" runat="server" Text="Gravar" class="btn btn-primary" OnClick="btnGravar_Click" />
    </div>
    
    
    
    
      <!-- Modal -->
  <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true"
                data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">
                                Cadastro</h5>
                        </div>
                        <div class="modal-body" align="center">
                            <h2>Pedido Cadastrado.</h2>
                        </div>
                        <div class="modal-footer">
                          <button type="button" id="btnCloseModal" class="btn btn-default" data-dismiss="modal">Fechar</button>
                        </div>
                    </div>
                </div>
            </div>
  
  
  <script type="text/javascript">
      $(document).ready(function() {
          $("#btnCloseModal").click(function() {
            $(location).attr('href', 'cadencaminhamento.aspx');
          });
      });
      
  </script>
<%--
    <script type="text/javascript">
        // uso no checkbox iCheck
        /* ifChecked    */
        /* ifChanged    */
        /* ifClicked    */
        /* ifUnchecked  */
        /* ifToggled    */
        /* ifDisabled   */
        //////////////////

        $(document).ready(function() {

            $('#rbExame').iCheck('check', function() {
                disableRadios();
            });

            $('#cbxObservacoes').iCheck('uncheck', function() {
                $('#txaOb').prop('disabled', true);
            });

            $('#cbxObservacoes').on("ifChecked", function(e) {
                $('#txaOb').prop('disabled', false);
            });
            $('#cbxObservacoes').on("ifUnchecked", function(e) {
                $('#txaOb').prop('disabled', true);
            });


            $('#cbSExame').on("ifClicked", function(e) {
                disableRadios();
            });

            $('input[id=cbCExame]').on("ifClicked", function(e) {
                $('#cbLab').iCheck('enable');
                $('#cbImagem').iCheck('enable');
                $('#cbOutros').iCheck('enable');
            });

            function disableRadios() {
                $('#cbLab').iCheck('disable');
                $('#cbImagem').iCheck('disable');
                $('#cbOutros').iCheck('disable');

                $('#cbLab').iCheck('uncheck');
                $('#cbImagem').iCheck('uncheck');
                $('#cbOutros').iCheck('uncheck');
            }
        });
    </script>--%>
    
</asp:Content>