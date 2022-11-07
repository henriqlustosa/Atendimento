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

/// <summary>
/// Summary description for UsuarioDAO
/// </summary>
public class UsuarioDAO
{
	public UsuarioDAO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static Usuario getUsuario(string _login)
    {
        Usuario usuario = new Usuario();
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["gtaConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            cmm.CommandText = "SELECT Id_User_Reg" +
                                  ",[UserName]" +
                                  ",[Nome_Completo]" +
                                  ",[Setor]" +
                                  ",[Cargo]" +
                                  ",[Uimage] " +
                              "FROM [hspmAtendimento].[dbo].[User_Reg_Profile] " +
                              "WHERE UserName = '" + _login + "'";

            try
            {
                cnn.Open();

                SqlDataReader dr1 = cmm.ExecuteReader();

                if (dr1.Read())
                {
                    usuario.Id = dr1.GetInt32(0);
                    usuario.UserLogin = dr1.GetString(1);
                    usuario.Nome_Completo = dr1.GetString(2);
                    usuario.Setor = dr1.GetString(3);
                    usuario.Cargo = dr1.GetString(4);
                    usuario.Uimage = dr1.GetString(5);
                }
                else
                {
                    usuario.UserLogin = "";
                    usuario.Nome_Completo = "";
                    usuario.Setor = "";
                    usuario.Cargo = "";
                    usuario.Uimage = "~/UserImages/User.png";
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }

        }
        return usuario;
    }

    public static void CadastroComplementar(string _login, string _nome, string _setor, string _cargo, string _uimage)
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
                cmm.CommandText = "Insert into User_Reg_Profile (UserName, Nome_Completo,Setor, Cargo, Uimage)"
                                    + " values ('"
                                    + _login + "','"
                                    + _nome.ToUpper() + "', '"
                                    + _setor.ToUpper() + "', '"
                                    + _cargo.ToUpper() + "', '"
                                    + _uimage + "');";
                cmm.ExecuteNonQuery();

                mt.Commit();
                mt.Dispose();
                cnn.Close();
                
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                mt.Rollback();
            }
        }

    }

    public static void AtualizaCadastroComplementar(string _login, string _nome, string _cargo, string _setor, string _Uimage)
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

                cmm.CommandText = "UPDATE User_Reg_Profile" +
                 " SET Nome_Completo = @nome " +
                 ", Setor = @setor " +
                 ", Cargo = @cargo " +
                 ", Uimage = @uimage " +
                 " WHERE  UserName = @login";

                cmm.Parameters.Add(new SqlParameter("@nome", _nome.ToUpper()));
                cmm.Parameters.Add(new SqlParameter("@setor", _cargo.ToUpper()));
                cmm.Parameters.Add(new SqlParameter("@cargo", _setor.ToUpper()));
                cmm.Parameters.Add(new SqlParameter("@uimage", _Uimage));
                cmm.Parameters.Add(new SqlParameter("@login", _login));

                cmm.ExecuteNonQuery();
                mt.Commit();
                mt.Dispose();
                cnn.Close();

            }
            catch (Exception ex)
            {
                string error = ex.Message;
                try
                {
                    mt.Rollback();
                }
                catch (Exception ex1)
                { }
            }
        }
    }
}
