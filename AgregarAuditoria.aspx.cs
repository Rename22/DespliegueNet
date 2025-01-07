using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Ejercicio_2
{
    public partial class AgregarAuditoria : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["conexionLibreria"].ConnectionString;

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return; // Si hay errores de validación, no continuar.
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Auditoria (Fecha, Objetivo, Responsable, Conclusion, Recomendacion, Costo) VALUES (@Fecha, @Objetivo, @Responsable, @Conclusion, @Recomendacion, @Costo)";
                SqlCommand command = new SqlCommand(query, connection);

                command.Parameters.AddWithValue("@Fecha", txtFecha.Text);
                command.Parameters.AddWithValue("@Objetivo", txtObjetivo.Text);
                command.Parameters.AddWithValue("@Responsable", txtResponsable.Text);
                command.Parameters.AddWithValue("@Conclusion", ddlConclusion.SelectedValue);
                command.Parameters.AddWithValue("@Recomendacion", txtRecomendacion.Text);
                command.Parameters.AddWithValue("@Costo", Convert.ToDecimal(txtCosto.Text));

                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();

                    MostrarAlerta("Éxito", "Auditoría agregada correctamente.", true);
                }
                catch (Exception ex)
                {
                    MostrarAlerta("Error", $"Error al agregar la auditoría: {ex.Message}");
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarAuditorias.aspx"); // Redirige al listado de auditorías
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
