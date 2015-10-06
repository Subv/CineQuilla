<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Statistics.aspx.cs" Inherits="CineQuilla.Statistics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="ErrorLabel" Text="Something went wrong"></asp:Label>
    <br />
    Top 10 peliculas mas vistas: <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="NoPopularMovies" Text="Nada que mostrar"></asp:Label>
    <asp:GridView ID="MostViewedMoviesGrid" runat="server"></asp:GridView>
</asp:Content>
