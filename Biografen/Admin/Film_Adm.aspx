<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage_Adm.master" AutoEventWireup="true" CodeFile="Film_Adm.aspx.cs" Inherits="Admin_Film_Adm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-9">
<!--PlaceHolder_Film start -->
                  <asp:PlaceHolder ID="PlaceHolder_Film" runat="server">
                    <div class="row col-md-12 custyle">
                      <div class="table-responsive">
                        <table id="filmtabel" class="table table-striped custab table-hover">
                            <thead>
                                <asp:LinkButton ID="LinkButton_AddFilm" 
                                                class="btn btn-primary btn-xs pull-right" 
                                                OnClick="LinkButton_AddFilm_Click"
                                                runat="server"><b>+</b> Tilføj ny film</asp:LinkButton>
                                <tr>
                                    <th>ID</th>
                                    <th>Navn</th>
                                    <th>Beskrivelse</th>
                                    <th>Genre</th>
                                    <th>Plakat</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                             <asp:PlaceHolder ID="PlaceHolder_FilmTabel" runat="server">
                                <asp:Repeater ID="Repeater_FilmTabel" OnItemCommand="Repeater_FilmTabel_ItemCommand"  runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="topalign "><%# Eval("film_id") %></td>
                                            <td class="topalign "><%# Eval("film_navn") %></td>
                                            <td class="topalign "><%# Eval("film_beskr") %></td>
                                            <td class="topalign "><%# Eval("genre_navn") %></td>
                                            <td>
                                                <asp:Image ID="Image_Plakat" CssClass="img_responsive responsive-plakat" AlternateText="filmplakat" 
                                                           ImageUrl='<%#"~/images/plakater/" + (Eval("bill_sti").ToString().Length>0 ? Eval("bill_sti") : "billede_paa_vej.jpg")%>' 
                                                           runat="server" />
                                            </td>
                                            <td class="text-center topalign col-xs-2">
                                                <asp:LinkButton ID="LinkButton_Edit" class='btn btn-info btn-xs' 
                                                                href='<%#"RedFilm_Adm.aspx?id=" + Eval("film_id") %>' 
                                                                runat="server">
                                                    <span class="glyphicon glyphicon-edit" ></span> Ret</asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton_Delete" class="btn btn-danger btn-xs" 
                                                                                    CommandArgument='<%# Eval("film_id") %>' CommandName="SletFilm" 
                                                                                    OnClientClick="return confirm ('Er du sikker??');" runat="server">
                                                <span class="glyphicon glyphicon-remove"></span> Slet</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </asp:PlaceHolder>
                        </table>
                     </div> <%--/.table-responsive--%>
                    </div><%--/.row col-md-12 custyle--%>
                  </asp:PlaceHolder>
<!--PlaceHolder_Film slut -->  
        <asp:Label ID="Label_Fejl" runat="server" Text="Label" Visible="false"></asp:Label>
                       
<!--PlaceHolder_NyFilm slut -->
                <!-- Oprette en film-->
                <asp:PlaceHolder ID="PlaceHolder_NyFilm" Visible="false" runat="server">
                        <h1><asp:Label ID="Label_NyFilm" runat="server" Text="Ny Film"></asp:Label></h1>
                        <!--Film navn-->
                        <br />
                        <div class="row">
                            <div class="col-sm-8 col-md-10">
                                <br/>
                                <div role="form">
                                    <div class="form-group float-label-control">
                                        <label for="">Navn</label>
                                        <asp:TextBox ID="TextBox_FilmNavn" class="form-control" 
                                                     runat="server" ForeColor="White" placeholder="Navn" 
                                                     ValidationGroup="Film"></asp:TextBox>
                                       
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
                                           <asp:TextBox ID="TextBox_FilmBeskrivelse" class="form-control common" runat="server"
                                                      ForeColor="White" TextMode="MultiLine"  placeholder="Beskrivelse"
                                                      ValidationGroup="Film">
                                           </asp:TextBox>
                                    </div>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator_Beskrivelse" runat="server"
                                        ErrorMessage="Må ikke være tom!!"
                                        Text="Må ikke være tom!! * " 
                                        ControlToValidate="TextBox_FilmBeskrivelse"
                                        Display="Dynamic" 
                                        ForeColor="Red"
                                        Font-Size="X-Small"
                                        CssClass="pull-right"
                                        ValidationGroup="Film">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator_Beskrivelse" 
                                        runat="server"
                                        ControlToValidate="TextBox_FilmBeskrivelse"
                                        ValidationExpression =".{3,1000}"
                                        ForeColor="Red"
                                        Display="Dynamic" 
                                        ErrorMessage="Skriv beskrivelse!"
                                        Font-Size="X-Small"
                                        CssClass="pull-right"
                                        ValidationGroup="Film"
                                        >
                                    </asp:RegularExpressionValidator>
                                     
                                    <asp:DropDownList ID="DropDownList_Genre" AppendDataBoundItems="true" 
                                                      class="form-control ddlrolle" runat="server" ValidationGroup="Film">
                                    </asp:DropDownList>
                                    <br />

                                    <asp:FileUpload ID="FileUpload_NyFilmPlakat" runat="server" />
                                     <asp:Label ID="Label_FileUploadNyFilmPlakat"  runat="server" 
                                                Visible="false" ForeColor="Red" Text=""></asp:Label>
                                </div>

                            </div>
                        </div><!--/.row-->
                        <asp:Button ID="Button_NyFilm" CssClass="gem_knappen btn btn-default btn-md"  
                                    ValidationGroup="Film" OnClick="Button_NyFilm_Click" 
                                    runat="server" Text="Gem"/>

                     <asp:Label ID="Label_OpretFejl" runat="server" Text="Label" Visible="false"></asp:Label>
                </asp:PlaceHolder>
<!--PlaceHolder_NyFilm slut -->

                </div><!--/.col-sm-9-->
            </div><!--/.row-->  
        </div><!--/.container-->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <!--Textarea autoresize-->
    <script>
        var txt = $('#ContentPlaceHolder1_TextBox_FilmBeskrivelse'),
            hiddenDiv = $(document.createElement('div')),
            content = null;

        txt.addClass('txtstuff');
        hiddenDiv.addClass('hiddendiv common');

        $('body').append(hiddenDiv);

        txt.on('keyup', function () {

            content = $(this).val();

            content = content.replace(/\n/g, '<br>');
            hiddenDiv.html(content + '<br class="lbr">');

            $(this).css('height', hiddenDiv.height());

        });
    </script>
    <script src="../Scripts/formscript.js"></script>

</asp:Content>

