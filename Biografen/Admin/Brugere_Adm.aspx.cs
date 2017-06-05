using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Brugere_Adm : System.Web.UI.Page
{
    // Denne connectionstring bruges igen og igen! Derfor ligger den uden for Page_Load!
    private static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());
    
    protected void Page_Load(object sender, EventArgs e)
    {
        // Udtræk brugere fra DB

        SqlCommand cmd = new SqlCommand(@"SELECT * FROM brugere left join genrer on fk_genre_id = genre_id
                                                                left join roller on fk_rolle_id = rolle_id", conn);

        try
        {
             conn.Open();
             Repeater_BrugereTabel.DataSource = cmd.ExecuteReader();
             Repeater_BrugereTabel.DataBind();
        }
        catch (Exception)
        {
            PlaceHolder_Brugere.Visible = false;
            Label_fejl.Visible = true;
            Label_fejl.Text = "Der skete desværre en fejl";
        }
        finally
        {
             conn.Close();
        }

        //DropdownListRolle
        if (!IsPostBack)
        {
            SqlCommand cmd_ddl = new SqlCommand(@"SELECT * FROM roller", conn);

            conn.Open();
            DropDownList_Rolle.DataSource = cmd_ddl.ExecuteReader();
            DropDownList_Rolle.DataValueField = "rolle_id";
            DropDownList_Rolle.DataTextField = "rolle_navn";

            DropDownList_Rolle.DataBind();
            conn.Close();
        }
   
    }
    protected void Button_NyBruger_Click(object sender, EventArgs e)
    {
        string navn = TextBox_BrugerNavn.Text;
        string salt = navn;
        string psw = Helper.GetMD5Hash(TextBox_Password.Text + salt);
        string email = TextBox_Email.Text;
        string nyhedsbrev = "";
        int point = 0;
        int genre = 0;
        int rolle = Convert.ToInt32(DropDownList_Rolle.SelectedValue);
        SqlCommand cmd_NyBruger = new SqlCommand(@"INSERT INTO brugere ( bruger_email, bruger_pass, nyhedsbrev, point, fk_genre_id, fk_rolle_id, bruger_navn)
                                                           VALUES (@email,@psw,@nyhedsbrev,@point,@genre,@rolle,@navn);", conn);

        cmd_NyBruger.Parameters.AddWithValue("@email", email);
        cmd_NyBruger.Parameters.AddWithValue("@psw", psw);
        cmd_NyBruger.Parameters.AddWithValue("@nyhedsbrev", nyhedsbrev);
        cmd_NyBruger.Parameters.AddWithValue("@point", point);
        cmd_NyBruger.Parameters.AddWithValue("@genre", genre);
        cmd_NyBruger.Parameters.AddWithValue("@rolle", rolle);
        cmd_NyBruger.Parameters.AddWithValue("@navn", navn);

        try
        {
            conn.Open();
            cmd_NyBruger.ExecuteNonQuery();
        }
        catch (Exception)
        {

            Label_OpretFejl.Visible=true;
            Label_OpretFejl.Text = "Der skete desværre en fejl";
        }
        finally
        {
            conn.Close();
        }
      
        Response.Redirect("~/Admin/Brugere_Adm.aspx");
       
    }
    /// <summary>
    /// Viser form, hvor vi kan oprette en ny bruger
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void LinkButton_AddBruger_Click(object sender, EventArgs e)
    {
        PlaceHolder_Brugere.Visible = false;
        PlaceHolder_NyBruger.Visible = true;
    }
    /// <summary>
    /// Slet Bruger
    /// </summary>
    /// <param name="source"></param>
    /// <param name="e"></param>
    protected void Repeater_BrugereTabel_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName.ToString() == "Sletbruger")
        {
            int Id = Convert.ToInt32(e.CommandArgument);

            SqlCommand cmd_slet = new SqlCommand(@"DELETE FROM brugere WHERE bruger_id = @id ", conn);

            cmd_slet.Parameters.AddWithValue("@id", Id);

            conn.Open();//åbner forbindelse til databasen
            cmd_slet.ExecuteNonQuery();//fordi vi ikke skal har noget resultat
            conn.Close();

            Response.Redirect(Request.RawUrl);

        }
    }
}