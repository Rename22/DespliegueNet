using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Ejercicio_2
{
    public partial class EditarLibro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario_id"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                string libroId = Request.QueryString["Id"];
                if (!string.IsNullOrEmpty(libroId))
                {
                    CargarLibro(libroId);
                }
            }
        }

        private void CargarLibro(string libroId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["conexionLibreria"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Libro WHERE Id = @Id";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Id", libroId);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        txtTitulo.Text = reader["Titulo"].ToString();
                        txtAutor.Text = reader["Autor"].ToString();
                        txtDescripcion.Text = reader["Descripcion"].ToString();
                        txtPrecio.Text = reader["Precio"].ToString();
                        ddlCondicion.SelectedValue = reader["Condicion"].ToString();
                        ddlCategoria.SelectedValue = reader["Categoria"].ToString();

                        if (!string.IsNullOrEmpty(reader["Imagen"].ToString()))
                        {
                            currentImagePreview.ImageUrl = $"/{reader["Imagen"]}";
                        }
                        else
                        {
                            currentImagePreview.Visible = false; // Ocultar si no hay imagen
                        }
                    }
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", script, true);
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string libroId = Request.QueryString["Id"];
            string titulo = txtTitulo.Text.Trim();
            string autor = txtAutor.Text.Trim();
            string descripcion = txtDescripcion.Text.Trim();
            decimal precio = decimal.Parse(txtPrecio.Text.Trim());
            string condicion = ddlCondicion.SelectedValue;
            string categoria = ddlCategoria.SelectedValue;
            string nuevaImagen = null;

            if (fileImagen.HasFile)
            {
                string uploadFolder = Server.MapPath("~/Images/");
                nuevaImagen = $"Images/{fileImagen.FileName}";
                fileImagen.SaveAs(uploadFolder + fileImagen.FileName);
            }

            string connectionString = ConfigurationManager.ConnectionStrings["conexionLibreria"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"UPDATE Libro 
                                 SET Titulo = @Titulo, Autor = @Autor, Descripcion = @Descripcion, 
                                     Precio = @Precio, Condicion = @Condicion, Categoria = @Categoria";

                if (!string.IsNullOrEmpty(nuevaImagen))
                {
                    query += ", Imagen = @Imagen";
                }

                query += " WHERE Id = @Id";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Titulo", titulo);
                command.Parameters.AddWithValue("@Autor", autor);
                command.Parameters.AddWithValue("@Descripcion", descripcion);
                command.Parameters.AddWithValue("@Precio", precio);
                command.Parameters.AddWithValue("@Condicion", condicion);
                command.Parameters.AddWithValue("@Categoria", categoria);

                if (!string.IsNullOrEmpty(nuevaImagen))
                {
                    command.Parameters.AddWithValue("@Imagen", nuevaImagen);
                }

                command.Parameters.AddWithValue("@Id", libroId);

                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();

                    string script = @"
                        iziToast.success({
                            title: 'Éxito',
                            message: 'El libro ha sido actualizado correctamente.',
                            position: 'topRight',
                            timeout: 3000,
                            onClosed: function() {
                                window.location.href = 'Productos.aspx';
                            }
                        });
                    ";
                    ClientScript.RegisterStartupScript(this.GetType(), "ToastMessage", script, true);
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", script, true);
                }
            }
        }
    }
}
