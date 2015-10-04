using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CineQuilla
{
    public partial class RegisterClient : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var UserInfo = Session["UserInfo"] as Auth.UserInfo;

            if (UserInfo == null)
                Response.Redirect("~/Login.aspx", true);
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = @"SELECT 1 FROM clients WHERE id = @id";
                        SqlParameter idParam = new SqlParameter("@id", SqlDbType.Int);

                        idParam.Value = args.Value;

                        command.Parameters.Add(idParam);

                        var reader = command.ExecuteReader();
                        if (reader.HasRows)
                            args.IsValid = false;
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorLabel.Visible = true;
                args.IsValid = false;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
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
                        command.CommandText = @"INSERT INTO clients (id, first_name, last_name, email) VALUES (@id, @fname, @lname, @email)";
                        SqlParameter idParam = new SqlParameter("@id", SqlDbType.Int);
                        SqlParameter fnameParam = new SqlParameter("@fname", SqlDbType.VarChar, 255);
                        SqlParameter lnameParam = new SqlParameter("@lname", SqlDbType.VarChar, 255);
                        SqlParameter emailParam = new SqlParameter("@email", SqlDbType.VarChar, 255);

                        idParam.Value = IDBox.Text;
                        fnameParam.Value = FNameBox.Text;
                        lnameParam.Value = LNameBox.Text;
                        emailParam.Value = EMailBox.Text;

                        command.Parameters.Add(idParam);
                        command.Parameters.Add(fnameParam);
                        command.Parameters.Add(lnameParam);
                        command.Parameters.Add(emailParam);

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorLabel.Visible = true;
                return;
            }

            ClientScript.RegisterStartupScript(typeof(Page), "closePage", "alert('Cliente registrado exitosamente'); window.close();", true);
        }
    }
}