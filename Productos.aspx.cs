using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ejercicio_2
{
    public partial class Productos : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Verificar si el usuario está autenticado
            if (Session["usuario_id"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            // Cargar los libros solo si no es un postback
            if (!IsPostBack)
            {
                CargarLibros();
            }
        }

        private void CargarLibros()
        {
            string usuarioId = Session["usuario_id"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["conexionLibreria"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT Id, Titulo, Autor, Precio, Condicion, Categoria, Imagen, Vendido 
                                 FROM Libro 
                                 WHERE VendedorId = @VendedorId";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@VendedorId", usuarioId);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    rptLibros.DataSource = reader;
                    rptLibros.DataBind();
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error al cargar los libros: {ex.Message}");
                }
            }
        }

        protected void rptLibros_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // Verificar qué comando fue invocado
            if (e.CommandName == "Eliminar")
            {
                string libroId = e.CommandArgument.ToString();
                EliminarLibro(libroId);
                Response.Redirect(Request.RawUrl);
            }
            else if (e.CommandName == "Editar")
            {
                string libroId = e.CommandArgument.ToString();
                Response.Redirect($"EditarLibro.aspx?Id={libroId}");
            }
        }

        private void EliminarLibro(string libroId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["conexionLibreria"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Libro WHERE Id = @Id";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Id", libroId);

                try
                {
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        Console.WriteLine($"Libro con ID {libroId} eliminado correctamente.");
                    }
                    else
                    {
                        Console.WriteLine($"No se encontró el libro con ID {libroId}.");
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error al intentar eliminar el libro con ID {libroId}: {ex.Message}");
                }
            }
        }
    }
}
