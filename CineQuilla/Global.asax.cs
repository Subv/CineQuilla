using CineQuilla.Auth;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;

namespace CineQuilla
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
                return;

            // Fill the needed session information
            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = "SELECT TOP 1 id, username, first_name, last_name, permission_level FROM users WHERE id = @id";
                        SqlParameter idParam = new SqlParameter("@id", SqlDbType.Int);

                        idParam.Value = HttpContext.Current.User.Identity.Name;

                        command.Parameters.Add(idParam);
                        command.Prepare();

                        var reader = command.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            // There's no matching user
                            Auth.Helpers.Logout(null);
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
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            Server.Transfer("~/ErrorPages/Error.aspx");
        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}