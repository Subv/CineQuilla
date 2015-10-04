<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FinalPurchase.aspx.cs" Inherits="CineQuilla.FinalPurchase" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="ErrorLabel" Text="Something went wrong"></asp:Label>
    <br />
    <asp:Label ID="Label2" runat="server" Text="Cedula cliente: "></asp:Label>
    <asp:TextBox ID="ClientID" runat="server" TextMode="Number"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ClientID" ErrorMessage="Por favor digite la cedula del cliente"></asp:RequiredFieldValidator>
    <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="ClientID" ErrorMessage="El cliente no existe, por favor <a href='/RegisterClient.aspx' target='_blank'>registrelo</a>" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
    <br />
    <asp:Label ID="Label3" runat="server" Text="Precio a pagar: "></asp:Label>
    <asp:TextBox ID="PriceToPayBox" runat="server" Enabled="false"></asp:TextBox>
    <br />
    <asp:Label ID="Label1" runat="server" Text="Metodo de pago"></asp:Label>
    <asp:DropDownList ID="PaymentMethod" CausesValidation="false" runat="server">
        <asp:ListItem Value="1">Tarjeta debito</asp:ListItem>
        <asp:ListItem Value="2">Tarjeta CineQuilla</asp:ListItem>
    </asp:DropDownList><asp:Button ID="Button2" runat="server" CausesValidation="false" Text="Update" OnClick="Button2_Click" />
    <asp:CustomValidator ID="CustomValidator3" runat="server" ControlToValidate="PaymentMethod" ErrorMessage="Invalid payment method" OnServerValidate="CustomValidator3_ServerValidate"></asp:CustomValidator>
    <br />
    <div id="PayWithDebit" runat="server" visible="false">
        <asp:Label ID="Label4" runat="server" Text="Debit card number: "></asp:Label>
        <asp:TextBox ID="DebitCardNumber" runat="server" TextMode="Number"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="DebitCardNumber" runat="server" ErrorMessage="Please enter a debit card number"></asp:RequiredFieldValidator>
    </div>
    <div id="PayWithPoints" runat="server" visible="false">
        <asp:Label ID="Label5" runat="server" Text="CineQuilla card: "></asp:Label>
        <asp:TextBox ID="CineQuillaCard" runat="server" TextMode="Number"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="CineQuillaCard" runat="server" ErrorMessage="Please enter a CineQuilla card number"></asp:RequiredFieldValidator>
        <asp:CustomValidator ID="CustomValidator2" ControlToValidate="CineQuillaCard" runat="server" ErrorMessage="La tarjeta indicada no existe o no le pertenece a ese cliente." OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
    </div>
    <br />
    <asp:Button ID="Button1" runat="server" Text="Pay" OnClick="Button1_Click" />
</asp:Content>
