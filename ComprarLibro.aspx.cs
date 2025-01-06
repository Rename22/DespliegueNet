using System;
using System.Data.SqlClient;

namespace Ejercicio_2
{
    public partial class ComprarLibro : System.Web.UI.Page
    {
        private string connectionString = "Data Source=DESKTOP-RSU098M;Initial Catalog=libreria_db;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string libroId = Request.QueryString["libroId"];
                if (string.IsNullOrEmpty(libroId))
                {
                    Response.Redirect("~/Default.aspx");
                }

                CargarLibro(libroId);
            }
        }

        private void CargarLibro(string libroId)
        {
            string query = "SELECT Titulo, Precio FROM Libro WHERE Id = @Id AND Vendido = 0 AND EnProceso = 0";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Id", libroId);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        lblTitulo.Text = reader["Titulo"].ToString();
                        lblPrecio.Text = reader["Precio"].ToString();
                    }
                    else
                    {
                        Response.Redirect("~/Default.aspx");
                    }
                }
                catch (Exception ex)
                {
                    lblTitulo.Text = "Error al cargar el libro.";
                }
            }
        }

        protected void btnConfirmarCompra_Click(object sender, EventArgs e)
        {
            string libroId = Request.QueryString["libroId"];
            string usuarioId = Session["usuario_id"].ToString();
            string lugarEncuentro = txtLugarEncuentro.Text.Trim();
            string fechaEncuentro = txtFechaEncuentro.Text.Trim();
            string horaEncuentro = txtHoraEncuentro.Text.Trim();

            string queryOrden = @"
                INSERT INTO Orden (CompradorId, LibroId, LugarEncuentro, FechaEncuentro, HoraEncuentro, Estado)
                VALUES (@CompradorId, @LibroId, @LugarEncuentro, @FechaEncuentro, @HoraEncuentro, 'Pendiente');
                UPDATE Libro SET EnProceso = 1 WHERE Id = @LibroId;";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(queryOrden, connection);
                command.Parameters.AddWithValue("@CompradorId", usuarioId);
                command.Parameters.AddWithValue("@LibroId", libroId);
                command.Parameters.AddWithValue("@LugarEncuentro", lugarEncuentro);
                command.Parameters.AddWithValue("@FechaEncuentro", fechaEncuentro);
                command.Parameters.AddWithValue("@HoraEncuentro", horaEncuentro);

                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();

                    Response.Redirect("~/Default.aspx");
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('Error al confirmar la compra: " + ex.Message + "');", true);
                }
            }
        }
    }
}
