<%@ Page Title="Iniciar Sesión" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Ejercicio_2.Login" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <title>Iniciar Sesión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-lg-6 col-md-8 col-sm-12">
                    <h1 class="text-center mb-4">Iniciar Sesión</h1>
                    <div class="p-4 border rounded-3 bg-light shadow">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
                        <div class="mb-3">
                            <label for="correo" class="form-label">Correo Electrónico</label>
                            <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" Placeholder="Ingresa tu correo"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="contrasena" class="form-label">Contraseña</label>
                            <asp:TextBox ID="txtContrasena" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Ingresa tu contraseña"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnLogin" runat="server" Text="Iniciar Sesión" CssClass="btn btn-success w-100" OnClick="btnLogin_Click" />
                    </div>
                    <p class="text-center mt-3">
                        ¿No tienes una cuenta? <a href="Register.aspx">Regístrate aquí</a>.
                    </p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
