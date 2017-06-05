<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage_Adm.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="Default_Adm.aspx.cs" Inherits="Admin_Default_Adm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="container-fluid">
    <div class="row">
        
        <div class="col-sm-9">
            <asp:PlaceHolder ID="PlaceHolder_Forsiden" runat="server">
            <!-- column 2 -->
            <strong><i class="glyphicon glyphicon-dashboard"></i> Mit Dashboard</strong>
            <hr>

            <div class="row">
                <!-- center left-->
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4>Kommende film</h4></div>
                        <div class="panel-body">
                            <asp:Repeater ID="Repeater_ForsFilm" runat="server">
                                <ItemTemplate>
                                    <div class="row">
                                        <div class="col-md-4 col-xs-4">
                                            <asp:Image ID="Image_ForsFilm" CssClass="img-responsive" ImageUrl='<%# "../images/plakater/" + Eval("bill_sti") %>' runat="server" />
                                        </div>
                                        <div class="col-md-8 col-xs-8">
                                            <h1  runat="server">
                                                <asp:Label ID="Label_FilmNavn" runat="server" ForeColor="Black" Text='<%#Eval("film_navn") %>'></asp:Label>
                                            </h1>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
                <!--/col-->
                <div class="col-md-6">
                    <asp:PlaceHolder ID="PlaceHolder_GenreTab" runat="server">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Genre</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <asp:Repeater ID="Repeater_GenreTab" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%#Eval("genre_id") %></td>
                                                <td><%#Eval("genre_navn") %></td>
                                            </tr>
                                        </ItemTemplate>
                                </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                     </asp:PlaceHolder>
                </div>
                <!--/col-span-6-->

            </div>
            <!--/row-->

<!--Repeater_Anmeldelser-->
            <hr>

            <strong><i class="glyphicon glyphicon-comment"></i> Anmeldelser</strong>

            <hr>

            <div class="row">
                <div class="col-md-12">
                    <ul class="list-group">
                        <asp:Repeater ID="Repeater_Anmeldelser" runat="server">
                            <ItemTemplate>
                                <li class="list-group-item">
                                    <a href="#"><%# IdToImage(Eval("godkendt")) + " "%><small><%# Eval("anm_date", "{0:dd/M/yyyy}") + " " %></small> <%#Eval("anm_tekst") %></a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
            </asp:PlaceHolder>
           <asp:Label ID="Label_Fejl" Visible="false" runat="server" Text="Label"></asp:Label>
        </div>
        <!--/col-span-9-->
    </div>
</div>
<!-- /Main -->


</asp:Content>

