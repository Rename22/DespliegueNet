<%@ Page Title="Listar Perfiles" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListarPerfiles.aspx.cs" Inherits="Ejercicio_2.ListarPerfiles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h1 class="text-center mb-4">Listar Perfiles</h1>
        <a href="AgregarPerfil.aspx" class="btn btn-success mb-3">Crear Nuevo Perfil</a>
        <asp:GridView ID="GridViewPerfiles" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" OnRowCommand="GridViewPerfiles_RowCommand">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="ID" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="Idioma" HeaderText="Idioma" />
                <asp:BoundField DataField="FechaCaducidad" HeaderText="Fecha Caducidad" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="Creador" HeaderText="Creador" />
                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <a href='EditarPerfil.aspx?Id=<%# Eval("Id") %>' class="btn btn-warning btn-sm">Editar</a>
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-danger btn-sm" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/izitoast/dist/js/iziToast.min.js"></script>
</asp:Content>
