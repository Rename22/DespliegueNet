<%@ Page Title="Agregar Auditoría" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarAuditoria.aspx.cs" Inherits="Ejercicio_2.AgregarAuditoria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="text-center mb-4">Agregar Auditoría</h1>
    <asp:ValidationSummary ID="ValidationSummary" runat="server" CssClass="alert alert-danger" HeaderText="Por favor, corrija los siguientes errores:" />

    <div class="mb-3">
        <label for="txtFecha" class="form-label">Fecha</label>
        <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvFecha" runat="server" ControlToValidate="txtFecha" ErrorMessage="La fecha es obligatoria." CssClass="text-danger" />
    </div>
    <div class="mb-3">
        <label for="txtObjetivo" class="form-label">Objetivo</label>
        <asp:TextBox ID="txtObjetivo" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvObjetivo" runat="server" ControlToValidate="txtObjetivo" ErrorMessage="El objetivo es obligatorio." CssClass="text-danger" />
    </div>
    <div class="mb-3">
        <label for="txtResponsable" class="form-label">Responsable</label>
        <asp:TextBox ID="txtResponsable" runat="server" CssClass="form-control"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvResponsable" runat="server" ControlToValidate="txtResponsable" ErrorMessage="El responsable es obligatorio." CssClass="text-danger" />
    </div>
    <div class="mb-3">
        <label for="ddlConclusion" class="form-label">Conclusión</label>
        <asp:DropDownList ID="ddlConclusion" runat="server" CssClass="form-select">
            <asp:ListItem Text="Seleccione una opción" Value="" />
            <asp:ListItem Text="Aprobada" Value="Aprobada" />
            <asp:ListItem Text="No Aprobada" Value="No Aprobada" />
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvConclusion" runat="server" ControlToValidate="ddlConclusion" InitialValue="" ErrorMessage="Debe seleccionar una conclusión." CssClass="text-danger" />
    </div>
    <div class="mb-3">
        <label for="txtRecomendacion" class="form-label">Recomendación</label>
        <asp:TextBox ID="txtRecomendacion" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvRecomendacion" runat="server" ControlToValidate="txtRecomendacion" ErrorMessage="La recomendación es obligatoria." CssClass="text-danger" />
    </div>
    <div class="mb-3">
        <label for="txtCosto" class="form-label">Costo</label>
        <asp:TextBox ID="txtCosto" runat="server" CssClass="form-control"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvCosto" runat="server" ControlToValidate="txtCosto" ErrorMessage="El costo es obligatorio." CssClass="text-danger" />
        <asp:RegularExpressionValidator ID="revCosto" runat="server" ControlToValidate="txtCosto" ErrorMessage="Ingrese un valor decimal válido." ValidationExpression="^\d+(\.\d{1,2})?$" CssClass="text-danger" />
    </div>

    <div class="d-flex justify-content-between">
        <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClick="btnCancelar_Click" />
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const txtCosto = document.getElementById('<%= txtCosto.ClientID %>');

            txtCosto.addEventListener('input', function (e) {
                this.value = this.value.replace(/[^0-9.]/g, ''); // Permite solo números y punto decimal
            });
        });
    </script>

    <link href="https://cdn.jsdelivr.net/npm/izitoast/dist/css/iziToast.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/izitoast/dist/js/iziToast.min.js"></script>
</asp:Content>
