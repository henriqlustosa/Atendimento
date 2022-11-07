<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="RelatorioAtivosRealizados.aspx.cs" Inherits="Relatorios_RelatorioAtivosRealizados"
    Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src='<%= ResolveUrl("https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js") %>'
        type="text/javascript"></script>
    
     <script src='<%= ResolveUrl("~/vendors/Chart/dist/Chart.min.js") %>' type="text/javascript"></script>
   <!-- 
    <script src='<%= ResolveUrl("https://cdn.jsdelivr.net/npm/chart.js@2.8.0") %>' type="text/javascript"></script>
     -->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div class="content">
        <div class="row tile_count">
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
                <span class="count_top"><i class="fa fa-phone"></i> Total de Ativo de Ligações</span>
                <div class="count">
                    <div class="count">
                        <asp:Label ID="lbTotal" runat="server" Text="" class="count green"></asp:Label>
                    </div>
                </div>
                <span class="count_bottom">Desde 08/10/2019</span>
            </div>
        </div>
        <asp:Button ID="btnGerarArquivo" runat="server" Text="Gerar arquivo total" class="btn btn-primary"
            OnClick="btnCarregarDados_Click" />
        <asp:GridView ID="gridAtivos" runat="server">
        </asp:GridView>
    </div>
    <div class="row tile_count">
        <div class="col-md-3 col-xs-12 widget widget_tally_box">
            <div class="x_panel fixed_height_490">
                <div class="x_title">
                    <h2>
                        Hoje</h2>
                    <div class="clearfix">
                    </div>
                </div>
                <div class="x_content">
                    <p>
                        <asp:Label ID="lbdataHoje" runat="server" Text=""></asp:Label></p>
                    <div class="divider">
                    </div>
                    <div style="text-align: center; overflow: hidden; margin: 10px 5px 0;">
                        <div class="count">
                            <div class="tile_stats_count">
                                <div class="count">
                                    <div class="count">
                                        <asp:Label ID="lbHoje" runat="server" Text="" class="count green"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="text-align: center; margin-bottom: 15px;">
                        <div class="btn-group" role="group" aria-label="First group">
                            <asp:Button ID="Button1" runat="server" Text="Gerar Relatório" class="btn btn-default btn-sm"
                                OnClick="btnCarregarDadosHoje_Click" />
                        </div>
                    </div>
                    <div style="text-align: center; overflow: hidden; margin: 10px 5px 0;">
                        
                        <canvas id="canvas_hoje_pie" height="400"></canvas>
                        
                        <canvas id="canvas_hoje" height="200"></canvas>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-3 col-xs-12 widget widget_tally_box">
            <div class="x_panel fixed_height_390">
                <div class="x_title">
                    <h2>
                        Ontem</h2>
                    <div class="clearfix">
                    </div>
                </div>
                <div class="x_content">
                    <p>
                        <asp:Label ID="lbDataOntem" runat="server" Text=""></asp:Label></p>
                    <div class="divider">
                    </div>
                    <div style="text-align: center; overflow: hidden; margin: 10px 5px 0;">
                        <div class="count">
                            <div class="tile_stats_count">
                                <div class="count">
                                    <div class="count">
                                        <asp:Label ID="lbOntem" runat="server" Text="" class="count green"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="text-align: center; margin-bottom: 15px;">
                        <div class="btn-group" role="group" aria-label="First group">
                            <asp:Button ID="Button2" runat="server" Text="Gerar Relatório" class="btn btn-default btn-sm"
                                OnClick="btnCarregarDadosOntem_Click" />
                        </div>
                    </div>
                    <div style="text-align: center; overflow: hidden; margin: 10px 5px 0;">
                        <canvas id="canvas_ontem" height="200"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-xs-12 widget widget_tally_box">
            <div class="x_panel fixed_height_390">
                <div class="x_title">
                    <h2>
                        Últimos 7 dias</h2>
                    <div class="clearfix">
                    </div>
                </div>
                <div class="x_content">
                    <p>
                        <asp:Label ID="lbDataSete" runat="server" Text=""></asp:Label>
                    </p>
                    <div class="divider">
                    </div>
                    <div style="text-align: center; overflow: hidden; margin: 10px 5px 0;">
                        <div class="count">
                            <div class="tile_stats_count">
                                <div class="count">
                                    <div class="count">
                                        <asp:Label ID="lbSete" runat="server" Text="" class="count green"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="text-align: center; margin-bottom: 15px;">
                        <div class="btn-group" role="group" aria-label="First group">
                            <asp:Button ID="Button3" runat="server" Text="Gerar Relatório" class="btn btn-default btn-sm"
                                OnClick="btnCarregarDadosSeteDias_Click" />
                        </div>
                    </div>
                    <div style="text-align: center; overflow: hidden; margin: 10px 5px 0;">
                        <canvas id="canvas_sete" height="190"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-xs-12 widget widget_tally_box">
            <div class="x_panel fixed_height_390">
                <div class="x_title">
                    <h2>
                        Este Mês</h2>
                    <div class="clearfix">
                    </div>
                </div>
                <div class="x_content">
                    <p>
                        <asp:Label ID="lbDataEsteMes" runat="server" Text=""></asp:Label>
                    </p>
                    <div class="divider">
                    </div>
                    <div style="text-align: center; overflow: hidden; margin: 10px 5px 0;">
                        <div class="count">
                            <div class="tile_stats_count">
                                <div class="count">
                                    <div class="count">
                                        <asp:Label ID="lbEsteMes" runat="server" Text="" class="count green"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="text-align: center; margin-bottom: 15px;">
                        <div class="btn-group" role="group" aria-label="First group">
                            <asp:Button ID="Button4" runat="server" Text="Gerar Relatório" class="btn btn-default btn-sm"
                                OnClick="btnCarregarDadosEsteMes_Click" />
                        </div>
                    </div>
                     <div style="text-align: center; overflow: hidden; margin: 10px 5px 0;">
                        <canvas id="canvas_este_mes" height="190"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-xs-12 widget widget_tally_box">
            <div class="x_panel fixed_height_390">
                <div class="x_title">
                    <h2>
                        Últimos 30 dias</h2>
                    <div class="clearfix">
                    </div>
                </div>
                <div class="x_content">
                    <p>
                        <asp:Label ID="lbDataTrintaDias" runat="server" Text=""></asp:Label>
                    </p>
                    <div class="divider">
                    </div>
                    <div style="text-align: center; overflow: hidden; margin: 10px 5px 0;">
                        <div class="count">
                            <div class="tile_stats_count">
                                <div class="count">
                                    <div class="count">
                                        <asp:Label ID="lbTrinta" runat="server" Text="" class="count green"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="text-align: center; margin-bottom: 15px;">
                        <div class="btn-group" role="group" aria-label="First group">
                            <asp:Button ID="Button5" runat="server" Text="Gerar Relatório" class="btn btn-default btn-sm"
                                OnClick="btnCarregarDadosTrintaDias_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
   <script type="text/javascript">

       var ctx = document.getElementById('canvas_hoje_pie').getContext('2d');
       var d = new Date();
       var n = d.toLocaleDateString();

       var myChart = new Chart(ctx, {
           type: 'pie',
           data: JSON.parse(GetDataDia(JSON.stringify(n)))
       });

       function GetDataDia(data) {
           var d = data;

           var result = null;
           $.ajax({
               async: false
                , url: '<%= ResolveUrl("~/Restrito/webservice.asmx/QuantidadeAtivosStatusDiaGrafico") %>'
                , data: '{data : ' + d + '}'
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
   
   
   
       var ctx = document.getElementById('canvas_hoje').getContext('2d');
       var d = new Date();
       var n = d.toLocaleDateString();

       var myChart = new Chart(ctx, {
           type: 'line',
           data: JSON.parse(GetData(JSON.stringify(n)))
       });

       function GetData(data) {
           var d = data;

           var result = null;
           $.ajax({
               async: false
                , url: '<%= ResolveUrl("~/Restrito/webservice.asmx/ChamadasDia") %>'
                , data: '{data : ' + d + '}'
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

       var ctx = document.getElementById('canvas_ontem').getContext('2d');
       var d1 = new Date();
       var n1 = d1.toLocaleDateString();

       var myChart1 = new Chart(ctx, {
           type: 'line',
           data: JSON.parse(GetOntem())
       });

       function GetOntem() {
           var result = null;
           $.ajax({
               async: false
                , url: '<%= ResolveUrl("~/Restrito/webservice.asmx/ChamadasOntem") %>'
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

       var ctx = document.getElementById('canvas_sete').getContext('2d');
       var d1 = new Date();
       var n1 = d1.toLocaleDateString();

       var myChart1 = new Chart(ctx, {
           type: 'line',
           data: JSON.parse(GetSete())
       });

       function GetSete() {
           var result = null;
           $.ajax({
               async: false
                , url: '<%= ResolveUrl("~/Restrito/webservice.asmx/ChamadasSeteDias") %>'
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

       var ctx = document.getElementById('canvas_este_mes').getContext('2d');
       var d1 = new Date();
       var n1 = d1.toLocaleDateString();

       var myChart1 = new Chart(ctx, {
           type: 'line',
           data: JSON.parse(GetEsteMes())
       });

       function GetEsteMes() {
           var result = null;
           $.ajax({
               async: false
                , url: '<%= ResolveUrl("~/Restrito/webservice.asmx/ChamadasEsteMes") %>'
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