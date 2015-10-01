<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CineQuilla.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Welcome, please log in.
    <br />
    <asp:Label ID="Label1" runat="server" Text="Username: "></asp:Label>
    <asp:TextBox ID="UsernameBox" runat="server"></asp:TextBox>
    <br />
    <asp:Label ID="Label2" runat="server" Text="Password: "></asp:Label>
    <asp:TextBox ID="PasswordBox" runat="server" TextMode="Password"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="LoginButton" runat="server" Text="Login" OnClick="LoginButton_Click" />
    <br />
    <asp:Label ForeColor="Red" Visible="false" ID="LoginError" runat="server" Text="Login error, please try again."></asp:Label>
</asp:Content>
