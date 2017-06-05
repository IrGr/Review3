using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default_Adm : System.Web.UI.Page
{
     // Denne connectionstring bruges igen og igen! Derfor ligger den uden for Page_Load!
    private static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        TagDataFraDB("SELECT TOP 5 anm_tekst, anm_date, godkendt FROM anmeldelse", Repeater_Anmeldelser, Label_Fejl);
        TagDataFraDB("SELECT TOP 1 film_navn, bill_sti, film_id FROM film join billeder on film_id = fk_film_id ORDER BY film_id", Repeater_ForsFilm, Label_Fejl);
        TagDataFraDB("SELECT TOP 5 genre_navn, genre_id FROM genrer ORDER BY genre_id DESC", Repeater_GenreTab, Label_Fejl);

    }

    private void TagDataFraDB(string query, Repeater control,Label label_id)
    {
        SqlCommand cmd = new SqlCommand(query, conn);

        try
        {
            conn.Open();
            control.DataSource = cmd.ExecuteReader();
            control.DataBind();
        }
        catch (Exception)
        {
            PlaceHolder_Forsiden.Visible = false;
            label_id.Visible = true;
            label_id.Text = "Der skete desværre en fejl";
        }
        finally
        {
            conn.Close();
        }
    }
    // tilføjer et billede, som afhænger af godkendelse
    public string IdToImage(object arg)
    {
        if (!(arg is int)) return "";

        int id = (int)arg;

        switch (id)
        {
            // ikke godkendt
            case 0:
                return "<i class=\"glyphicon glyphicon-flash\"></i>";
            //godkendt
            case 1:
                return "<i class=\"glyphicon glyphicon-heart\"></i>";
        }

        return "";
    }

}