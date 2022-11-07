using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Configuration;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class webservice : System.Web.Services.WebService
{
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod()]
    public string QuantidadeAtivosStatusDiaGrafico(string data)
    {
        data = "23/03/2020";


        int dia = Convert.ToInt32(data.Substring(0, 2));
        int mes = Convert.ToInt32(data.Substring(3, 2));
        int ano = Convert.ToInt32(data.Substring(6, 4));

        var dados = new List<CallStatus>();

        var quantidade1 = new List<int>();
        var descricao1 = new List<string>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT COUNT(status_consulta.status) AS qtd_status, status_consulta.status " +
                                " FROM hspmAtendimento.dbo.ativo_ligacao INNER JOIN hspmAtendimento.dbo.status_consulta ON hspmAtendimento.dbo.ativo_ligacao.status = status_consulta.id_status " +
                                " WHERE DAY(data_ligacao) = "+ dia +" and MONTH(data_ligacao) = " + mes + " and YEAR(data_ligacao) = " + ano +
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
                    call.descricao = dr1.GetString(1) + " - " + dr1.GetInt32(0);

                    quantidade1.Add(call.quantidade);
                    descricao1.Add(call.descricao.ToString());

                    //dados.Add(call);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }

        Chart _chart = new Chart();
        _chart.labels = descricao1.ToArray();
        _chart.datasets = new List<Datasets>();

        List<Datasets> _dataSet = new List<Datasets>();
        _dataSet.Add(new Datasets()
        {
            label = "Total do Dia",
            data = quantidade1.ToArray(),
            backgroundColor = new string[] { "rgba(38, 185, 154, 0.31)", 
                                                 "rgba(0, 255, 255)" ,
                                                 "rgba(0, 128, 255)", 
                                                 "rgba(0, 0, 255)" ,
                                                 "rgba(0,100,0)", 
                                                 "rgba(0,255,0)" ,
                                                 "rgba(143,188,143)", 
                                                 "rgba(102,205,170)" ,
                                                 "rgba(0,128,128)", 
                                                 "rgba(0,0,0)" ,
                                                 "rgba(224,255,255)",
                                                 "rgba(106,90,205)",
                                                 "rgba(128,0,128)" },

            borderColor = new string[] { "rgba(38, 185, 154, 0.7)",
                                          "rgba(0, 255, 255)" ,
                                                 "rgba(0, 128, 255)", 
                                                 "rgba(0, 0, 255)" ,
                                                 "rgba(0,100,0)", 
                                                 "rgba(0,255,0)" ,
                                                 "rgba(143,188,143)", 
                                                 "rgba(102,205,170)" ,
                                                 "rgba(0,128,128)", 
                                                 "rgba(0,0,0)" ,
                                                 "rgba(224,255,255)",
                                                 "rgba(106,90,205)",
                                                 "rgba(128,0,128)"
                                        },

            pointHoverBackgroundColor = new string[] { "#fff" },
            pointHoverBorderColor = new string[] { "rgba(220,220,220,1)" },
            pointBorderColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointBackgroundColor = new string[] { "rgba(38, 185, 154, 0.7)" }

        });

        _chart.datasets = _dataSet;

        //O JavaScriptSerializer vai fazer o web service retornar JSON
        JavaScriptSerializer js = new JavaScriptSerializer();
        //return js.Serialize(dados);
        return js.Serialize(_chart);
    }




    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod()]
    public string AtivosStatusPorUsuarioGrafico(string mesAno, string user)
    {


        int mes = Convert.ToInt32(mesAno.Substring(0, 2));
        int ano = Convert.ToInt32(mesAno.Substring(3, 4));

        string _usuario = user;


        var dados = new List<CallStatus>();

        var quantidade1 = new List<int>();
        var descricao1 = new List<string>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT s.status,COUNT(*) as qtd "+
                                 " FROM [hspmAtendimento].[dbo].[ativo_ligacao] a, [hspmAtendimento].[dbo].[status_consulta] s "+
                                 " WHERE a.status = s.id_status "+
                                 " AND a.usuario = '"+ _usuario +"'"+
                                 " AND MONTH(a.data_ligacao) = " + mes + " and YEAR(a.data_ligacao) = " + ano +
                                 " GROUP BY s.status " +
                                 " ORDER BY status";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                //char[] ponto = { '.', ' ' };
                while (dr1.Read())
                {
                    CallStatus call = new CallStatus();
                    call.descricao = dr1.GetString(0) + " - " + dr1.GetInt32(1);
                    call.quantidade = dr1.GetInt32(1);

                    quantidade1.Add(call.quantidade);
                    descricao1.Add(call.descricao.ToString());

                    //dados.Add(call);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }

        Chart _chart = new Chart();
        _chart.labels = descricao1.ToArray();
        _chart.datasets = new List<Datasets>();

        List<Datasets> _dataSet = new List<Datasets>();
        _dataSet.Add(new Datasets()
        {
            label = "Total do Mês",
            data = quantidade1.ToArray(),
            backgroundColor = new string[] { "rgba(38, 185, 154, 0.31)", 
                                                 "rgba(0, 255, 255)" ,
                                                 "rgba(0, 128, 255)", 
                                                 "rgba(0, 0, 255)" ,
                                                 "rgba(0,100,0)", 
                                                 "rgba(0,255,0)" ,
                                                 "rgba(143,188,143)", 
                                                 "rgba(102,205,170)" ,
                                                 "rgba(0,128,128)", 
                                                 "rgba(0,0,0)" ,
                                                 "rgba(224,255,255)",
                                                 "rgba(106,90,205)",
                                                 "rgba(128,0,128)" },

            borderColor = new string[] { "rgba(38, 185, 154, 0.7)",
                                          "rgba(0, 255, 255)" ,
                                                 "rgba(0, 128, 255)", 
                                                 "rgba(0, 0, 255)" ,
                                                 "rgba(0,100,0)", 
                                                 "rgba(0,255,0)" ,
                                                 "rgba(143,188,143)", 
                                                 "rgba(102,205,170)" ,
                                                 "rgba(0,128,128)", 
                                                 "rgba(0,0,0)" ,
                                                 "rgba(224,255,255)",
                                                 "rgba(106,90,205)",
                                                 "rgba(128,0,128)"
                                        },

            pointHoverBackgroundColor = new string[] { "#fff" },
            pointHoverBorderColor = new string[] { "rgba(220,220,220,1)" },
            pointBorderColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointBackgroundColor = new string[] { "rgba(38, 185, 154, 0.7)" }

        });

        _chart.datasets = _dataSet;

        //O JavaScriptSerializer vai fazer o web service retornar JSON
        JavaScriptSerializer js = new JavaScriptSerializer();
        //return js.Serialize(dados);
        return js.Serialize(_chart);
    }




    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod()]
    public string QuantidadeAtivosPorUsuario(string mesAno)
    {
        int mes = Convert.ToInt32(mesAno.Substring(0, 2));
        int ano = Convert.ToInt32(mesAno.Substring(3, 4));

        var quantidade1 = new List<int>();
        var usuario = new List<string>();

        var dados = new List<CallStatus>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT usuario, COUNT(*) as quantidade "+
                                "FROM [hspmAtendimento].[dbo].[ativo_ligacao] "+
                                "WHERE MONTH(data_ligacao) = " + mes + " and YEAR(data_ligacao) = " + ano +
                                "GROUP BY usuario " +
                                "ORDER BY quantidade DESC ";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                //char[] ponto = { '.', ' ' };
                while (dr1.Read())
                {
                    CallStatus call = new CallStatus();

                    call.descricao = dr1.GetString(0).ToUpper() + " - " + dr1.GetInt32(1);
                    call.quantidade = dr1.GetInt32(1);
                    

                    quantidade1.Add(call.quantidade);
                    usuario.Add(call.descricao.ToString());
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }

        Chart _chart = new Chart();
        _chart.labels = usuario.ToArray();
        _chart.datasets = new List<Datasets>();

        List<Datasets> _dataSet = new List<Datasets>();
        _dataSet.Add(new Datasets()
        {
            label = "Total do Mês por Colaborador",
            data = quantidade1.ToArray(),
            backgroundColor = new string[] { "rgba(38, 185, 154, 0.31)", 
                                                 "rgba(0, 255, 255)" ,
                                                 "rgba(0, 128, 255)", 
                                                 "rgba(0, 0, 255)" ,
                                                 "rgba(0,100,0)", 
                                                 "rgba(0,255,0)" ,
                                                 "rgba(143,188,143)", 
                                                 "rgba(102,205,170)" ,
                                                 "rgba(0,128,128)", 
                                                 "rgba(0,0,0)" },

            borderColor = new string[] { "rgba(38, 185, 154, 0.7)",
                                          "rgba(0, 255, 255)" ,
                                                 "rgba(0, 128, 255)", 
                                                 "rgba(0, 0, 255)" ,
                                                 "rgba(0,100,0)", 
                                                 "rgba(0,255,0)" ,
                                                 "rgba(143,188,143)", 
                                                 "rgba(102,205,170)" ,
                                                 "rgba(0,128,128)", 
                                                 "rgba(0,0,0)" 
                                        },

            pointHoverBackgroundColor = new string[] { "#fff" },
            pointHoverBorderColor = new string[] { "rgba(220,220,220,1)" },
            pointBorderColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointBackgroundColor = new string[] { "rgba(38, 185, 154, 0.7)" }

        });

        _chart.datasets = _dataSet;

        //O JavaScriptSerializer vai fazer o web service retornar JSON
        JavaScriptSerializer js = new JavaScriptSerializer();
        //return js.Serialize(dados);
        return js.Serialize(_chart);
    }

    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod()]
    public string QuantidadeAtivosStatus(string mesAno)
    {
        int mes = Convert.ToInt32(mesAno.Substring(0, 2));
        int ano = Convert.ToInt32(mesAno.Substring(3, 4));
        var dados = new List<CallStatus>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            //cmm.CommandText = "SELECT COUNT(status_consulta.status) AS qtd_status, status_consulta.status " +
            //                    " FROM hspmAtendimento.dbo.ativo_ligacao INNER JOIN hspmAtendimento.dbo.status_consulta ON hspmAtendimento.dbo.ativo_ligacao.status = status_consulta.id_status " +
            //                    " WHERE MONTH(data_ligacao) = " + mes + " and YEAR(data_ligacao) = " + ano +
            //                    " GROUP BY status_consulta.status " +
            //                    " ORDER BY qtd_status DESC";

            cmm.CommandText = "SELECT COUNT(status_consulta.status) AS qtd_status, status_consulta.status, " +
                                "cast((count(status_consulta.status)*100.0)/(select COUNT(*) FROM hspmAtendimento.dbo.ativo_ligacao INNER JOIN hspmAtendimento.dbo.status_consulta ON hspmAtendimento.dbo.ativo_ligacao.status = status_consulta.id_status " +
                                "WHERE MONTH(data_ligacao) = " + mes + " and YEAR(data_ligacao) = " + ano + ")as decimal(5,2)) as porcentagem " +
                                "FROM hspmAtendimento.dbo.ativo_ligacao INNER JOIN hspmAtendimento.dbo.status_consulta ON hspmAtendimento.dbo.ativo_ligacao.status = status_consulta.id_status " +
                                "WHERE MONTH(data_ligacao) = " + mes + " and YEAR(data_ligacao) = " + ano + 
                                "GROUP BY status_consulta.status " +
                                "ORDER BY qtd_status DESC ";
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
                    call.porcentagem = Convert.ToString(dr1.GetDecimal(2)) + "%";


                    dados.Add(call);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(dados);
    }

    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod()]
    public string QuantidadeAtivosStatusGrafico(string mesAno)
    {
        int mes = Convert.ToInt32(mesAno.Substring(0,2));
        int ano = Convert.ToInt32(mesAno.Substring(3,4));

        var dados = new List<CallStatus>();

        var quantidade1 = new List<int>();
        var descricao1 = new List<string>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText =   "SELECT COUNT(status_consulta.status) AS qtd_status, status_consulta.status " +
                                " FROM hspmAtendimento.dbo.ativo_ligacao INNER JOIN hspmAtendimento.dbo.status_consulta ON hspmAtendimento.dbo.ativo_ligacao.status = status_consulta.id_status " +
                                " WHERE MONTH(data_ligacao) = "+ mes +" and YEAR(data_ligacao) = " + ano +
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
                    call.descricao = dr1.GetString(1) + " - " + dr1.GetInt32(0);

                    quantidade1.Add(call.quantidade);
                    descricao1.Add(call.descricao.ToString());
                    
                    //dados.Add(call);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }

        Chart _chart = new Chart();
        _chart.labels = descricao1.ToArray();
        _chart.datasets = new List<Datasets>();

        List<Datasets> _dataSet = new List<Datasets>();
        _dataSet.Add(new Datasets()
        {
            label = "Total do Mês",
            data = quantidade1.ToArray(),
            backgroundColor = new string[] { "rgba(38, 185, 154, 0.31)", 
                                                 "rgba(0, 255, 255)" ,
                                                 "rgba(0, 128, 255)", 
                                                 "rgba(0, 0, 255)" ,
                                                 "rgba(0,100,0)", 
                                                 "rgba(0,255,0)" ,
                                                 "rgba(143,188,143)", 
                                                 "rgba(102,205,170)" ,
                                                 "rgba(0,128,128)", 
                                                 "rgba(0,0,0)" ,
                                                 "rgba(224,255,255)",
                                                 "rgba(106,90,205)",
                                                 "rgba(128,0,128)" },

            borderColor = new string[] { "rgba(38, 185, 154, 0.7)",
                                          "rgba(0, 255, 255)" ,
                                                 "rgba(0, 128, 255)", 
                                                 "rgba(0, 0, 255)" ,
                                                 "rgba(0,100,0)", 
                                                 "rgba(0,255,0)" ,
                                                 "rgba(143,188,143)", 
                                                 "rgba(102,205,170)" ,
                                                 "rgba(0,128,128)", 
                                                 "rgba(0,0,0)" ,
                                                 "rgba(224,255,255)",
                                                 "rgba(106,90,205)",
                                                 "rgba(128,0,128)"
                                        },

            pointHoverBackgroundColor = new string[] { "#fff" },
            pointHoverBorderColor = new string[] { "rgba(220,220,220,1)" },
            pointBorderColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointBackgroundColor = new string[] { "rgba(38, 185, 154, 0.7)" }

        });

        _chart.datasets = _dataSet;

        //O JavaScriptSerializer vai fazer o web service retornar JSON
        JavaScriptSerializer js = new JavaScriptSerializer();
        //return js.Serialize(dados);
        return js.Serialize(_chart);
    }

    //Retorna o formato JSON
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod()]
    public string RetornaChamadasDia()
    {
        //Lista
        var lista = new List<CallHoras>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT DATEPART(HOUR, data_ligacao) AS [HourofDay], COALESCE(COUNT(id_consulta), 0) AS [Total Calls] " +
                            " FROM [hspmAtendimento].[dbo].[ativo_ligacao] " +
                            " WHERE day(data_ligacao) = 11 " +
                            " GROUP BY DATEPART(HOUR, data_ligacao) " +
                            " ORDER BY DATEPART(HOUR, data_ligacao)";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                //char[] ponto = { '.', ' ' };
                while (dr1.Read())
                {
                    CallHoras call = new CallHoras();

                    call.Horadodia = dr1.GetInt32(0);
                    call.TotalCall = dr1.GetInt32(1);

                    lista.Add(call);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }

        //O JavaScriptSerializer vai fazer o web service retornar JSON
        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(lista);
    }

    //Retorna o formato JSON
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod()]
    public string ChamadasDia(string data)
    {
        string _dia = data;
        //string d = "18/10/2019";

        var horas = new List<string>();
        var total = new List<int>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT DATEPART(HOUR, data_ligacao) AS [HourofDay], COALESCE(COUNT(id_consulta), 0) AS [Total Calls] " +
                            " FROM [hspmAtendimento].[dbo].[ativo_ligacao] " +
                            " WHERE CONVERT(varchar(12),data_ligacao, 103) = '" + _dia + "' GROUP BY DATEPART(HOUR, data_ligacao) " +
                            " ORDER BY DATEPART(HOUR, data_ligacao)";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                while (dr1.Read())
                {
                    CallHoras call = new CallHoras();
                    call.Horadodia = dr1.GetInt32(0);
                    call.TotalCall = dr1.GetInt32(1);

                    horas.Add(call.Horadodia.ToString() + ":00");

                    total.Add(call.TotalCall);

                }

            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }

        Chart _chart = new Chart();
        _chart.labels = horas.ToArray();
        _chart.datasets = new List<Datasets>();

        List<Datasets> _dataSet = new List<Datasets>();
        _dataSet.Add(new Datasets()
        {
            label = "Ativos de Hoje",
            data = total.ToArray(),
            backgroundColor = new string[] { "rgba(38, 185, 154, 0.31)" },
            borderColor = new string[] { "rgba(38, 185, 154, 0.7)" },

            pointBorderColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointBackgroundColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointHoverBackgroundColor = new string[] { "#fff" },
            pointHoverBorderColor = new string[] { "rgba(220,220,220,1)" },
            pointBorderWidth = "1",
            borderWidth = "1"
        });

        _chart.datasets = _dataSet;


        //O JavaScriptSerializer vai fazer o web service retornar JSON
        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(_chart);
    }

    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod()]
    public string ChamadasOntem()
    {
        var horas = new List<string>();
        var total = new List<int>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT DATEPART(HOUR, data_ligacao) AS [HourofDay], COALESCE(COUNT(id_consulta), 0) AS [Total Calls] " +
                            " FROM [hspmAtendimento].[dbo].[ativo_ligacao] " +
                            " WHERE DATEDIFF(day, GETDATE() , data_ligacao) = - 1 " +
                            " GROUP BY DATEPART(HOUR, data_ligacao) " +
                            " ORDER BY DATEPART(HOUR, data_ligacao)";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                while (dr1.Read())
                {
                    CallHoras call = new CallHoras();
                    call.Horadodia = dr1.GetInt32(0);
                    call.TotalCall = dr1.GetInt32(1);

                    horas.Add(call.Horadodia.ToString() + ":00");
                    total.Add(call.TotalCall);

                }

            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }

        Chart _chart = new Chart();
        _chart.labels = horas.ToArray();
        _chart.datasets = new List<Datasets>();

        List<Datasets> _dataSet = new List<Datasets>();
        _dataSet.Add(new Datasets()
        {
            label = "Ativos de Ontem",
            data = total.ToArray(),
            backgroundColor = new string[] { "rgba(38, 185, 154, 0.31)" },
            borderColor = new string[] { "rgba(38, 185, 154, 0.7)" },

            pointBorderColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointBackgroundColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointHoverBackgroundColor = new string[] { "#fff" },
            pointHoverBorderColor = new string[] { "rgba(220,220,220,1)" },
            pointBorderWidth = "1",
            borderWidth = "1"
        });

        _chart.datasets = _dataSet;

        //O JavaScriptSerializer vai fazer o web service retornar JSON
        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(_chart);
    }

    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod()]
    public string ChamadasSeteDias()
    {
        var horas = new List<string>();
        var total = new List<int>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT DATEPART(DAY, data_ligacao) AS [Day], COALESCE(COUNT(id_consulta), 0) AS [Total Calls] " +
                            " FROM [hspmAtendimento].[dbo].[ativo_ligacao] " +
                            " WHERE data_ligacao between (CONVERT(datetime, GETDATE() - 6, 103)) AND (CONVERT(datetime, GETDATE(), 103)) " +
                            " GROUP BY DATEPART(DAY, data_ligacao), DATEPART(MONTH, data_ligacao) " +
                            " ORDER BY DATEPART(MONTH, data_ligacao) asc ";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                while (dr1.Read())
                {
                    CallHoras call = new CallHoras();
                    call.Horadodia = dr1.GetInt32(0);
                    call.TotalCall = dr1.GetInt32(1);

                    horas.Add(call.Horadodia.ToString());
                    total.Add(call.TotalCall);

                }

            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }

        Chart _chart = new Chart();
        _chart.labels = horas.ToArray();
        _chart.datasets = new List<Datasets>();

        List<Datasets> _dataSet = new List<Datasets>();
        _dataSet.Add(new Datasets()
        {
            label = "Ativos Últimos 7 Dias",
            data = total.ToArray(),
            backgroundColor = new string[] { "rgba(38, 185, 154, 0.31)" },
            borderColor = new string[] { "rgba(38, 185, 154, 0.7)" },

            pointBorderColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointBackgroundColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointHoverBackgroundColor = new string[] { "#fff" },
            pointHoverBorderColor = new string[] { "rgba(220,220,220,1)" },
            pointBorderWidth = "1",
            borderWidth = "1"
        });

        _chart.datasets = _dataSet;

        //O JavaScriptSerializer vai fazer o web service retornar JSON
        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(_chart);
    }

    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod()]
    public string ChamadasEsteMes()
    {
        var horas = new List<string>();
        var total = new List<int>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT DATEPART(DAY, data_ligacao) AS [Day], COALESCE(COUNT(id_consulta), 0) AS [Total Calls] " +
                            " FROM [hspmAtendimento].[dbo].[ativo_ligacao] " +
                            " WHERE data_ligacao between (CONVERT(datetime, (DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0)) - 0, 103)) AND (CONVERT(datetime, GETDATE(), 103)) " +
                            " GROUP BY DATEPART(DAY, data_ligacao) " +
                            " ORDER BY DATEPART(DAY, data_ligacao)";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                while (dr1.Read())
                {
                    CallHoras call = new CallHoras();
                    call.Horadodia = dr1.GetInt32(0);
                    call.TotalCall = dr1.GetInt32(1);

                    horas.Add(call.Horadodia.ToString());
                    total.Add(call.TotalCall);

                }

            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }

        Chart _chart = new Chart();
        _chart.labels = horas.ToArray();
        _chart.datasets = new List<Datasets>();

        List<Datasets> _dataSet = new List<Datasets>();
        _dataSet.Add(new Datasets()
        {
            label = "Ativos Este Mês",
            data = total.ToArray(),
            backgroundColor = new string[] { "rgba(38, 185, 154, 0.31)" },
            borderColor = new string[] { "rgba(38, 185, 154, 0.7)" },

            pointBorderColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointBackgroundColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointHoverBackgroundColor = new string[] { "#fff" },
            pointHoverBorderColor = new string[] { "rgba(220,220,220,1)" },
            pointBorderWidth = "1",
            borderWidth = "1"
        });

        _chart.datasets = _dataSet;

        //O JavaScriptSerializer vai fazer o web service retornar JSON
        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(_chart);
    }

    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod()]
    public string ChamadasMes(string mesAno)
    {
        int mes = Convert.ToInt32(mesAno.Substring(0, 2));
        int ano = Convert.ToInt32(mesAno.Substring(3, 4));

        var horas = new List<string>();
        var total = new List<int>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT DATEPART(DAY, data_ligacao) AS [Day], COALESCE(COUNT(id_consulta), 0) AS [Total Calls] " +
                            " FROM [hspmAtendimento].[dbo].[ativo_ligacao] " +
                            " WHERE MONTH(data_ligacao) = " + mes + " and YEAR(data_ligacao) = " + ano +
                            " GROUP BY DATEPART(DAY, data_ligacao) " +
                            " ORDER BY DATEPART(DAY, data_ligacao)";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                while (dr1.Read())
                {
                    CallHoras call = new CallHoras();
                    call.Horadodia = dr1.GetInt32(0);
                    call.TotalCall = dr1.GetInt32(1);

                    horas.Add(call.Horadodia.ToString());
                    total.Add(call.TotalCall);

                }

            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }

        Chart _chart = new Chart();
        _chart.labels = horas.ToArray();
        _chart.datasets = new List<Datasets>();

        List<Datasets> _dataSet = new List<Datasets>();
        _dataSet.Add(new Datasets()
        {
            label = "Evolução de Ligações durante o Mês",
            data = total.ToArray(),
            backgroundColor = new string[] { "rgba(38, 185, 154, 0.31)" },
            borderColor = new string[] { "rgba(38, 185, 154, 0.7)" },

            pointBorderColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointBackgroundColor = new string[] { "rgba(38, 185, 154, 0.7)" },
            pointHoverBackgroundColor = new string[] { "#fff" },
            pointHoverBorderColor = new string[] { "rgba(220,220,220,1)" },
            pointBorderWidth = "1",
            borderWidth = "1"
        });

        _chart.datasets = _dataSet;

        //O JavaScriptSerializer vai fazer o web service retornar JSON
        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(_chart);
    }
}