<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FinalPurchase.aspx.cs" Inherits="CineQuilla.FinalPurchase" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="Label2" runat="server" Text="Cedula cliente: "></asp:Label>
    <asp:TextBox ID="ClientID" runat="server" TextMode="Number"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ClientID" ErrorMessage="Por favor digite la cedula del cliente"></asp:RequiredFieldValidator>
    <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="ClientID" ErrorMessage="El cliente no existe, por favor <a href='/RegisterClient.aspx'>registrelo</a>"></asp:CustomValidator>
    <br />
    <asp:Label ID="Label3" runat="server" Text="Precio a pagar: "></asp:Label>
    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Session["PurchasePrice"] %>' Enabled="false"></asp:TextBox>
    <br />
    <asp:Label ID="Label1" runat="server" Text="Metodo de pago"></asp:Label>
    <asp:DropDownList ID="PaymentMethod" runat="server">
        <asp:ListItem Value="1">Tarjeta debito</asp:ListItem>
        <asp:ListItem Value="2">Tarjeta CineQuilla</asp:ListItem>
    </asp:DropDownList>
</asp:Content>
