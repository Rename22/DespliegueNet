<%@ Page Title="Mis Compras" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MisSolicitudes.aspx.cs" Inherits="Ejercicio_2.MisSolicitudes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h2 class="text-center text-primary mb-4">Mis Solicitudes de Compra</h2>

        <!-- Campo de búsqueda -->
        <div class="mb-3">
            <input type="text" id="filtro" class="form-control" placeholder="Buscar en las solicitudes...">
        </div>

        <!-- Tabla de solicitudes -->
        <asp:Repeater ID="rptSolicitudes" runat="server">
            <HeaderTemplate>
                <table class="table table-bordered mt-4" id="tabla-solicitudes">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>Libro</th>
                            <th>Precio</th>
                            <th>Vendedor</th>
                            <th>Lugar</th>
                            <th>Fecha</th>
                            <th>Hora</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody class="text-center align-middle">
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("Titulo") %></td>
                    <td>$<%# Eval("Precio") %></td>
                    <td><%# Eval("Vendedor") %></td>
                    <td><%# Eval("LugarEncuentro") %></td>
                    <td><%# Eval("FechaEncuentro") %></td>
                    <td><%# Eval("HoraEncuentro") %></td>
                    <td>
                        <asp:Literal runat="server" Text='<%# ObtenerEstado(Eval("Estado").ToString(), Eval("Motivo").ToString()) %>'></asp:Literal>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>

    <!-- Script para búsqueda en tiempo real -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const filtro = document.getElementById('filtro');
            const tabla = document.getElementById('tabla-solicitudes');
            const filas = tabla.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

            filtro.addEventListener('input', function () {
                const texto = filtro.value.toLowerCase();

                for (let fila of filas) {
                    const columnas = fila.getElementsByTagName('td');
                    let coincide = false;

                    for (let columna of columnas) {
                        if (columna.textContent.toLowerCase().includes(texto)) {
                            coincide = true;
                            break;
                        }
                    }

                    fila.style.display = coincide ? '' : 'none';
                }
            });
        });
    </script>
</asp:Content>
