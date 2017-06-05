using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BrugerProfil : System.Web.UI.Page
{
     // Denne connectionstring bruges igen og igen! Derfor ligger den uden for Page_Load!
    private static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session[NavnKonstant.SessionBrugerNavn] != null)
        {
            Label_ProfilBrugerNavn.Text = Session[NavnKonstant.SessionBrugerNavn].ToString();
            LabelProfilEmail.Text = Session[NavnKonstant.SessionBrugerEmail].ToString();
            
            //Hvis SessionBrugerFavoritGenre er forskellige fra null og den har datatype int, så konverterer den, ellers den er lige med 0
            int genre_id = 0;
            if (Session[NavnKonstant.SessionBrugerFavoritGenre] != null && 
                Session[NavnKonstant.SessionBrugerFavoritGenre] is string)
            {
                int.TryParse(Session[NavnKonstant.SessionBrugerFavoritGenre].ToString(), out genre_id);
            }
            SqlCommand cmd = new SqlCommand("SELECT * FROM genrer WHERE genre_id = @genre_id",conn);
            cmd.Parameters.AddWithValue("@genre_id", genre_id);
            
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader != null && reader.HasRows)
            {
                while (reader.Read())
                {
                    Label_FavoritGenre.Text = reader["genre_navn"].ToString();
                    break;
                }
            }
            conn.Close();

        }

        //ReklamBaner
        string randomReklameBillede = DB.TagRandomReklame();
        Image_Reklam.ImageUrl = "images/reklam/" + randomReklameBillede; 


        //DropdownListGenre
        if (!IsPostBack)
        {
            SqlCommand cmd = new SqlCommand(@"SELECT * FROM genrer",conn);

            conn.Open();
            DropDownList_FavoritGenre.DataSource=cmd.ExecuteReader();
            DropDownList_FavoritGenre.DataValueField = "genre_id";
            DropDownList_FavoritGenre.DataTextField = "genre_navn";
           
            DropDownList_FavoritGenre.DataBind();
            conn.Close();
        }
    }

/// <summary>
/// Gemmer Email efter redigering
/// </summary>
/// <param name="sender"></param>
/// <param name="e"></param>
    protected void Button_RedEmail_Click(object sender, EventArgs e)
    {
        string email = Request.Form["TextBoxProfilEmail"];

        int id = Convert.ToInt32(Session[NavnKonstant.SessionBrugerId]);

        SqlCommand cmd_ = new SqlCommand(@"UPDATE brugere SET bruger_email = @email
                                                    WHERE bruger_id = @id; ", conn);
        
        cmd_.Parameters.Add(new SqlParameter("@id", id));
        cmd_.Parameters.Add(new SqlParameter("@email", email));

        conn.Open();
        cmd_.ExecuteNonQuery();
        conn.Close();
        
        LabelProfilEmail.Text = email;
       
        Label_RedigeringStatus.Visible = true;
        Label_RedigeringStatus.Text = "Indholdet i Email-feltet blev ændret";
        Label_RedigeringStatus.CssClass = "bg-success";

        Session[NavnKonstant.SessionBrugerEmail] = email;
    }

    /// <summary>
    /// Gemmer Adgangskode
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void LinkButton_Kodeord_Click(object sender, EventArgs e)
    {
        string navn = Session[NavnKonstant.SessionBrugerNavn].ToString();
        string salt = navn;
        string kodeord = Helper.GetMD5Hash(Request.Form["TextBoxKodeord"] + salt);

        int id = Convert.ToInt32(Session[NavnKonstant.SessionBrugerId]);

        SqlCommand cmd_ = new SqlCommand(@"UPDATE brugere SET bruger_pass = @kodeord
                                                    WHERE bruger_id = @id; ", conn);

        cmd_.Parameters.Add(new SqlParameter("@id", id));
        cmd_.Parameters.Add(new SqlParameter("@kodeord", kodeord));

        conn.Open();
        cmd_.ExecuteNonQuery();
        conn.Close();

        LabelKodeord.Text = "*****";

        Label_RedigeringStatus.Visible = true;
        Label_RedigeringStatus.Text = "Indholdet i Kodeord-feltet blev ændret";
        Label_RedigeringStatus.CssClass = "bg-success";
    }
    /// <summary>
    /// Gemmer brugerens favoritgenre
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void LinkButton_FavoritGenre_Click(object sender, EventArgs e)
    {
        //genrer_id: DropDownList_FavoritGenre.SelectedIndex 
        int genre_id = Convert.ToInt32(DropDownList_FavoritGenre.SelectedValue);
        int bruger_id = Convert.ToInt32(Session[NavnKonstant.SessionBrugerId]);

        SqlCommand cmd = new SqlCommand(@"UPDATE brugere SET fk_genre_id=@genre_id
                                          WHERE bruger_id = @bruger_id;", conn);

        cmd.Parameters.Add(new SqlParameter("@bruger_id", bruger_id));
        cmd.Parameters.Add(new SqlParameter("@genre_id", genre_id));

        try
        {
            conn.Open();
            
            cmd.ExecuteNonQuery();// gemmer værdien til DB

            Label_FavoritGenre.Text = DropDownList_FavoritGenre.SelectedItem.Text;

            Label_RedigeringStatus.Visible = true;
            Label_RedigeringStatus.Text = "Indholdet i FavoritGenre-feltet blev ændret";
            Label_RedigeringStatus.CssClass = "bg-success";

            Session[NavnKonstant.SessionBrugerFavoritGenre] = DropDownList_FavoritGenre.SelectedValue;
        }
        catch
        {
            Label_RedigeringStatus.Visible = true;
            Label_RedigeringStatus.Text = "Indholdet i FavoritGenre-feltet blev ikke ændret";
            Label_RedigeringStatus.CssClass = "bg-dange";
            
        }
        finally
        {
            conn.Close();
        }
       
    }
}