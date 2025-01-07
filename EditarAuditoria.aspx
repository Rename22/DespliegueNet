<%@ Page Title="Editar Auditoría" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditarAuditoria.aspx.cs" Inherits="Ejercicio_2.EditarAuditoria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="text-center mb-4">Editar Auditoría</h1>
    <div class="mb-3">
        <label for="txtFecha" class="form-label">Fecha</label>
        <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
    </div>
    <div class="mb-3">
        <label for="txtObjetivo" class="form-label">Objetivo</label>
        <asp:TextBox ID="txtObjetivo" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
    </div>
    <div class="mb-3">
        <label for="txtResponsable" class="form-label">Responsable</label>
        <asp:TextBox ID="txtResponsable" runat="server" CssClass="form-control"></asp:TextBox>
    </div>
    <div class="mb-3">
        <label for="ddlConclusion" class="form-label">Conclusión</label>
        <asp:DropDownList ID="ddlConclusion" runat="server" CssClass="form-select">
            <asp:ListItem Text="Aprobada" Value="Aprobada"></asp:ListItem>
            <asp:ListItem Text="No Aprobada" Value="No Aprobada"></asp:ListItem>
        </asp:DropDownList>
    </div>
    <div class="mb-3">
        <label for="txtRecomendacion" class="form-label">Recomendación</label>
        <asp:TextBox ID="txtRecomendacion" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
    </div>
    <div class="mb-3">
        <label for="txtCosto" class="form-label">Costo</label>
        <asp:TextBox ID="txtCosto" runat="server" CssClass="form-control" placeholder="Ingrese un valor decimal"></asp:TextBox>
    </div>
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
        <script>
        document.addEventListener("DOMContentLoaded", function () {
            const txtCosto = document.getElementById('<%= txtCosto.ClientID %>');

        txtCosto.addEventListener('input', function (e) {
            this.value = this.value.replace(/[^0-9,]/g, ''); 
        });
    });
        </script>

<link href="https://cdn.jsdelivr.net/npm/izitoast/dist/css/iziToast.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/izitoast/dist/js/iziToast.min.js"></script>

</asp:Content>
