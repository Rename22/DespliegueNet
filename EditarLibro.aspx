<%@ Page Title="Editar Libro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditarLibro.aspx.cs" Inherits="Ejercicio_2.EditarLibro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white text-center">
                        <h3>Editar Libro</h3>
                    </div>
                    <div class="card-body">
                        <asp:Panel ID="panelEditar" runat="server">
                            <div class="form-group mb-3">
                                <label for="txtTitulo">Título:</label>
                                <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group mb-3">
                                <label for="txtAutor">Autor:</label>
                                <asp:TextBox ID="txtAutor" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group mb-3">
                                <label for="txtDescripcion">Sinopsis:</label>
                                <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group mb-3">
                                <label for="txtPrecio">Precio:</label>
                                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group mb-3">
                                <label for="ddlCondicion">Condición:</label>
                                <asp:DropDownList ID="ddlCondicion" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="Nuevo">Nuevo</asp:ListItem>
                                    <asp:ListItem Value="Usado">Usado</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group mb-3">
                                <label for="ddlCategoria">Categoría:</label>
                                <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="Ficción">Ficción</asp:ListItem>
                                    <asp:ListItem Value="No Ficción">No Ficción</asp:ListItem>
                                    <asp:ListItem Value="Fantasía">Fantasía</asp:ListItem>
                                    <asp:ListItem Value="Ciencia Ficción">Ciencia Ficción</asp:ListItem>
                                    <asp:ListItem Value="Romance">Romance</asp:ListItem>
                                    <asp:ListItem Value="Misterio">Misterio</asp:ListItem>
                                    <asp:ListItem Value="Historia">Historia</asp:ListItem>
                                    <asp:ListItem Value="Biografía">Biografía</asp:ListItem>
                                    <asp:ListItem Value="Infantil">Infantil</asp:ListItem>
                                    <asp:ListItem Value="Autoayuda">Autoayuda</asp:ListItem>
                                    <asp:ListItem Value="Otros">Otros</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group mb-3">
                                <label for="fileImagen">Imagen (opcional):</label>
                                <div style="display: flex; justify-content: center; align-items: center;">
                                    <!-- Vista previa de la imagen actual -->
                                    <asp:Image ID="currentImagePreview" runat="server" CssClass="img-fluid mb-2" AlternateText="Vista previa de imagen actual" Style="max-width: 100%; max-height: 200px; object-fit: contain;" />
                                </div>

                                <div>
                                    <!-- Vista previa de la nueva imagen -->
                                    <img id="newImagePreview" src="#" alt="Vista previa de nueva imagen" style="width: 100%; max-height: 200px; object-fit: contain; display: none;" />
                                </div>
                                <asp:FileUpload ID="fileImagen" runat="server" CssClass="form-control" />
                            </div>
                            <div class="form-group">
                                <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-success w-100" Text="Guardar Cambios" OnClick="btnGuardar_Click" />
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Cargar estilos y scripts directamente -->
    <link href="https://cdn.jsdelivr.net/npm/izitoast/dist/css/iziToast.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/izitoast/dist/js/iziToast.min.js"></script>

    <!-- Script para gestionar la vista previa -->
    <script>
        document.getElementById("<%= fileImagen.ClientID %>").addEventListener("change", function (event) {
            const fileInput = event.target;
            const file = fileInput.files[0];
            const currentPreview = document.getElementById("<%= currentImagePreview.ClientID %>");
            const newPreview = document.getElementById("newImagePreview");

            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    // Actualizar la nueva imagen
                    newPreview.src = e.target.result;
                    newPreview.style.display = "block";

                    // Ocultar la imagen actual
                    currentPreview.style.display = "none";
                };
                reader.readAsDataURL(file);
            } else {
                // Restaurar la imagen actual si no se selecciona una nueva
                newPreview.src = "#";
                newPreview.style.display = "none";
                currentPreview.style.display = "block";
            }
        });

        // Probar si iziToast está disponible
        if (typeof iziToast !== "undefined") {
            console.log("iziToast cargado correctamente.");
        } else {
            console.error("iziToast no está disponible.");
        }
    </script>
</asp:Content>
