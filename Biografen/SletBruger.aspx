<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SletBruger.aspx.cs" Inherits="SletBruger" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <div class="row">
           
            <h1 style="color:red">Er du sikke, at du vil slette brugeren <b><%=Session[NavnKonstant.SessionBrugerNavn]%></b>?</h1><br />
  
              <asp:Button id="YesButton" class="btn btn-primary col-xs-3 col-sm-2 col-md-2"  Text="Yes" OnClick="YesButton_OnClick" runat="server" />
              <asp:Button id="CancelButton" class="btn btn-default col-xs-3 col-sm-2 col-md-2"  Text="Cancel" OnClick="CancelButton_OnClick"  runat="server" />
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>

