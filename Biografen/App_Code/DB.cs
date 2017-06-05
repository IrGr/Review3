using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DB
/// </summary>
public class DB
{
	public DB()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static Film_Info TagRandomFilm()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());

        SqlCommand cmd = new SqlCommand();
        cmd.Connection = conn;
        cmd.CommandText = @"SELECT TOP 1 film_id,film_navn,film_beskr,bill_sti, Convert(decimal(18,2),rating_total) / rating_votes as rate_avg FROM film 
                            join rating on film.film_id=rating.fk_film_id
                            join billeder on film.film_id=billeder.fk_film_id 
                            ORDER BY NEWID()";
        
        Film_Info film = new Film_Info();

        conn.Open();
        SqlDataReader r = cmd.ExecuteReader();

        if (r.HasRows)
        {
            r.Read();
            film.Id = Convert.ToInt32(r["film_id"]);
            film.Film_navn = r["film_navn"].ToString();
            film.Film_beskrivelse = r["film_beskr"].ToString();
            film.Billede = r["bill_sti"].ToString();
            film.Film_rating = Convert.ToDecimal(r["rate_avg"]);
           
        }
        conn.Close();

        return film;
    }



    public static DataTable HentFilm(int brugerid)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());
       

        //SqlCommand cmd = new SqlCommand("SELECT * FROM film join billeder on film_id=fk_film_id", conn);
        SqlCommand cmd = new SqlCommand(@"SELECT  film_id,film_navn,bill_sti,film.fk_genre_id, Convert(decimal(18,2),rating_total) / rating_votes as rate_avg,
                                                  Convert(int,rating_total) / rating_votes as rate_avg_int  FROM film 
                                            join rating on film.film_id=rating.fk_film_id
                                            join billeder on film.film_id=billeder.fk_film_id
											left join brugere on film.fk_genre_id=brugere.fk_genre_id and brugere.bruger_id = @id
											ORDER BY isnull(brugere.bruger_id,0) DESC, rate_avg DESC ", conn);
        cmd.Parameters.AddWithValue("@id",brugerid);
        SqlDataAdapter adapter = new SqlDataAdapter(cmd);

        DataTable dt = new DataTable();
        adapter.Fill(dt);

        
        return dt;
    }


    /// <summary>
    /// Udtræk fra DB
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    public static Film_Info EnEnkeltFilm_Udtreak(int id)
    {
        Film_Info film = new Film_Info();

        string query = "SELECT * FROM film join billeder on film_id=fk_film_id WHERE film_id = @id";
        List<SqlParameter> param = new List<SqlParameter>();

        param.Add(new SqlParameter("@id", id));

        DataTable dt = new DataTable();
        dt = ExecuteQueryWithParameters(query, param);

        if (dt != null && dt.Rows.Count > 0)
        {
            DataRow row = dt.Rows[0];
            
            film.Id = (int)TageFeltFraDataRow(row, "film_id", 0);
            film.Film_navn = (string)TageFeltFraDataRow(row, "film_navn", string.Empty);
            film.Billede = (string)TageFeltFraDataRow(row, "bill_sti", string.Empty);
            film.Film_beskrivelse = (string)TageFeltFraDataRow(row, "film_beskr", string.Empty);
        }
        return film;
    }

    private static object TageFeltFraDataRow(DataRow row, string kolon_navn, object default_veardi)
    {
        if (row != null && row.Table.Columns.Contains(kolon_navn))
        {
            return row[kolon_navn];
        }

        return default_veardi;
    }

    /// <summary>
    /// Metoden hjælper os med at undgå at skrive datatype. Den tager samme datatype, som default_veardi har
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="row"></param>
    /// <param name="kolon_navn"></param>
    /// <param name="default_veardi"></param>
    /// <returns></returns>
    private static T TageFeltFraDataRowGeneric<T>(DataRow row, string kolon_navn, T default_veardi)
    {
        if (row != null && row.Table.Columns.Contains(kolon_navn))
        {
            return (T)row[kolon_navn];
        }

        return default_veardi;
    }


    /// <summary>
    /// Udføre forespørgslen  med parametre
    /// </summary>
    /// <param name="query"></param>
    /// <param name="parameters"></param>
    /// <returns></returns>
    public static DataTable ExecuteQueryWithParameters(string query, List<SqlParameter> parameters)
    {
        if (string.IsNullOrEmpty(query))
        {
            return null;
        }

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());

        SqlCommand cmd = new SqlCommand(query, conn);
        if (parameters != null && parameters.Count > 0)
        {
            foreach (var p in parameters)
            {
                cmd.Parameters.Add(p);
            }
        }
        SqlDataAdapter adapter = new SqlDataAdapter(cmd);

        // saves to table
        DataTable dt = new DataTable();
        adapter.Fill(dt);
        return dt;
    }

    #region TagRandomReklame()
    /// <summary>
    /// 
    /// </summary>
    public static string TagRandomReklame()
    {

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["biografConnectionString1"].ToString());

        SqlCommand cmd = new SqlCommand("SELECT TOP 1 bill_sti FROM billeder WHERE bill_feature = 2 ORDER BY NEWID()", conn);

        conn.Open();
        SqlDataReader reader = cmd.ExecuteReader();

        string randombillede = string.Empty;
        while (reader.Read())
        {
            randombillede = reader["bill_sti"].ToString();
        }
        conn.Close();

        return randombillede;
    }
    #endregion
}