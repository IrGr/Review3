using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
     // Denne connectionstring bruges igen og igen! Derfor ligger den uden for Page_Load!
    private static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());

    protected void Page_Load(object sender, EventArgs e)
    {
        // udtræk af randomReklameBillede
        string randomReklameBillede = DB.TagRandomReklame();
        Image_Reklam.ImageUrl = "images/reklam/" + randomReklameBillede; 

    }
    protected void Button_Login_Click(object sender, EventArgs e)
    {
        string brugernavn = TextBox_Brugernavn.Text;
        string salt = brugernavn;
        string password = Helper.GetMD5Hash(TextBox_Password.Text + salt);


        SqlCommand cmd_login = new SqlCommand("SELECT * FROM brugere WHERE bruger_navn = @brugernavn AND bruger_pass = @password", conn);

        cmd_login.Parameters.Add(new SqlParameter("@brugernavn", brugernavn));
        cmd_login.Parameters.Add(new SqlParameter("@password", password));
        conn.Open();
        SqlDataReader reader = cmd_login.ExecuteReader();

        if (reader != null && reader.HasRows)
        {
            while (reader.Read())
            {
                Session[NavnKonstant.SessionBrugerNavn] = reader["bruger_navn"];
                Session[NavnKonstant.SessionBrugerEmail] = reader["bruger_email"];
                Session[NavnKonstant.SessionBrugerId] = reader["bruger_id"];
                Session[NavnKonstant.SessionBrugerRolle] = reader["fk_rolle_id"];
                Session[NavnKonstant.SessionBrugerFavoritGenre] = reader["fk_genre_id"].ToString();
               

                conn.Close();

                Response.Redirect("~/Default.aspx");
                break;
            }
        }
        else
        {
            Label_Error.Visible = true;
            Label_Error.Text = "<span style='color:Red;font-weight:bold;margin-right:5px'><p>Fejl! Prøv igen!</p></span>";

        }

        conn.Close();
    }
}