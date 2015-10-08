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
    public partial class ManageTransactions : System.Web.UI.Page
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
                // Populate the GridView with the users in the database
                try
                {
                    var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                    using (SqlConnection connection = new SqlConnection(connString))
                    {
                        connection.Open();
                        using (SqlCommand command = new SqlCommand(null, connection))
                        {
                            command.CommandText = "SELECT t.id, t.date, t.client_id, CONCAT(c.first_name, ' ', c.last_name) as client_name, t.cashier_id, CONCAT(u.first_name, ' ', u.last_name) as cashier_name, t.quantity, t.amount, CASE t.payment_method WHEN 1 THEN 'Tarjeta Debito' WHEN 2 THEN 'Tarjeta CineQuilla' END as payment_method, t.debit_number, t.points_card_id FROM transactions t LEFT JOIN clients c ON c.id = t.client_id LEFT JOIN users u ON u.id = t.cashier_id";
                            SqlDataAdapter adapter = new SqlDataAdapter(command);
                            DataSet dataset = new DataSet();
                            int rows = adapter.Fill(dataset);
                            if (rows == 0)
                            {
                                TransactionsTable.Visible = false;
                                NoTransactions.Visible = true;
                            }
                            else
                            {
                                TransactionsTable.DataSource = dataset;
                                TransactionsTable.DataBind();
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

        protected void TransactionsTable_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "DeleteTransaction")
                return;

            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = "DELETE FROM transactions WHERE id = @id";
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