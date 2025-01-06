<%@ Page Title="Solicitudes de Compra" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SolicitudesDeCompra.aspx.cs" Inherits="Ejercicio_2.SolicitudesDeCompra" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h2 class="text-center text-primary mb-4">Solicitudes de Compra</h2>

        <!-- Solicitudes Pendientes -->
        <h4 class="text-warning">Pendientes:</h4>
        <asp:Repeater ID="rptPendientes" runat="server" OnItemCommand="rptPendientes_ItemCommand">
            <HeaderTemplate>
                <table class="table table-striped table-hover table-bordered">
                    <thead class="table-warning text-center">
                        <tr>
                            <th>Libro</th>
                            <th>Precio</th>
                            <th>Comprador</th>
                            <th>Lugar</th>
                            <th>Fecha</th>
                            <th>Hora</th>
                            <th>Motivo</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody class="text-center align-middle">
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("Titulo") %></td>
                    <td>$<%# Eval("Precio") %></td>
                    <td><%# Eval("Comprador") %></td>
                    <td><%# Eval("LugarEncuentro") %></td>
                    <td><%# Eval("FechaEncuentro") %></td>
                    <td><%# Eval("HoraEncuentro") %></td>
                    <td>
                        <asp:TextBox ID="txtMotivoPendiente" runat="server" CssClass="form-control" Placeholder="Motivo del rechazo"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="btnAceptarPendiente" runat="server" CssClass="btn btn-success btn-sm" CommandName="Aceptar" CommandArgument='<%# Eval("Id") %>' Text="Aceptar" />
                        <asp:Button ID="btnRechazarPendiente" runat="server" CssClass="btn btn-danger btn-sm" CommandName="Rechazar" CommandArgument='<%# Eval("Id") %>' Text="Rechazar" />
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:Repeater>

        <!-- Solicitudes Aceptadas -->
        <h4 class="text-primary mt-5">Aceptadas:</h4>
        <asp:Repeater ID="rptAceptadas" runat="server" OnItemCommand="rptAceptadas_ItemCommand">
            <HeaderTemplate>
                <table class="table table-striped table-hover table-bordered">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>Libro</th>
                            <th>Precio</th>
                            <th>Comprador</th>
                            <th>Lugar</th>
                            <th>Fecha</th>
                            <th>Hora</th>
                            <th>Motivo</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody class="text-center align-middle">
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("Titulo") %></td>
                    <td>$<%# Eval("Precio") %></td>
                    <td><%# Eval("Comprador") %></td>
                    <td><%# Eval("LugarEncuentro") %></td>
                    <td><%# Eval("FechaEncuentro") %></td>
                    <td><%# Eval("HoraEncuentro") %></td>
                    <td>
                        <asp:TextBox ID="txtMotivoAceptada" runat="server" CssClass="form-control" Placeholder="Motivo del rechazo"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="btnCompletar" runat="server" CssClass="btn btn-success btn-sm" CommandName="Completar" CommandArgument='<%# Eval("Id") %>' Text="Completar" />
                        <asp:Button ID="btnCancelarAceptada" runat="server" CssClass="btn btn-danger btn-sm" CommandName="Cancelar" CommandArgument='<%# Eval("Id") %>' Text="Cancelar" />
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
