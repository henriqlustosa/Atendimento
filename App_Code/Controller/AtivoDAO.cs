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
/// Summary description for AtivoDAO
/// </summary>
public class AtivoDAO
{
	public AtivoDAO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static List<Ativo_Ligacao> getAtivosRecentAtividadesUsuario(string usuario)
    {
        var listaAtividades = new List<Ativo_Ligacao>();
       
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            cmm.CommandText = "SELECT TOP 5 "+
                                 " [status]" +
                                 " ,[observacao]" +
                                 " ,[data_ligacao]" +
                             " FROM [hspmAtendimento].[dbo].[ativo_ligacao]" +
                             " WHERE usuario = '"+ usuario +"'" +
                             " ORDER BY data_ligacao DESC";

            try
            {
                cnn.Open();

                SqlDataReader dr1 = cmm.ExecuteReader();

                while (dr1.Read())
                {
                    Ativo_Ligacao ativo = new Ativo_Ligacao();
                    ativo.Status = StatusConsultaDAO.getDescricaoStats(dr1.GetInt32(0));
                    ativo.Observacao = dr1.GetString(1);
                    ativo.Data_Contato = dr1.GetDateTime(2);
                    listaAtividades.Add(ativo);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return listaAtividades;
    }


    public static Ativo_Ligacao getAtivo(int _id_consulta)
    {
        Ativo_Ligacao ativo = new Ativo_Ligacao();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            cmm.CommandText = "SELECT [id_consulta]" +
                                  ",[status]" +
                                  ",[observacao]" +
                                  ",[data_ligacao]" +
                                  ",[tentativa]" +
                                  ",[usuario] " +
                              "FROM [hspmAtendimento].[dbo].[ativo_ligacao] " +
                              "WHERE id_consulta = '" + _id_consulta + "'";

            try
            {
                cnn.Open();

                SqlDataReader dr1 = cmm.ExecuteReader();

                if (dr1.Read())
                {
                    ativo.Id_Consulta = dr1.GetInt32(0);
                    ativo.Status = Convert.ToString(dr1.GetInt32(1));
                    ativo.Observacao = dr1.GetString(2);
                    ativo.Data_Contato = dr1.GetDateTime(3);
                    ativo.Tentativa = dr1.GetInt32(4);
                    ativo.Usuario_Contato = dr1.GetString(5);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }

        }
        return ativo;
    }

    public static int QuantidadeConsultasRealizarAtivo(int _ativo, int _tentativa)
    {
        string SqlQuery = "";
        int QuantidadeConsultas = 0;

        if (_tentativa >= 1)
        {
            SqlQuery = "Select count(*) as quantidadeConsultas " +
                                "FROM consulta c, ativo_ligacao l, status_consulta s, paciente_Mailling p " +
                                "WHERE p.prontuario = c.prontuario " +
                                "AND c.ativo = " + _ativo +
                                " AND tentativa = " + _tentativa +
                                " AND l.id_consulta = c.id_consulta " +
                                " AND l.status = s.id_status " +
                                " AND s.tenta = 'S' " +
                                " AND c.equipe NOT LIKE 'ENDOCRINO%'" +
                                " AND datediff(day, GETDATE() , dt_consulta ) > 0 "+
                                " AND l.realizado = 'N'";
        }
        else
        {
            SqlQuery = "Select count(*) as quantidadeConsultas FROM consulta where ativo = 0 AND equipe NOT LIKE 'ENDOCRINO%'";
        }

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            try
            {
                cnn.Open();
                cmm.CommandText = SqlQuery;
                
                SqlDataReader dr1 = cmm.ExecuteReader();  
                if (dr1.Read())
                {
                    QuantidadeConsultas = dr1.GetInt32(0);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return QuantidadeConsultas;
    }

    public static List<Ativo> ListaConsultasPaciente(int _prontuario)
    {
        var lista = new List<Ativo>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT id_consulta, prontuario, dt_consulta, grade, "+
                            "equipe, profissional, codigo_consulta "+
                            "FROM consulta "+
                            "WHERE prontuario = " + _prontuario +
                            " AND  ativo = 0 AND dt_consulta >= GETDATE() - 90";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();
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

    // Não carrega a lista de consultas da Endócrino
    public static List<Ativo> ListaConsultas(int _ativoConsulta, string _statusConsulta, int _tentativaLigacao)
    {
        var lista = new List<Ativo>();
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            if (_ativoConsulta == 0)
            {
                cmm.CommandText = "SELECT c.id_consulta, c.prontuario, p.nome_paciente ," +
                              "c.dt_consulta, c.grade, c.equipe, c.profissional, c.codigo_consulta, c.ativo, " +
                              "p.telefone1, p.telefone2, p.telefone3, p.telefone4 " +
                              "FROM consulta c, paciente_Mailling p " +
                              "WHERE c.prontuario = p.prontuario AND ativo = 0 " +
                              //" WHERE c.prontuario = p.prontuario AND ativo = 0 AND dt_consulta <= GETDATE() + 30 " +
                              " AND equipe NOT LIKE 'ENDOCRINO%'" +
                              " ORDER BY c.id_consulta;";
                   
            }else if(_ativoConsulta == 1 && _statusConsulta.Equals("S")) // lista as consultas tentativas
            {
                cmm.CommandText = "SELECT  c.id_consulta, c.prontuario, p.nome_paciente, c.dt_consulta, c.grade, c.equipe, c.profissional, c.codigo_consulta " +
                        ", c.ativo, p.telefone1, p.telefone2, p.telefone3, p.telefone4 " +
                        " FROM ativo_ligacao l, consulta c, status_consulta s, paciente_Mailling p " +
                        " WHERE p.prontuario = c.prontuario " +
                        " AND c.ativo = 1" +
                        //" AND c.dt_consulta <= GETDATE() + 20 " +
                        " AND tentativa = "+_tentativaLigacao + 
                        " AND l.id_consulta = c.id_consulta " +
                        " AND l.status = s.id_status " +
                        " AND s.tenta = 'S'" +
                        " AND equipe NOT LIKE 'ENDOCRINO%'" +
                        " ORDER BY c.id_consulta;";
            }
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();
                while (dr1.Read())
                {
                    Ativo consulta = new Ativo();

                    consulta.Id_Consulta = dr1.GetInt32(0);
                    consulta.Prontuario = dr1.GetInt32(1);
                    consulta.Nome = dr1.GetString(2);
                    consulta.Dt_Consulta = dr1.GetDateTime(3).ToString();
                    consulta.Grade = dr1.GetInt32(4);
                    consulta.Equipe = dr1.GetString(5);
                    consulta.Nome_Profissional = dr1.GetString(6);
                    consulta.Codigo_Consulta = dr1.GetInt32(7);
                    consulta.Ativo_Status = dr1.GetBoolean(8);
                    consulta.Telefone1 = dr1.GetString(9).ToString();
                    consulta.Telefone2 = dr1.GetString(10);
                    consulta.Telefone3= dr1.GetString(11);
                    consulta.Telefone4 = dr1.GetString(12);
                    
                    lista.Add(consulta);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
            return lista;
        }
    }
   
    public static string GravaStatusAtivo(int _status, string _observacao, string _usuario, int _id_consulta, int _tentativa, int _id_ativo)
    {
        string mensagem = "";
        string _dtAtivo = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        string _realizado = "";

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = new SqlCommand();
            cmm.Connection = cnn;
            cnn.Open();
            SqlTransaction mt = cnn.BeginTransaction();
            cmm.Transaction = mt;
            try
            {
                if (_id_ativo != 0 || _status == 1)
                {
                    cmm.CommandText = "UPDATE ativo_ligacao" +
                     " SET realizado = 'S'" +
                     " WHERE  idativo = @id_ativo";
                    cmm.Parameters.Add(new SqlParameter("@id_ativo", _id_ativo));
                    cmm.ExecuteNonQuery();
                }

                //1 = CONFIRMADO, 2 = CANCELAR CONSULTA, 3 = CANCELAR E REMARCAR, 4 = FALECIDO, 10 = NÃO CONSTA CONSULTA, 11 = CONSULTA REMARCADA
                
                // tentativa = 2 confirma realizado - solicitado não entrar na lista da 3ª tentativa


                //3ª tentativa Ligar mais tarde, não atende, caixa postal, telefone inesistente, não completa chamada
                // colocando a variável _tentativa == 2, as ligações não vão mais para a 3ª tentativa
                //if (_status == 1 || _status == 2 || _status == 3 || _status == 4 || _status == 10 || _status == 11 ) // || _tentativa == 2
                if (_tentativa == 2)
                {
                    _realizado = "S";
                }
                else
                {
                    _realizado = "N";
                }

                cmm.CommandText = "Insert into ativo_ligacao (id_consulta, status, observacao, data_ligacao, tentativa,usuario, realizado)" +
                       "values (@id_consulta,@status,@observacao,@data_ligacao, @tentativa, @usuario, @realizado)";

                cmm.Parameters.Add("@id_consulta", SqlDbType.Int).Value = _id_consulta;
                cmm.Parameters.Add("@status", SqlDbType.Int).Value = _status;
                cmm.Parameters.Add("@observacao", SqlDbType.VarChar).Value = _observacao;
                cmm.Parameters.Add("@data_ligacao", SqlDbType.VarChar).Value = _dtAtivo;
                cmm.Parameters.Add("@tentativa", SqlDbType.Int).Value = _tentativa;
                cmm.Parameters.Add("@usuario", SqlDbType.VarChar).Value = _usuario;
                cmm.Parameters.Add("@realizado", SqlDbType.VarChar).Value = _realizado;
                cmm.ExecuteNonQuery();

                bool _ativo = true;
                
                cmm.CommandText = "UPDATE consulta" +
                 " SET ativo = @ativo" +
                 " where id_consulta = @id_con";
                cmm.Parameters.Add(new SqlParameter("@ativo", _ativo));
                cmm.Parameters.Add(new SqlParameter("@id_con", _id_consulta));

                cmm.ExecuteNonQuery();
                    mt.Commit();
                    mt.Dispose();
                    cnn.Close();
                    mensagem = "Cadastro realizado com sucesso!";

                // 2 - cancelar consulta, 3 - cancelar e remarcar, 4 - falecido, 7 - pessoa desconhecida, 8 - telefone inexistente
                if(_status == 4 ) 
                {
                    consultasCanceladas(_id_consulta);
                }
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
        }
        return mensagem;
    }

    protected static void consultasCanceladas(int _id_consulta)
    {
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = new SqlCommand();
            cmm.Connection = cnn;
            cnn.Open();
            SqlTransaction mt = cnn.BeginTransaction();
            cmm.Transaction = mt;
            try
            {
                cmm.CommandText = "Insert into consultas_cancelar (id_consulta)" +
                    "values (@id_consulta)";

                cmm.Parameters.Add("@id_consulta", SqlDbType.Int).Value = _id_consulta;
                cmm.ExecuteNonQuery();
                mt.Commit();
                mt.Dispose();
                cnn.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                try
                {
                    mt.Rollback();
                }
                catch (Exception ex1)
                {
                    Console.WriteLine(ex1.Message);
                }
            }
        }
    }

    public static List<Ativo_Ligacao> ListaTentativaContato(int _tentativaLigacao, string _realizada)
    {
        var lista = new List<Ativo_Ligacao>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

             cmm.CommandText = "SELECT a.[idativo] " +
                                  ", a.[id_consulta] " +
                                  ",s.[status] " +
                                  ",a.[observacao] " +
                                  ",a.[data_ligacao] " +
                                  ",a.[tentativa] " +
                                  ",a.[usuario] " +
                                  ",c.[prontuario] " +
                                  ",p.[nome_paciente] " +
                                  ",c.[codigo_consulta] " +
                                  ",c.[dt_consulta] " +
                                  ",c.[grade] " +
                                  ",c.[equipe] " +
                                  ",c.[profissional] " +
                                  ",c.[codigo_consulta] " +
                              " FROM ativo_ligacao a, consulta c, status_consulta s, paciente_Mailling p " +
                              " WHERE a.[id_consulta] = c.[id_consulta] " +
                              " AND c.[prontuario] = p.[prontuario]" +
                              " AND a.[status] = s.[id_status] " +
                              " AND a.tentativa = " + _tentativaLigacao +
                              " AND s.[tenta] = 'S'" +
                              " AND a.[realizado] = 'N'" +
                              " AND equipe NOT LIKE 'ENDOCRINO%'" +
                              " AND datediff(day, GETDATE() , dt_consulta ) > 0 " +
                              " ORDER BY c.[dt_consulta];";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();
                while (dr1.Read())
                {
                    Ativo_Ligacao tentativa = new Ativo_Ligacao();

                    tentativa.Id_Ativo = dr1.GetInt32(0);
                    tentativa.Id_Consulta = dr1.GetInt32(1);
                    tentativa.Status = dr1.GetString(2);
                    tentativa.Observacao = dr1.GetString(3);
                    tentativa.Data_Contato = dr1.GetDateTime(4);
                    tentativa.Tentativa = dr1.GetInt32(5);
                    tentativa.Usuario_Contato = dr1.GetString(6);
                    tentativa.Prontuario = dr1.GetInt32(7);
                    tentativa.Nome = dr1.GetString(8);
                    tentativa.Codigo_Consulta = dr1.GetInt32(9);
                    tentativa.Dt_Consulta = dr1.GetDateTime(10).ToString();
                    tentativa.Grade = dr1.GetInt32(11);
                    tentativa.Equipe = dr1.GetString(12);
                    tentativa.Nome_Profissional = dr1.GetString(13);
                    tentativa.Codigo_Consulta = dr1.GetInt32(14);

                    lista.Add(tentativa);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
            return lista;
        }
    }

    public static List<Ativo_Ligacao> ListaTentativaContatoPaciente(int _prontuario, int _tentativaLigacao, string _realizada)
    {
        var lista = new List<Ativo_Ligacao>();
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT a.[idativo] " +
                                      ", a.[id_consulta] "+
                                      ",s.[status] " +
                                      ",a.[observacao] "+
                                      ",a.[data_ligacao] "+
                                      ",a.[tentativa] "+
                                      ",a.[usuario] "+
                                      ",c.[prontuario] "+
                                      ",c.[codigo_consulta] "+
                                      ",c.[dt_consulta] " +
                                      ",c.[grade] "+
                                      ",c.[equipe] "+
                                      ",c.[profissional] "+
                                      ",c.[codigo_consulta] "+
                                  "FROM ativo_ligacao a, consulta c, status_consulta s " +
                                  "WHERE a.[id_consulta] = c.[id_consulta] " +
                                  "AND a.[status] = s.[id_status] " +
                                  "AND a.tentativa = " + _tentativaLigacao +
                                  "AND c.prontuario  = " + _prontuario +
                                  "AND s.[tenta] = 'S'" +
                                  "AND a.[realizado] = 'N' AND dt_consulta >= GETDATE() - 90";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();
                while (dr1.Read())
                {
                    Ativo_Ligacao tentativa = new Ativo_Ligacao();

                    tentativa.Id_Ativo = dr1.GetInt32(0);
                    tentativa.Id_Consulta = dr1.GetInt32(1);
                    tentativa.Status = dr1.GetString(2);
                    tentativa.Observacao = dr1.GetString(3);
                    tentativa.Data_Contato = dr1.GetDateTime(4);
                    tentativa.Tentativa = dr1.GetInt32(5);
                    tentativa.Usuario_Contato = dr1.GetString(6);
                    tentativa.Prontuario = dr1.GetInt32(7);
                    tentativa.Codigo_Consulta = dr1.GetInt32(8);
                    tentativa.Dt_Consulta = dr1.GetDateTime(9).ToString();
                    tentativa.Grade = dr1.GetInt32(10);
                    tentativa.Equipe = dr1.GetString(11);
                    tentativa.Nome_Profissional = dr1.GetString(12);
                    tentativa.Codigo_Consulta = dr1.GetInt32(13);

                    lista.Add(tentativa);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
            return lista;
        }
    }

    public static List<Ativo> ListaConsultasEndocrino(int _ativoConsulta, string _statusConsulta, int _tentativaLigacao)
    {
        var lista = new List<Ativo>();
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            if (_ativoConsulta == 0)
            {
                cmm.CommandText = "SELECT c.id_consulta, c.prontuario, p.nome_paciente ," +
                              "c.dt_consulta, c.grade, c.equipe, c.profissional, c.codigo_consulta, c.ativo, " +
                              "p.telefone1, p.telefone2, p.telefone3, p.telefone4 " +
                              "FROM consulta c, paciente_Mailling p " +
                              " WHERE c.prontuario = p.prontuario AND ativo = 0 "+ //AND dt_consulta <= GETDATE() + 20 " +
                              " AND c.equipe LIKE 'ENDOCRINO%' " +
                              " ORDER BY id_consulta;";
            }
            else if (_ativoConsulta == 1 && _statusConsulta.Equals("S")) // lista as consultas tentativas
            {
                cmm.CommandText = "SELECT  c.id_consulta, c.prontuario, p.nome_paciente, c.dt_consulta, c.grade, c.equipe, c.profissional, c.codigo_consulta " +
                        ", c.ativo, p.telefone1, p.telefone2, p.telefone3, p.telefone4 " +
                        " FROM ativo_ligacao l, consulta c, status_consulta s, paciente_Mailling p " +
                        " WHERE p.prontuario = c.prontuario " +
                        " AND c.ativo = 1" +
                        " AND c.dt_consulta <= GETDATE() + 20 " +
                        " AND tentativa = " + _tentativaLigacao +
                        " AND l.id_consulta = c.id_consulta " +
                        " AND l.status = s.id_status " +
                        " AND s.tenta = 'S'" +
                        " AND c.equipe LIKE 'ENDOCRINO%' " +
                        " ORDER BY id_consulta;";
            }

            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();
                while (dr1.Read())
                {
                    Ativo consulta = new Ativo();

                    consulta.Id_Consulta = dr1.GetInt32(0);
                    consulta.Prontuario = dr1.GetInt32(1);
                    consulta.Nome = dr1.GetString(2);
                    consulta.Dt_Consulta = dr1.GetDateTime(3).ToString();
                    consulta.Grade = dr1.GetInt32(4);
                    consulta.Equipe = dr1.GetString(5);
                    consulta.Nome_Profissional = dr1.GetString(6);
                    consulta.Codigo_Consulta = dr1.GetInt32(7);
                    consulta.Ativo_Status = dr1.GetBoolean(8);
                    consulta.Telefone1 = dr1.GetString(9).ToString();
                    consulta.Telefone2 = dr1.GetString(10);
                    consulta.Telefone3 = dr1.GetString(11);
                    consulta.Telefone4 = dr1.GetString(12);

                    lista.Add(consulta);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
            return lista;
        }
    }

    public static int QuantidadeConsultasRealizarAtivoEndocrino(int _ativo, int _tentativa)
    {
        string SqlQuery = "";
        int QuantidadeConsultas = 0;

        if (_tentativa >= 1)
        {
            SqlQuery = "Select count(*) as quantidadeConsultas " +
                                "FROM consulta c, ativo_ligacao l, status_consulta s, paciente_Mailling p " +
                                "WHERE p.prontuario = c.prontuario " +
                                "AND c.ativo = " + _ativo +
                                " AND tentativa = " + _tentativa +
                                " AND l.id_consulta = c.id_consulta " +
                                " AND l.status = s.id_status " +
                                "AND s.tenta = 'S' " +
                                " AND c.equipe LIKE 'ENDOCRINO%' " +
                                " AND datediff(day, GETDATE() , dt_consulta ) > 0 " +
                                "AND l.realizado = 'N'";
        }
        else
        {
            SqlQuery = "Select count(*) as quantidadeConsultas " + 
                " FROM consulta "+
                " WHERE ativo = 0 " +
                " AND equipe LIKE 'ENDOCRINO%'" ;
        }

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            try
            {
                cnn.Open();
                cmm.CommandText = SqlQuery;

                SqlDataReader dr1 = cmm.ExecuteReader();
                if (dr1.Read())
                {
                    QuantidadeConsultas = dr1.GetInt32(0);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return QuantidadeConsultas;
    }

    public static List<Ativo_Ligacao> ListaTentativaContatoEndocrino(int _tentativaLigacao, string _realizadas)
    {
        var lista = new List<Ativo_Ligacao>();
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT a.[idativo] " +
                                  ",a.[id_consulta] " +
                                  ",s.[status] " +
                                  ",a.[observacao] " +
                                  ",a.[data_ligacao] " +
                                  ",a.[tentativa] " +
                                  ",a.[usuario] " +
                                  ",c.[prontuario] " +
                                  ",p.[nome_paciente] " +
                                  ",c.[codigo_consulta] " +
                                  ",c.[dt_consulta] " +
                                  ",c.[grade] " +
                                  ",c.[equipe] " +
                                  ",c.[profissional] " +
                                  ",c.[codigo_consulta] " +
                              " FROM ativo_ligacao a, consulta c, status_consulta s, paciente_Mailling p " +
                              " WHERE a.[id_consulta] = c.[id_consulta] " +
                              " AND c.[prontuario] = p.[prontuario]" +
                              " AND a.[status] = s.[id_status] " +
                              " AND a.tentativa = " + _tentativaLigacao +
                              " AND s.[tenta] = 'S'" +
                              " AND a.[realizado] = 'N'" +
                              " AND c.[equipe] LIKE 'ENDOCRINO%'" +
                              " AND datediff(day, GETDATE() , dt_consulta ) > 0 " +
                              " ORDER BY id_consulta;";

            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();
                while (dr1.Read())
                {
                    Ativo_Ligacao tentativa = new Ativo_Ligacao();

                    tentativa.Id_Ativo = dr1.GetInt32(0);
                    tentativa.Id_Consulta = dr1.GetInt32(1);
                    tentativa.Status = dr1.GetString(2);
                    tentativa.Observacao = dr1.GetString(3);
                    tentativa.Data_Contato = dr1.GetDateTime(4);
                    tentativa.Tentativa = dr1.GetInt32(5);
                    tentativa.Usuario_Contato = dr1.GetString(6);
                    tentativa.Prontuario = dr1.GetInt32(7);
                    tentativa.Nome = dr1.GetString(8);
                    tentativa.Codigo_Consulta = dr1.GetInt32(9);
                    tentativa.Dt_Consulta = dr1.GetDateTime(10).ToString();
                    tentativa.Grade = dr1.GetInt32(11);
                    tentativa.Equipe = dr1.GetString(12);
                    tentativa.Nome_Profissional = dr1.GetString(13);
                    tentativa.Codigo_Consulta = dr1.GetInt32(14);

                    lista.Add(tentativa);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
            return lista;
        }
    }
}