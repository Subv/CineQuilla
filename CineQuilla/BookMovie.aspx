<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookMovie.aspx.cs" Inherits="CineQuilla.BookMovie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <asp:Label Visible="false" ForeColor="Red" runat="server" ID="ErrorLabel" Text="Something went wrong"></asp:Label>
    <br />
    <asp:Label ID="Label1" runat="server" Text="Dias disponibles: "></asp:Label>
    <asp:Calendar ID="Calendar1" runat="server" OnDayRender="Calendar1_DayRender" OnSelectionChanged="Calendar1_SelectionChanged"></asp:Calendar>
    <br />
    <br />
    <div runat="server" id="AvailableShowsDiv" visible="false">
        <asp:Label ID="Label2" runat="server" Text="Funciones disponibles para el dia: "></asp:Label>
        <br />
        <asp:GridView ID="AvailableShowsGrid" runat="server" AutoGenerateColumns="false" OnRowCommand="AvailableShowsGrid_RowCommand">
            <Columns>
                <asp:BoundField DataField="showroom_id" HeaderText="Sala"/>
                <asp:BoundField DataField="available_chairs" HeaderText="Sillas disponibles" />
                <asp:BoundField DataField="num_chairs" HeaderText="Sillas totales" />
                <asp:BoundField DataField="start_time" HeaderText="Hora de inicio"/>
                <asp:BoundField DataField="end_time" HeaderText="Hora de finalizacion"/>
                <asp:BoundField DataField="price" HeaderText="Precio" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="false" CommandName="Purchase"
                            Text="Comprar" CommandArgument='<%# Eval("id") %>' Enabled='<%# (int)Eval("available_chairs") > 0 && (Calendar1.SelectedDate > DateTime.Now || DateTime.Parse(Eval("end_time").ToString()).TimeOfDay > DateTime.Now.TimeOfDay) %>'/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
