using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ejercicio_2
{
    public partial class ListarAuditorias : Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["conexionLibreria"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarAuditorias();
            }
        }

        private void CargarAuditorias()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Auditoria";
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                GridViewAuditorias.DataSource = reader;
                GridViewAuditorias.DataBind();
            }
        }

        protected void GridViewAuditorias_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                EliminarAuditoria(id);
                CargarAuditorias();

                MostrarAlerta("Éxito", "La auditoría fue eliminada correctamente.");
            }
        }

        private void EliminarAuditoria(int id)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Auditoria WHERE ID = @ID";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@ID", id);
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
