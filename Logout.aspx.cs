using System;

namespace Ejercicio_2
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Limpiar la sesión
            Session.Clear();
            Session.Abandon();

            // Redirigir al inicio de sesión
            Response.Redirect("Login.aspx");
        }
    }
}
