<%@ Page Title="Reporte de Ventas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ventas.aspx.cs" Inherits="Ejercicio_2.Ventas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h2 class="text-center text-primary mb-4">Reporte de Ventas</h2>

        <!-- Campo de búsqueda -->
        <div class="mb-3">
            <input type="text" id="filtro" class="form-control" placeholder="Buscar en el reporte...">
        </div>

        <!-- Tabla de ventas -->
        <asp:Repeater ID="rptVentas" runat="server">
            <HeaderTemplate>
                <table class="table table-striped table-hover table-bordered mt-4" id="tabla-reporte">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>Libro</th>
                            <th>Precio</th>
                            <th>Comprador</th>
                            <th>Lugar de Encuentro</th>
                            <th>Fecha</th>
                            <th>Hora</th>
                        </tr>
                    </thead>
                    <tbody class="text-center align-middle">
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("Titulo") %></td>
                    <td class="text-success fw-bold">$<%# Eval("Precio") %></td>
                    <td class="text-dark"><%# Eval("Comprador") %></td>
                    <td class="text-muted"><%# Eval("LugarEncuentro") %></td>
                    <td><%# Eval("FechaEncuentro") %></td>
                    <td><%# Eval("HoraEncuentro") %></td>
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
            const tabla = document.getElementById('tabla-reporte');
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
