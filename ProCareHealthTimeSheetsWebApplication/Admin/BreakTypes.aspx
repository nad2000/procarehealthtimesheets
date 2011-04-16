<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="True"
    CodeBehind="BreakTypes.aspx.cs" Inherits="SoftwareAssociates.ProCareHealth.Admin.BreakTypes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView ID="BreakTypeGridView" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="Id" DataSourceID="BreakTypeSource"
        GridLines="None"  
        CssClass="mGrid"  
        PagerStyle-CssClass="pgr"  
        AlternatingRowStyle-CssClass="alt" 
        SelectedRowStyle-CssClass="selected">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" 
                ReadOnly="True" SortExpression="Id" Visible="False" />
            <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="TimeValue" HeaderText="Length (min)" 
                SortExpression="TimeValue" />
            <asp:BoundField DataField="AlternativeCode" HeaderText="Alternative Code" 
                SortExpression="AlternativeCode" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="EditImageButton" runat="server" CausesValidation="False" 
                        CommandName="Edit" Text="Edit" ImageUrl="~/Styles/icons/application_edit.png" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:ImageButton ID="UpdateImageButton" runat="server" CausesValidation="True" 
                        CommandName="Update" Text="Update" ImageUrl="~/Styles/icons/accept.png" />
                    &nbsp;<asp:ImageButton ID="CancelImageButton" runat="server" CausesValidation="False" 
                        CommandName="Cancel" Text="Cancel"  ImageUrl="~/Styles/icons/cancel.png" />
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="BreakTypeSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SoftwareAssociates.ProCareHealth.Properties.Settings.MainSqlConnection %>" 
        SelectCommand="SELECT [Id], [Code], [Name], [TimeValue], [AlternativeCode] FROM [BreakTypes]">
    </asp:SqlDataSource>


</asp:Content>
