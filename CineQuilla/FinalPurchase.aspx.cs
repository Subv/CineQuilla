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
    public partial class FinalPurchase : System.Web.UI.Page
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

            if (Session["PurchaseDate"] == null || Session["PurchaseMovieId"] == null || Session["PurchaseShowId"] == null || Session["PurchaseSelectedChairs"] == null || Session["PurchasePrice"] == null)
            {
                Session["PurchaseDate"] = null;
                Session["PurchaseMovieId"] = null;
                Session["PurchaseShowId"] = null;
                Session["PurchaseSelectedChairs"] = null;
                Session["PurchasePrice"] = null;
                Session["ShowDefaultError"] = true;
                Response.Redirect("~/Default.aspx", true);
                return;
            }

            PriceToPayBox.Text = Session["PurchasePrice"].ToString();
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = @"SELECT 1 FROM clients WHERE id = @id";
                        SqlParameter idParam = new SqlParameter("@id", SqlDbType.Int);

                        idParam.Value = args.Value;

                        command.Parameters.Add(idParam);

                        var reader = command.ExecuteReader();
                        if (!reader.HasRows)
                            args.IsValid = false;
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorLabel.Visible = true;
                args.IsValid = false;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();

                    int transaction_id = -1;
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = @"INSERT INTO transactions (payment_method, date, cashier_id, client_id, amount, quantity, debit_number, points_card_id) OUTPUT INSERTED.ID VALUES
                                                (@method, @date, @cashier, @client, @amount, @qty, @debit, @card)";

                        SqlParameter methodParam = new SqlParameter("@method", SqlDbType.Int);
                        SqlParameter dateParam = new SqlParameter("@date", SqlDbType.Date);
                        SqlParameter cashierParam = new SqlParameter("@cashier", SqlDbType.Int);
                        SqlParameter clientParam = new SqlParameter("@client", SqlDbType.Int);
                        SqlParameter amountParam = new SqlParameter("@amount", SqlDbType.Int);
                        SqlParameter qtyParam = new SqlParameter("@qty", SqlDbType.Int);
                        SqlParameter debitParam = new SqlParameter("@debit", SqlDbType.Int);
                        SqlParameter cardParam = new SqlParameter("@card", SqlDbType.Int);

                        methodParam.Value = PaymentMethod.SelectedValue;
                        dateParam.Value = DateTime.Now;
                        cashierParam.Value = UserInfo.Id;
                        clientParam.Value = ClientID.Text;
                        amountParam.Value = Session["PurchasePrice"];
                        qtyParam.Value = (Session["PurchaseSelectedChairs"] as List<PurchaseChairs.ChairPosition>).Count;

                        cardParam.Value = DBNull.Value;
                        debitParam.Value = DBNull.Value;

                        if (PaymentMethod.SelectedValue == "2")
                            cardParam.Value = CineQuillaCard.Text;
                        else
                            debitParam.Value = DebitCardNumber.Text;

                        command.Parameters.Add(methodParam);
                        command.Parameters.Add(dateParam);
                        command.Parameters.Add(cashierParam);
                        command.Parameters.Add(clientParam);
                        command.Parameters.Add(amountParam);
                        command.Parameters.Add(qtyParam);
                        command.Parameters.Add(debitParam);
                        command.Parameters.Add(cardParam);

                        transaction_id = (int)command.ExecuteScalar();
                    }

                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = @"INSERT INTO chairs (transaction_id, show_id, date, row, [column]) VALUES
                                                (@tid, @sid, @date, @row, @column)";

                        SqlParameter tidParam = new SqlParameter("@tid", SqlDbType.Int);
                        SqlParameter sidParam = new SqlParameter("@sid", SqlDbType.Int);
                        SqlParameter dateParam = new SqlParameter("@date", SqlDbType.Date);
                        SqlParameter rowParam = new SqlParameter("@row", SqlDbType.Int);
                        SqlParameter colParam = new SqlParameter("@column", SqlDbType.Int);

                        tidParam.Value = transaction_id;
                        sidParam.Value = Session["PurchaseShowId"];
                        dateParam.Value = Session["PurchaseDate"];

                        command.Parameters.Add(tidParam);
                        command.Parameters.Add(sidParam);
                        command.Parameters.Add(dateParam);
                        command.Parameters.Add(rowParam);
                        command.Parameters.Add(colParam);

                        var chairs = Session["PurchaseSelectedChairs"] as List<PurchaseChairs.ChairPosition>;

                        foreach (var chair in chairs)
                        {
                            rowParam.Value = chair.Row;
                            colParam.Value = chair.Column;
                            command.ExecuteNonQuery();
                        }
                    }

                    Session["PurchaseDate"] = null;
                    Session["PurchaseMovieId"] = null;
                    Session["PurchaseShowId"] = null;
                    Session["PurchaseSelectedChairs"] = null;
                    Session["PurchasePrice"] = null;

                    // TODO Update the points if bought with CineQuilla card

                    Response.Redirect("~/PurchaseCompleted.aspx", true);
                }
            }
            catch (SqlException ex)
            {
                ErrorLabel.Visible = true;
            }
        }

        protected void CustomValidator3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = args.Value == "1" || args.Value == "2";
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            try
            {
                var connString = ConfigurationManager.ConnectionStrings["CineQuilla"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(null, connection))
                    {
                        command.CommandText = @"SELECT 1 FROM cards WHERE id = @id AND owner = @owner";
                        SqlParameter idParam = new SqlParameter("@id", SqlDbType.Int);
                        SqlParameter ownerParam = new SqlParameter("@owner", SqlDbType.Int);

                        idParam.Value = args.Value;
                        ownerParam.Value = ClientID.Text;

                        command.Parameters.Add(idParam);
                        command.Parameters.Add(ownerParam);

                        var reader = command.ExecuteReader();
                        if (!reader.HasRows)
                            args.IsValid = false;
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorLabel.Visible = true;
                args.IsValid = false;
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (PaymentMethod.SelectedValue == "1")
            {
                PayWithPoints.Visible = false;
                PayWithDebit.Visible = true;
            }
            else if (PaymentMethod.SelectedValue == "2")
            {
                PayWithPoints.Visible = true;
                PayWithDebit.Visible = false;
            }
        }
    }
}