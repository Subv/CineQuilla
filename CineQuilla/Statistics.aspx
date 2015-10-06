<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Statistics.aspx.cs" Inherits="CineQuilla.Statistics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="ErrorLabel" Text="Something went wrong"></asp:Label>
    <br />
    Top 10 peliculas mas vistas: <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="NoPopularMovies" Text="Nada que mostrar"></asp:Label>
    <asp:GridView ID="MostViewedMoviesGrid" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="Id" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# "~/" + Eval("image") %>' Width="64" Height="64" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="name" HeaderText="Titulo" />
            <asp:BoundField DataField="views" HeaderText="Numero de vistas" />
        </Columns>
    </asp:GridView>
    <br />
    Top 10 clientes con mas boletas: <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="NoMostBuyers" Text="Nada que mostrar"></asp:Label>
    <asp:GridView ID="MostBuyersGrid" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="first_name" HeaderText="Nombre" />
            <asp:BoundField DataField="last_name" HeaderText="Apellido" />
            <asp:BoundField DataField="email" HeaderText="Email" />
            <asp:BoundField DataField="views" HeaderText="Boletas compradas" />
        </Columns>
    </asp:GridView>
    <br />
    Promedio de ventas por dia: <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="NoMeans" Text="Nada que mostrar"></asp:Label>
    <asp:GridView ID="WeekdayMeansGrid" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="dia" HeaderText="Dia" />
            <asp:BoundField DataField="promedio" HeaderText="Promedio de boletas" />
            <asp:BoundField DataField="muestras" HeaderText="Numero de muestras" />
        </Columns>
    </asp:GridView>

</asp:Content>
