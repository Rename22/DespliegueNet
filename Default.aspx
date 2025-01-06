<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Ejercicio_2.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h1 class="text-center text-primary mb-4">Bienvenido, <%= Session["usuario_nombre"] ?? "Usuario" %>!</h1>

        <!-- Formulario de Filtros -->
        <div class="mb-4 p-3 bg-light rounded shadow-sm">
            <asp:Panel ID="PanelFiltros" runat="server">
                <div class="row g-3">
                    <!-- Buscar por título o autor -->
                    <div class="col-md-3">
                        <asp:TextBox ID="txtBusqueda" runat="server" CssClass="form-control" Placeholder="Buscar por título o autor"></asp:TextBox>
                    </div>

                    <!-- Filtrar por categoría -->
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Todas las categorías" Value="" />
                            <asp:ListItem Text="Ficción" Value="Ficción" />
                            <asp:ListItem Text="No Ficción" Value="No Ficción" />
                            <asp:ListItem Text="Fantasía" Value="Fantasía" />
                            <asp:ListItem Text="Ciencia Ficción" Value="Ciencia Ficción" />
                            <asp:ListItem Text="Romance" Value="Romance" />
                            <asp:ListItem Text="Misterio" Value="Misterio" />
                            <asp:ListItem Text="Historia" Value="Historia" />
                            <asp:ListItem Text="Biografía" Value="Biografía" />
                            <asp:ListItem Text="Infantil" Value="Infantil" />
                            <asp:ListItem Text="Autoayuda" Value="Autoayuda" />
                            <asp:ListItem Text="Otros" Value="Otros" />
                        </asp:DropDownList>
                    </div>

                    <!-- Filtrar por precio mínimo -->
                    <div class="col-md-2">
                        <asp:TextBox ID="txtPrecioMin" runat="server" CssClass="form-control" Placeholder="Precio mínimo"></asp:TextBox>
                    </div>

                    <!-- Filtrar por precio máximo -->
                    <div class="col-md-2">
                        <asp:TextBox ID="txtPrecioMax" runat="server" CssClass="form-control" Placeholder="Precio máximo"></asp:TextBox>
                    </div>

                    <!-- Botón de filtrar -->
                    <div class="col-md-2">
                        <asp:Button ID="btnFiltrar" runat="server" CssClass="btn btn-primary w-100" Text="Filtrar" OnClick="FiltrarLibros" />
                    </div>
                </div>
            </asp:Panel>
        </div>

        <!-- Lista de Libros -->
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4" id="contenedorLibros">
            <asp:Repeater ID="rptLibros" runat="server" OnItemCommand="rptLibros_ItemCommand">
                <ItemTemplate>
                    <div class="col">
                        <div class="card shadow-sm h-100 border-0">
                            <img src='<%# Eval("ImagenUrl") %>' alt='<%# Eval("Titulo") %>' class="card-img-top img-fluid rounded-top" style="height: 200px; object-fit: contain;" />
                            <div class="card-body text-center">
                                <h5 class="card-title text-truncate text-primary"><%# Eval("Titulo") %></h5>
                                <p class="card-text"><strong>Autor:</strong> <%# Eval("Autor") %></p>
                                <p class="card-text"><strong>Estado:</strong> <%# Eval("Condicion") %></p>
                                <p class="card-text"><strong>Categoría:</strong> <%# Eval("Categoria") %></p>
                                <p class="card-text text-success"><strong>Precio:</strong> $<%# Eval("Precio") %></p>
                                <p class="card-text"><strong>Vendedor:</strong> <%# Eval("Vendedor") %></p>
                            </div>
                            <div class="card-footer text-center bg-light">
                                <!-- Botón Sinopsis -->
                                <asp:Button ID="btnSinopsis" runat="server" CssClass="btn btn-info btn-sm" CommandName="Sinopsis" CommandArgument='<%# Eval("Id") %>' Text="Sinopsis" />
                                <a href="ComprarLibro.aspx?libroId=<%# Eval("Id") %>" class="btn btn-success btn-sm">Comprar</a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- Modal para Sinopsis -->
    <div class="modal fade" id="sinopsisModal" tabindex="-1" aria-labelledby="sinopsisModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="sinopsisModalLabel">Sinopsis</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblSinopsis" runat="server" Text=""></asp:Label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Mostrar el modal de Sinopsis
        function mostrarModalSinopsis() {
            const modal = new bootstrap.Modal(document.getElementById('sinopsisModal'));
            modal.show();
        }
    </script>
</asp:Content>
