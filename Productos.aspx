<%@ Page Title="Mis Publicaciones" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="Ejercicio_2.Productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h1 class="text-center text-primary mb-4">Mis Libros Publicados</h1>
        <div class="d-flex justify-content-between align-items-center mb-4">
            <input type="text" id="buscador" class="form-control w-50" placeholder="Buscar por título, autor o categoría..." onkeyup="filtrarLibros()" />
            <a href="AgregarLibro.aspx" class="btn btn-success">Agregar Nuevo Libro</a>
        </div>

        <div class="row" id="contenedorLibros">
            <asp:Repeater ID="rptLibros" runat="server" OnItemCommand="rptLibros_ItemCommand">
                <ItemTemplate>
                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4 libro-item">
                        <div class="card shadow-sm h-100 border-0">
                            <img src='<%# Eval("Imagen") %>' alt='<%# Eval("Titulo") %>' class="card-img-top img-fluid rounded-top" style="height: 200px; object-fit: contain;" />
                            <div class="card-body text-center">
                                <h5 class="card-title text-truncate text-primary"><%# Eval("Titulo") %></h5>
                                <p class="card-text"><strong>Autor:</strong> <%# Eval("Autor") %></p>
                                <p class="card-text"><strong>Estado:</strong> <%# Eval("Condicion") %></p>
                                <p class="card-text"><strong>Categoría:</strong> <%# Eval("Categoria") %></p>
                                <p class="card-text text-success"><strong>Precio:</strong> $<%# Eval("Precio") %></p>
                            </div>
                            <div class="card-footer text-center bg-light">
                                <asp:PlaceHolder ID="phVendido" runat="server" Visible='<%# Convert.ToBoolean(Eval("Vendido")) %>'>
                                    <span class="badge bg-success">Vendido</span>
                                </asp:PlaceHolder>
                                <asp:PlaceHolder ID="phEditable" runat="server" Visible='<%# !Convert.ToBoolean(Eval("Vendido")) %>'>
                                    <!-- Botón Editar -->
                                    <asp:Button ID="btnEditar" runat="server" CssClass="btn btn-primary btn-sm" CommandName="Editar" CommandArgument='<%# Eval("Id") %>' Text="Editar" />
                                    <!-- Botón Eliminar con confirmación -->
                                    <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-danger btn-sm" CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' Text="Eliminar" OnClientClick="return confirmarEliminacion();" />
                                </asp:PlaceHolder>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <script>
        // Función para mostrar confirmación antes de eliminar
        function confirmarEliminacion() {
            return confirm("¿Estás seguro de que deseas eliminar este libro?");
        }

        // Función para filtrar libros (por título, autor o categoría)
        function filtrarLibros() {
            const buscador = document.getElementById('buscador').value.toLowerCase();
            const libros = document.querySelectorAll('.libro-item');

            libros.forEach(libro => {
                const titulo = libro.querySelector('.card-title').textContent.toLowerCase();
                const autor = libro.querySelector('.card-text:nth-child(2)').textContent.toLowerCase();
                const categoria = libro.querySelector('.card-text:nth-child(4)').textContent.toLowerCase();

                if (titulo.includes(buscador) || autor.includes(buscador) || categoria.includes(buscador)) {
                    libro.style.display = '';
                } else {
                    libro.style.display = 'none';
                }
            });
        }
    </script>
</asp:Content>
