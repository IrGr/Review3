using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OpretBruger : System.Web.UI.Page
{
     // Denne connectionstring bruges igen og igen! Derfor ligger den uden for Page_Load!
    private static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button_OpretBruger_Click(object sender, EventArgs e)
    {
        if (TextBox_NyBrugerNavn.Text != "" &&
           TextBox_BrugerEmail.Text != "" &&
           TextBox_Password.Text != "" &&
           TextBox_VerificerPassword.Text != "")
        {

            //de to passwords er ikke ens
            if (TextBox_Password.Text != TextBox_VerificerPassword.Text)
            {
                Label_Status.Text = "De to passwords er ikke ens - prøv igen!";
                Label_Status.CssClass = "bg-danger";
                return;
            }


            string email = TextBox_BrugerEmail.Text;
            //string email = TextBox_NyBrugerNavn.Text;
            
            SqlCommand cmd = new SqlCommand("SELECT * FROM brugere WHERE bruger_email = @email", conn);

            cmd.Parameters.Add(new SqlParameter("@email", email));

            bool brugerEksistererAllerede = true;
            conn.Open();
            try
            {
                SqlDataReader reader = cmd.ExecuteReader();
                brugerEksistererAllerede = reader.HasRows;
            }
            catch (Exception)
            {
                Label_Status.Text = "Der sket en fejl! Prøv igen";
            }
            finally
            {
                conn.Close();
            }
            


            //bruger eksisterer allerede
            if (brugerEksistererAllerede)
            {
                Label_Status.Text = "Bruger eksisterer allerede, venligst benyt et andet email!";
                Label_Status.CssClass = "bg-danger";
            }
            else
            {

               

                //oprette ny bruger
                string navn = TextBox_NyBrugerNavn.Text;
                string salt = navn;
                string psw = Helper.GetMD5Hash(TextBox_Password.Text + salt);
                string nyhedsbrev = "";
                int point = 0;
                int genre = 0;
                int rolle = 3;
                SqlCommand cmd_NyBruger = new SqlCommand(@"INSERT INTO brugere ( bruger_email, bruger_pass, nyhedsbrev, point, fk_genre_id, fk_rolle_id, bruger_navn)
                                                           VALUES (@email,@psw,@nyhedsbrev,@point,@genre,@rolle,@navn);", conn);


                cmd_NyBruger.Parameters.AddWithValue("@email", email);
                cmd_NyBruger.Parameters.AddWithValue("@psw", psw);
                cmd_NyBruger.Parameters.AddWithValue("@nyhedsbrev", nyhedsbrev);
                cmd_NyBruger.Parameters.AddWithValue("@point", point);
                cmd_NyBruger.Parameters.AddWithValue("@genre", genre);
                cmd_NyBruger.Parameters.AddWithValue("@rolle", rolle);
                cmd_NyBruger.Parameters.AddWithValue("@navn", navn);
               


                conn.Open();
                cmd_NyBruger.ExecuteNonQuery();
                conn.Close();

                Session["brugeremail"] = email;
                Session["bruger_navn"] = navn;
                

                Response.Redirect("~/Default.aspx");
            }
           
        }
    }




}