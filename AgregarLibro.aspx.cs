using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Ejercicio_2
{
    public partial class AgregarLibro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario_id"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            string usuarioId = Session["usuario_id"].ToString();
            string titulo = txtTitulo.Text.Trim();
            string autor = txtAutor.Text.Trim();
            string descripcion = txtDescripcion.Text.Trim();
            decimal precio;
            if (!decimal.TryParse(txtPrecio.Text.Trim(), out precio))
            {
                MostrarAlerta("Error", "El precio ingresado no es válido.");
                return;
            }

            string condicion = ddlCondicion.SelectedValue;
            string categoria = ddlCategoria.SelectedValue;
            string imagenPath = "";

            // Validar y guardar la imagen
            if (fileImagen.HasFile)
            {
                string uploadFolder = Server.MapPath("~/Images/");
                imagenPath = $"Images/{fileImagen.FileName}";
                fileImagen.SaveAs(uploadFolder + fileImagen.FileName);
            }

            string connectionString = ConfigurationManager.ConnectionStrings["conexionLibreria"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Libro 
                                 (Titulo, Autor, Descripcion, Precio, Condicion, Categoria, Imagen, VendedorId) 
                                 VALUES 
                                 (@Titulo, @Autor, @Descripcion, @Precio, @Condicion, @Categoria, @Imagen, @VendedorId)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Titulo", titulo);
                command.Parameters.AddWithValue("@Autor", autor);
                command.Parameters.AddWithValue("@Descripcion", descripcion);
                command.Parameters.AddWithValue("@Precio", precio);
                command.Parameters.AddWithValue("@Condicion", condicion);
                command.Parameters.AddWithValue("@Categoria", categoria);
                command.Parameters.AddWithValue("@Imagen", imagenPath);
                command.Parameters.AddWithValue("@VendedorId", usuarioId);

                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();

                    // Mostrar alerta y redirigir
                    MostrarAlerta("Éxito", "Libro agregado correctamente.", true);
                }
                catch (Exception ex)
                {
                    MostrarAlerta("Error", $"Error al agregar el libro: {ex.Message}");
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
                        {(redirigir ? "setTimeout(function() { window.location.href = 'Productos.aspx'; }, 500);" : "")}
                    }}
                }});
            ";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ToastMessage", script, true);
        }

    }
}
