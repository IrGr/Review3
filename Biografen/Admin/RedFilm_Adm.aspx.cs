using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_RedFilm_Adm : System.Web.UI.Page
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

                SqlCommand cmd_RedFilm = new SqlCommand(@"SELECT * FROM film
                                                            join genrer on fk_genre_id = genre_id
                                                            WHERE film_id = @id", conn);

                cmd_RedFilm.Parameters.AddWithValue("@id", id);

                conn.Open();
                SqlDataReader reader = cmd_RedFilm.ExecuteReader();// vi får data ind i reader

                int current_film_genre = 0;//

                while (reader.Read())
                {
                    TextBox_FilmNavn.Text = reader["film_navn"].ToString();
                    TextBox_FilmBeskrivelse.Text = reader["film_beskr"].ToString();
                    current_film_genre = (int)reader["fk_genre_id"];//
                }
                conn.Close();

                SqlCommand cmd_ddl = new SqlCommand(@"SELECT * FROM genrer", conn);
                conn.Open();
                SqlDataReader reader_ddl = cmd_ddl.ExecuteReader();

                DropDownList_Genre.DataSource = reader_ddl;
                DropDownList_Genre.DataTextField = "genre_navn";
                DropDownList_Genre.DataValueField = "genre_id";

                DropDownList_Genre.SelectedValue = current_film_genre.ToString();

                DropDownList_Genre.DataBind();

                conn.Close();
            }

        }
    }
    protected void Button_RedFilm_Click(object sender, EventArgs e)
    {
        string navn = TextBox_FilmNavn.Text;
        string beskrivelse = TextBox_FilmBeskrivelse.Text;
        int id = Convert.ToInt32(Request.QueryString["id"]);
        int genre_id = Convert.ToInt32(DropDownList_Genre.SelectedValue);
        int film_rating = 0;

        SqlCommand cmd = new SqlCommand(@"UPDATE film SET film_navn = @navn, film_beskr = @beskrivelse,
                                                          fk_genre_id = @genre_id, film_rating=@film_rating 
                                                    WHERE film_id = @id;", conn);
        cmd.Parameters.AddWithValue("@navn",navn);
        cmd.Parameters.AddWithValue("@beskrivelse", beskrivelse);
        cmd.Parameters.AddWithValue("@genre_id", genre_id);
        cmd.Parameters.AddWithValue("@film_rating", film_rating);
        cmd.Parameters.AddWithValue("@id", id);



        try
        {
            conn.Open();//åbner forbindelse til databasen
            cmd.ExecuteNonQuery();
        }
        catch (Exception)
        {
            Label_Fejl.Visible = true;
            Label_Fejl.Text = "Film kan ikke ændres";
        }
        finally
        {
            conn.Close();
        }


        if (FileUpload_RedFilmPlakat.HasFile == true)
        {
            string Filename;
            if (!File.Exists(Server.MapPath("~/images/plakater/" + FileUpload_RedFilmPlakat.FileName.ToString())))
            {
                FileUpload_RedFilmPlakat.SaveAs(Server.MapPath("~/images/plakater/" + FileUpload_RedFilmPlakat.FileName.ToString()));
                Filename = FileUpload_RedFilmPlakat.FileName;
            }

            string bill_sti = FileUpload_RedFilmPlakat.FileName.ToString();
            int bill_feature = 1;
           

            cmd = new SqlCommand(@"UPDATE billeder SET bill_sti = @bill_sti, bill_feature = @bill_feature
                                                    WHERE fk_film_id = @id;", conn);

            cmd.Parameters.AddWithValue("@bill_sti", bill_sti);
            cmd.Parameters.AddWithValue("@bill_feature", bill_feature);
            cmd.Parameters.AddWithValue("@id", id);
           

            try
            {
                conn.Open();//åbner forbindelse til databasen
                cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {

                Label_Fejl.Visible = true;
                Label_Fejl.Text = "Film kan ikke ændres";
            }
            finally
            {
                conn.Close();
            }
           
        }
 
       Response.Redirect("~/Admin/Film_Adm.aspx");
    }
}