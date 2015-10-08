<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageTransactions.aspx.cs" Inherits="CineQuilla.ManageTransactions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Transacciones: <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="ErrorLabel" Text="Something went wrong"></asp:Label>
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="NoTransactions" Text="No hay transacciones"></asp:Label>
    <br />
    <asp:GridView ID="TransactionsTable" runat="server" DataKeyNames="id" OnRowCommand="TransactionsTable_OnRowCommand" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="Id" />
            <asp:BoundField DataField="date" HeaderText="Fecha" />
            <asp:BoundField DataField="client_id" HeaderText="Id Cliente" />
            <asp:BoundField DataField="client_name" HeaderText="Nombre Cliente" />
            <asp:BoundField DataField="cashier_id" HeaderText="Id Cajero" />
            <asp:BoundField DataField="cashier_name" HeaderText="Nombre Cajero" />
            <asp:BoundField DataField="quantity" HeaderText="Cantidad de boletas" />
            <asp:BoundField DataField="amount" HeaderText="Pago Total" />
            <asp:BoundField DataField="payment_method" HeaderText="Metodo de pago" />
            <asp:BoundField DataField="debit_number" HeaderText="Tarjeta Debito" />
            <asp:BoundField DataField="points_card_id" HeaderText="Tarjeta CineQuilla" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="false" CommandName="DeleteTransaction"
                        Text="Eliminar Transaccion" CommandArgument='<%# Eval("id") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
