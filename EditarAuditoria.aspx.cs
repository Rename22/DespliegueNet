using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Ejercicio_2
{
    public partial class EditarAuditoria : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["conexionLibreria"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["ID"]);
                CargarAuditoria(id);
            }
        }

        private void CargarAuditoria(int id)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Auditoria WHERE ID = @ID";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@ID", id);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    txtFecha.Text = Convert.ToDateTime(reader["Fecha"]).ToString("yyyy-MM-dd");
                    txtObjetivo.Text = reader["Objetivo"].ToString();
                    txtResponsable.Text = reader["Responsable"].ToString();
                    ddlConclusion.SelectedValue = reader["Conclusion"].ToString();
                    txtRecomendacion.Text = reader["Recomendacion"].ToString();
                    txtCosto.Text = reader["Costo"].ToString();
                }
                connection.Close();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Request.QueryString["ID"]);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE Auditoria SET Fecha = @Fecha, Objetivo = @Objetivo, Responsable = @Responsable, Conclusion = @Conclusion, Recomendacion = @Recomendacion, Costo = @Costo WHERE ID = @ID";
                SqlCommand command = new SqlCommand(query, connection);

                command.Parameters.AddWithValue("@Fecha", txtFecha.Text);
                command.Parameters.AddWithValue("@Objetivo", txtObjetivo.Text);
                command.Parameters.AddWithValue("@Responsable", txtResponsable.Text);
                command.Parameters.AddWithValue("@Conclusion", ddlConclusion.SelectedValue);
                command.Parameters.AddWithValue("@Recomendacion", txtRecomendacion.Text);
                command.Parameters.AddWithValue("@Costo", Convert.ToDecimal(txtCosto.Text));
                command.Parameters.AddWithValue("@ID", id);

                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();
                    MostrarAlerta("Éxito", "Auditoría actualizada correctamente.", true);
                }
                catch (Exception ex)
                {
                    MostrarAlerta("Error", $"Error al actualizar la auditoría: {ex.Message}");
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
                        {(redirigir ? "setTimeout(function() { window.location.href = 'ListarAuditorias.aspx'; }, 500);" : "")}
                    }}
                }});
            ";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ToastMessage", script, true);
        }
    }
}
