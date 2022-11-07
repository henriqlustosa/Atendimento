using System;
using System.Collections;
using System.Configuration;
using System.Data;
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

public partial class Consultas_rediscagem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GridView1.DataSource = ListaConsultasRediscagem();
        GridView1.DataBind();
    }

    private List<Ativo> ListaConsultasRediscagem()
    {
        // colocar regra para listar consultas do paciente com tentativas abaixo de 3 (terceira tentativa)

        var lista = new List<Ativo>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT  [id_consulta]" +
                                 " ,[prontuario]" +
                                 " ,[dt_consulta]" +
                                 " ,[grade]" +
                                 " ,[equipe]" +
                                 " ,[profissional]" +
                                 " ,[codigo_consulta]" +
                             " FROM [hspmAtendimento].[dbo].[consulta]" +
                             " where (DAY(dt_consulta) between 23 and 27)  and MONTH(dt_consulta) = 3 and YEAR(dt_consulta) = 2020" +
                             " and ativo = 1";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                //char[] ponto = { '.', ' ' };
                while (dr1.Read())
                {
                    Ativo consulta = new Ativo();
                    consulta.Id_Consulta = dr1.GetInt32(0);
                    consulta.Prontuario = dr1.GetInt32(1);
                    consulta.Dt_Consulta = dr1.GetDateTime(2).ToString();
                    consulta.Grade = dr1.GetInt32(3);
                    consulta.Equipe = dr1.GetString(4);
                    consulta.Nome_Profissional = dr1.GetString(5);
                    consulta.Codigo_Consulta = dr1.GetInt32(6);
                    consulta.Nome = PacienteMailingDAO.getDadosPaciente(consulta.Prontuario).Nome;

                    lista.Add(consulta);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return lista;
    }
}
