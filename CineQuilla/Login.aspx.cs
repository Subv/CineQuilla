using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web.Security;
using CineQuilla.Auth;

namespace CineQuilla
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoginError.Visible = false;
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = "SELECT TOP 1 id, username, first_name, last_name, permission_level FROM users WHERE username = @user AND password_hash = HASHBYTES('SHA2_256', @pass)";
                        SqlParameter userParam = new SqlParameter("@user", SqlDbType.VarChar, 255);
                        SqlParameter passParam = new SqlParameter("@pass", SqlDbType.VarChar, 255);

                        userParam.Value = UsernameBox.Text;
                        passParam.Value = PasswordBox.Text;

                        command.Parameters.Add(userParam);
                        command.Parameters.Add(passParam);

                        command.Prepare();
                        var reader = command.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            // There's no matching user
                            LoginError.Visible = true;
                            return;
                        }
                        else
                        {
                            reader.Read();
                            Session["UserInfo"] = new UserInfo
                            {
                                Id = reader.GetInt32(0),
                                Username = reader.GetString(1),
                                FirstName = reader.GetString(2),
                                LastName = reader.GetString(3),
                                PermissionLevel = reader.GetInt32(4)
                            };

                            // Login success!
                            FormsAuthentication.RedirectFromLoginPage(reader.GetInt32(0).ToString(), true);
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                throw;
            }
        }
    }
}