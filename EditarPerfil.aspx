<%@ Page Title="Editar Perfil" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditarPerfil.aspx.cs" Inherits="TuProyecto.EditarPerfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="text-center mb-4">Editar Perfil</h1>
    <div class="mb-3">
        <label for="txtNombre" class="form-label">Nombre</label>
        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
    </div>
    <div class="mb-3">
        <label for="txtDescripcion" class="form-label">Descripción</label>
        <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
    </div>
    <div class="mb-3">
        <label for="ddlIdioma" class="form-label">Idioma</label>
        <asp:DropDownList ID="ddlIdioma" runat="server" CssClass="form-select">
            <asp:ListItem Text="Español" Value="Español"></asp:ListItem>
            <asp:ListItem Text="Inglés" Value="Inglés"></asp:ListItem>
        </asp:DropDownList>
    </div>
    <div class="mb-3">
        <label for="txtFechaCaducidad" class="form-label">Fecha de Caducidad</label>
        <asp:TextBox ID="txtFechaCaducidad" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
    </div>
    <div class="mb-3">
        <label for="txtCreador" class="form-label">Creador</label>
        <asp:TextBox ID="txtCreador" runat="server" CssClass="form-control"></asp:TextBox>
    </div>
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />

    
    <link href="https://cdn.jsdelivr.net/npm/izitoast/dist/css/iziToast.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/izitoast/dist/js/iziToast.min.js"></script>
</asp:Content>
