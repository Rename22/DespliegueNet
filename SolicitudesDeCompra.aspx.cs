using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ejercicio_2
{
    public partial class SolicitudesDeCompra : Page
    {
        private string connectionString = "Data Source=DESKTOP-RSU098M;Initial Catalog=libreria_db;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarSolicitudes();
            }
        }

        private void CargarSolicitudes()
        {
            if (Session["usuario_id"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string vendedorId = Session["usuario_id"].ToString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Cargar pendientes
                string queryPendientes = @"SELECT o.Id, l.Titulo, l.Precio, u.Nombre + ' ' + u.Apellido AS Comprador, 
                                           o.LugarEncuentro, o.FechaEncuentro, o.HoraEncuentro
                                           FROM Orden o
                                           INNER JOIN Libro l ON o.LibroId = l.Id
                                           INNER JOIN Usuario u ON o.CompradorId = u.Id
                                           WHERE o.Estado = 'Pendiente' AND l.VendedorId = @VendedorId";

                SqlCommand commandPendientes = new SqlCommand(queryPendientes, connection);
                commandPendientes.Parameters.AddWithValue("@VendedorId", vendedorId);

                // Cargar aceptadas
                string queryAceptadas = @"SELECT o.Id, l.Titulo, l.Precio, u.Nombre + ' ' + u.Apellido AS Comprador, 
                                          o.LugarEncuentro, o.FechaEncuentro, o.HoraEncuentro
                                          FROM Orden o
                                          INNER JOIN Libro l ON o.LibroId = l.Id
                                          INNER JOIN Usuario u ON o.CompradorId = u.Id
                                          WHERE o.Estado = 'Aceptada' AND l.VendedorId = @VendedorId";

                SqlCommand commandAceptadas = new SqlCommand(queryAceptadas, connection);
                commandAceptadas.Parameters.AddWithValue("@VendedorId", vendedorId);

                try
                {
                    connection.Open();

                    // Cargar pendientes
                    SqlDataReader readerPendientes = commandPendientes.ExecuteReader();
                    rptPendientes.DataSource = readerPendientes;
                    rptPendientes.DataBind();
                    readerPendientes.Close();

                    // Cargar aceptadas
                    SqlDataReader readerAceptadas = commandAceptadas.ExecuteReader();
                    rptAceptadas.DataSource = readerAceptadas;
                    rptAceptadas.DataBind();
                    readerAceptadas.Close();
                }
                catch (Exception ex)
                {
                    string errorScript = $"alert('Error al cargar las solicitudes: {ex.Message}');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErrorCargaSolicitudes", errorScript, true);
                }
            }
        }

        protected void rptPendientes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string ordenId = e.CommandArgument.ToString();

            if (e.CommandName == "Aceptar")
            {
                ActualizarEstadoOrden(ordenId, "Aceptada");
            }
            else if (e.CommandName == "Rechazar")
            {
                TextBox txtMotivo = (TextBox)e.Item.FindControl("txtMotivoPendiente");
                string motivo = txtMotivo?.Text.Trim();

                if (string.IsNullOrEmpty(motivo))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "MotivoVacio", "alert('Por favor ingrese un motivo para rechazar.');", true);
                    return;
                }

                RechazarOrden(ordenId, motivo);
            }

            CargarSolicitudes();
        }

        protected void rptAceptadas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string ordenId = e.CommandArgument.ToString();

            if (e.CommandName == "Completar")
            {
                CompletarOrden(ordenId);
            }
            else if (e.CommandName == "Cancelar")
            {
                TextBox txtMotivo = (TextBox)e.Item.FindControl("txtMotivoAceptada");
                string motivo = txtMotivo?.Text.Trim();

                if (string.IsNullOrEmpty(motivo))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "MotivoVacio", "alert('Por favor ingrese un motivo para cancelar.');", true);
                    return;
                }

                RechazarOrden(ordenId, motivo);
            }

            CargarSolicitudes();
        }

        private void CompletarOrden(string ordenId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
            UPDATE Orden
            SET Estado = 'Completada'
            WHERE Id = @OrdenId;

            UPDATE Libro
            SET Vendido = 1, EnProceso = 0
            WHERE Id = (SELECT LibroId FROM Orden WHERE Id = @OrdenId);";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@OrdenId", ordenId);

                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();

                    // Mostrar un mensaje de éxito
                    string script = @"
                iziToast.success({
                    title: 'Éxito',
                    message: 'La orden se ha completado y el libro ha sido marcado como vendido.',
                    position: 'topRight',
                    timeout: 3000
                });";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ToastMessage", script, true);
                }
                catch (Exception ex)
                {
                    string errorScript = $"alert('Error al completar la orden: {ex.Message}');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErrorCompletarOrden", errorScript, true);
                }
            }
        }


        private void ActualizarEstadoOrden(string ordenId, string estado)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"UPDATE Orden SET Estado = @Estado WHERE Id = @OrdenId";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Estado", estado);
                command.Parameters.AddWithValue("@OrdenId", ordenId);

                connection.Open();
                command.ExecuteNonQuery();
            }
        }

        private void RechazarOrden(string ordenId, string motivo)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"UPDATE Orden
                                 SET Estado = 'Rechazada', Motivo = @Motivo
                                 WHERE Id = @OrdenId;

                                 UPDATE Libro
                                 SET EnProceso = 0
                                 WHERE Id = (SELECT LibroId FROM Orden WHERE Id = @OrdenId);";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Motivo", motivo);
                command.Parameters.AddWithValue("@OrdenId", ordenId);

                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }
}
