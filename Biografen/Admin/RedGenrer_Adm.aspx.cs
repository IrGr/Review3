using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_RedGenrer_Adm : System.Web.UI.Page
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

                    SqlCommand cmd_RedGenre = new SqlCommand(@"SELECT * FROM genrer WHERE genre_id = @id", conn);

                    cmd_RedGenre.Parameters.AddWithValue("@id", id);

                    conn.Open();
                    SqlDataReader reader = cmd_RedGenre.ExecuteReader();// vi får data ind i reader

             
                    while (reader.Read())
                    {
                        TextBox_GenreNavn.Text = reader["genre_navn"].ToString();
                    }
                    conn.Close();
                }
            }
    }
    protected void Button_NyGenre_Click(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(Request.QueryString["id"]);
        string navn = TextBox_GenreNavn.Text;
        SqlCommand cmd = new SqlCommand("UPDATE genrer SET genre_navn = @navn WHERE genre_id=@id ",conn);

        cmd.Parameters.AddWithValue("@id",id);
        cmd.Parameters.AddWithValue("@navn", navn);

        try
        {
            conn.Open();
            cmd.ExecuteReader();
        }
        catch (Exception)
        {
            Label_RedFejl.Visible = true;
            Label_RedFejl.Text = "Der skete en fejl";
        }
        finally
        {
            conn.Close();
        }
        Response.Redirect("~/Admin/Genrer_Adm.aspx");
    }
}