<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <title>Forside: Biografen</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
         <div class="row">
            <asp:HyperLink ID="HyperLink_EnFilm" NavigateUrl="#" runat="server">
                <div class="col-xs-4 col-sm-4 col-md-4">
                        <asp:Image ID="RandomImg_Forside" CssClass="img-responsive" AlternateText="filmplakat"
                                   ImageUrl='<%#"images/" + Eval("fk_film_id")%>' runat="server" />
                </div>
                <div class="col-xs-8 col-sm-8 col-md-8">
                    <h2>
                        <asp:Label ID="Label_Overskrift" runat="server" Text="Label"></asp:Label>
                    </h2>
                
                    <p>
                        <asp:Label ID="Label_Beskrivelse" runat="server" Text="Label"></asp:Label>
                    </p>
                
                    <h4>
                        <asp:Label ID="Label_Rating" runat="server" Text="Label"></asp:Label>
                    </h4>
                </div>
            </asp:HyperLink>
            
             <!--reklamebox-->
            
           <div class="col-xs-12 reklamebox">
                 <div class="row">
                    <asp:Image ID="Image_Reklam" CssClass="img-responsive center-block" runat="server" />
                </div>
             </div><!--reklamebox-->
        </div>
  </div>

</asp:Content>

