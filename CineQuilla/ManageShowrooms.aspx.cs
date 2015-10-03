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
    public partial class ManageShowrooms : System.Web.UI.Page
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

            if (Session["ShowShowroomAddedMessage"] != null && (bool)Session["ShowShowroomAddedMessage"] == true)
            {
                ShowroomAddedMessage.Visible = true;
                Session["ShowShowroomAddedMessage"] = null;
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
                            command.CommandText = "SELECT id, capacity, capable_3d, active FROM showroom";
                            SqlDataAdapter adapter = new SqlDataAdapter(command);
                            DataSet dataset = new DataSet();
                            int rows = adapter.Fill(dataset);
                            if (rows == 0)
                            {
                                ShowroomsTable.Visible = false;
                                NoShowrooms.Visible = true;
                            }
                            else
                            {
                                ShowroomsTable.DataSource = dataset;
                                ShowroomsTable.DataBind();
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

        protected void Button3_Click(object sender, EventArgs e)
        {
            AddNewShowroomDiv.Visible = true;
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
                        command.CommandText = "INSERT INTO showroom (capacity, capable_3d, active) VALUES (@cap, @ac_3d, @active)";
                        SqlParameter capacityParam = new SqlParameter("@cap", SqlDbType.Int);
                        SqlParameter cap3dParam = new SqlParameter("@ac_3d", SqlDbType.Int);
                        SqlParameter activeParam = new SqlParameter("@active", SqlDbType.Int);

                        capacityParam.Value = CapacityBox.Text;
                        cap3dParam.Value = Capable3DBox.Checked ? 1 : 0;
                        activeParam.Value = ActiveBox.Checked ? 1 : 0;

                        command.Parameters.Add(capacityParam);
                        command.Parameters.Add(cap3dParam);
                        command.Parameters.Add(activeParam);

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

            Session["ShowShowroomAddedMessage"] = true;
            Response.Redirect(Request.RawUrl);
        }

        protected void ShowroomsTable_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "DeleteShowroom")
                return;

            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = "DELETE FROM showroom WHERE id = @id";
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
    }
}