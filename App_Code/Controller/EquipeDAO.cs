using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Data.SqlClient;

/// <summary>
/// Summary description for EquipeDAO
/// </summary>
public class EquipeDAO
{
    public static List<Equipe> listaEquipe(){
        var listaEquipe = new List<Equipe>();
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            cmm.CommandText = "SELECT id_equipe, equipe "+
                             " FROM [hspmAtendimento].[dbo].[equipe] " +
                             " ORDER BY equipe";

            try
            {
                cnn.Open();

                SqlDataReader dr1 = cmm.ExecuteReader();

                while (dr1.Read())
                {
                    Equipe equipe = new Equipe();
                    equipe.id_equipe = dr1.GetInt32(0);
                    equipe.descricao = dr1.GetString(1);
                    listaEquipe.Add(equipe);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }

        }
        return listaEquipe;
    }
}