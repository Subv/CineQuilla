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
    public partial class ManageShows : System.Web.UI.Page
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

            if (Session["ShowShowAddedMessage"] != null && (bool)Session["ShowShowAddedMessage"] == true)
            {
                ShowAddedMessage.Visible = true;
                Session["ShowShowAddedMessage"] = null;
            }
        }

        protected void ShowsTable_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void ShowDate_SelectionChanged(object sender, EventArgs e)
        {
            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = @"SELECT (sr.rows * sr.columns) - ISNULL(ch.num_chairs, 0) as available_chairs, ISNULL(ch.num_chairs, 0) as num_chairs, s.id, s.start_time, s.end_time, s.showroom_id, s.price, m.name as movie_name, m.image
                                                FROM shows s INNER JOIN movies m ON s.movie_id = m.id LEFT JOIN (SELECT show_id, COUNT(*) as num_chairs FROM chairs WHERE date = @time GROUP BY chairs.show_id) ch ON ch.show_id = s.id LEFT JOIN showroom sr ON sr.id = s.showroom_id WHERE s.start_date <= @time AND s.end_date >= @time";
                        SqlParameter timeParam = new SqlParameter("@time", SqlDbType.Date);
                        timeParam.Value = ShowDate.SelectedDate;
                        command.Parameters.Add(timeParam);

                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataSet dataset = new DataSet();
                        int rows = adapter.Fill(dataset);
                        if (rows == 0)
                        {
                            ShowsTable.Visible = false;
                            NoShows.Visible = true;
                        }
                        else
                        {
                            NoShows.Visible = false;
                            ShowsTable.Visible = true;
                            ShowsTable.DataSource = dataset;
                            ShowsTable.DataBind();
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorLabel.Visible = true;
            }
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (NewShowEndDate.SelectedDate == default(DateTime) || NewShowStartDate.SelectedDate == default(DateTime))
                args.IsValid = false;
            else if (NewShowEndDate.SelectedDate < NewShowStartDate.SelectedDate)
                args.IsValid = false;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            AddNewShowDiv.Visible = true;

            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = @"SELECT id, name FROM movies";

                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataSet dataset = new DataSet();
                        int rows = adapter.Fill(dataset);
                        if (rows == 0)
                        {
                            NewShowMovie.DataSource = null;
                        }
                        else
                        {
                            NewShowMovie.DataTextField = "name";
                            NewShowMovie.DataValueField = "id";
                            NewShowMovie.DataSource = dataset;
                            NewShowMovie.DataBind();
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorLabel.Visible = true;
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
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
                        command.CommandText = @"INSERT INTO shows (movie_id, showroom_id, start_time, end_time, start_date, end_date, price) VALUES (@movie, @showroom, @start_time, @end_time, @start_date, @end_date, @price)";
                        SqlParameter movieParam = new SqlParameter("@movie", SqlDbType.Int);
                        SqlParameter roomParam = new SqlParameter("@showroom", SqlDbType.Int);
                        SqlParameter startDateParam = new SqlParameter("@start_date", SqlDbType.Date);
                        SqlParameter endDateParam = new SqlParameter("@end_date", SqlDbType.Date);
                        SqlParameter startTimeParam = new SqlParameter("@start_time", SqlDbType.Time);
                        SqlParameter endTimeParam = new SqlParameter("@end_time", SqlDbType.Time);
                        SqlParameter priceParam = new SqlParameter("@price", SqlDbType.Int);

                        movieParam.Value = NewShowMovie.SelectedValue;
                        roomParam.Value = NewShowShowroom.SelectedValue;
                        startDateParam.Value = NewShowStartDate.SelectedDate;
                        endDateParam.Value = NewShowEndDate.SelectedDate;
                        startTimeParam.Value = NewShowStartTime.Text;
                        endTimeParam.Value = NewShowEndTime.Text;
                        priceParam.Value = NewShowPrice.Text;

                        command.Parameters.Add(movieParam);
                        command.Parameters.Add(roomParam);
                        command.Parameters.Add(startDateParam);
                        command.Parameters.Add(endDateParam);
                        command.Parameters.Add(startTimeParam);
                        command.Parameters.Add(endTimeParam);
                        command.Parameters.Add(priceParam);

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorLabel.Visible = true;
                return;
            }

            Session["ShowShowAddedMessage"] = true;
            Response.Redirect(Request.RawUrl);
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = @"SELECT sr.id, sr.rows * sr.columns as capacity FROM showroom sr WHERE sr.active = 1 AND sr.id NOT IN (SELECT s.showroom_id FROM shows s WHERE (s.start_date <= @end_date AND s.end_date >= @start_date) AND (s.start_time < @end_time AND s.end_time > @start_time))";
                        SqlParameter startDateParam = new SqlParameter("@start_date", SqlDbType.Date);
                        SqlParameter endDateParam = new SqlParameter("@end_date", SqlDbType.Date);
                        SqlParameter startTimeParam = new SqlParameter("@start_time", SqlDbType.Time);
                        SqlParameter endTimeParam = new SqlParameter("@end_time", SqlDbType.Time);

                        startDateParam.Value = NewShowStartDate.SelectedDate;
                        endDateParam.Value = NewShowEndDate.SelectedDate;
                        startTimeParam.Value = NewShowStartTime.Text;
                        endTimeParam.Value = NewShowEndTime.Text;

                        command.Parameters.Add(startDateParam);
                        command.Parameters.Add(endDateParam);
                        command.Parameters.Add(startTimeParam);
                        command.Parameters.Add(endTimeParam);

                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataSet dataset = new DataSet();
                        int rows = adapter.Fill(dataset);
                        if (rows == 0)
                        {
                            NewShowShowroom.DataSource = null;
                        }
                        else
                        {
                            NewShowShowroom.DataTextField = "id";
                            NewShowShowroom.DataValueField = "id";
                            NewShowShowroom.DataSource = dataset;
                            NewShowShowroom.DataBind();
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorLabel.Visible = true;
            }

            NewShowStartTime.Enabled = false;
            NewShowEndTime.Enabled = false;
        }

        protected void NewShowDates_SelectionChanged(object sender, EventArgs e)
        {
            NewShowShowroom.DataSource = null;
            NewShowShowroom.Items.Clear();
            NewShowStartTime.Enabled = true;
            NewShowEndTime.Enabled = true;
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            try
            {
                // parse & compare dates
                string randomDt = "01/01/2000 ";
                args.IsValid = DateTime.Parse(randomDt + NewShowEndTime.Text) > DateTime.Parse(randomDt + NewShowStartTime.Text);
            }
            catch (Exception /*ex*/)
            {
                // exception is assumed to be invalid times entered
                args.IsValid = false;
            }
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            NewShowShowroom.DataSource = null;
            NewShowShowroom.Items.Clear();
            NewShowStartTime.Enabled = true;
            NewShowEndTime.Enabled = true;
        }
    }
}