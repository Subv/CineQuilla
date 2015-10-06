<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SellCards.aspx.cs" Inherits="CineQuilla.SellCards" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="ErrorLabel" Text="Something went wrong"></asp:Label>
    <br />
    <asp:Label Visible="false" ForeColor="Green" runat="server" ID="SuccessLabel" Text=""></asp:Label>
    <br />
    Comprar tarjeta CineQuilla:
    <br />
    <asp:Label ID="Label1" runat="server" Text="Cedula del cliente: "></asp:Label>
    <asp:TextBox ID="ClientID" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ClientID" ErrorMessage="Por favor digite la cedula del cliente"></asp:RequiredFieldValidator>
    <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="ClientID" ErrorMessage="El cliente no existe, por favor <a href='/RegisterClient.aspx' target='_blank'>registrelo</a>" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
    <br />
    <asp:Button ID="Button1" runat="server" Text="Comprar" OnClick="Button1_Click" />
</asp:Content>
