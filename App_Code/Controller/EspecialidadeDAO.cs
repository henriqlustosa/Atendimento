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
using System.Data.SqlClient;
using System.Collections.Generic;

/// <summary>
/// Summary description for EspecialidadeDAO
/// </summary>
public class EspecialidadeDAO
{
    public static string getEspecialidade(int _cod)
    {
        string espec = "";
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            cmm.CommandText = "SELECT descricao_espec" +
                             " FROM [hspmAtendimento].[dbo].[especialidade] " +
                             " WHERE cod_especialidade = " + _cod;

            try
            {
                cnn.Open();

                SqlDataReader dr1 = cmm.ExecuteReader();

                if (dr1.Read())
                {
                    espec = dr1.GetString(0);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return espec;
    }

    public static List<Especialidade> listaEspecialidade()
    {
        var listaEspec = new List<Especialidade>();
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            cmm.CommandText = "SELECT cod_especialidade, descricao_espec, status_espec " +
                             " FROM [hspmAtendimento].[dbo].[especialidade] " +
                             " ORDER BY descricao_espec";

            try
            {
                cnn.Open();

                SqlDataReader dr1 = cmm.ExecuteReader();

                while (dr1.Read())
                {
                    Especialidade espec = new Especialidade();
                    espec.cod_especialidade = dr1.GetInt32(0);
                    espec.descricao_espec = dr1.GetString(1);
                    espec.status_espec = dr1.GetString(2);
                    listaEspec.Add(espec);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }

        }
        return listaEspec;
    }
}
