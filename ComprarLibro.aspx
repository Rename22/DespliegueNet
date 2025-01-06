<%@ Page Title="Comprar Libro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ComprarLibro.aspx.cs" Inherits="Ejercicio_2.ComprarLibro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white text-center">
                        <h3>Comprar "<asp:Label ID="lblTitulo" runat="server"></asp:Label>"</h3>
                    </div>
                    <div class="card-body">
                        <p class="text-center"><strong>Precio:</strong> $<asp:Label ID="lblPrecio" runat="server"></asp:Label></p>
                        <div class="mb-3">
                            <label for="txtLugarEncuentro" class="form-label">Lugar de Encuentro:</label>
                            <asp:TextBox ID="txtLugarEncuentro" runat="server" CssClass="form-control" Placeholder="Ej: Parque central"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtFechaEncuentro" class="form-label">Fecha de Encuentro:</label>
                            <asp:TextBox ID="txtFechaEncuentro" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtHoraEncuentro" class="form-label">Hora de Encuentro:</label>
                            <asp:TextBox ID="txtHoraEncuentro" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                        </div>
                        <div class="text-center">
                            <asp:Button ID="btnConfirmarCompra" runat="server" CssClass="btn btn-success" Text="Confirmar Compra" OnClick="btnConfirmarCompra_Click" />
                            <asp:Button ID="btnCancelar" runat="server" CssClass="btn btn-danger" Text="Cancelar" OnClientClick="return cancelarCompra();" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Script para manejar el botón Cancelar -->
    <script>
        function cancelarCompra() {
            // Confirmar si desea cancelar la operación y retroceder
            if (confirm("¿Estás seguro de que deseas cancelar la compra?")) {
                window.location.href = "Default.aspx";
                return false; // Prevenir el postback
            }
            return false; // Si no confirma, prevenir la acción
        }
    </script>
</asp:Content>
