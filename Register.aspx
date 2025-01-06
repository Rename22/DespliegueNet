<%@ Page Title="Registro de Usuario" Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Ejercicio_2.Register" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <title>Registro de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation/dist/jquery.validate.min.js"></script>
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10 col-sm-12">
                    <h1 class="text-center mb-4">Registro de Usuario</h1>
                    <div class="p-4 border rounded-3 bg-light shadow">
                        <!-- Mensajes de error individuales -->
                        <asp:Label ID="lblCedulaError" runat="server" CssClass="text-danger"></asp:Label>
                        <asp:Label ID="lblTelefonoError" runat="server" CssClass="text-danger"></asp:Label>
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

                        <div class="row">
                            <!-- Columna izquierda -->
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="nombre" class="form-label">Nombre</label>
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Placeholder="Nombre" MaxLength="50" OnBlur="this.value = capitalizeSentence(this.value);" />
                                </div>
                                <div class="mb-3">
                                    <label for="apellido" class="form-label">Apellido</label>
                                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" Placeholder="Apellido" MaxLength="50" OnBlur="this.value = capitalizeSentence(this.value);" />
                                </div>
                                <div class="mb-3">
                                    <label for="cedula" class="form-label">Cédula</label>
                                    <asp:TextBox ID="txtCedula" runat="server" CssClass="form-control" Placeholder="Cédula" MaxLength="10" OnKeyPress="return isNumberKey(event);" />
                                </div>
                                <div class="mb-3">
                                    <label for="direccion" class="form-label">Dirección</label>
                                    <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" Placeholder="Dirección"></asp:TextBox>
                                </div>
                            </div>

                            <!-- Columna derecha -->
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="telefono" class="form-label">Teléfono</label>
                                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" Placeholder="Teléfono" MaxLength="10" OnKeyPress="return isNumberKey(event);" />
                                </div>
                                <div class="mb-3">
                                    <label for="correo" class="form-label">Correo Electrónico</label>
                                    <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" TextMode="Email" Placeholder="Correo Electrónico"></asp:TextBox>
                                </div>
                                <div class="mb-3">
                                    <label for="contrasena" class="form-label">Contraseña</label>
                                    <asp:TextBox ID="txtContrasena" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Contraseña"></asp:TextBox>
                                </div>
                                <div class="mb-3">
                                    <label for="confirmar_contrasena" class="form-label">Confirmar Contraseña</label>
                                    <asp:TextBox ID="txtConfirmarContrasena" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Confirmar Contraseña"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- Botones -->
                        <div class="text-center mt-4">
                            <asp:Button ID="btnRegister" runat="server" Text="Registrarse" CssClass="btn btn-primary me-2" OnClick="btnRegister_Click" />
                            <a href="Login.aspx" class="btn btn-danger">Cancelar</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        // Función para validar solo números
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            return charCode >= 48 && charCode <= 57;
        }

        // Función para convertir texto a tipo oración
        function capitalizeSentence(value) {
            return value.toLowerCase().replace(/(^|\s)\S/g, function (letter) {
                return letter.toUpperCase();
            });
        }
    </script>
</body>
</html>
