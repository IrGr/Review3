<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage_Adm.master" AutoEventWireup="true" CodeFile="Genrer_Adm.aspx.cs" Inherits="Admin_Genrer_Adm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-9">
<!--PlaceHolder_Genrer start -->
                 <asp:PlaceHolder ID="PlaceHolder_Genrer" runat="server">
                    <div class="row col-md-12 custyle">
                      <div class="table-responsive">
                        <table class="table table-striped custab table-hover">
                            <thead>
                                <asp:LinkButton ID="LinkButton_AddGenre" class="btn btn-primary btn-xs pull-right" 
                                                OnClick="LinkButton_AddGenre_Click" 
                                                runat="server"><b>+</b> Tilføj en ny genre</asp:LinkButton>
                                <tr>
                                    <th>ID</th>
                                    <th>Genre</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                             <asp:PlaceHolder ID="PlaceHolder_GenreTabel" runat="server">
                                <asp:Repeater ID="Repeater_GenreTabel" OnItemCommand="Repeater_GenreTabel_ItemCommand"  runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="topalign"><%# Eval("genre_id") %></td>
                                            <td class="topalign"><%# Eval("genre_navn") %></td>
                                            
                                            <td class="text-center topalign">
                                                <asp:LinkButton ID="LinkButton_Edit" class='btn btn-info btn-xs' href='<%#"RedGenrer_Adm.aspx?id=" + Eval("genre_id") %>' 
                                                                 runat="server">
                                                    <span class="glyphicon glyphicon-edit" ></span>Ret</asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton_Delete" class="btn btn-danger btn-xs" 
                                                                CommandArgument='<%# Eval("genre_id") %>' CommandName="Sletgenren" 
                                                                OnClientClick="return confirm ('Er du sikker??');"
                                                                runat="server">
                                                <span class="glyphicon glyphicon-remove"></span> Slet</asp:LinkButton><%-- --%>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </asp:PlaceHolder>
                        </table>
                      </div><%--/.table-responsive--%>

                    </div><%--/.row col-md-12 custyle--%>
                  </asp:PlaceHolder>
<!--PlaceHolder_Brugere slut -->
                 <asp:Label ID="Label_fejl" runat="server" Text="Label" Visible="false"></asp:Label>

             <!-- Oprette en genre-->
                <asp:PlaceHolder ID="PlaceHolder_NyGenre" Visible="false" runat="server">
                        <h1><asp:Label ID="Label_NyGenre" runat="server" Text="Ny Genre"></asp:Label></h1>
                        <!--Genre navn-->
                        <br />
                        <div class="row">
                            <div class="col-sm-8 col-md-10">
                                <br/>
                                <div role="form">
                                    <div class="form-group float-label-control">
                                        <label for="">Genre</label>
                                        <asp:TextBox ID="TextBox_GenreNavn" class="form-control" runat="server"  ValidationGroup="Genre"
                                                     ForeColor="White" placeholder="Genre"></asp:TextBox>
                                       
                                    </div><!--/.form-group float-label-control-->
                                </div>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator_Genre" runat="server"
                                            ErrorMessage="Må ikke være tomt!!"
                                            Text="Må ikke være tomt!! * " 
                                            ControlToValidate="TextBox_GenreNavn"
                                            Display="Dynamic" 
                                            ForeColor="Red"
                                            Font-Size="X-Small"
                                            CssClass="pull-right"
                                            ValidationGroup="Genre">
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
                        </div><!--row-->
                        <asp:Button ID="Button_NyGenre" CssClass="gem_knappen btn btn-default btn-md"  
                                    ValidationGroup="Genre" OnClick="Button_NyGenre_Click"
                                    runat="server" Text="Gem"/>
                
                     <asp:Label ID="Label_OpretFejl" runat="server" Text="Label" Visible="false"></asp:Label>
                </asp:PlaceHolder>
<!--PlaceHolder_NyGenre slut -->

                </div><!--/.col-sm-9-->
            </div><!--/.row-->  
        </div><!--/.container-->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <script src="../Scripts/formscript.js"></script>
</asp:Content>

