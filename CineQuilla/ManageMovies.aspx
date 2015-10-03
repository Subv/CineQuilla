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
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# "~/" + Eval("image") %>' Width="64" Height="64" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="name" HeaderText="Title" />
            <asp:BoundField DataField="description" HeaderText="Description" />
            <asp:BoundField DataField="year" HeaderText="Year" />
            <asp:BoundField DataField="director" HeaderText="Director" />
            <asp:BoundField DataField="length" HeaderText="Duration" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="false" CommandName="DeleteMovie"
                        Text="Eliminar Pelicula" CommandArgument='<%# Eval("id") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/MovieDetails.aspx?id=" + Eval("id") %>'>Ver detalles</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <br />
    <asp:Button ID="Button3" runat="server" Text="Add new movie" OnClick="Button3_Click" />
    <div id="AddNewMovieDiv" runat="server" visible="false">
        Nueva pelicula: <br />
        <asp:Label ID="Label1" runat="server" Text="Title: "></asp:Label>
        <asp:TextBox ID="NameBox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="NameValidator" ControlToValidate="NameBox" runat="server" ErrorMessage="Please enter a movie title."></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Description: "></asp:Label>
        <br />
        <asp:TextBox ID="DescriptionBox" runat="server" TextMode="MultiLine"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="DescriptionBox" runat="server" ErrorMessage="Please enter a description"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Year: "></asp:Label>
        <asp:TextBox ID="YearBox" runat="server" TextMode="Number"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="YearBox" runat="server" ErrorMessage="Please enter a year"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label4" runat="server" Text="Director: "></asp:Label>
        <asp:TextBox ID="DirectorBox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="DirectorBox" runat="server" ErrorMessage="Please enter a director name"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label5" runat="server" Text="Length (minutes): "></asp:Label>
        <asp:TextBox ID="LengthBox" runat="server" TextMode="Number"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="LengthBox" runat="server" ErrorMessage="Please enter a length"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label6" runat="server" Text="Cover image: "></asp:Label>
        <asp:FileUpload ID="ImageUpload" runat="server" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="ImageUpload" runat="server" ErrorMessage="Please select a cover image"></asp:RequiredFieldValidator>
        <br />
        <asp:Button ID="Button2" runat="server" Text="Create Movie" OnClick="Button2_Click" />
    </div>
</asp:Content>
