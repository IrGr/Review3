<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BrugerProfil.aspx.cs" Inherits="BrugerProfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">

        <asp:Label ID="Label_RedigeringStatus" runat="server" ForeColor="Black" Visible="false" Text="Label"></asp:Label>

        <div class="row profilpunkt">
            <div class="col-xs-2">
                <i class="fa fa-user fa-3x"></i>
            </div>
            <div class="col-xs-10">
                <asp:Label ID="Label_ProfilBrugerNavn" CssClass="text-uppercase" runat="server" Text="Label"></asp:Label>
                <asp:TextBox ID="TextBox_ProfilBrugerNavn" CssClass="form-control input-lg" Visible="false" runat="server"></asp:TextBox>
            </div>
        </div>
       
        <!--Email-->
         <div class="row profilpunkt">
            <div class="col-xs-2">
                <i class="fa fa-pencil-square-o fa-3x"></i>
            </div>
            <div class="col-xs-10">
                <div class="row">
                    <div class="col-xs-9">
                        <asp:Label ID="LabelProfilEmail"  class="col-xs-10 editable" runat="server" Text="Label"></asp:Label>
                    </div>
                     <div class="col-xs-3">
                        <span data-placement="top" data-toggle="tooltip" title="Edit" runat="server">
                            <asp:LinkButton ID="LinkButton_RedEmail" 
                                            class="btn btn-primary btn-xs" 
                                            data-title="Edit" 
                                            OnClick="Button_RedEmail_Click"
                                            runat="server">
                                <span class="glyphicon glyphicon-floppy-disk"></span>
                            </asp:LinkButton>
<%--  data-toggle="modal" <i class="fa fa-pencil icon-ok icon-white"></i> --%>
                        </span>
                    </div><!--col-xs-3-->
                </div><!--/.row-->
            </div> 
        </div><!--/.row-->

         <!--Genre-->
         <div class="row profilpunkt">
            <div class="col-xs-2">
                <i class="fa fa-flag-o fa-3x"></i>
            </div>
            <div class="col-xs-10">
                 <div class="row">
                     <div class="col-xs-9">
                        <asp:Label ID="Label_FavoritGenre" runat="server" CssClass="edit"  Text="Du har ikke favoritgenre endnu"></asp:Label>
                        <asp:DropDownList ID="DropDownList_FavoritGenre" Visible="true"
                                          AppendDataBoundItems="true" runat="server" >
                        </asp:DropDownList><%--AppendDataBoundItems="true"--%>
                     </div>
                 
                    <div class="col-xs-3">
                        <span data-placement="top" data-toggle="tooltip" title="Edit" runat="server">
                            <asp:LinkButton ID="LinkButton_FavoritGenre" 
                                            class="btn btn-primary btn-xs" 
                                            data-title="Edit" 
                                            OnClick="LinkButton_FavoritGenre_Click"
                                            runat="server">
                                <span class="glyphicon glyphicon-floppy-disk"></span>
                            </asp:LinkButton>
                        </span>
                     </div>
                 </div>
            </div>
        </div>

        <!--Kodeord-->
         <div class="row profilpunkt">
            <div class="col-xs-2">
                <i class="fa fa-lock fa-3x"></i>
            </div>
            <div class="col-xs-10">
                <div class="row">
                    <div class="col-xs-9">
                        <asp:Label ID="LabelKodeord"  runat="server" CssClass="editable" Text="Ændre kodeord"></asp:Label>
                    </div>
                    <div class="col-xs-3">
                            <span data-placement="top" data-toggle="tooltip" title="Edit" runat="server">
                                <asp:LinkButton ID="LinkButton_Kodeord" 
                                                class="btn btn-primary btn-xs" 
                                                data-title="Edit" 
                                                OnClick="LinkButton_Kodeord_Click"
                                                runat="server">
                                    <span class="glyphicon glyphicon-floppy-disk"></span>
                                </asp:LinkButton>
                            </span>
                    </div>
                </div>
            </div>
        </div>

        <!--Nyhedsbrev-->
         <div class="row">
            <div class="col-xs-2">
                <i class="fa fa-envelope-o fa-3x"></i>
            </div>
            <div class="col-xs-6">
                <asp:Label ID="Label_Nyhedsbrev" runat="server" Text="Nyhedsbrev"></asp:Label>
                <asp:TextBox ID="TextBox_Nyhedsbrev" CssClass="form-control input-lg" Visible="false" runat="server"></asp:TextBox>
           </div>
           <div class="checkbox col-xs-4">
                <label>
                    <input type="checkbox"/> Tilmeldt
                </label>
           </div>
        </div>


        <!--linkbutton SletProfil-->
        <asp:LinkButton ID="LinkButton_SletBruger" href="SletBruger.aspx"
                        CssClass="btn btn-default btn-xs col-md-offset-10 col-xs-offset-10" 
                        runat="server">Slet Profil</asp:LinkButton>


        <div class="row">
             <div class="col-xs-12 reklamebox">
               <div class="row">   
                 <asp:Image ID="Image_Reklam" CssClass="img-responsive center-block" runat="server" />
               </div>
            </div><!--Reklamebox-->
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">

    
    <!--Editable Label: Convert a Label to TextBox when clicked using jQuery in ASP.Net-->
    <script type="text/javascript">
        $(function () {
            //Loop through all Labels with class 'editable'.
            $(".editable").each(function () {
                $(this).closest(".row").find(".btn").attr("style", "visibility: hidden");


                //Reference the Label.
                var label = $(this);
                //Add a TextBox next to the Label.
                label.after("<input type = 'text' style = 'display:none; color:#000' />");


                //Reference the TextBox.
                var textbox = $(this).next();

                //Set the name attribute of the TextBox.
                var id = this.id.split('_')[this.id.split('_').length - 1];
                textbox[0].name = id.replace("Label", "TextBox");

                //Assign the value of Label to TextBox.
                textbox.val(label.html());

                //When Label is clicked, hide Label and show TextBox.
                label.click(function () {
                    $(this).hide();
                    $(this).next().show();
                    $(this).closest(".row").find(".btn").attr("style", "visibility: visible");
                   
                });

                //When focus is lost from TextBox, hide TextBox and show Label.
                textbox.focusout(function () {
                    $(this).hide();
                    $(this).prev().html($(this).val());
                    $(this).prev().show();
                });
            });
        });
</script>


    <script type="text/javascript">
        $(function () {
            //Loop through all Labels with class 'edit'.
            $(".edit").each(function () {
                $(this).closest(".row").find(".btn").attr("style", "visibility: hidden");

                //Reference the Label.
                var label = $(this);

                //Reference the DropdownList.
                var drwlist = $(this).next();
                drwlist.attr("style", "visibility: hidden");

                //Assign the value of Label to DropdownList.
                drwlist.val(label.html());

                //When Label is clicked, hide Label and show DropdownList.
                label.click(function () {
                    $(this).hide();
                    $(this).next().attr("style", "visibility: visible");
                    $(this).closest(".row").find(".btn").attr("style", "visibility: visible");
                   
                });

                //When focus is lost from TextBox, hide DropdownList and show Label.
                drwlist.focusout(function () {
                    $(this).attr("style", "visibility: hidden");
                    if ($(this).find("option:selected").text()) {
                        $(this).prev().html($(this).find("option:selected").text());
                    }
                    else
                    {
                        $(this).closest(".row").find(".btn").attr("style", "visibility: hidden");
                    }
                    $(this).prev().show();
                });
                
            });
        });
</script>
</asp:Content>


