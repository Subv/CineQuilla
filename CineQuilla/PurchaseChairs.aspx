<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PurchaseChairs.aspx.cs" Inherits="CineQuilla.PurchaseChairs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="ErrorLabel" Text="Something went wrong"></asp:Label>
    <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="NoSelectionLabel" Text="Please select at least one chair"></asp:Label>
    <br />
    <asp:Label ID="Label1" runat="server" Text="Available chairs for this showroom: "></asp:Label>
    <asp:Table ID="ChairsTable" runat="server"></asp:Table>
    <br />
    <asp:Button ID="Button1" runat="server" Text="Buy" OnClick="Button1_Click" />
</asp:Content>
