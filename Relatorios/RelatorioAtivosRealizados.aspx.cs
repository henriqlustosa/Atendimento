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
using System.Data.SqlClient;
using System.IO;

public partial class Relatorios_RelatorioAtivosRealizados : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lbTotal.Text = TotalAtivos().ToString();
            lbHoje.Text = AtivosHoje().ToString();
            lbSete.Text = AtivosSeteDias().ToString();
            lbOntem.Text = AtivosOntem().ToString();
            lbTrinta.Text = AtivosTrinta().ToString();
            lbEsteMes.Text = AtivosEsteMes().ToString();
            lbdataHoje.Text = DateTime.Now.ToShortDateString();
            lbDataOntem.Text = DateTime.Now.AddDays(-1).ToShortDateString();
            lbDataSete.Text = DateTime.Now.AddDays(-7).ToShortDateString() + " à " + DateTime.Now.ToShortDateString();
            
            DateTime primeiroDia = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            lbDataEsteMes.Text = primeiroDia.ToShortDateString() + " à " + DateTime.Now.ToShortDateString();

            lbDataTrintaDias.Text = DateTime.Now.AddDays(-30).ToShortDateString() + " à " + DateTime.Now.ToShortDateString();
        }
    }

    protected void btnCarregarDados_Click(object sender, EventArgs e)
    {
        gridAtivos.DataSource = CarregaDadosTotais();
        gridAtivos.DataBind();
        ExportGridToExcel();
    }

    protected void btnCarregarDadosHoje_Click(object sender, EventArgs e)
    {
        gridAtivos.DataSource = CarregaDadosHoje();
        gridAtivos.DataBind();
        ExportGridToExcel();
    }

    protected void btnCarregarDadosOntem_Click(object sender, EventArgs e)
    {
        gridAtivos.DataSource = CarregaDadosOntem();
        gridAtivos.DataBind();
        ExportGridToExcel();
    }

    protected void btnCarregarDadosSeteDias_Click(object sender, EventArgs e)
    {
        gridAtivos.DataSource = CarregaDadosSeteDias();
        gridAtivos.DataBind();
        ExportGridToExcel();
    }

    protected void btnCarregarDadosTrintaDias_Click(object sender, EventArgs e)
    {
        gridAtivos.DataSource = CarregaDadosTrintaDias();
        gridAtivos.DataBind();
        ExportGridToExcel();
    }

    protected void btnCarregarDadosEsteMes_Click(object sender, EventArgs e)
    {
        gridAtivos.DataSource = CarregaDadosEsteMes();
        gridAtivos.DataBind();
        ExportGridToExcel();
    }

    protected static int AtivosEsteMes()
    {
        int esteMes = 0;
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            try
            {
                cnn.Open();
                cmm.CommandText = "SELECT count(*) as Ativos  FROM [hspmAtendimento].[dbo].[vw_relatorio_ativos] " +
                    " WHERE data_ligacao between (CONVERT(datetime, (DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0)) - 0, 103)) AND (CONVERT(datetime, GETDATE(), 103))";
                    //" WHERE data_ligacao between (CONVERT(datetime, (DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0)) - 30, 103)) AND (CONVERT(datetime, GETDATE(), 103))";
                SqlDataReader dr1 = cmm.ExecuteReader();
                if (dr1.Read())
                {
                    esteMes = dr1.GetInt32(0);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }

        return esteMes;
    }

    protected static int AtivosTrinta()
    {
        int trinta = 0;
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            try
            {
                cnn.Open();
                cmm.CommandText = "SELECT count(*) as Ativos  FROM [hspmAtendimento].[dbo].[vw_relatorio_ativos] " +
                    " WHERE data_ligacao between (CONVERT(datetime, GETDATE() - 30, 103)) AND (CONVERT(datetime, GETDATE(), 103))";
                SqlDataReader dr1 = cmm.ExecuteReader();
                if (dr1.Read())
                {
                    trinta = dr1.GetInt32(0);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return trinta;
    }

    protected static int AtivosOntem()
    {
        int ontem = 0;
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            try
            {
                cnn.Open();
                cmm.CommandText = "SELECT count(*) as Ativos  FROM [hspmAtendimento].[dbo].[vw_relatorio_ativos] WHERE DATEDIFF(day, GETDATE() , data_ligacao) = - 1";
                SqlDataReader dr1 = cmm.ExecuteReader();
                if (dr1.Read())
                {
                    ontem = dr1.GetInt32(0);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return ontem;
    }

    protected static int AtivosSeteDias()
    {
        int sete = 0;
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            try
            {
                cnn.Open();
                cmm.CommandText = "SELECT count(*) as Ativos  FROM [hspmAtendimento].[dbo].[vw_relatorio_ativos] "+
                    " WHERE data_ligacao between (CONVERT(datetime, GETDATE() - 6, 103)) AND (CONVERT(datetime, GETDATE(), 103))";
                SqlDataReader dr1 = cmm.ExecuteReader();
                if (dr1.Read())
                {
                    sete = dr1.GetInt32(0);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return sete;
    }

    protected static int AtivosHoje()
    {
        int hoje = 0;
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            try
            {
                cnn.Open();
                cmm.CommandText = "SELECT count(*) as Ativos  FROM [hspmAtendimento].[dbo].[vw_relatorio_ativos] WHERE DATEDIFF(day, GETDATE() , data_ligacao) = 0";
                SqlDataReader dr1 = cmm.ExecuteReader();
                if (dr1.Read())
                {
                    hoje = dr1.GetInt32(0);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return hoje;
    }


    protected static int TotalAtivos()
    {
        int total = 0;
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            try
            {
                cnn.Open();
                cmm.CommandText = "SELECT count(*) as Ativos  FROM [hspmAtendimento].[dbo].[vw_relatorio_ativos]";

                SqlDataReader dr1 = cmm.ExecuteReader();
                if (dr1.Read())
                {
                    total = dr1.GetInt32(0);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return total;
    }

    public DataTable CarregaDadosEsteMes()
    {
        DataTable dt = new DataTable();
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            try
            {
                cnn.Open();
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = cnn;
                    command.CommandText = "SELECT * FROM [vw_relatorio_ativos] WHERE data_ligacao between (CONVERT(datetime, (DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0)) - 0, 103)) AND (CONVERT(datetime, GETDATE(), 103))";

                    using (SqlDataAdapter adapter = new SqlDataAdapter())
                    {
                        adapter.SelectCommand = command;
                        adapter.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return dt;
    }

    public DataTable CarregaDadosTrintaDias()
    {
        DataTable dt = new DataTable();
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            try
            {
                cnn.Open();
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = cnn;
                    command.CommandText = "SELECT * FROM [vw_relatorio_ativos] WHERE data_ligacao between (CONVERT(datetime, GETDATE() - 30, 103)) AND (CONVERT(datetime, GETDATE(), 103))";

                    using (SqlDataAdapter adapter = new SqlDataAdapter())
                    {
                        adapter.SelectCommand = command;
                        adapter.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return dt;
    }

    public DataTable CarregaDadosSeteDias()
    {
        DataTable dt = new DataTable();
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            try
            {
                cnn.Open();
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = cnn;
                    command.CommandText = "SELECT * FROM [vw_relatorio_ativos] WHERE data_ligacao between (CONVERT(datetime, GETDATE() - 7, 103)) AND (CONVERT(datetime, GETDATE(), 103))";

                    using (SqlDataAdapter adapter = new SqlDataAdapter())
                    {
                        adapter.SelectCommand = command;
                        adapter.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return dt;
    }

    public DataTable CarregaDadosOntem()
    {
        DataTable dt = new DataTable();
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            try
            {
                cnn.Open();
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = cnn;
                    command.CommandText = "SELECT * FROM [vw_relatorio_ativos] WHERE DATEDIFF(day, GETDATE() , data_ligacao) = - 1";

                    using (SqlDataAdapter adapter = new SqlDataAdapter())
                    {
                        adapter.SelectCommand = command;
                        adapter.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return dt;
    }

    public DataTable CarregaDadosHoje()
    {
        DataTable dt = new DataTable();
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            try
            {
                cnn.Open();
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = cnn;
                    command.CommandText = "SELECT * FROM [vw_relatorio_ativos] WHERE DATEDIFF(day, GETDATE() , data_ligacao) = 0";

                    using (SqlDataAdapter adapter = new SqlDataAdapter())
                    {
                        adapter.SelectCommand = command;
                        adapter.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return dt;
    }

    public DataTable CarregaDadosTotais()
    {
        DataTable dt = new DataTable();
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            try
            {
                cnn.Open();
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = cnn;
                    command.CommandText = "SELECT * FROM [vw_relatorio_ativos]";

                    using (SqlDataAdapter adapter = new SqlDataAdapter())
                    {
                        adapter.SelectCommand = command;
                        adapter.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return dt;
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    private void ExportGridToExcel()
    {
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "Ativos" + DateTime.Now + ".xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
        gridAtivos.GridLines = GridLines.Both;
        gridAtivos.HeaderStyle.Font.Bold = true;
        gridAtivos.RenderControl(htmltextwrtter);
        Response.Write(strwritter.ToString());
        Response.End();
    }
}