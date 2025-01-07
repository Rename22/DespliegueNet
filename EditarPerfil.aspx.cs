using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace TuProyecto
{
    public partial class EditarPerfil : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["conexionLibreria"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["Id"]);
                CargarPerfil(id);
            }
        }

        private void CargarPerfil(int id)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Perfiles WHERE Id = @Id";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Id", id);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    txtNombre.Text = reader["Nombre"].ToString();
                    txtDescripcion.Text = reader["Descripcion"].ToString();
                    ddlIdioma.SelectedValue = reader["Idioma"].ToString();
                    txtFechaCaducidad.Text = Convert.ToDateTime(reader["FechaCaducidad"]).ToString("yyyy-MM-dd");
                    txtCreador.Text = reader["Creador"].ToString();
                }
                connection.Close();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Request.QueryString["Id"]);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE Perfiles SET Nombre = @Nombre, Descripcion = @Descripcion, Idioma = @Idioma, FechaCaducidad = @FechaCaducidad, Creador = @Creador WHERE Id = @Id";
                SqlCommand command = new SqlCommand(query, connection);

                command.Parameters.AddWithValue("@Nombre", txtNombre.Text);
                command.Parameters.AddWithValue("@Descripcion", txtDescripcion.Text);
                command.Parameters.AddWithValue("@Idioma", ddlIdioma.SelectedValue);
                command.Parameters.AddWithValue("@FechaCaducidad", txtFechaCaducidad.Text);
                command.Parameters.AddWithValue("@Creador", txtCreador.Text);
                command.Parameters.AddWithValue("@Id", id);

                
                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();

                    MostrarAlerta("Éxito", "Perfil actualizado correctamente.", true);
                }
                catch (Exception ex)
                {
                    MostrarAlerta("Error", $"Error al actualizar el perfil: {ex.Message}");
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
