<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage_Adm.master" AutoEventWireup="true" CodeFile="Brugere_Adm.aspx.cs" Inherits="Admin_Brugere_Adm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="container-fluid">
        <div class="row">
            <div class="col-sm-9">
<!--PlaceHolder_Brugere start -->
                 <asp:PlaceHolder ID="PlaceHolder_Brugere" runat="server">
                    <div class="row col-md-12 custyle">
                      <div class="table-responsive">
                        <table class="table table-striped custab table-hover">
                            <thead>
                                <asp:LinkButton ID="LinkButton_AddBruger" class="btn btn-primary btn-xs pull-right"  OnClick="LinkButton_AddBruger_Click"
                                                runat="server"><b>+</b> Tilføj en ny bruger</asp:LinkButton>
                                <tr>
                                    <th>ID</th>
                                    <th>Navn</th>
                                    <th>Email</th>
                                    <th>Genre</th>
                                    <th>Rolle</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                             <asp:PlaceHolder ID="PlaceHolder_BrugereTabel" runat="server">
                                <asp:Repeater ID="Repeater_BrugereTabel" OnItemCommand="Repeater_BrugereTabel_ItemCommand" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="topalign"><%# Eval("bruger_id") %></td>
                                            <td class="topalign"><%# Eval("bruger_navn") %></td>
                                            <td class="topalign"><%# Eval("bruger_email") %></td>
                                            <td class="topalign"><%# Eval("genre_navn") %></td>
                                            <td class="topalign"><%# Eval("rolle_navn") %></td>
                                            <td class="text-center topalign">
                                                <asp:LinkButton ID="LinkButton_Edit" class='btn btn-info btn-xs' href='<%#"RedBruger_Adm.aspx?id=" + Eval("bruger_id") %>' 
                                                                 runat="server">
                                                    <span class="glyphicon glyphicon-edit" ></span>Ret</asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton_Delete" class="btn btn-danger btn-xs" 
                                                                CommandArgument='<%# Eval("bruger_id") %>' 
                                                                CommandName="Sletbruger" 
                                                                OnClientClick="return confirm ('Er du sikker??');"
                                                                runat="server">
                                                <span class="glyphicon glyphicon-remove"></span> Slet</asp:LinkButton>
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
 <!-- Oprette en bruger-->
                <asp:PlaceHolder ID="PlaceHolder_NyBruger" Visible="false" runat="server">
            
                        <h1><asp:Label ID="Label_NyBruger" runat="server" Text="Ny Bruger"></asp:Label></h1>
                        <!--Bruger navn-->
                        <br />

                        <div class="row">
                            <div class="col-sm-8 col-md-10">
                                <br/>
                                <div role="form">
                                    <div class="form-group float-label-control">
                                        <label for="">Navn</label>
                                        <asp:TextBox ID="TextBox_BrugerNavn" class="form-control" runat="server" ForeColor="White" placeholder="Navn"></asp:TextBox>
                                        
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_Navn" runat="server"
                                        ErrorMessage="Må ikke være tom!!"
                                        Text="Må ikke være tom!! * " 
                                        ControlToValidate="TextBox_BrugerNavn"
                                        Display="Dynamic" 
                                        ForeColor="Red"
                                        Font-Size="X-Small"
                                        CssClass="pull-right"
                                        ValidationGroup="Bruger">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator_Navn" 
                                        runat="server"
                                        ControlToValidate="TextBox_BrugerNavn"
                                        ValidationExpression =".{3,100}"
                                        ForeColor="Red"
                                        Display="Dynamic" 
                                        ErrorMessage="Skriv dit navn!"
                                        Font-Size="X-Small"
                                        CssClass="pull-right"
                                        ValidationGroup="Bruger"
                                        >
                                    </asp:RegularExpressionValidator>
                                    <div class="form-group float-label-control">
                                        <label for="">Password</label>
                                        <asp:TextBox ID="TextBox_Password" class="form-control" 
                                                     runat="server" TextMode="Password" 
                                                     ForeColor="White" ValidationGroup="Bruger"
                                                     placeholder="Password"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_Password" runat="server"
                                        ErrorMessage="Må ikke være tom"
                                        Text="Må ikke være tom * " 
                                        ControlToValidate="TextBox_Password"
                                        Display="Dynamic" 
                                        ForeColor="Red"
                                        Font-Size="X-Small"
                                         CssClass="pull-right"
                                        ValidationGroup="Bruger">
                                    </asp:RequiredFieldValidator>

                                     <div class="form-group float-label-control">
                                        <label for="">Email</label>
                                        <asp:TextBox ID="TextBox_Email" class="form-control"
                                                     ValidationGroup="Bruger" runat="server"
                                                     ForeColor="White"  placeholder="Email"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_Email" runat="server"
                                        ErrorMessage="Må ikke være tom"
                                        Text="Må ikke være tom * " 
                                        ControlToValidate="TextBox_Email"
                                        Display="Dynamic" 
                                        ForeColor="Red"
                                        Font-Size="X-Small"
                                        CssClass="pull-right"
                                        ValidationGroup="Bruger">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator_Email" 
                                        runat="server"
                                        ControlToValidate="TextBox_Email"
                                        ValidationExpression ="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                        ForeColor="Red"
                                        Display="Dynamic" 
                                        ErrorMessage="Email er ikke gyldig. Eks.:bruger@gmail.com"
                                        Font-Size="X-Small"
                                        CssClass="pull-right"
                                        ValidationGroup="Bruger">
                                    </asp:RegularExpressionValidator>
                  
                                        <asp:DropDownList ID="DropDownList_Rolle" AppendDataBoundItems="true"
                                                          ValidationGroup="Bruger" class="form-control ddlrolle" 
                                                          runat="server">
                                        </asp:DropDownList>
                                </div>

                            </div>
                        </div>
                        <asp:Button ID="Button_NyBruger" CssClass="gem_knappen btn btn-default btn-md"  
                                    ValidationGroup="Bruger" OnClick="Button_NyBruger_Click" 
                                    runat="server" Text="Gem"/>
                
                 
                     <asp:Label ID="Label_OpretFejl" runat="server" Text="Label" Visible="false"></asp:Label>
                </asp:PlaceHolder>
<!--PlaceHolder_NyBruger slut -->

            </div><!--/.col-sm-9-->
        </div><!--/.row-->
    </div><!--/.container-->
</asp:Content>



<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">

    <!-- http://bootsnipp.com/snippets/vvG7d -->
        <script src="../Scripts/formscript.js"></script>

</asp:Content>

