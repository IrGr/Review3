using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Film_Info
/// </summary>
public class Film_Info
{
	public Film_Info()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public int Id { get; set; }
    public string Billede{get; set;}
    public string Film_navn { get; set; }
    public string Film_beskrivelse { get; set; }
   public decimal Film_rating { get; set; }

}