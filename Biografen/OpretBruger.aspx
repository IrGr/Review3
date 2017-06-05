<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="OpretBruger.aspx.cs" Inherits="OpretBruger" %>

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
                                <asp:TextBox ID="TextBox_NyBrugerNavn" class="form-control input-lg" type="text" name="text" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_navn" runat="server"
                                        ErrorMessage="Må ikke være tom"
                                        Text="Må ikke være tom!! * " 
                                        ControlToValidate="TextBox_NyBrugerNavn"
                                        Display="Dynamic" 
                                        ForeColor="Red"
                                        Font-Size="X-Small"
                                        CssClass="pull-right"
                                        ValidationGroup="Opret">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator_Navn" 
                                        runat="server"
                                        ControlToValidate="TextBox_NyBrugerNavn"
                                        ValidationExpression =".{3,100}"
                                        ForeColor="Red"
                                        Display="Dynamic" 
                                        ErrorMessage="Skriv dit navn! Der skal være min. 3 bogstaver"
                                        Font-Size="X-Small"
                                        CssClass="pull-right"
                                        ValidationGroup="Opret">
                                    </asp:RegularExpressionValidator>
				            </div>
				        <h3 class="col-xs-offset-1">Email</h3>
				            <div class="form-group">
                                <asp:TextBox ID="TextBox_BrugerEmail" class="form-control input-lg" name="email" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_Email" runat="server"
                                        ErrorMessage="Må ikke være tom"
                                        Text="Må ikke være tom * " 
                                        ControlToValidate="TextBox_BrugerEmail"
                                        Display="Dynamic" 
                                        ForeColor="Red"
                                        Font-Size="X-Small"
                                         CssClass="pull-right"
                                        ValidationGroup="Opret">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator_Email" 
                                        runat="server"
                                        ControlToValidate="TextBox_BrugerEmail"
                                        ValidationExpression ="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                        ForeColor="Red"
                                        Display="Dynamic" 
                                        ErrorMessage="Email er ikke gyldig. Eks.:bruger@gmail.com"
                                        Font-Size="X-Small"
                                        CssClass="pull-right"
                                        ValidationGroup="Opret">
                                    </asp:RegularExpressionValidator>
				            </div>

                        <h3 class="col-xs-offset-1">Kodeord</h3>
				            <div class="form-group">
                                <asp:TextBox ID="TextBox_Password" class="form-control input-lg" type="password" name="password" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ErrorMessage="Må ikke være tom"
                                        Text="Må ikke være tom * " 
                                        ControlToValidate="TextBox_Password"
                                        Display="Dynamic" 
                                        ForeColor="Red"
                                        Font-Size="X-Small"
                                         CssClass="pull-right"
                                        ValidationGroup="Opret">
                                    </asp:RequiredFieldValidator>
				            </div>
                         <h3 class="col-xs-offset-1">Verificer Kodeord</h3>
                            <div class="form-group">
                                <asp:TextBox ID="TextBox_VerificerPassword" class="form-control input-lg" type="password" name="password" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                        ErrorMessage="Må ikke være tom"
                                        Text="Må ikke være tom * " 
                                        ControlToValidate="TextBox_VerificerPassword"
                                        Display="Dynamic" 
                                        ForeColor="Red"
                                        Font-Size="X-Small"
                                         CssClass="pull-right"
                                        ValidationGroup="Opret">
                                    </asp:RequiredFieldValidator>
				            </div>
                        <asp:Button ID="Button_OpretBruger" class="btn btn-lg btn-primary btn-block" 
                                    OnClick="Button_OpretBruger_Click"  runat="server" 
                                    Text="Opret bruger" ValidationGroup="Opret" />
                        <br />
                        <asp:Label ID="Label_Status" ForeColor="Black" runat="server" ></asp:Label>
			        </fieldset>
		        </section>
	        </div>
        </div>
    </div>
</asp:Content>

