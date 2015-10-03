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
    public partial class PurchaseChairs : System.Web.UI.Page
    {
        public Auth.UserInfo UserInfo = null;

        public struct ChairPosition
        {
            public int Row;
            public int Column;
        }

        int TicketPrice = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            UserInfo = Session["UserInfo"] as Auth.UserInfo;

            if (UserInfo == null)
            {
                Response.Redirect("~/Login.aspx", true);
                return;
            }

            if (Session["PurchaseDate"] == null || Session["PurchaseMovieId"] == null || Session["PurchaseShowId"] == null)
            {
                Session["PurchaseDate"] = null;
                Session["PurchaseMovieId"] = null;
                Session["PurchaseShowId"] = null;
                Session["ShowDefaultError"] = true;
                Response.Redirect("~/Default.aspx", true);
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
                        command.CommandText = @"SELECT sr.rows, sr.columns, price FROM shows s LEFT JOIN (SELECT show_id, COUNT(*) as num_chairs FROM chairs WHERE date = @date GROUP BY chairs.show_id) ch ON ch.show_id = s.id LEFT JOIN showroom sr ON sr.id = s.showroom_id WHERE movie_id = @mov_id AND start_date <= @date AND end_date >= @date AND (sr.rows * sr.columns) - ISNULL(ch.num_chairs, 0) > 0 AND s.id = @show_id";
                        SqlParameter dateParam = new SqlParameter("@date", SqlDbType.Date);
                        SqlParameter movieParam = new SqlParameter("@mov_id", SqlDbType.Int);
                        SqlParameter showParam = new SqlParameter("@show_id", SqlDbType.Int);

                        dateParam.Value = Session["PurchaseDate"];
                        movieParam.Value = Session["PurchaseMovieId"];
                        showParam.Value = Session["PurchaseShowId"];

                        command.Parameters.Add(dateParam);
                        command.Parameters.Add(movieParam);
                        command.Parameters.Add(showParam);

                        var reader = command.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            Session["PurchaseDate"] = null;
                            Session["PurchaseMovieId"] = null;
                            Session["PurchaseShowId"] = null;
                            Session["ShowDefaultError"] = true;
                            Response.Redirect("~/Default.aspx", true);
                            return;
                        }

                        reader.Read();

                        int rows = reader.GetInt32(0);
                        int columns = reader.GetInt32(1);
                        TicketPrice = reader.GetInt32(2);

                        reader.Close();

                        command.CommandText = "SELECT row, [column] FROM chairs WHERE show_id = @show_id AND date = @date";
                        var chairsReader = command.ExecuteReader();
                        List<ChairPosition> bought_chairs = new List<ChairPosition>();
                        while (chairsReader.Read())
                        {
                            bought_chairs.Add(new ChairPosition
                            {
                                Row = chairsReader.GetInt32(0),
                                Column = chairsReader.GetInt32(1)
                            });
                        }

                        for (int i = 0; i < rows; ++i)
                        {
                            var tr = new TableRow();
                            for (int j = 0; j < columns; ++j)
                            {
                                var td = new TableCell();
                                var chair = new ChairPosition
                                {
                                    Row = i,
                                    Column = j
                                };

                                CheckBox checkbox = new CheckBox();
                                checkbox.ID = i + "," + j;
                                if (bought_chairs.Contains(chair))
                                {
                                    checkbox.Checked = true;
                                    checkbox.Enabled = false;
                                }
                                else
                                    checkbox.Checked = false;

                                checkbox.CausesValidation = false;
                                checkbox.CheckedChanged += Checkbox_CheckedChanged;

                                td.Controls.Add(checkbox);
                                tr.Cells.Add(td);

                            }
                            ChairsTable.Rows.Add(tr);
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

        List<ChairPosition> SelectedChairs = new List<ChairPosition>();

        private void Checkbox_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox check = sender as CheckBox;
            if (check.Checked)
            {
                var pos = check.ID.Split(',');
                SelectedChairs.Add(new ChairPosition
                {
                    Row = int.Parse(pos[0]),
                    Column = int.Parse(pos[1])
                });
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Session["PurchaseSelectedChairs"] = SelectedChairs;
            Session["PurchasePrice"] = SelectedChairs.Count * TicketPrice;
            Response.Redirect("~/FinalPurchase.aspx", true);
        }
    }
}