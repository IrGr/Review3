using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using AjaxControlToolkit;
public partial class Film : System.Web.UI.Page
{
     // Denne connectionstring bruges igen og igen! Derfor ligger den uden for Page_Load!
    private static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        int film_id = 0;
        QueryStringKontrol(out film_id);
       
        Film_Info filmen = DB.EnEnkeltFilm_Udtreak(film_id);

        if (filmen.Id != 0)
        {
             Opdaterefilm(filmen);
             PlaceHolder_FilmInfo.Visible = true;
             PlaceHolder_UkendtUrl.Visible = false;
        }
        else
        {
            PlaceHolder_FilmInfo.Visible = false;
            PlaceHolder_UkendtUrl.Visible = true;
        }

        if (Session[NavnKonstant.SessionBrugerRolle] == null)
        {
            Rater1.Visible = false;
            din_bedomelse.Visible = false;
        }



        //rating start

        Label1.Text = "0 Users have rated this Product";
        Label2.Text = "Average rating for this Product is 0";


        
            if (!IsPostBack)
            {
                BindRatings(Convert.ToInt32(Request.QueryString["id"]));
            }


        /// Anmelselser udtræk

        int qsfilm_id = Convert.ToInt32(Request.QueryString["id"]);
        SqlCommand cmd = new SqlCommand(@"SELECT TOP 2 * FROM anmeldelse 
                                            join brugere on fk_bruger_id = bruger_id
                                            where fk_film_id=@qsfilm_id  ORDER BY NEWID()",conn);

        cmd.Parameters.AddWithValue("@qsfilm_id", qsfilm_id);

        try
        {
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                Repeater_Anmeldelse.DataSource = reader;
                Repeater_Anmeldelse.DataBind();
            }
            else
            {
                PlaceHolder_Anmeldelser.Visible = false;
            }
            
        }
        catch (Exception)
        {

            Label_Fejl.Visible = true;
            Label_Fejl.Text = "Der skete en fejl";
        }
        finally
        {
            conn.Close();
        }


    }


    /// <summary>
    /// tjekker querystring
    /// </summary>
    /// <param name="id">en plads hvor data skal gemmes</param>
    /// <returns></returns>
    private bool QueryStringKontrol(out int id)
    {
        id = 0;
        int.TryParse(Request.QueryString["id"], out id);

        return Request.QueryString["id"] == null;
    }



    /// <summary>
    /// 
    /// </summary>
    /// <param name="film"></param>
    private void Opdaterefilm(Film_Info film)
    {
        if (film == null)
        {
            return;
        }

        if (File.Exists(Server.MapPath("~/images/plakater/" + film.Billede)))
        {
            Img_Film.ImageUrl = "images/plakater/" + film.Billede;
        }
        else
        {
            Img_Film.ImageUrl = "images/plakater/billede_paa_vej.jpg";
        }
        Lbl_FilmenOverskrift.Text = film.Film_navn;
        Lbl_FilmenBeskrivelse.Text = film.Film_beskrivelse;
    }

    protected void Rating1_Changed(object sender, RatingEventArgs e)
    {
          
        conn.Open();
        SqlCommand cmd = new SqlCommand("update rating set rating_total = rating_total + @Rating, rating_votes = rating_votes + 1 where fk_film_id = @film_id", conn);
        cmd.Parameters.AddWithValue("@film_id", SqlDbType.Int).Value = Request.QueryString["id"];
        cmd.ExecuteNonQuery();
        conn.Close();

        BindRatings(Convert.ToInt32(Request.QueryString["id"]));
        
      
  
        
    }


        public void BindRatings(int film_id)
        {
            SqlCommand cmd = new SqlCommand("SELECT rating_votes, Convert(decimal(18,2),rating_total) / rating_votes as rate_avg FROM rating where fk_film_id=@film_id", conn);
            cmd.Parameters.AddWithValue("@film_id", SqlDbType.Int).Value = film_id;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
           
            if (dt.Rows.Count > 0)
            {
                Rater1.Value = Convert.ToInt32(dt.Rows[0][1]);
                Label1.Text = dt.Rows[0][0].ToString() + " " + "Users have rated this film";
                Label2.Text = "Average rating for this film is" + " " + string.Format("{0:0.00}", dt.Rows[0][1]);
            }
           
        }
    
        protected void Rater1_Command(object sender, CommandEventArgs e)
        {
            int stjernerNum = Convert.ToInt32(e.CommandArgument);
            conn.Open();
            SqlCommand cmd = new SqlCommand("update rating set rating_total = rating_total + @Rating, rating_votes = rating_votes + 1 where fk_film_id = @film_id", conn);

            cmd.Parameters.AddWithValue("@Rating", SqlDbType.Int).Value = stjernerNum;
            cmd.Parameters.AddWithValue("@film_id", SqlDbType.Int).Value = Request.QueryString["id"];
            cmd.ExecuteNonQuery();
            conn.Close();
            Lbl_RatingStatus.Text = stjernerNum.ToString();

            BindRatings(Convert.ToInt32(Request.QueryString["id"]));
        }
}

