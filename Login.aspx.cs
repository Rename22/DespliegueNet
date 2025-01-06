using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Ejercicio_2
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario_id"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string correo = txtCorreo.Text;
            string contrasena = txtContrasena.Text;

            string connectionString = "Data Source=DESKTOP-RSU098M;Initial Catalog=libreria_db;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, Nombre FROM Usuario WHERE Correo = @Correo AND Contrasena = @Contrasena";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Correo", correo);
                command.Parameters.AddWithValue("@Contrasena", contrasena);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        Session["usuario_id"] = reader["Id"];
                        Session["usuario_nombre"] = reader["Nombre"];
                        Response.Redirect("Default.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Correo o contraseña incorrectos.";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = $"Error: {ex.Message}";
                }
            }
        }


    }
}
