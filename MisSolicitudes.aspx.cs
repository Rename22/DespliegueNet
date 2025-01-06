using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Ejercicio_2
{
    public partial class MisSolicitudes : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["conexionLibreria"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario_id"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarSolicitudes();
            }
        }

        private void CargarSolicitudes()
        {
            string compradorId = Session["usuario_id"].ToString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT o.Id, l.Titulo, l.Precio, u.Nombre + ' ' + u.Apellido AS Vendedor,
                                 o.LugarEncuentro, o.FechaEncuentro, o.HoraEncuentro, o.Estado, o.Motivo
                                 FROM Orden o
                                 INNER JOIN Libro l ON o.LibroId = l.Id
                                 INNER JOIN Usuario u ON l.VendedorId = u.Id
                                 WHERE o.CompradorId = @CompradorId";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CompradorId", compradorId);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    rptSolicitudes.DataSource = reader;
                    rptSolicitudes.DataBind();
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error al cargar las solicitudes: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "ErrorCargaSolicitudes", script, true);
                }
            }
        }

        protected string ObtenerEstado(string estado, string motivo)
        {
            if (estado == "Rechazada")
            {
                return $"<span class='badge bg-danger'>Rechazada</span><p class='mt-2 text-danger'>Motivo: {motivo}</p>";
            }
            else if (estado == "Cancelada")
            {
                return $"<span class='badge bg-secondary'>Cancelada</span><p class='mt-2 text-secondary'>Motivo: {motivo}</p>";
            }
            else if (estado == "Pendiente")
            {
                return "<span class='badge bg-warning text-dark'>Pendiente</span>";
            }
            else if (estado == "Aceptada")
            {
                return "<span class='badge bg-primary'>Aceptada</span>";
            }
            else if (estado == "Completada")
            {
                return "<span class='badge bg-success'>Completada</span>";
            }
            return string.Empty;
        }
    }
}
