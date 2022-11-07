<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PassoaPasso.aspx.cs" Inherits="publico_PassoaPasso" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        blockquote
        {
            padding: 10px 20px;
            margin: 0 0 20px;
            font-size: 17.5px;
            border-left: 5px solid #eee;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div role="main">
        <div class="">
            <div class="row">
                <div class="col-md-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                Ligações do Ativo retornos HSPM</h2>
                            <div class="clearfix">
                            </div>
                        </div>
                        <div class="x_content">
                            <blockquote>
                                <p>
                                    <i class="fa fa-phone"></i> Conferir se a consulta ainda está no sistema. Se não
                                    tiver, colocar o Status: Não consta consulta.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i> Checar se tem outros telefones de contato. Vide link
                                    <b>
                                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="http://hspmins17/amb/"><i class="fa fa-desktop"> http://hspmins17/amb/</asp:HyperLink></b></i>
                                    - clicar em “Consulta do Paciente” e digitar o RH sem o último digito.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i> Ligar para o paciente para confirmar a presença e/ou
                                    o cancelamento, colocando o motivo e se há interesse na remarcação.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i> Consultas de Endocrinologia – aviso sobre coleta de exames,
                                    das 7h às 8h, no próximo dia útil após o nosso contato.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i> Sempre anotar com quem falou (grau de parentesco).
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i>Não deixar recados com menor de 12 anos.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i> Pedir para paciente repetir os dados da consulta.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i> Avisar que o paciente poderá cancelar a consulta até
                                    2 dias úteis antes da data.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i> O paciente deverá comparecer com RG ou documento oficial
                                    com foto, cartão do HSPM e holerite atualizado, pode ser foto no celular.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i> Aposentados – isentos de apresentação, se constar o carimbo
                                    no cartão de consulta: “Autorizado Sem Holerite”.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i> Qualquer dúvida, fornecer o telefone do HSPM: 3397-7700.
                                </p>
                            </blockquote>
                        </div>
                    </div>
                    
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                Status das Ligações</h2>
                            <div class="clearfix">
                            </div>
                        </div>
                        <div class="x_content">
                            <blockquote>
                                <p>
                                    <i class="fa fa-phone"></i><b> Confirmado</b> – paciente confirma que irá comparecer
                                    na consulta.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i><b> Cancelar consulta </b>– paciente informa que não irá
                                    à consulta e não tem interesse na remarcação.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i><b>C ancelar e remarcar </b>– paciente informa que não
                                    poderá comparecer a consulta (anotar o motivo) e tem interesse na remarcação. Importante
                                    sabermos pra quando (período/mês) ele quer a remarcação.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i><b> Falecido </b>– familiar e/ou informa que o paciente
                                    faleceu. Orientar o familiar comparecer na Seção de Matrícula do Hospital, com os
                                    documentos RG, Cartão e Declaração de Óbito, para atualização cadastral. Horário
                                    das 7h30 às 15h30. Qualquer dúvida, fornecer o telefone 3397-8010.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i><b> Ligar mais tarde </b>– por algum motivo, o paciente
                                    e/ou quem atendeu está impossibilitado de anotar o recado da consulta no momento
                                    da ligação. Já avisar que o hospital retornará o contato posteriormente.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i><b> Não atende </b>- chamada não atendida até cair a ligação.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i><b> Pessoa desconhecida </b>- quem atende não conhece
                                    o paciente.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i><b> Telefone inexistente </b>– recado fornecido pela própria
                                    operadora.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i><b> Caixa Postal </b>– pode deixar o recado da consulta.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i><b> Não costa consulta </b>– após conferência no SGH,
                                    se a consulta não constar.
                                </p>
                                <p>
                                    <i class="fa fa-phone"></i><b> Consulta remarcada </b>– durante o contato, o paciente
                                    que não poderá comparecer na data agendada e solicita remarcação da consulta. Pesquisar
                                    a especialidade pela grade (consulta do paciente – exemplo abaixo <i class="fa fa-hand-o-down"></i>) e, havendo vaga
                                    disponível no sistema SGH, a consulta poderá ser remarcada.
                                </p>
                            </blockquote>
                        </div>
                    </div>
                    
                    
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                Consultas do paciente no SGH</h2>
                            <div class="clearfix">
                            </div>
                        </div>
                        <div class="x_content">
                        <h3>Histórico de Consultas do Paciente</h3>
                        <p>
                            <img alt="Consultas do paciente" src="../images/pesquisar_consultas.png" class="img-fluid" />
                           </p> 
                           
                           <h3>Estornar consulta do Paciente</h3>
                           <p>
                            <img alt="Estornar consultas" src="../images/estornar_consulta.png" class="img-fluid" />
                           </p>
                        </div>
                        </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>