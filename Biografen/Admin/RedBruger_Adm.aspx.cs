using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_RedBruger_Adm : System.Web.UI.Page
{
     // Denne connectionstring bruges igen og igen! Derfor ligger den uden for Page_Load!
    private static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["id"] != null)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);

                SqlCommand cmd_RedBruger = new SqlCommand(@"SELECT * FROM brugere
                                                            join roller on fk_rolle_id = rolle_id
                                                            WHERE bruger_id = @id", conn);

                cmd_RedBruger.Parameters.AddWithValue("@id", id);

                conn.Open();
                SqlDataReader reader = cmd_RedBruger.ExecuteReader();// vi får data ind i reader

                int current_bruger_rolle = 0;//
                
                while (reader.Read())
                {
                    TextBox_BrugerNavn.Text = reader["bruger_navn"].ToString();
                    TextBox_Email.Text = reader["bruger_email"].ToString();
                    current_bruger_rolle = (int)reader["fk_rolle_id"];//
                }
                conn.Close();

//Dropdownlist rolle

// udskriver data fra databasen i DropDownList 
                SqlCommand cmd_ddl = new SqlCommand(@"SELECT * FROM roller", conn);
                conn.Open();
                SqlDataReader reader_ddl = cmd_ddl.ExecuteReader();

                DropDownList_Rolle.DataSource = reader_ddl;
                DropDownList_Rolle.DataTextField = "rolle_navn";
                DropDownList_Rolle.DataValueField = "rolle_id";
                
                DropDownList_Rolle.SelectedValue = current_bruger_rolle.ToString();
               
                DropDownList_Rolle.DataBind();

                conn.Close();
            }

        }
    }
    protected void Button_RedBruger_Click(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(Request.QueryString["id"]);
        string navn = TextBox_BrugerNavn.Text;
        string email = TextBox_Email.Text;
        int rolle_id = Convert.ToInt32(DropDownList_Rolle.SelectedValue);

        //søger efter en email som er lige med email fra Textbox og med bruger_id forskellige fra Request.QueryString["id"]
        SqlCommand cmd_email = new SqlCommand("SELECT TOP 1 bruger_email FROM brugere WHERE bruger_email=@email AND bruger_id <> @id", conn);
        cmd_email.Parameters.Add(new SqlParameter("@email", email));
        cmd_email.Parameters.Add(new SqlParameter("@id", id));

        conn.Open();
        SqlDataReader reader_email = cmd_email.ExecuteReader();
        bool email_exist = reader_email.HasRows; 
        conn.Close();

        if (email_exist)
        {
            Label_fejl.Visible = true;
            Label_fejl.Text = "Den mail er allerede eksisteret";
        }
        else
        {
            SqlCommand cmd = new SqlCommand(@"UPDATE brugere SET bruger_navn = @navn, bruger_email = @email,
                                              fk_rolle_id=@rolle_id WHERE bruger_id = @id;", conn);

            cmd.Parameters.Add(new SqlParameter("@navn", navn));
            cmd.Parameters.Add(new SqlParameter("@email", email));
            cmd.Parameters.Add(new SqlParameter("@rolle_id", rolle_id));
            cmd.Parameters.Add(new SqlParameter("@id", id));

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

             Response.Redirect("~/Admin/Brugere_Adm.aspx");

        }
    }
}