<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage_Adm.master" AutoEventWireup="true" CodeFile="RedFilm_Adm.aspx.cs" Inherits="Admin_RedFilm_Adm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="container-fluid">
        <div class="row">
            <div class="col-sm-9">
             <asp:Label ID="Label_Fejl" runat="server" Text="Label" Visible="false"></asp:Label>
<!--PlaceHolder_RedFilm slut -->
                <!-- Oprette en film-->
                <asp:PlaceHolder ID="PlaceHolder_RedFilm"  runat="server">
                        <h1><asp:Label ID="Label_RedFilm" runat="server" Text="Redigere Film"></asp:Label></h1>
                        <!--Film navn-->
                        <br />
                        <div class="row">
                            <div class="col-sm-8 col-md-10">
                                <br/>
                                <div role="form">
                                    <div class="form-group float-label-control">
                                        <label for="">Navn</label>
                                        <asp:TextBox ID="TextBox_FilmNavn" class="form-control" runat="server" ValidationGroup="Film"
                                                     ForeColor="White" placeholder="Navn"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_Navn" runat="server"
                                                    ErrorMessage="Må ikke være tom!!"
                                                    Text="Må ikke være tom!! * " 
                                                    ControlToValidate="TextBox_FilmNavn"
                                                    Display="Dynamic" 
                                                    ForeColor="Red"
                                                    Font-Size="X-Small"
                                                    CssClass="pull-right"
                                                    ValidationGroup="Film">
                                                </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator_Navn" 
                                                    runat="server"
                                                    ControlToValidate="TextBox_FilmNavn"
                                                    ValidationExpression =".{3,100}"
                                                    ForeColor="Red"
                                                    Display="Dynamic" 
                                                    ErrorMessage="Skriv filmnavn!"
                                                    Font-Size="X-Small"
                                                    CssClass="pull-right"
                                                    ValidationGroup="Film"
                                                    >
                                                </asp:RegularExpressionValidator>
                                                                      
                                    <div class="form-group float-label-control">
                                        <label for="">Beskrivelse</label>
                                           <asp:TextBox ID="TextBox_FilmBeskrivelse" class="form-control common" runat="server" rows="1"
                                                      ForeColor="White" TextMode="MultiLine" ValidationGroup="Film"  placeholder="Beskrivelse">
                                           </asp:TextBox>
                                    </div>

                                     
                                    <asp:DropDownList ID="DropDownList_Genre" AppendDataBoundItems="true" ValidationGroup="Film"
                                                      class="form-control ddlrolle" runat="server">
                                    </asp:DropDownList>
                                    <br />

                                    <asp:FileUpload ID="FileUpload_RedFilmPlakat"  runat="server" />
                                     <asp:Label ID="Label_FileUploadRedFilmPlakat"  runat="server" 
                                                Visible="false" ForeColor="Red" Text=""></asp:Label>
                                </div>

                            </div>
                        </div><!--/.row-->
                        <asp:Button ID="Button_RedFilm" CssClass="gem_knappen btn btn-default btn-md"  
                                    ValidationGroup="Film" OnClick="Button_RedFilm_Click" 
                                    runat="server" Text="Gem"/>

                     <asp:Label ID="Label_OpretFejl" runat="server" Text="Label" Visible="false"></asp:Label>
                </asp:PlaceHolder>
<!--PlaceHolder_RedFilm slut -->

                </div><!--/.col-sm-9-->
            </div><!--/.row-->  
        </div><!--/.container-->

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <script src="../Scripts/formscript.js"></script>
</asp:Content>

