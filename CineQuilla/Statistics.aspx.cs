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
    public partial class Statistics : System.Web.UI.Page
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

            if (!Page.IsPostBack)
            {
                try
                {
                    var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                    using (SqlConnection connection = new SqlConnection(connString))
                    {
                        connection.Open();
                        using (SqlCommand command = new SqlCommand(null, connection))
                        {
                            command.CommandText = @"SELECT id, name, image, views FROM movies m INNER JOIN (SELECT TOP 5 s.movie_id, COUNT(c.show_id) as views FROM shows s INNER JOIN chairs c ON c.show_id = s.id GROUP BY s.movie_id ORDER BY COUNT(c.show_id)) counts ON counts.movie_id = m.id ORDER BY views DESC";

                            SqlDataAdapter da = new SqlDataAdapter(command);
                            DataTable dt = new DataTable();
                            int rows = da.Fill(dt);
                            if (rows == 0)
                            {
                                MostViewedMoviesGrid.DataSource = null;
                                NoPopularMovies.Visible = true;
                            }
                            else
                            {
                                MostViewedMoviesGrid.DataSource = dt;
                                MostViewedMoviesGrid.DataBind();
                            }
                        }
                    }
                }
                catch (SqlException ex)
                {
                    ErrorLabel.Visible = true;
                }
            }
        }
    }
}