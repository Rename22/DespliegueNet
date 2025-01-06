using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Ejercicio_2
{
    public partial class Register : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            lblCedulaError.Text = "";
            lblTelefonoError.Text = "";
            lblMessage.Text = "";

            string cedula = txtCedula.Text.Trim();
            string telefono = txtTelefono.Text.Trim();

            // Validar cédula
            if (string.IsNullOrWhiteSpace(cedula) || cedula.Length != 10)
            {
                lblCedulaError.Text = "La cédula debe tener exactamente 10 dígitos.";
                return;
            }

            // Validar teléfono
            if (string.IsNullOrWhiteSpace(telefono) || telefono.Length != 10)
            {
                lblTelefonoError.Text = "El teléfono debe tener exactamente 10 dígitos.";
                return;
            }

            // Validar otros campos
            if (string.IsNullOrWhiteSpace(txtNombre.Text) || string.IsNullOrWhiteSpace(txtApellido.Text) ||
                string.IsNullOrWhiteSpace(txtDireccion.Text) || string.IsNullOrWhiteSpace(txtCorreo.Text) ||
                string.IsNullOrWhiteSpace(txtContrasena.Text) || string.IsNullOrWhiteSpace(txtConfirmarContrasena.Text))
            {
                lblMessage.Text = "Todos los campos son obligatorios.";
                return;
            }

            if (txtContrasena.Text.Trim() != txtConfirmarContrasena.Text.Trim())
            {
                lblMessage.Text = "Las contraseñas no coinciden.";
                return;
            }

            // Insertar en la base de datos
            string connectionString = ConfigurationManager.ConnectionStrings["conexionLibreria"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Usuario 
                                 (Nombre, Apellido, Cedula, Direccion, Telefono, Correo, Contrasena) 
                                 VALUES (@Nombre, @Apellido, @Cedula, @Direccion, @Telefono, @Correo, @Contrasena)";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Nombre", txtNombre.Text.Trim());
                command.Parameters.AddWithValue("@Apellido", txtApellido.Text.Trim());
                command.Parameters.AddWithValue("@Cedula", cedula);
                command.Parameters.AddWithValue("@Direccion", txtDireccion.Text.Trim());
                command.Parameters.AddWithValue("@Telefono", telefono);
                command.Parameters.AddWithValue("@Correo", txtCorreo.Text.Trim());
                command.Parameters.AddWithValue("@Contrasena", txtContrasena.Text.Trim());

                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();
                    Response.Redirect("Login.aspx");
                }
                catch (Exception ex)
                {
                    lblMessage.Text = $"Error: {ex.Message}";
                }
            }
        }
    }
}
