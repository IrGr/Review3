using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
     // Denne connectionstring bruges igen og igen! Derfor ligger den uden for Page_Load!
    private static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
    
        Film_Info f = DB.TagRandomFilm();

        Label_Overskrift.Text = f.Film_navn;

        if (f.Film_beskrivelse.Length < 300)
        {
           Label_Beskrivelse.Text = f.Film_beskrivelse; 
        }
        else
        {
            Label_Beskrivelse.Text = f.Film_beskrivelse.Substring(0,300) + " ..."; 
        }

        HyperLink_EnFilm.NavigateUrl = "Film.aspx?id=" + f.Id;
      
        Label_Rating.Text = "Brugernes vurdering:" + " " + string.Format("{0:0.00}", f.Film_rating);

        if (String.IsNullOrEmpty(f.Billede)) 
        {
            RandomImg_Forside.ImageUrl = "images/plakater/billede_paa_vej.jpg";
        }
        else
        {
            RandomImg_Forside.ImageUrl = "images/plakater/" + f.Billede;      
        }


        // udtræk af randomReklameBillede
        string randomReklameBillede = DB.TagRandomReklame();
        Image_Reklam.ImageUrl = "images/rekalam/" + randomReklameBillede; 

    }


}