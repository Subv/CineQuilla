﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CineQuilla
{
    public partial class Site : System.Web.UI.MasterPage
    {
        public Auth.UserInfo UserInfo = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            UserInfo = Session["UserInfo"] as Auth.UserInfo;

            if (UserInfo == null)
            {
                if (Request.FilePath != "/Login.aspx")
                {
                    Auth.Helpers.Logout(Page);
                    Response.End();
                }
                return;
            }

            if (Session["ShowPermissionError"] != null && (bool)Session["ShowPermissionError"] == true)
            {
                ErrorText.Visible = true;
                ErrorText.Text = "You do not have the permissions to do that.";
                Session["ShowPermissionError"] = null;
            }

            // Only administrators can view the admin panel
            if (UserInfo.PermissionLevel >= 2)
            {
                LoginView1.FindControl("AdminPanel").Visible = true;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Auth.Helpers.Logout(Page);
        }
    }
}