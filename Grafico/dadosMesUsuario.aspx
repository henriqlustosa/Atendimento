<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="dadosMesUsuario.aspx.cs" Inherits="Grafico_dadosMesUsuario" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src='<%= ResolveUrl("https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js") %>'
        type="text/javascript"></script>

    <script src='<%= ResolveUrl("https://cdn.jsdelivr.net/npm/chart.js@2.8.0") %>' type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
           <asp:Label ID="lbMsg" runat="server" Text=""></asp:Label>
            <div class="row">
                <label class="control-label">
                    <h6>
                        Informe mês e ano:</h6>
                </label>
                <div class="col-md-4 col-sm-12 col-xs-12">
                    <div class="col-md-4">
                        <asp:TextBox ID="txbData" runat="server" class="form-control" data-inputmask="'mask': '99/9999'"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredValidator" runat="server" ControlToValidate="txbData"
                            ForeColor="red" Display="Static" ErrorMessage="Required" /><br />
                    </div>
                    <div class="col-md-4">
                        <input id="btn" runat="server" type="button" onclick="gerarGrafico()" value="Gráfico" class="btn btn-success" />
                    </div>
                    <div class="col-md-4">
                        <input id="Button2" runat="server" type="button" value="Limpar" onclick="reloadPage()" class="btn btn-primary" />
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    
    <div class="x_content">
        <div>
             <canvas id="myChart" style="height: 150px; width: 250px"></canvas>
        </div>
       
    </div>
<script type="text/javascript">

    $(document).ready(function() {
        $("#myChart").hide();

    });

    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: []
    });

    function gerarGrafico() {
        var dia = document.getElementById('<%=txbData.ClientID %>');
        updateChart(dia.value)
    }

    function updateChart(data) {
        $("#myChart").show();
        myChart.data = JSON.parse(GetData(JSON.stringify(data)));
        myChart.update();
    };

    function GetData(data) {
        var d = data;

        var result = null;
       
       $.ajax({
            async: false
                , url: '<%= ResolveUrl("~/publico/webservice.asmx/QuantidadeAtivosPorUsuario") %>'
                , data: '{mesAno : ' + d + '}'
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

    function reloadPage() {
        window.location.reload()
    }
    </script>
</asp:Content>

