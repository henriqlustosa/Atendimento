<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Perfil.aspx.cs" Inherits="publico_Perfil" Title="Atendimento HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                        <div class="profile_img">
                            <div id="crop-avatar">
                                <!-- Current avatar -->
                                <img runat="server" id="imgAvatar" src="" class="img-responsive avatar-view" alt="Avatar"
                                    title="Avatar" />
                            </div>
                        </div>
                      <h3>
                            Login -
                            <%=User.Identity.Name%></h3>
                        <ul class="list-unstyled user_data">
                            <li><i class="fa fa-user"></i>
                                <asp:Label ID="lbNomeCompleto" runat="server" Text="Nome - "></asp:Label>
                            </li>
                            <li><i class="fa fa-map-marker user-profile-icon"></i><asp:Label ID="lbSetor" runat="server" Text="Setor - "></asp:Label></li>
                            <li><i class="fa fa-briefcase user-profile-icon"></i><asp:Label ID="lbCargo" runat="server" Text="Cargo - "></asp:Label></li>
                        </ul>
                        <asp:Button ID="btnEditarPerfil" runat="server" class="btn btn-success" Text="Editar Perfil"
                            OnClick="btnEncaminhaAlteracao_Click" />
                        <br />
                    </div>
                    <div class="col-md-9 col-sm-9 col-xs-12">
                        <div id="myTabContent">
                            <div class="active in" id="tab_content1" aria-labelledby="home-tab">
                                <!-- start recent activity -->
                                <ul class="messages">
                                    <li>
                                        <img src="../UserImages/User.png" class="avatar" alt="Avatar">
                                        <div class="message_date">
                                            <h3 class="date text-info">
                                                24</h3>
                                            <p class="month">
                                                May</p>
                                        </div>
                                        <div class="message_wrapper">
                                            <h4 class="heading">
                                                Desmond Davison</h4>
                                            <blockquote class="message">
                                                Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown
                                                aliqua butcher retro keffiyeh dreamcatcher synth.</blockquote>
                                            <br />
                                            <p class="url">
                                                <span class="fs1 text-info" aria-hidden="true" data-icon=""></span><a href="#"><i
                                                    class="fa fa-paperclip"></i>User Acceptance Test.doc </a>
                                            </p>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="../UserImages/User.png" class="avatar" alt="Avatar">
                                        <div class="message_date">
                                            <h3 class="date text-error">
                                                21</h3>
                                            <p class="month">
                                                May</p>
                                        </div>
                                        <div class="message_wrapper">
                                            <h4 class="heading">
                                                Brian Michaels</h4>
                                            <blockquote class="message">
                                                Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown
                                                aliqua butcher retro keffiyeh dreamcatcher synth.</blockquote>
                                            <br />
                                            <p class="url">
                                                <span class="fs1" aria-hidden="true" data-icon=""></span><a href="#" data-original-title="">
                                                    Download</a>
                                            </p>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="../UserImages/User.png" class="avatar" alt="Avatar">
                                        <div class="message_date">
                                            <h3 class="date text-info">
                                                24</h3>
                                            <p class="month">
                                                May</p>
                                        </div>
                                        <div class="message_wrapper">
                                            <h4 class="heading">
                                                Desmond Davison</h4>
                                            <blockquote class="message">
                                                Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown
                                                aliqua butcher retro keffiyeh dreamcatcher synth.</blockquote>
                                            <br />
                                            <p class="url">
                                                <span class="fs1 text-info" aria-hidden="true" data-icon=""></span><a href="#"><i
                                                    class="fa fa-paperclip"></i>User Acceptance Test.doc </a>
                                            </p>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="../UserImages/User.png" class="avatar" alt="Avatar">
                                        <div class="message_date">
                                            <h3 class="date text-error">
                                                21</h3>
                                            <p class="month">
                                                May</p>
                                        </div>
                                        <div class="message_wrapper">
                                            <h4 class="heading">
                                                Brian Michaels</h4>
                                            <blockquote class="message">
                                                Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown
                                                aliqua butcher retro keffiyeh dreamcatcher synth.</blockquote>
                                            <br />
                                            <p class="url">
                                                <span class="fs1" aria-hidden="true" data-icon=""></span><a href="#" data-original-title="">
                                                    Download</a>
                                            </p>
                                        </div>
                                    </li>
                                </ul>
                                <!-- end recent activity -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /page content -->
</asp:Content>
