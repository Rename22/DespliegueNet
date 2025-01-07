using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ejercicio_2
{
    public partial class ListarPerfiles : Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["conexionLibreria"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPerfiles();
            }
        }

        private void CargarPerfiles()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Perfiles";
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                GridViewPerfiles.DataSource = reader;
                GridViewPerfiles.DataBind();
            }
        }

        protected void GridViewPerfiles_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                EliminarPerfil(id);
                CargarPerfiles();

                
                MostrarAlerta("Éxito", "El perfil fue eliminado correctamente.");
            }
        }

        private void EliminarPerfil(int id)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Perfiles WHERE Id = @Id";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Id", id);
                connection.Open();
                command.ExecuteNonQuery();
            }
        }

        private void MostrarAlerta(string titulo, string mensaje)
        {
            string script = $@"
                iziToast.success({{
                    title: '{titulo}',
                    message: '{mensaje}',
                    position: 'topRight',
                    timeout: 3000
                }});
            ";
            ScriptManager.RegisterStartupScript(this, GetType(), "ToastMessage", script, true);
        }

        
    }
}
