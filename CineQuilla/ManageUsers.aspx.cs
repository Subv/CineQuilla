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
    public partial class ManageUsers : System.Web.UI.Page
    {
        public Auth.UserInfo UserInfo = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            UserInfo = Session["UserInfo"] as Auth.UserInfo;

            if (UserInfo == null)
            {
                Response.Redirect("~/Login.aspx", true);
                return;
            }

            if (UserInfo.PermissionLevel <= 1)
            {
                Session["ShowPermissionError"] = true;
                Response.Redirect("~/Default.aspx", true);
                return;
            }

            if (Session["ShowUserAddedMessage"] != null && (bool)Session["ShowUserAddedMessage"] == true)
            {
                UserAddedMessage.Visible = true;
                Session["ShowUserAddedMessage"] = null;
            }

            if (!Page.IsPostBack)
            {
                // Populate the GridView with the users in the database
                try
                {
                    var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                    using (SqlConnection connection = new SqlConnection(connString))
                    {
                        connection.Open();
                        using (SqlCommand command = new SqlCommand(null, connection))
                        {
                            command.CommandText = "SELECT id, username, first_name, last_name, permission_level FROM users";
                            SqlDataAdapter adapter = new SqlDataAdapter(command);
                            DataSet dataset = new DataSet();
                            int rows = adapter.Fill(dataset);
                            if (rows == 0)
                            {
                                UsersTable.Visible = false;
                                NoUsers.Visible = true;
                            }
                            else
                            {
                                UsersTable.DataSource = dataset;
                                UsersTable.DataBind();
                            }
                        }
                    }
                }
                catch (SqlException ex)
                {
                    ErrorLabel.Visible = true;
                    return;
                }
            }
        }

        protected void UsersTable_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "DeleteUser")
                return;

            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = "DELETE FROM users WHERE id = @id";
                        SqlParameter idParam = new SqlParameter("@id", SqlDbType.Int);
                        idParam.Value = e.CommandArgument;
                        command.Parameters.Add(idParam);
                        command.Prepare();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorLabel.Visible = true;
                return;
            }

            Response.Redirect(Request.RawUrl);
        }

        protected void Button2_Click(object sender, EventArgs e)
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
                        command.CommandText = "INSERT INTO users (username, password_hash, first_name, last_name, permission_level) VALUES (@user, HASHBYTES('SHA2_256', @pass), @fname, @lname, @plevel)";
                        SqlParameter userParam = new SqlParameter("@user", SqlDbType.VarChar, 255);
                        SqlParameter passParam = new SqlParameter("@pass", SqlDbType.VarChar, 255);
                        SqlParameter fnameParam = new SqlParameter("@fname", SqlDbType.VarChar, 255);
                        SqlParameter lnameParam = new SqlParameter("@lname", SqlDbType.VarChar, 255);
                        SqlParameter plevelParam = new SqlParameter("@plevel", SqlDbType.Int);

                        userParam.Value = UsernameBox.Text;
                        passParam.Value = PasswordBox.Text;
                        fnameParam.Value = FNameBox.Text;
                        lnameParam.Value = LNameBox.Text;
                        plevelParam.Value = PermissionLevelSelect.Value;

                        command.Parameters.Add(userParam);
                        command.Parameters.Add(passParam);
                        command.Parameters.Add(fnameParam);
                        command.Parameters.Add(lnameParam);
                        command.Parameters.Add(plevelParam);

                        command.Prepare();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorLabel.Visible = true;
                return;
            }

            Session["ShowUserAddedMessage"] = true;
            Response.Redirect(Request.RawUrl);
        }

        protected void UserExistenceValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // Validate that the user does not already exist in the database
            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = "SELECT COUNT(*) FROM users WHERE username = @user";
                        SqlParameter userParam = new SqlParameter("@user", SqlDbType.VarChar, 255);
                        userParam.Value = UsernameBox.Text;
                        command.Parameters.Add(userParam);
                        command.Prepare();
                        var reader = command.ExecuteReader();
                        reader.Read();
                        args.IsValid = reader.GetInt32(0) == 0;
                    }
                }
            }
            catch (SqlException ex)
            {
                args.IsValid = false;
                ErrorLabel.Visible = true;
                return;
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            AddNewUserDiv.Visible = true;
        }
    }
}