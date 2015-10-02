using CineQuilla.Auth;
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
    public partial class ManageMovies : System.Web.UI.Page
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
                MovieAddedMessage.Visible = true;
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
                            command.CommandText = "SELECT id, name, description, year, director, length, image FROM movies";
                            SqlDataAdapter adapter = new SqlDataAdapter(command);
                            DataSet dataset = new DataSet();
                            int rows = adapter.Fill(dataset);
                            if (rows == 0)
                            {
                                MoviesTable.Visible = false;
                                ErrorLabel.Text = "No hay peliculas";
                                ErrorLabel.Visible = true;
                            }
                            else
                            {
                                MoviesTable.DataSource = dataset;
                                MoviesTable.DataBind();
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

        protected void MoviesTable_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "DeleteMovie")
                return;

            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = "DELETE FROM movies WHERE id = @id";
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
                throw;
            }

            Response.Redirect(Request.RawUrl);
        }

        protected void Button3_Click(object sender, EventArgs e)
        {

        }
    }
}