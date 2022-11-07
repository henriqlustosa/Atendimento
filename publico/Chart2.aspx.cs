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

public partial class publico_Chart2 : System.Web.UI.Page
{
    

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddl.DataSource = ComboData.Data().ToList();
            ddl.DataTextField = "DayName";
            ddl.DataValueField = "DayValue";
            ddl.DataBind();

            //txbData.Text = DateTime.Today.ToShortDateString();
        }
    }

    protected void ddl_SelectedIndexChanged(object sender, EventArgs e)
    {
        txbData.Text = ddl.SelectedItem.Value;
    }



    protected void btnListar_Click(object sender, EventArgs e)
    {
        int mes = 1;
        int ano = 2020;

        rpt.DataSource = QuantidadeAtivosStatus(mes, ano);
        rpt.DataBind();
    }


    public List<CallStatus> QuantidadeAtivosStatus(int mes, int ano)
    {
        var dados = new List<CallStatus>();



        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT COUNT(status_consulta.status) AS qtd_status, status_consulta.status " +
                                " FROM hspmAtendimento.dbo.ativo_ligacao INNER JOIN hspmAtendimento.dbo.status_consulta ON hspmAtendimento.dbo.ativo_ligacao.status = status_consulta.id_status " +
                                " WHERE MONTH(data_ligacao) = " + mes + " and YEAR(data_ligacao) = " + ano +
                                " GROUP BY status_consulta.status " +
                                " ORDER BY qtd_status DESC";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                //char[] ponto = { '.', ' ' };
                while (dr1.Read())
                {
                    CallStatus call = new CallStatus();

                    call.quantidade = dr1.GetInt32(0);
                    call.descricao = dr1.GetString(1);


                    dados.Add(call);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }

        return dados;
    }
}