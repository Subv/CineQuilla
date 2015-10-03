<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CineQuilla.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server" >
    <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="ErrorLabel" Text="Something went wrong"></asp:Label>
    <br />
    <asp:Label ID="Label1" runat="server" Text="Currently showing: "></asp:Label>
    <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="NoShows" Text="No hay funciones disponibles"></asp:Label>
    <asp:GridView ID="ShowingGridView" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField ShowHeader="true" HeaderText="Cover">
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# "~/" + Eval("image") %>' Width="64" Height="64" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="true" HeaderText="Title">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/BookMovie.aspx?id=" + Eval("id") %>'><%# Eval("name") %></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
