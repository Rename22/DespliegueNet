using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ejercicio_2
{
    public partial class Default : Page
    {
        private string connectionString = "Data Source=DESKTOP-RSU098M;Initial Catalog=libreria_db;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario_id"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                CargarLibros();
            }
        }

        private void CargarLibros()
        {
            string usuarioId = Session["usuario_id"].ToString();
            string query = @"SELECT Id, Titulo, Autor, Condicion, Categoria, Precio, Imagen AS ImagenUrl,
                            (SELECT Nombre + ' ' + Apellido FROM Usuario WHERE Usuario.Id = Libro.VendedorId) AS Vendedor
                            FROM Libro
                            WHERE Vendido = 0 AND EnProceso = 0 AND VendedorId != @UsuarioId";

            List<Libro> libros = ObtenerLibros(query, usuarioId);
            rptLibros.DataSource = libros;
            rptLibros.DataBind();
        }

        protected void FiltrarLibros(object sender, EventArgs e)
        {
            string usuarioId = Session["usuario_id"].ToString();
            string query = @"SELECT Id, Titulo, Autor, Condicion, Categoria, Precio, Imagen AS ImagenUrl,
                            (SELECT Nombre + ' ' + Apellido FROM Usuario WHERE Usuario.Id = Libro.VendedorId) AS Vendedor
                            FROM Libro
                            WHERE Vendido = 0 AND EnProceso = 0 AND VendedorId != @UsuarioId";

            if (!string.IsNullOrEmpty(txtBusqueda.Text))
            {
                query += " AND (Titulo LIKE '%' + @Busqueda + '%' OR Autor LIKE '%' + @Busqueda + '%')";
            }
            if (!string.IsNullOrEmpty(ddlCategoria.SelectedValue))
            {
                query += " AND Categoria = @Categoria";
            }
            if (!string.IsNullOrEmpty(txtPrecioMin.Text))
            {
                query += " AND Precio >= @PrecioMin";
            }
            if (!string.IsNullOrEmpty(txtPrecioMax.Text))
            {
                query += " AND Precio <= @PrecioMax";
            }

            List<Libro> libros = ObtenerLibros(query, usuarioId, txtBusqueda.Text, ddlCategoria.SelectedValue, txtPrecioMin.Text, txtPrecioMax.Text);
            rptLibros.DataSource = libros;
            rptLibros.DataBind();
        }

        private List<Libro> ObtenerLibros(string query, string usuarioId, string busqueda = "", string categoria = "", string precioMin = "", string precioMax = "")
        {
            List<Libro> libros = new List<Libro>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@UsuarioId", usuarioId);

                if (!string.IsNullOrEmpty(busqueda))
                {
                    command.Parameters.AddWithValue("@Busqueda", busqueda);
                }
                if (!string.IsNullOrEmpty(categoria))
                {
                    command.Parameters.AddWithValue("@Categoria", categoria);
                }
                if (!string.IsNullOrEmpty(precioMin))
                {
                    command.Parameters.AddWithValue("@PrecioMin", Convert.ToDecimal(precioMin));
                }
                if (!string.IsNullOrEmpty(precioMax))
                {
                    command.Parameters.AddWithValue("@PrecioMax", Convert.ToDecimal(precioMax));
                }

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    libros.Add(new Libro
                    {
                        Id = reader["Id"].ToString(),
                        Titulo = reader["Titulo"].ToString(),
                        Autor = reader["Autor"].ToString(),
                        Condicion = reader["Condicion"].ToString(),
                        Categoria = reader["Categoria"].ToString(),
                        Precio = Convert.ToDecimal(reader["Precio"]),
                        ImagenUrl = reader["ImagenUrl"].ToString(),
                        Vendedor = reader["Vendedor"].ToString()
                    });
                }
            }

            return libros;
        }

        protected void rptLibros_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Sinopsis")
            {
                string libroId = e.CommandArgument.ToString();
                CargarSinopsis(libroId);
            }
        }

        private void CargarSinopsis(string libroId)
        {
            string query = "SELECT Descripcion FROM Libro WHERE Id = @Id";

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
                        lblSinopsis.Text = reader["Descripcion"].ToString();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "SinopsisModal", "mostrarModalSinopsis();", true);
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error al cargar la sinopsis: {ex.Message}");
                }
            }
        }

        private class Libro
        {
            public string Id { get; set; }
            public string Titulo { get; set; }
            public string Autor { get; set; }
            public string Condicion { get; set; }
            public string Categoria { get; set; }
            public decimal Precio { get; set; }
            public string ImagenUrl { get; set; }
            public string Vendedor { get; set; }
        }
    }
}
