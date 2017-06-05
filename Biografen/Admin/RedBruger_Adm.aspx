<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage_Adm.master" AutoEventWireup="true" CodeFile="RedBruger_Adm.aspx.cs" Inherits="Admin_RedBruger_Adm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-9">
                <asp:Label ID="Label_fejl" runat="server" Text="Label" Visible="false"></asp:Label>
 <!-- Redigere brugeren-->
                <asp:PlaceHolder ID="PlaceHolder_RedBruger" Visible="true" runat="server">
                  
                        <!--Bruger navn-->
                        <br />
                        <div class="row">
                            <div class="col-sm-8 col-md-10">
                                <br/>
                                <div role="form">
                                    <div class="form-group float-label-control">
                                        <label for="">Navn</label>
                                        <asp:TextBox ID="TextBox_BrugerNavn" class="form-control" runat="server" ValidationGroup="RedBruger"
                                                     ForeColor="White" placeholder="Navn"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_Navn" runat="server"
                                        ErrorMessage="Må ikke være tom!!"
                                        Text="Må ikke være tom!! * " 
                                        ControlToValidate="TextBox_BrugerNavn"
                                        Display="Dynamic" 
                                        ForeColor="Red"
                                        Font-Size="X-Small"
                                        CssClass="pull-right"
                                        ValidationGroup="RedBruger">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator_Navn" 
                                        runat="server"
                                        ControlToValidate="TextBox_BrugerNavn"
                                        ValidationExpression =".{3,100}"
                                        ForeColor="Red"
                                        Display="Dynamic" 
                                        ErrorMessage="Skriv dit navn!"
                                        Font-Size="X-Small"
                                        CssClass="pull-right"
                                        ValidationGroup="RedBruger"
                                        >
                                    </asp:RegularExpressionValidator>
                                     <div class="form-group float-label-control">
                                        <label for="">Email</label>
                                        <asp:TextBox ID="TextBox_Email" class="form-control" runat="server" ValidationGroup="RedBruger"
                                                     ForeColor="White"  placeholder="Email"></asp:TextBox>
                                    </div>
                  
                                        <asp:DropDownList ID="DropDownList_Rolle" AppendDataBoundItems="true" 
                                                          class="form-control ddlrolle" runat="server"
                                                          ValidationGroup="RedBruger"></asp:DropDownList>
                                </div><!--/rolle="form"-->
                            </div>
                        </div><!--/.row-->
                        <asp:Button ID="Button_RedBruger" CssClass="gem_knappen btn btn-default btn-md"  
                                    ValidationGroup="RedBruger" OnClick="Button_RedBruger_Click"
                                    runat="server" Text="Gem"/>
                
                  
                     <asp:Label ID="Label_RedFejl" runat="server" Text="Label" Visible="false"></asp:Label>
                </asp:PlaceHolder>
<!--PlaceHolder_NyBruger slut -->

            </div><!--/.col-sm-9-->
        </div><!--/.row-->
    </div><!--/.container-->

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <script src="../Scripts/formscript.js"></script>
</asp:Content>

