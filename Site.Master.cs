using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ejercicio_2
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario_id"] == null && !Request.Url.AbsolutePath.EndsWith("Login.aspx"))
            {
                Response.Redirect("Login.aspx");
            }
        }

    }
}