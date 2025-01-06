using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Ejercicio_2
{
    public partial class Ventas : Page
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
                CargarReporteVentas();
            }
        }

        private void CargarReporteVentas()
        {
            string vendedorId = Session["usuario_id"].ToString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT l.Titulo, l.Precio, u.Nombre + ' ' + u.Apellido AS Comprador,
                                 o.LugarEncuentro, o.FechaEncuentro, o.HoraEncuentro
                                 FROM Orden o
                                 INNER JOIN Libro l ON o.LibroId = l.Id
                                 INNER JOIN Usuario u ON o.CompradorId = u.Id
                                 WHERE l.VendedorId = @VendedorId AND o.Estado = 'Completada'";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@VendedorId", vendedorId);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    rptVentas.DataSource = reader;
                    rptVentas.DataBind();
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error al cargar el reporte: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "ErrorCargaReporte", script, true);
                }
            }
        }
    }
}
