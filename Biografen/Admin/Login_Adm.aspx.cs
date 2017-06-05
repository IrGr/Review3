using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Login_Adm : System.Web.UI.Page
{
     // Denne connectionstring bruges igen og igen! Derfor ligger den uden for Page_Load!
    private static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button_AdminLogin_Click(object sender, EventArgs e)
    {
        string email = TextBox_AdminEmail.Text;
        string navn = TextBox_AdminNavn.Text;
        string salt = navn;
        string pass = Helper.GetMD5Hash(TextBox_AdminPass.Text + salt);

        SqlCommand cmd = new SqlCommand(@"SELECT * FROM brugere WHERE bruger_email=@email AND bruger_pass=@pass AND fk_rolle_id IN (1) ",conn);
       
        cmd.Parameters.AddWithValue("@email", email);
        cmd.Parameters.AddWithValue("@pass",pass);

        try
        {
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader != null && reader.HasRows)
            {
                while (reader.Read())
                {
                    Session["bruger_email"] = reader["bruger_email"];
                    Session["bruger_navn"] = reader["bruger_navn"];
                    Session["rolle_id"] = reader["fk_rolle_id"];
            
                    Response.Redirect("~/Admin/Default_Adm.aspx");

                   break; 
                }
           
            }
            else
            {
                Label_Error.Visible = true;
                Label_Error.Text = "<span style='color:Red;font-weight:bold;margin-right:5px'><p>Den log ind-information, du har angivet, er ikke korekt. Prøv igen!</p></span>";
            }
       }
        catch (Exception)
        {
            
             Label_Error.Visible = true;
             Label_Error.Text = "<span style='color:Red;font-weight:bold;margin-right:5px'><p>Der skete en fejl</p></span>";
        }
        finally
        {
            conn.Close();
        }
    }
}