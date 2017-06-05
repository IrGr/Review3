<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">

        <div class="row" style="margin-top:20px">
            <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
		        <section role="form">
			        <fieldset>
				        <h3 class="col-xs-offset-1">Brugernavn</h3>
				
				        <div class="form-group">
                            <%--<asp:TextBox ID="TextBox_Brugeremail" class="form-control input-lg" type="text" name="text" runat="server"></asp:TextBox>--%>
                            <asp:TextBox ID="TextBox_Brugernavn" class="form-control input-lg" type="text" name="text" placeholder="admin" runat="server"></asp:TextBox>
				        </div>
                            <h3 class="col-xs-offset-1">Kodeord</h3>
				        <div class="form-group">
                            <asp:TextBox ID="TextBox_Password" class="form-control input-lg" type="password" name="password" placeholder="1234" runat="server"></asp:TextBox>
				        </div>
				
				
				        <div class="row">
					        <div class="col-xs-6 col-sm-6 col-md-6">
                                <asp:Button ID="Button_Login" class="btn btn-lg btn-success btn-block" OnClick="Button_Login_Click" runat="server" Text="Login" />
					        </div>
					        <div class="col-xs-6 col-sm-6 col-md-6">
                                <asp:HyperLink ID="HyperLink_OpretBruger"  class="btn btn-lg btn-primary btn-block"
                                               NavigateUrl="OpretBruger.aspx" runat="server">Opret bruger</asp:HyperLink>
					        </div>
				        </div>

                        <asp:Label ID="Label_Error" Visible="false" runat="server" Text="Label"></asp:Label>
			        </fieldset>
		        </section>
	        </div>
        </div> 
    </div>

    <!--reklamebox-->
    <div class="container-fluid">
        <div class="row">
             <div class="col-xs-12 reklamebox">
                <div class="row">
                    <asp:Image ID="Image_Reklam" CssClass="img-responsive center-block" runat="server" />
                </div>
            </div><!--reklamebox-->
        </div>
   </div>
</asp:Content>

