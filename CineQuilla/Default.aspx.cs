using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CineQuilla
{
    public partial class Default : System.Web.UI.Page
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

            if (!Page.IsPostBack)
            {
                if (Session["ShowDefaultError"] != null)
                {
                    Session["ShowDefaultError"] = null;
                    ErrorLabel.Visible = true;
                }

                try
                {
                    var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                    using (SqlConnection connection = new SqlConnection(connString))
                    {
                        connection.Open();
                        using (SqlCommand command = new SqlCommand(null, connection))
                        {
                            command.CommandText = "SELECT id, name, image FROM movies WHERE id IN (SELECT movie_id FROM shows WHERE CAST(end_date as DateTime) + CAST(end_time AS DateTime) > CURRENT_TIMESTAMP)";
                            SqlDataAdapter adapter = new SqlDataAdapter(command);
                            DataSet dataset = new DataSet();
                            int rows = adapter.Fill(dataset);
                            if (rows == 0)
                            {
                                ShowingGridView.Visible = false;
                                NoShows.Visible = true;
                            }
                            else
                            {
                                ShowingGridView.DataSource = dataset;
                                ShowingGridView.DataBind();
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