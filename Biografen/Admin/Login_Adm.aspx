<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login_Adm.aspx.cs" Inherits="Admin_Login_Adm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <title>Login</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css"/>
    <link href="../Content/bootstrap-theme.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../styles/minstyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class="container">
	    <div class="login-container">
                <div id="output"></div>
                <div class="form-box">
                    <section>
                        <asp:Label ID="Label_Error" runat="server" Visible="true"  Text="Label"></asp:Label>
                        <asp:TextBox ID="TextBox_AdminNavn" placeholder="navn" ForeColor="Black" runat="server"></asp:TextBox>
                        <asp:TextBox ID="TextBox_AdminEmail" placeholder="email" ForeColor="Black" runat="server"></asp:TextBox>
                        <asp:TextBox ID="TextBox_AdminPass" placeholder="kodeord" ForeColor="Black" runat="server"></asp:TextBox>

                      
                       <asp:Button ID="Button_AdminLogin" class="btn btn-info btn-block login" 
                                   type="submit" runat="server" OnClick="Button_AdminLogin_Click"
                                   Text="Login" />
                    </section>
                     
                </div>
            </div>
        
    </div>

    </div>
    </form>

      <!--Scripts-->
 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="../Scripts/bootstrap.js"></script>

    
</body>
</html>
