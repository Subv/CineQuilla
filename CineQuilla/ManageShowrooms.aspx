<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageShowrooms.aspx.cs" Inherits="CineQuilla.ManageShowrooms" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Salas: <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="ErrorLabel" Text="Something went wrong"></asp:Label>
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="NoShowrooms" Text="No hay salas"></asp:Label>
    <br />
    <asp:Label Visible="false" ForeColor="Green" runat="server" ID="ShowroomAddedMessage" Text="Sala añadida correctamente"></asp:Label>
    <asp:GridView ID="ShowroomsTable" runat="server" DataKeyNames="id" OnRowCommand="ShowroomsTable_OnRowCommand" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="Id"/>
            <asp:BoundField DataField="capacity" HeaderText="Capacity" />
            <asp:TemplateField HeaderText="3D">
                <ItemTemplate><%# (int)Eval("capable_3d") == 1 ? "Yes" : "No" %></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Active">
                <ItemTemplate><%# (int)Eval("active") == 1 ? "Yes" : "No" %></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="false" CommandName="DeleteShowroom"
                        Text="Eliminar Sala" CommandArgument='<%# Eval("id") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <br />
    <asp:Button ID="Button3" runat="server" Text="Add new showroom" OnClick="Button3_Click" />
    <div id="AddNewShowroomDiv" runat="server" visible="false">
        Nueva sala: <br />
        <asp:Label ID="Label1" runat="server" Text="Capacity: "></asp:Label>
        <asp:TextBox ID="CapacityBox" runat="server" TextMode="Number"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator" ControlToValidate="CapacityBox" runat="server" ErrorMessage="Please enter a capacity."></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label2" runat="server" Text="3D: "></asp:Label>
        <asp:CheckBox ID="Capable3DBox" runat="server" />
        <br />
        <asp:Label ID="Label3" runat="server" Text="Active: "></asp:Label>
        <asp:CheckBox ID="ActiveBox" runat="server" />
        <br />
        <asp:Button ID="Button2" runat="server" Text="Create User" OnClick="Button2_Click" />
    </div>
</asp:Content>
