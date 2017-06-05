using AjaxControlToolkit.Bundling;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for Helper
/// </summary>
public class Helper
{
	public Helper()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static void ShowTextOnButton(string p, string url)
    {
        if (HttpContext.Current.Session["brugeremail"] != null)
        {
            HyperLink loginLink = (HyperLink)((System.Web.UI.Page)HttpContext.Current.CurrentHandler).Master.FindControl("HyperLink_LogInUd");
            loginLink.Text = p;
            loginLink.NavigateUrl = url;
        }
    }


    /// <summary>
    /// Bruges til at generer md5hash udfra input
    ///http://dotnet-snippets.com/snippet/generate-md5-hash/644
    /// </summary>
    /// <param name="textToHash"></param>
    /// <returns></returns>
    public static string GetMD5Hash(String textToHash)
    {
        //Check wether data was passed
        if ((textToHash == null) || (textToHash.Length == 0))
        {
            return String.Empty;
        }

        //Calculate MD5 hash. This requires that the string is splitted into a byte[].
        MD5 md5 = new MD5CryptoServiceProvider();

        byte[] hashed = Encoding.Default.GetBytes(textToHash);
        byte[] result = md5.ComputeHash(hashed);

        //Convert result back to string.
        return System.BitConverter.ToString(result);

    }

    #region IsLoggetInd_VisProfil()
    /// <summary>
    /// Hvis brugeremail er i Session, så viser vi ProfilLink i navigationmenu
    /// </summary>
    public static void IsLoggetInd_VisProfil(){
        if (HttpContext.Current.Session["brugeremail"] != null)
        {
            HyperLink profilLink = (HyperLink)((System.Web.UI.Page)HttpContext.Current.CurrentHandler).Master.FindControl("HyperLink_BrugerProfil");
            profilLink.Visible = true;
        }
    }
    #endregion
      

    public static bool ErLoggetInd()
    {
        if (HttpContext.Current.Session["bruger_navn"] == null)
        {
            return false;
        }
        else
        {
            return true;
        }
    }


}
