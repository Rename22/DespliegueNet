<%@ Page Title="Listar Auditorías" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListarAuditorias.aspx.cs" Inherits="Ejercicio_2.ListarAuditorias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h1 class="text-center mb-4">Listar Auditorías</h1>
        <a href="AgregarAuditoria.aspx" class="btn btn-success mb-3">Crear Nueva Auditoría</a>
        <asp:GridView ID="GridViewAuditorias" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" OnRowCommand="GridViewAuditorias_RowCommand">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" />
                <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="Objetivo" HeaderText="Objetivo" />
                <asp:BoundField DataField="Responsable" HeaderText="Responsable" />
                <asp:BoundField DataField="Conclusion" HeaderText="Conclusión" />
                <asp:BoundField DataField="Costo" HeaderText="Costo" DataFormatString="{0:C}" />
                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <a href='EditarAuditoria.aspx?ID=<%# Eval("ID") %>' class="btn btn-warning btn-sm">Editar</a>
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="Eliminar" CommandArgument='<%# Eval("ID") %>' CssClass="btn btn-danger btn-sm" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
      <script src="https://cdn.jsdelivr.net/npm/izitoast/dist/js/iziToast.min.js"></script>
</asp:Content>
