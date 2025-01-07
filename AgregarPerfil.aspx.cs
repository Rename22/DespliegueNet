using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Ejercicio_2
{
    public partial class AgregarPerfil : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["conexionLibreria"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Perfiles (Nombre, Descripcion, Idioma, FechaCaducidad, Creador) VALUES (@Nombre, @Descripcion, @Idioma, @FechaCaducidad, @Creador)";
                SqlCommand command = new SqlCommand(query, connection);

                command.Parameters.AddWithValue("@Nombre", txtNombre.Text);
                command.Parameters.AddWithValue("@Descripcion", txtDescripcion.Text);
                command.Parameters.AddWithValue("@Idioma", ddlIdioma.SelectedValue);
                command.Parameters.AddWithValue("@FechaCaducidad", txtFechaCaducidad.Text);
                command.Parameters.AddWithValue("@Creador", txtCreador.Text);

                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();

                    MostrarAlerta("Éxito", "Perfil agregado correctamente.", true);
                }
                catch (Exception ex)
                {
                    MostrarAlerta("Error", $"Error al agregar el perfil: {ex.Message}");
                }


               
            }
        }
        private void MostrarAlerta(string titulo, string mensaje, bool redirigir = false)
        {
            string script = $@"
                iziToast.{(titulo == "Éxito" ? "success" : "error")}({{
                    title: '{titulo}',
                    message: '{mensaje}',
                    position: 'topRight',
                    timeout: 3000,
                    onClosing: function() {{
                        {(redirigir ? "setTimeout(function() { window.location.href = 'ListarPerfiles.aspx'; }, 500);" : "")}
                    }}
                }});
            ";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ToastMessage", script, true);
        }
    }

}

    

