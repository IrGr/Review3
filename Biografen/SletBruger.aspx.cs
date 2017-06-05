using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SletBruger : System.Web.UI.Page
{
     // Denne connectionstring bruges igen og igen! Derfor ligger den uden for Page_Load!
    private static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void YesButton_OnClick(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(Session[NavnKonstant.SessionBrugerId]);
        SqlCommand cmd_ = new SqlCommand(@"DELETE FROM brugere WHERE bruger_id = @id; ", conn);

        cmd_.Parameters.Add(new SqlParameter("@id", id));

        conn.Open();
        cmd_.ExecuteNonQuery();
        conn.Close();

        Response.Redirect("Logud.aspx");
        
    }

    protected void CancelButton_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }
}