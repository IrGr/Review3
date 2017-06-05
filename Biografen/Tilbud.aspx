<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Tilbud.aspx.cs" Inherits="Tilbud" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <div class="row">
            <asp:Repeater ID="Repeater_Tilbud" runat="server">
                <ItemTemplate>
                    <div class="col-xs-6 col-md-4">
                        <div class="thumbnail">
                            <asp:Image ID="Image_Tilbud" ImageUrl='<%# "~/images/tilbud/"+ Eval("bill_sti") %>' runat="server" />
                            <div class="caption">
                                <h3><%# Eval("Tilbud_tekst") %></h3>
                            </div>
                        </div><!--/.thumbnail-->
                    </div><!--/.col-xs-4 col-md-2-->
                </ItemTemplate>
           </asp:Repeater><!--/#Repeater_Tilbud-->
            <asp:Image ID="Image_GestTilbud" runat="server" />
        </div><!--/.row-->
    </div><!--/.container-->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
       <!--.thumbnail script // gør alle kolonner med samme højde -->
    <script>
        function equalHeight(group) {
            var tallest = 0;
            group.each(function () {
                var thisHeight = $(this).height();
                if (thisHeight > tallest) {
                    tallest = thisHeight;
                }
            });
            group.each(function () { $(this).height(tallest); });
        }

        $(document).ready(function () {
            equalHeight($(".thumbnail .caption"));
        });
 </script>
</asp:Content>

