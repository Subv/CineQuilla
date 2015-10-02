<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageMovies.aspx.cs" Inherits="CineQuilla.ManageMovies" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Movies: <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="ErrorLabel" Text="Something went wrong"></asp:Label>
    <br />
    <asp:Label Visible="false" ForeColor="Green" runat="server" ID="MovieAddedMessage" Text="Pelicula añadida correctamente"></asp:Label>
    <asp:GridView ID="MoviesTable" runat="server" DataKeyNames="id" OnRowCommand="MoviesTable_OnRowCommand" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="Id"/>
            <asp:BoundField DataField="username" HeaderText="Username" />
            <asp:BoundField DataField="first_name" HeaderText="Nombre" />
            <asp:BoundField DataField="last_name" HeaderText="Apellido" />
            <asp:BoundField DataField="permission_level" HeaderText="Nivel" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="false" CommandName="DeleteMovie"
                        Text="Eliminar Pelicula" CommandArgument='<%# Eval("id") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <br />
    <asp:Button ID="Button3" runat="server" Text="Add new movie" OnClick="Button3_Click" />
</asp:Content>
