<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Film.aspx.cs" Inherits="Film" %>

<%@ Register Assembly="ASPnetRater" Namespace="ASPnetRater" TagPrefix="cc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">



        <asp:PlaceHolder ID="PlaceHolder_FilmInfo" Visible="false" runat="server">
         <div class="row">
            <div class="col-xs-4 col-sm-4 col-md-4">
                 <asp:Image ID="Img_Film" CssClass="img-responsive" AlternateText="billede af filmen" runat="server" />
            </div>

            <div class="col-xs-8 col-sm-8 col-md-8">
                <h2 >
                     <asp:Label ID="Lbl_FilmenOverskrift" runat="server" Text="Label"></asp:Label> 
                </h2>
                
                <p>
                    <asp:Label ID="Lbl_FilmenBeskrivelse" runat="server" Text="Label"></asp:Label>
                </p>
            </div>
          </div>
        </asp:PlaceHolder>




        <asp:PlaceHolder ID="PlaceHolder_UkendtUrl" Visible="true" runat="server">
            <h3> Der skete desværre en fejl</h3>
            <p> SIDEN FINDES IKKE
                Vi kunne ikke finde den efterspurgte side. Det kan skyldes, at siden ikke findes, at siden er flyttet eller at linket er skrevet forkert.</p> 
            <asp:HyperLink ID="HyperLink_LinkTilFilmListe" NavigateUrl="~/Filmliste.aspx" runat="server">Klik her for at komme til filmliste.</asp:HyperLink>
        </asp:PlaceHolder>


<!--Rating-->
        <asp:PlaceHolder ID="PlaceHolder_Rating" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            
            <cc2:Rater ID="Rater1" 
                ImageOn="/images/star_icons/filled_star.gif"
                ImageOff="/images/star_icons/emptystar.gif"
                ImageOver="/images/star_icons/waitingstar.gif" 
                Value="3"
                MaxValue="5"
                OnCommand="Rater1_Command"
                runat="server"/>
            <br />   <br />
            <p id ="din_bedomelse" runat="server">Din bedømmelse:<asp:Label ID="Lbl_RatingStatus" runat="server" Text=""></asp:Label></p>

            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
        </asp:PlaceHolder>

        <asp:PlaceHolder ID="PlaceHolder_Anmeldelser" runat="server">
             <div class="col-xs-12 reklamebox">
                 <div class="row">
                     <asp:Repeater ID="Repeater_Anmeldelse" runat="server">
                         <ItemTemplate>
                             <article>
                                <p>Anmeldelse af bruger:<strong> <%# Eval("bruger_navn") %></strong></p>
                                <p>' <%#Eval("anm_tekst") %>'</p>
                             </article>
                         </ItemTemplate>
                    </asp:Repeater>
                 </div>
             </div><!--Anmeldelsebox-->
        </asp:PlaceHolder>
        <asp:Label ID="Label_Fejl" Visible="false" runat="server" Text="Label"></asp:Label>
  </div>

</asp:Content>

