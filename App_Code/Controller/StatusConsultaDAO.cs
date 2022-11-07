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
/// Summary description for StatusConsultaDAO
/// </summary>
public class StatusConsultaDAO
{
    public StatusConsultaDAO()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string getDescricaoStats(int _cod)
    {
        string descStatus = "";
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            cmm.CommandText = "SELECT [status]"+
                              " FROM [hspmAtendimento].[dbo].[status_consulta] "+
                              " WHERE id_status = " + _cod;

            try
            {
                cnn.Open();

                SqlDataReader dr1 = cmm.ExecuteReader();

                if (dr1.Read())
                {
                    descStatus = dr1.GetString(0);
                }

            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }

        }

        return descStatus;
    }

    public static List<StatusConsulta> listaStatusConsulta()
    {
        var lista = new List<StatusConsulta>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            cmm.CommandText = "SELECT [id_status], [status], [tenta], [ativo] FROM [status_consulta]";

            try
            {
                cnn.Open();

                SqlDataReader dr1 = cmm.ExecuteReader();

                while (dr1.Read())
                {
                    StatusConsulta status = new StatusConsulta();

                    status.Id_Status = dr1.GetInt32(0);
                    status.Descricao = dr1.GetString(1);
                    status.Tentativa = dr1.GetString(2);
                    status.Ativo = dr1.GetString(3);
                    lista.Add(status);
                }

            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }

        }
        return lista;
    }

    public static String GravaStatus(string _descricao, string _tentativa, string _ativo)
    {
        string mensagem = "";


        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = new SqlCommand();
            cmm.Connection = cnn;
            cnn.Open();
            SqlTransaction mt = cnn.BeginTransaction();
            cmm.Transaction = mt;
            try
            {
                cmm.CommandText = "Insert into status_consulta " +
                    "(status, tenta, ativo)" +
                    "values (@status,@tenta,@ativo)";


                cmm.Parameters.Add("@status", SqlDbType.VarChar).Value = _descricao.ToUpper();
                cmm.Parameters.Add("@tenta", SqlDbType.VarChar).Value = _tentativa.ToUpper();
                cmm.Parameters.Add("@ativo", SqlDbType.VarChar).Value = _ativo.ToUpper();
                cmm.ExecuteNonQuery();

                mt.Commit();
                mt.Dispose();
                cnn.Close();
                mensagem = "Cadastro realizado com sucesso!";
            }
            catch (Exception ex)
            {
                string error = ex.Message;
                mensagem = error;
                try
                {
                    mt.Rollback();
                }
                catch (Exception ex1)
                { }
            }
            return mensagem;
        }
    }
}