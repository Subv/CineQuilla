<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CineQuilla.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login_box">
        <asp:Image ID="Image1" class="login_image" runat="server" ImageUrl="~/Resources/logo.jpg" Width="175" Height="100" />
        <br />
        <div class="login_data">
            <asp:Label ForeColor="Red" Visible="false" ID="LoginError" runat="server" Text="Login error, please try again."></asp:Label>
            <br />
            <asp:Label AssociatedControlID="UsernameBox" ID="Label1" runat="server" Text="Username: "></asp:Label>
            <br />
            <asp:TextBox ID="UsernameBox" runat="server"></asp:TextBox>
            <br />
            <asp:Label AssociatedControlID="PasswordBox" ID="Label2" runat="server" Text="Password: "></asp:Label>
            <br />
            <asp:TextBox ID="PasswordBox" runat="server" TextMode="Password"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="LoginButton" class="login_button" runat="server" Text="Login" OnClick="LoginButton_Click" />
        </div>
    </div>
</asp:Content>
