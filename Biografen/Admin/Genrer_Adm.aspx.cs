using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Genrer_Adm : System.Web.UI.Page
{
     // Denne connectionstring bruges igen og igen! Derfor ligger den uden for Page_Load!
    private static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand(@"SELECT * FROM genrer",conn);
        try
        {
            conn.Open();
            Repeater_GenreTabel.DataSource = cmd.ExecuteReader();
            Repeater_GenreTabel.DataBind();
        }
        catch (Exception)
        {
            
            Label_fejl.Visible = true;
            Label_fejl.Text = "Der skete en fejl. Prøv igen lidt senere";
        }
        finally
        {
            conn.Close();
        }
       

    }
    protected void LinkButton_AddGenre_Click(object sender, EventArgs e)
    {
        PlaceHolder_Genrer.Visible = false;
        PlaceHolder_NyGenre.Visible = true;
    }
    protected void Button_NyGenre_Click(object sender, EventArgs e)
    {
        string genre = TextBox_GenreNavn.Text;
       
            SqlCommand cmd = new SqlCommand(@"INSERT INTO genrer (genre_navn) VALUES (@genre);", conn);
         
            cmd.Parameters.AddWithValue("@genre", genre);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
               
            }
            catch (Exception)
            {
                Label_OpretFejl.Visible = true;
                Label_OpretFejl.Text = "Der skete desværre en fejl. Din data kan ikke gemmes";
            }
            finally
            {
                conn.Close();
            }
         Response.Redirect("~/Admin/Genrer_Adm.aspx");
    }
    protected void Repeater_GenreTabel_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName.ToString() == "Sletgenren")
        {
            int id = Convert.ToInt32(e.CommandArgument);

            SqlCommand cmd_slet = new SqlCommand("DELETE FROM genrer WHERE genre_id=@id",conn);

            cmd_slet.Parameters.AddWithValue("@id",id);

            try
            {
                conn.Open();
                cmd_slet.ExecuteNonQuery();
            }
            catch (Exception)
            {
                
                Label_fejl.Visible = true;
                Label_fejl.Text = "Der skete en fejl. Din data kan ikke slettes";
            }
            finally
            {
                conn.Close();

            }
            Response.Redirect(Request.RawUrl);
        }
    }
}

