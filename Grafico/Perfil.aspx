<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Perfil.aspx.cs" Inherits="publico_Perfil" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src='<%= ResolveUrl("https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js") %>'
        type="text/javascript"></script>

    <script src='<%= ResolveUrl("https://cdn.jsdelivr.net/npm/chart.js@2.8.0") %>' type="text/javascript"></script>

        <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <!-- page content -->
    <div class="clearfix">
    </div>
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>
                        Relatório de Usuário <small>Relatório de atividades</small></h2>
                    <div class="clearfix">
                    </div>
                </div>
                <div class="x_content">
                    
                    <div class="col-md-3 col-sm-3 col-xs-12 profile_left">
                        <!-- perfil user -->
                        <div class="row">
                        <div class="col-md-6">
                            <asp:DropDownList ID="UsersListBox" class="form-control" runat="server" DataTextField="Username" AutoPostBack="true" OnSelectedIndexChanged="Selected_IndexChanged">
                               
                            </asp:DropDownList>    
                        </div>
                        </div>
                        
                        <div class="profile_img">
                            <div id="crop-avatar">
                                <!-- Current avatar -->
                                <img runat="server" id="imgAvatar" src="" class="img-responsive avatar-view" alt="Avatar"
                                    title="Avatar" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <h3><asp:Label ID="lbNameUser" runat="server" class="control-label col-md-12" /></h3>
                            </div>
                        </div>
                        <div class="row">
                            <ul class="list-unstyled user_data">
                                <li><i class="fa fa-envelope-o"></i> Email:
                                    <asp:Label runat="server" ID="EmailLabel" />
                                </li>
                                <li><i class='fa fa-sign-in'></i> Último Login:
                                    <asp:Label runat="server" ID="LastLoginDateLabel" />
                                </li>
                                <li><i class='fa fa-calendar'></i> Data de Criação:
                                    <asp:Label runat="server" ID="CreationDateLabel" />
                                </li>
                                <li><i class="fa fa-map-marker user-profile-icon"></i> Setor:
                                    <asp:Label ID="lbSetor" runat="server" Text=""></asp:Label></li>
                                <li><i class="fa fa-briefcase user-profile-icon"></i> Cargo: 
                                    <asp:Label ID="lbCargo" runat="server" Text=""></asp:Label></li>
                            </ul>
                        </div>
                        <div class="row">
                            <asp:Button ID="btnEditarPerfil" runat="server" class="btn btn-success" Text="Editar Perfil"
                                OnClick="btnEncaminhaAlteracao_Click" />
                        </div>
                        <br />
                    </div>
                    <!-- área direita -->
                    <div class="col-md-9 col-sm-9 col-xs-12">
                        
                            <div class="row">
                                <label class="control-label">
                                            Informe mês e ano
                                    </label>
                                <div class="col-md-4 col-sm-12 col-xs-12">
                                    <div class="col-md-4">
                                        
                                        <asp:TextBox ID="txbData" runat="server" class="form-control" data-inputmask="'mask': '99/9999'"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredValidator" runat="server" ControlToValidate="txbData"
                                            ForeColor="red" Display="Static" ErrorMessage="Required" />
                                     
                                    </div>
                                   <input id="btn" runat="server" type="button" onclick="gerarGrafico()" value="Gráfico"
                                            class="btn btn-success" />
                                </div>
                            </div>
                       
                    
                        <div id="graph_bar">
                            <canvas id="myChart" style="width: 100%; height: 500px"></canvas>
                        </div>
                        
                        
                        
                              <!-- Atividades do usuário -->
                    
                                <div>
                        <div id="myTabContent">
                            <div class="active in" id="tab_content1" aria-labelledby="home-tab">
                                <!-- start recent activity -->
                                
                                      <table class="table table-striped jambo_table">
                                            <asp:Repeater ID="rpt" runat="server">
                                                <HeaderTemplate>
                                                    <thead>
                                                        <tr>
                                                            <th colspan="2">
                                                                <h4>Últimas atividades do usuário</h4>
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            
                                                               <h4><b><%# Eval("status")%></b></h4>
                                                               <h4><i><%# Eval("Observacao")%></i></h4>
                                                            </td>
                                                        <td>
                                                                <h5>
                                                                    <%# Eval("Data_Contato")%></h5>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                    </table>
                                <!-- end recent activity -->
                            </div>
                        </div>
                        
                        
                    </div>
                    
              
                    </div>
                    
                    <!-- fim área direita -->
                </div>
            </div>
        </div>
    </div>
    <!-- /page content -->

    <script type="text/javascript">

        $(document).ready(function() {
            $("#myChart").hide();

        });

        var ctx = document.getElementById('myChart').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: []
        });

        function gerarGrafico() {
            var dia = document.getElementById('<%=txbData.ClientID %>');
            var usuario = document.getElementById('<%=UsersListBox.ClientID %>');
            updateChart(dia.value, usuario.value)
        }

        function updateChart(data, user) {
            $("#myChart").show();
            myChart.data = JSON.parse(GetData(JSON.stringify(data), JSON.stringify(user)));
            myChart.update();
        };

        function GetData(data, user) {
            var d = data;
            var u = user;

            var result = null;
            $.ajax({
                async: false
                , url: '<%= ResolveUrl("~/publico/webservice.asmx/AtivosStatusPorUsuarioGrafico") %>'
                , data: '{mesAno : ' + d + ', user: '+ u +'}'
                , type: 'POST'
                , contentType: 'application/json; charset=utf-8'
                , dataType: 'json'
                , success: function(data) {
                    result = data.d;
                }
                , error: function(xhr, er) {
                    $("#lbMsg").html('<p> Erro ' + xhr.staus + ' - ' + xhr.statusText + ' - <br />Tipo de erro:  ' + er + '</p>');
                }
            });
            return result;
        }
    </script>

</asp:Content>
