<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Filmliste.aspx.cs" Inherits="Filmliste" %>
<%@ Register Assembly="ASPnetRater" Namespace="ASPnetRater" TagPrefix="cc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
   <%--     <div class="row">--%>
           <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:Repeater ID="Repeater_Filmliste" runat="server">
                <ItemTemplate>
                        <div class="row film_fra_liste">
                            <asp:HyperLink ID="HyperLink_EnFilm" NavigateURL='<%# "Film.aspx?id=" + Eval("film_id") %>' runat="server">

                                <div class="col-xs-4 col-md-4">
                                    <asp:Image ID="Image_Filmliste" CssClass="img-responsive" ImageUrl='<%# "images/plakater/" + Eval("bill_sti")%>' runat="server" />
                                </div>
                                <div class="col-xs-8 col-md-8"> 
                                    <h3><%# Eval("film_navn") %></h3>
                                </div>

                             
                                 <cc2:Rater
                                            ImageOn="/images/star_icons/filled_star.gif"
                                            ImageOff="/images/star_icons/emptystar.gif"
                                            ImageOver="/images/star_icons/waitingstar.gif"
                                            Value= '<%#Eval("rate_avg_int") %>'
                                            MaxValue="5"
                                            runat="server" Enabled="False" />


                             </asp:HyperLink>
                        </div><!--/Repeater_Filmliste.row-->
                    
                </ItemTemplate>
            </asp:Repeater>
         <%--  </div>.row--%>
    </div><!--/.container-->
</asp:Content>

