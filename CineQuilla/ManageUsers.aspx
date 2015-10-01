<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="CineQuilla.ManageUsers" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Usuarios: <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="ErrorLabel" Text="Something went wrong"></asp:Label>
    <br />
    <asp:Label Visible="false" ForeColor="Green" runat="server" ID="UserAddedMessage" Text="Usuario añadido correctamente"></asp:Label>
    <asp:GridView ID="UsersTable" runat="server" DataKeyNames="id" OnRowCommand="UsersTable_OnRowCommand" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="Id"/>
            <asp:BoundField DataField="username" HeaderText="Username" />
            <asp:BoundField DataField="first_name" HeaderText="Nombre" />
            <asp:BoundField DataField="last_name" HeaderText="Apellido" />
            <asp:BoundField DataField="permission_level" HeaderText="Nivel" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="false" CommandName="DeleteUser"
                        Text="Eliminar Usuario" CommandArgument='<%# Eval("id") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <br />
    <asp:Button ID="Button3" runat="server" Text="Add new user" OnClick="Button3_Click" />
    <div id="AddNewUserDiv" runat="server" visible="false">
        Nuevo Usuario: <br />
        <asp:Label ID="Label1" runat="server" Text="Username: "></asp:Label>
        <asp:TextBox ID="UsernameBox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="UsernameValidator" ControlToValidate="UsernameBox" runat="server" ErrorMessage="Please enter an username."></asp:RequiredFieldValidator>
        <asp:CustomValidator ID="UserExistenceValidator" ControlToValidate="UsernameBox" runat="server" ErrorMessage="That username already exists." OnServerValidate="UserExistenceValidator_ServerValidate"></asp:CustomValidator>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Password: "></asp:Label>
        <asp:TextBox ID="PasswordBox" runat="server" TextMode="Password"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="PasswordBox" runat="server" ErrorMessage="Please enter a password"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label3" runat="server" Text="First Name: "></asp:Label>
        <asp:TextBox ID="FNameBox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="FNameBox" runat="server" ErrorMessage="Please enter a first name"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label4" runat="server" Text="Last Name: "></asp:Label>
        <asp:TextBox ID="LNameBox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="LNameBox" runat="server" ErrorMessage="Please enter a last name"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label5" runat="server" Text="Permission Level: "></asp:Label>
        <select id="PermissionLevelSelect" runat="server">
            <option value="1">Cashier</option>
            <option value="2">Administrator</option>
        </select>
        <br />
        <asp:Button ID="Button2" runat="server" Text="Create User" OnClick="Button2_Click" />
    </div>
</asp:Content>
