using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Security;

namespace CineQuilla.Auth
{
    public class Helpers
    {
        public static void Logout(System.Web.UI.Page page)
        {
            if (page != null)
            {
                page.Session["UserInfo"] = null;
                page.Session.Abandon();
            }
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage();
        }
    }
}
