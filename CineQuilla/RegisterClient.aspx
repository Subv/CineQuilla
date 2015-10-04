<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterClient.aspx.cs" Inherits="CineQuilla.RegisterClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="ErrorLabel" Text="Something went wrong"></asp:Label>
    <br />
    Nuevo cliente: <br />
    <asp:Label ID="Label1" runat="server" Text="Cedula: "></asp:Label>
    <asp:TextBox ID="IDBox" runat="server" TextMode="Number"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="IDBox" runat="server" ErrorMessage="Por favor ingrese la cedula."></asp:RequiredFieldValidator>
    <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="IDBox" ErrorMessage="El cliente ya existe en el sistema." OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
    <br />
    <asp:Label ID="Label2" runat="server" Text="Nombre: "></asp:Label>
    <asp:TextBox ID="FNameBox" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="FNameBox" runat="server" ErrorMessage="Por favor ingrese el nombre."></asp:RequiredFieldValidator>
    <br />
    <asp:Label ID="Label3" runat="server" Text="Apellido: "></asp:Label>
    <asp:TextBox ID="LNameBox" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="LNameBox" runat="server" ErrorMessage="Por favor ingrese el apellido."></asp:RequiredFieldValidator>
    <br />
    <asp:Label ID="Label4" runat="server" Text="Email: "></asp:Label>
    <asp:TextBox ID="EMailBox" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="EMailBox" runat="server" ErrorMessage="Por favor ingrese el correo electronico."></asp:RequiredFieldValidator>
    <br />
    <asp:Button ID="Button1" runat="server" Text="Registrar" OnClick="Button1_Click" />
</asp:Content>
