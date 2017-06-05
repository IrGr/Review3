<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage_Adm.master" AutoEventWireup="true" CodeFile="RedGenrer_Adm.aspx.cs" Inherits="Admin_RedGenrer_Adm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="container-fluid">
        <div class="row">
            <div class="col-sm-9">
    <!-- Redigere en genre-->
                <asp:PlaceHolder ID="PlaceHolder_RedGenre"  runat="server">
                        <h1><asp:Label ID="Label_RedGenre" runat="server" Text="Redigere Genre"></asp:Label></h1>
                        <!--Genre navn-->
                        <br />
                        <div class="row">
                            <div class="col-sm-8 col-md-10">
                                <br/>
                                <div role="form">
                                    <div class="form-group float-label-control">
                                        <label for="">Genre</label>
                                        <asp:TextBox ID="TextBox_GenreNavn" class="form-control" runat="server" ForeColor="White" placeholder="Genre"></asp:TextBox>
                                       
                                    </div><!--/.form-group float-label-control-->
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator_Genre" runat="server"
                                            ErrorMessage="Må ikke være tomt!!"
                                            Text="Må ikke være tomt!! * " 
                                            ControlToValidate="TextBox_GenreNavn"
                                            Display="Dynamic" 
                                            ForeColor="Red"
                                            Font-Size="X-Small"
                                            CssClass="pull-right"
                                            ValidationGroup="Genre"
                                            >
                                        </asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator_Genre" 
                                            runat="server"
                                            ControlToValidate="TextBox_GenreNavn"
                                            ValidationExpression =".{3,100}"
                                            ForeColor="Red"
                                            Display="Dynamic" 
                                            ErrorMessage="Skriv en genre. Der skal være min. 3 bogstaver"
                                            Font-Size="X-Small"
                                            CssClass="pull-right"
                                            ValidationGroup="Genre"
                                            >
                                        </asp:RegularExpressionValidator>
                                </div>

                            </div>
                        </div><!--row-->
                        <asp:Button ID="Button_RedGenre" CssClass="gem_knappen btn btn-default btn-md"  
                                    ValidationGroup="Genre" OnClick="Button_NyGenre_Click"
                                    runat="server" Text="Gem"/>
                
                     <asp:Label ID="Label_RedFejl" runat="server" Text="Label" Visible="false"></asp:Label>
                </asp:PlaceHolder>
            </div><!--/.col-sm-9-->
        </div><!--/.row-->  
    </div><!--/.container-->
<!--PlaceHolder_RedGenre slut -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <script src="../Scripts/formscript.js"></script>
</asp:Content>

