<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageShows.aspx.cs" Inherits="CineQuilla.ManageShows" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="Label1" runat="server" Text="Seleccione una fecha para ver los shows: "></asp:Label>
    <asp:Calendar ID="ShowDate" runat="server" OnSelectionChanged="ShowDate_SelectionChanged"></asp:Calendar>
    <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="ErrorLabel" Text="Something went wrong"></asp:Label>
    <br />
    <asp:Label Visible="false" ForeColor="Green" runat="server" ID="ShowAddedMessage" Text="Funcion añadida correctamente"></asp:Label>
    <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="NoShows" Text="No hay funciones para esa fecha"></asp:Label>
    <asp:GridView ID="ShowsTable" Visible="false" runat="server" DataKeyNames="id" OnRowCommand="ShowsTable_OnRowCommand" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="Id"/>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# "~/" + Eval("image") %>' Width="64" Height="64" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="movie_name" HeaderText="Movie" />
            <asp:BoundField DataField="showroom_id" HeaderText="Sala" />
            <asp:BoundField DataField="start_time" HeaderText="Hora de inicio" />
            <asp:BoundField DataField="end_time" HeaderText="Hora de finalizacion" />
            <asp:BoundField DataField="price" HeaderText="Precio" />
            <asp:BoundField DataField="num_chairs" HeaderText="Boletas vendidas" />
            <asp:BoundField DataField="available_chairs" HeaderText="Sillas disponibles" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="false" CommandName="DeleteShow"
                        Text="Eliminar Funcion" CommandArgument='<%# Eval("id") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <br />
    <br />
    <asp:Button ID="Button2" runat="server" Text="Add new show" OnClick="Button2_Click" />
    <div id="AddNewShowDiv" runat="server" Visible="false">
        <asp:Label ID="Label2" runat="server" Text="Fecha de inicio: "></asp:Label>
        <asp:Calendar ID="NewShowStartDate" runat="server" OnSelectionChanged="NewShowDates_SelectionChanged"></asp:Calendar>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Fecha de finalizacion: "></asp:Label>
        <asp:Calendar ID="NewShowEndDate" runat="server" OnSelectionChanged="NewShowDates_SelectionChanged"></asp:Calendar>
        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="La fecha de finalizacion no puede ser anterior a la fecha de inicio" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Text="Start time: "></asp:Label>
        <asp:TextBox ID="NewShowStartTime" runat="server" TextMode="Time"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NewShowStartTime" ErrorMessage="Ingrese una hora de inicio"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label5" runat="server" Text="End time: "></asp:Label>
        <asp:TextBox ID="NewShowEndTime" runat="server" TextMode="Time"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NewShowEndTime" ErrorMessage="Ingrese una hora de finalizacion"></asp:RequiredFieldValidator>
        <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="NewShowEndTime" ErrorMessage="La hora de finalizacion debe ser mayor a la hora de inicio" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
        <br />
        <asp:Label ID="Label7" runat="server" Text="Price: "></asp:Label>
        <asp:TextBox ID="NewShowPrice" runat="server" TextMode="Number"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="NewShowPrice" ErrorMessage="Ingrese un precio"></asp:RequiredFieldValidator>
        <br />
        <asp:Button ID="Button4" runat="server" Text="Actualizar salas" OnClick="Button4_Click" /><asp:Button ID="Button5" runat="server" Text="Cambiar tiempos" OnClick="Button5_Click" />
        <br />
        <asp:Label ID="Label6" runat="server" Text="Sala: "></asp:Label>
        <asp:DropDownList ID="NewShowShowroom" runat="server"></asp:DropDownList>
        <br />
        <asp:Label ID="Label8" runat="server" Text="Pelicula: "></asp:Label>
        <asp:DropDownList ID="NewShowMovie" runat="server"></asp:DropDownList>
        <br />

        <asp:Button ID="Button3" runat="server" Text="Create Show" OnClick="Button3_Click" />
    </div>
</asp:Content>
