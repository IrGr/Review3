using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_MasterPage_Adm : System.Web.UI.MasterPage
{
    private static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
            if (Helper.ErLoggetInd() == true)
            {
                LinkButton_BrugerNavn.Text = "<i class='glyphicon glyphicon-user'></i>  " + Session["bruger_navn"].ToString()+ " <span class='glyphicon glyphicon-menu-down'></span>";
            }
            else
            {
                Response.Redirect("~/Admin/Login_Adm.aspx"); 
            }

    }
    protected void LinkButton_Logud_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("~/Admin/Login_Adm.aspx");
    }
}

