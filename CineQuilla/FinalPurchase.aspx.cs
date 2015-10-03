using System;
using System.Collections.Generic;
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
        }
    }
}