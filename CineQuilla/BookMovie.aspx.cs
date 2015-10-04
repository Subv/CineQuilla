using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CineQuilla
{
    public partial class BookMovie : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id;
            if (Request.QueryString["id"] == null || Request.QueryString["id"].Trim() == "" || !int.TryParse(Request.QueryString["id"], out id))
            {
                Session["ShowDefaultError"] = true;
                Response.Redirect("~/Default.aspx", true);
                return;
            }
        }

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            if (e.Day.Date.Add(DateTime.Now.TimeOfDay) < DateTime.Now)
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = Color.Gray;
                return;
            }

            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = @"SELECT 1 FROM shows WHERE movie_id = @mov_id AND start_date <= @start_date AND end_date >= @end_date";
                        SqlParameter startDateParam = new SqlParameter("@start_date", SqlDbType.Date);
                        SqlParameter endDateParam = new SqlParameter("@end_date", SqlDbType.Date);
                        SqlParameter movieParam = new SqlParameter("@mov_id", SqlDbType.Int);

                        startDateParam.Value = e.Day.Date;
                        endDateParam.Value = e.Day.Date;
                        movieParam.Value = Request.QueryString["id"];

                        command.Parameters.Add(startDateParam);
                        command.Parameters.Add(endDateParam);
                        command.Parameters.Add(movieParam);

                        var reader = command.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            e.Day.IsSelectable = false;
                            e.Cell.ForeColor = Color.Gray;
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorLabel.Visible = true;
            }
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = @"SELECT (sr.rows * sr.columns) - ISNULL(ch.num_chairs, 0) as available_chairs, sr.rows * sr.columns as num_chairs, s.id, showroom_id, start_date, end_date, start_time, end_time, price FROM shows s LEFT JOIN (SELECT show_id, COUNT(*) as num_chairs FROM chairs WHERE date = @date GROUP BY chairs.show_id) ch ON ch.show_id = s.id LEFT JOIN showroom sr ON sr.id = s.showroom_id WHERE movie_id = @mov_id AND start_date <= @date AND end_date >= @date";
                        SqlParameter dateParam = new SqlParameter("@date", SqlDbType.Date);
                        SqlParameter movieParam = new SqlParameter("@mov_id", SqlDbType.Int);

                        dateParam.Value = Calendar1.SelectedDate;
                        movieParam.Value = Request.QueryString["id"];

                        command.Parameters.Add(dateParam);
                        command.Parameters.Add(movieParam);

                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        AvailableShowsGrid.DataSource = dt;
                        AvailableShowsGrid.DataBind();
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorLabel.Visible = true;
                return;
            }
            AvailableShowsDiv.Visible = true;
        }

        protected void AvailableShowsGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Purchase")
                return;

            Session["PurchaseDate"] = Calendar1.SelectedDate;
            Session["PurchaseMovieId"] = Request.QueryString["id"];
            Session["PurchaseShowId"] = e.CommandArgument;

            Response.Redirect("~/PurchaseChairs.aspx", true);
        }
    }
}