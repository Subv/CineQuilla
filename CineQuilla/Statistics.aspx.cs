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
                            command.CommandText = @"SELECT id, name, image, views FROM movies m INNER JOIN (SELECT TOP 10 s.movie_id, COUNT(c.show_id) as views FROM shows s INNER JOIN chairs c ON c.show_id = s.id GROUP BY s.movie_id ORDER BY COUNT(c.show_id)) counts ON counts.movie_id = m.id ORDER BY views DESC";
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

                        using (SqlCommand command = new SqlCommand(null, connection))
                        {
                            command.CommandText = @"SELECT TOP 10 first_name, last_name, email, views FROM clients c RIGHT JOIN (SELECT client_id, SUM(bb.bought) AS views FROM transactions t INNER JOIN (SELECT transaction_id, COUNT(transaction_id) as bought FROM chairs GROUP BY transaction_id) bb ON bb.transaction_id = t.id GROUP BY client_id) vv ON vv.client_id = c.id ORDER BY views DESC";
                            SqlDataAdapter da = new SqlDataAdapter(command);
                            DataTable dt = new DataTable();
                            int rows = da.Fill(dt);
                            if (rows == 0)
                            {
                                MostBuyersGrid.DataSource = null;
                                NoMostBuyers.Visible = true;
                            }
                            else
                            {
                                MostBuyersGrid.DataSource = dt;
                                MostBuyersGrid.DataBind();
                            }
                        }

                        using (SqlCommand command = new SqlCommand(null, connection))
                        {
                            command.CommandText = @"SELECT dia, AVG(sells) as promedio, COUNT(sells) as muestras FROM (SELECT (CASE DATEPART(WeekDay, date) WHEN 1 THEN 'Lunes' WHEN 2 THEN 'Martes' WHEN 3 THEN 'Miercoles' WHEN 4 THEN 'Jueves' WHEN 5 THEN 'Viernes' WHEN 6 THEN 'Sabado' WHEN 7 THEN 'Domingo' END) as dia, date, COUNT(*) as sells FROM chairs GROUP BY date) s GROUP BY dia ORDER BY promedio DESC";
                            SqlDataAdapter da = new SqlDataAdapter(command);
                            DataTable dt = new DataTable();
                            int rows = da.Fill(dt);
                            if (rows == 0)
                            {
                                WeekdayMeansGrid.DataSource = null;
                                NoMeans.Visible = true;
                            }
                            else
                            {
                                WeekdayMeansGrid.DataSource = dt;
                                WeekdayMeansGrid.DataBind();
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