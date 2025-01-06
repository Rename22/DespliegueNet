<%@ Page Title="Agregar Libro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarLibro.aspx.cs" Inherits="Ejercicio_2.AgregarLibro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white text-center">
                        <h3>Agregar Libro</h3>
                    </div>
                    <div class="card-body">
                        <asp:Panel ID="panelAgregar" runat="server">
                            <div class="form-group mb-3">
                                <label for="txtTitulo">Título:</label>
                                <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group mb-3">
                                <label for="txtAutor">Autor:</label>
                                <asp:TextBox ID="txtAutor" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group mb-3">
                                <label for="txtDescripcion">Descripción:</label>
                                <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
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
                                <label for="fileImagen">Imagen:</label>
                                <asp:FileUpload ID="fileImagen" runat="server" CssClass="form-control" />
                                <img id="previewImage" src="#" alt="Vista previa de la imagen" style="width: 100%; max-height: 200px; object-fit: contain; display: none;" />
                            </div>
                            <div class="form-group">
                                <asp:Button ID="btnAgregar" runat="server" Text="Agregar Libro" CssClass="btn btn-success w-100" OnClick="btnAgregar_Click" />
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

    <!-- Script para vista previa de la imagen -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const fileInput = document.getElementById('<%= fileImagen.ClientID %>');
            const previewImage = document.getElementById('previewImage');

            fileInput.addEventListener('change', function (event) {
                const file = event.target.files[0];

                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        previewImage.src = e.target.result;
                        previewImage.style.display = 'block';
                    };
                    reader.readAsDataURL(file);
                } else {
                    previewImage.src = '';
                    previewImage.style.display = 'none';
                }
            });
        });

        // Probar si iziToast está disponible
        if (typeof iziToast !== "undefined") {
            console.log("iziToast cargado correctamente.");
        } else {
            console.error("iziToast no está disponible.");
        }
    </script>
</asp:Content>
