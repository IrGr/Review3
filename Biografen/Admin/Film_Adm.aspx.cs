using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Film_Adm : System.Web.UI.Page
{
     // Denne connectionstring bruges igen og igen! Derfor ligger den uden for Page_Load!
    private static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BiografConnectionString1"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {

        //Udtrækker og udskriver alle film
        SqlCommand cmd = new SqlCommand(@"SELECT * FROM film join billeder on film_id=fk_film_id
				                                             join genrer on fk_genre_id = genre_id
                                                             ORDER BY film_id DESC", conn);
        try
        {
            conn.Open();
            Repeater_FilmTabel.DataSource = cmd.ExecuteReader();
            Repeater_FilmTabel.DataBind();
        }
        catch (Exception)
        {
            PlaceHolder_Film.Visible = false;
            Label_Fejl.Visible=true;
            Label_Fejl.Text = "Der skete en fejl";
        }
        finally
        {
            conn.Close();
        }
       

        //dropdown
        if (!IsPostBack)
        {
             SqlCommand cmd_ddl = new SqlCommand(@"SELECT * FROM genrer", conn);
             try
             {
                conn.Open();
                SqlDataReader reader_ddl = cmd_ddl.ExecuteReader();

                DropDownList_Genre.DataSource = reader_ddl;
                DropDownList_Genre.DataTextField = "genre_navn";
                DropDownList_Genre.DataValueField = "genre_id";
                          
                DropDownList_Genre.DataBind();
             }
             catch (Exception)
             {
                 
                 Label_Fejl.Visible=true;
                 Label_Fejl.Text = "Fejl";
             }
             finally
             {
                 conn.Close();
             }

                
        }
    }
    protected void LinkButton_AddFilm_Click(object sender, EventArgs e)
    {
        PlaceHolder_Film.Visible = false;
        PlaceHolder_NyFilm.Visible = true;
    }
    protected void Repeater_FilmTabel_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName.ToString() == "SletFilm")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            
            SqlCommand cmd_slet = new SqlCommand(@"DELETE FROM film WHERE film_id = @id",conn);

            cmd_slet.Parameters.AddWithValue("@id",id);
            conn.Open();
            cmd_slet.ExecuteNonQuery();
            conn.Close();
            Response.Redirect(Request.RawUrl);
        }
    }
    /// <summary>
    /// Oprette en ny film
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Button_NyFilm_Click(object sender, EventArgs e)
    {
        string navn = TextBox_FilmNavn.Text;
        string beskrivelse = TextBox_FilmBeskrivelse.Text;
        int genre_id = Convert.ToInt32(DropDownList_Genre.SelectedValue);
        int film_rating = 0;



        SqlCommand cmd_NyFilm = new SqlCommand(@"INSERT INTO film (film_navn, film_beskr, fk_genre_id, film_rating)
                                                  VALUES (@navn,@beskrivelse,@genre_id,@film_rating);SELECT cast(SCOPE_IDENTITY() as int)", conn);

        cmd_NyFilm.Parameters.AddWithValue("@navn", navn);
        cmd_NyFilm.Parameters.AddWithValue("@beskrivelse", beskrivelse);
        cmd_NyFilm.Parameters.AddWithValue("@genre_id", genre_id);
        cmd_NyFilm.Parameters.AddWithValue("@film_rating", film_rating);

        object film_id = null;
        try
        {
            conn.Open();//åbner forbindelse til databasen
            film_id = cmd_NyFilm.ExecuteScalar();// result af SELECT cast(SCOPE_IDENTITY() as int)
        }
        catch (Exception)
        {
            Label_Fejl.Visible = true;
            Label_Fejl.Text="Film kan ikke gemmes";
        }
        finally
        {
            conn.Close();
        }


        if (FileUpload_NyFilmPlakat.HasFile == true && film_id != null)
        {
            string Filename;
            if (!File.Exists(Server.MapPath("~/images/plakater/" + FileUpload_NyFilmPlakat.FileName.ToString())))
            {
                FileUpload_NyFilmPlakat.SaveAs(Server.MapPath("~/images/plakater/" + FileUpload_NyFilmPlakat.FileName.ToString()));
                Filename = FileUpload_NyFilmPlakat.FileName;
            }

            string billede_sti = FileUpload_NyFilmPlakat.FileName.ToString();
            int bill_feature = 1;
            int fk_film_id = (int)film_id;

            cmd_NyFilm = new SqlCommand(@"INSERT INTO billeder (bill_sti,bill_feature,fk_film_id)
                                         VALUES (@billede_sti,@bill_feature,@fk_film_id)", conn);
                                         



            cmd_NyFilm.Parameters.AddWithValue("@billede_sti", billede_sti);
            cmd_NyFilm.Parameters.AddWithValue("@bill_feature", bill_feature);
            cmd_NyFilm.Parameters.AddWithValue("@fk_film_id", fk_film_id);

            try
            {
                conn.Open();//åbner forbindelse til databasen
                cmd_NyFilm.ExecuteNonQuery();
            }
            catch (Exception)
            {

                Label_Fejl.Visible = true;
                Label_Fejl.Text = "Film kan ikke gemmes";
            }
            finally
            {
                conn.Close();
            }
           
        }
 
       Response.Redirect("~/Admin/Film_Adm.aspx");


    }
}