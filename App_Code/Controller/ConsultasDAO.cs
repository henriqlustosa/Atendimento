﻿using System;
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
/// Summary description for ConsultasDAO
/// </summary>
public class ConsultasDAO
{
	public ConsultasDAO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    private static string InformacaoConCancelada(int _id_consulta)
    {
        string informacao = "";

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            cmm.CommandText = "SELECT i.[descricao_con_cancelada]" +
                              " FROM [hspmCall].[dbo].[consultas_cancelar] c ,[hspmCall].[dbo].[info_con_cancelada] i " +
                              " WHERE c.id_cancela = i.id_consultas_cancelar " +
                              " AND c.id_consulta = " + _id_consulta;

            try
            {
                cnn.Open();

                SqlDataReader dr1 = cmm.ExecuteReader();

                if (dr1.Read())
                {
                    informacao = dr1.GetString(0);
                }

            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }

        }



        return informacao;
    }

    public static List<Ativo_Ligacao> ListaConsultasPaciente(int _prontuario)
    {
        var lista = new List<Ativo_Ligacao>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT [id_consulta]" +
                              ",[equipe]" +
                              ",[dt_consulta]" +
                              ",[codigo_consulta]" +
                              ",[grade]" +
                              ",[equipe]" +
                              ",[profissional]" +
                              ",[ativo]" +
                              " FROM [consulta] " +
                              " WHERE  [prontuario] = " + _prontuario + 
                              " ORDER BY dt_consulta DESC";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                //char[] ponto = { '.', ' ' };
                while (dr1.Read())
                {
                    ConsultasRemarcar consulta = new ConsultasRemarcar();

                    consulta.Id_Consulta = dr1.GetInt32(0);
                    consulta.Equipe = dr1.GetString(1);
                    consulta.Dt_Consulta = dr1.GetDateTime(2).ToString();
                    consulta.Codigo_Consulta = dr1.GetInt32(3);
                    consulta.Grade = dr1.GetInt32(4);
                    consulta.Equipe = dr1.GetString(5);
                    consulta.Nome_Profissional = dr1.GetString(6);
                    consulta.Ativo_Status = dr1.GetBoolean(7);
                    if (consulta.Ativo_Status == true)
                    {
                        Ativo_Ligacao ativo = new Ativo_Ligacao();
                        ativo = AtivoDAO.getAtivo(dr1.GetInt32(0));
                        consulta.Status = StatusConsultaDAO.getDescricaoStats(Convert.ToInt32(ativo.Status));
                        consulta.Observacao = ativo.Observacao;
                        consulta.Data_Contato = ativo.Data_Contato;
                        consulta.Tentativa = ativo.Tentativa;
                        consulta.Usuario_Contato = ativo.Usuario_Contato;
                        consulta.DescricaoRemarcar = InformacaoConCancelada(dr1.GetInt32(0));
                    }
                   
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

    public static List<ConsultasRemarcar> ListaConsultasCancelar(int _status)
    {
        // colocar regra para listar consultas do paciente com tentativas abaixo de 3 (terceira tentativa)

        var lista = new List<ConsultasRemarcar>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT [id_cancela] " +
                              ",[id_consulta]" +
                              ",[prontuario]" +
                              ",[nome_paciente]" +
                              ",[equipe]" +
                              ",[dt_consulta]" +
                              ",[codigo_consulta]" +
                              ",[desc_status]" +
                              ",[observacao]" +
                              ",[data_ligacao]" +
                              ",[stat_cancelar]" +
                              ",[status]" +
                              ",[usuario]" +
                              " FROM [vw_cancelar_consultas] " +
                              " WHERE stat_cancelar = 0 " +
                              " AND status = " + _status;
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                //char[] ponto = { '.', ' ' };
                while (dr1.Read())
                {
                    ConsultasRemarcar consulta = new ConsultasRemarcar();
                    consulta.id_cancela = dr1.GetInt32(0);
                    consulta.Id_Consulta = dr1.GetInt32(1);
                    consulta.Prontuario = dr1.GetInt32(2);
                    consulta.Nome = dr1.GetString(3);
                    consulta.Equipe = dr1.GetString(4);
                    consulta.Dt_Consulta = dr1.GetDateTime(5).ToString();
                    consulta.Codigo_Consulta = dr1.GetInt32(6);
                    consulta.Status = dr1.GetString(7);
                    consulta.Observacao = dr1.GetString(8);
                    consulta.Data_Contato = dr1.GetDateTime(9);
                    consulta.Usuario_Contato = dr1.GetString(12);

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

    public static ConsultasRemarcar getDadosConsulta(int _idConsulta, string _status)
    {
        //Ativo_Ligacao consulta = new Ativo_Ligacao();
        ConsultasRemarcar consulta = new ConsultasRemarcar();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            cmm.CommandText = "SELECT [prontuario] " +
                                          ",[nome_paciente] " +
                                          ",[telefone1] " +
                                          ",[telefone2] " +
                                          ",[telefone3] " +
                                          ",[telefone4] " +
                                          ",[equipe] " +
                                          ",[profissional] " +
                                          ",[dt_consulta] " +
                                          ",[codigo_consulta] " +
                                          ",[desc_status] " +
                                          ",[observacao] " +
                                          ",[data_ligacao] " +
                                          ",[id_cancela] " +
                                          ",[usuario] " +
                                          "FROM vw_cancelar_consultas " +
                                          " WHERE id_consulta = " + _idConsulta +
                                          " AND desc_status = '" + _status + "'";

            cnn.Open();
            SqlDataReader dr = cmm.ExecuteReader();
            if (dr.Read())
            {
                consulta.Prontuario = dr.GetInt32(0);
                consulta.Nome = dr.GetString(1);
                consulta.Telefone1 = dr.GetString(2);
                consulta.Telefone2 = dr.GetString(3);
                consulta.Telefone3 = dr.GetString(4);
                consulta.Telefone4 = dr.GetString(5);
                consulta.Equipe = dr.GetString(6);
                consulta.Nome_Profissional = dr.GetString(7);
                consulta.Dt_Consulta = dr.GetDateTime(8).ToString();
                consulta.Codigo_Consulta = dr.GetInt32(9);
                consulta.Status = dr.GetString(10);
                consulta.Observacao = dr.GetString(11) + " Funcionário que fez contato: " + dr.GetString(14);
                consulta.Data_Contato = dr.GetDateTime(12);
                consulta.id_cancela = dr.GetInt32(13);
            }
        }
        return consulta;
    }
}