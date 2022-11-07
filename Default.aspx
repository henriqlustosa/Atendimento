<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ATENDIMENTO HSPM</title>
    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet" type="text/css" />
    <!-- Animate.css -->
    <link href="vendors/animate.css/animate.min.css" rel="stylesheet" type="text/css" />
    <!-- Custom Theme Style -->
    <link href="build/css/custom.min.css" rel="stylesheet" type="text/css" />
</head>
<body class="login">
    <div>
        <div class="login_wrapper">
            <div class="form">
           
                <section class="login_content">
                 
            <form id="form1" runat="server">
              <asp:Image ID="Image1" runat="server" ImageUrl="images/pasta.png"></asp:Image>
              <asp:Login ID="Login1" runat="server" 
                DestinationPageUrl="~/administrativo/Principal.aspx" Width="100%">
                  <LayoutTemplate>
                  
                    <div class="col-md-12 form-group">
                        <asp:TextBox ID="UserName" runat="server" class="form-control has-feedback-left" placeholder="Usuário"></asp:TextBox>
                        <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
                                              <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                                  ControlToValidate="UserName" ErrorMessage="User Name is required." 
                                                  ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                
                      </div>
                          
              <div class="col-md-12 form-group">
              <asp:TextBox ID="Password" runat="server" class="form-control has-feedback-left"   TextMode="Password" placeholder="Senha"></asp:TextBox>
              <span class="fa fa-lock form-control-feedback left" aria-hidden="true"></span>                               
                                              <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                                  ControlToValidate="Password" ErrorMessage="Password is required." 
                                                  ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                    
                
              </div>
              <div align="center" style="color:Red;"><asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                        </div>
              <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
               <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Entrar" 
                                                  ValidationGroup="Login1" class="btn btn-success" />
              
              </div>
                  </LayoutTemplate>
               </asp:Login>
              <div class="clearfix"></div>

              <div class="separator">
               
                <div class="clearfix"></div>
                <br />

                <div>
                  <h1>HSPM</h1>
                  <p>©2022 HSPM - Hospital do Servidor Público Municipal</p>
                </div>
              </div>
            </form>
          </section>
            </div>
        </div>
    </div>
</body>
</html>
