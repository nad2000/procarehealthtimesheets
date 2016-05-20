<%@ Page Title="Approving" Language="C#" MasterPageFile="~/Site.master" 
    AutoEventWireup="True" 
    CodeBehind="Approving2.aspx.cs" 
    Inherits="SoftwareAssociates.ProCareHealth.Approving2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:DropDownList runat="server" ID="ApprovableUserDropDownList" 
        AutoPostBack="True" DataSourceID="ApprovableUsersSource" DataTextField="FullName" 
        DataValueField="UserName" 
        onselectedindexchanged="ApprovableUserDropDownList_SelectedIndexChanged" 
        ondatabound="ApprovableUserDropDownList_DataBound" />
    <asp:Button ID="ThisWeekButton" runat="server" Text="This Week" Enabled="false" 
        onclick="WeekButton_Click" />
    <asp:Button ID="LastWeekButton" runat="server" Text="Last Week" 
        onclick="WeekButton_Click" />

    <asp:GridView ID="TimeSheetGridView"
        runat="server"
        AutoGenerateColumns="False" 
        DataSourceID="TimeSheetSource" 
        onrowdatabound="TimeSheetGridView_RowDataBound"
        ShowFooter="True"
        RowHeaderColumn="Date" DataMember="DefaultView"
        GridLines="None"  
        CssClass="mGrid"  
        PagerStyle-CssClass="pgr"  
        AlternatingRowStyle-CssClass="alt" 
        SelectedRowStyle-CssClass="selected"
        onrowediting="TimeSheetGridView_RowEditing" 
        DataKeyNames="Date"
        EnablePersistedSelection="True" 
        ondatabinding="TimeSheetGridView_DataBinding">
<AlternatingRowStyle CssClass="alt"></AlternatingRowStyle>
        <Columns>
            <asp:TemplateField InsertVisible="False">
                <ItemTemplate>
                    <asp:Label ID="IdLabel" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle CssClass="HiddenElement" />
                <HeaderStyle CssClass="HiddenElement" />
                <ItemStyle CssClass="HiddenElement" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="Week Day" ReadOnly="true" DataField="Date" DataFormatString="{0:dddd}" />
            <asp:TemplateField HeaderText="Date" SortExpression="Date">
                <ItemTemplate>
                    <asp:Label ID="DateLabel" runat="server" Text='<%# Bind("Date", "{0:d}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
<asp:TemplateField HeaderText="Started At">
<ItemTemplate>
    <asp:TextBox ID="StartedAtTextBox" runat="server" 
        Text='<%# Bind("StartedAt", "{0:hh\:mm}") %>' MaxLength="5"></asp:TextBox>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Ended At">
<ItemTemplate>
        <asp:TextBox ID="EndedAtTextBox" runat="server" Text='<%# Bind("EndedAt", "{0:hh\:mm}") %>'  MaxLength="5"></asp:TextBox>
</ItemTemplate>
</asp:TemplateField>
            <asp:TemplateField HeaderText="Break">
                <ItemTemplate>
                    <asp:DropDownList ID="BreakTypeDropDownList" runat="server" 
                        AppendDataBoundItems="True" DataSourceID="BreakTypeSource" DataTextField="Name" 
                        DataValueField="Id" SelectedValue='<%# Bind("Break_Id") %>'>
                        <asp:ListItem></asp:ListItem>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Total Time" >
                <ItemTemplate>
                    <asp:Label ID="TotalTimeLabel" runat="server" 
                        Text='<%# TotalTimeFormated( Eval("TotalTime"))  %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="SumOfTotalTimeLabel" runat="server"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="IsApproved">
                <ItemTemplate>
                    <asp:CheckBox ID="IsApprovedCheckBox" runat="server" Checked='<%# Bind("IsApproved") %>' Enabled="true" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Comment">
                <ItemTemplate>
                    <asp:TextBox ID="CommentTextBox" runat="server" Text='<%# Bind("Comment") %>'></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

<PagerStyle CssClass="pgr"></PagerStyle>

<SelectedRowStyle CssClass="selected"></SelectedRowStyle>
    </asp:GridView>

    <asp:LinqDataSource ID="ApprovableUsersSource" runat="server" 
        ContextTypeName="SoftwareAssociates.ProCareHealth.WorkSheetDataClassesDataContext" 
        onselecting="ApprovableUsersSource_Selecting" AutoPage="False" 
        AutoSort="False" EnableObjectTracking="False" EntityTypeName="User" TableName="Users" >
    </asp:LinqDataSource>

    <asp:SqlDataSource ID="TimeSheetSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SoftwareAssociates.ProCareHealth.Properties.Settings.MainSqlConnection %>" 
        SelectCommand="GetUserTimeSheetEntries" 
        SelectCommandType="StoredProcedure" 
        UpdateCommand="ApproverTimeSheetEntry_Update" 
        UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ApprovableUserDropDownList" 
                DefaultValue="UserName" Name="UserName" PropertyName="SelectedValue" 
                Type="String" />
            <asp:Parameter DbType="Date" Name="WeekEndingDate" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" ConvertEmptyStringToNull="true" />
            <asp:Parameter DbType="Date" Name="Date" />
            <asp:Parameter DbType="Time" Name="StartedAt" ConvertEmptyStringToNull="true" />
            <asp:Parameter DbType="Time" Name="EndedAt" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="Break_Id" Type="Int32"  ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="IsApproved" Type="Boolean" />
            <asp:Parameter Name="Comment" Type="String" />
            <asp:SessionParameter Name="VerifiedBy_Id" Type="Int32" SessionField="UserId"  />
            <asp:ControlParameter ControlID="ApprovableUserDropDownList" 
                Name="ReportedBy_UserName" PropertyName="SelectedValue" Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="BreakTypeSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SoftwareAssociates.ProCareHealth.Properties.Settings.MainSqlConnection %>" 
        SelectCommand="SELECT [Id], [Name] FROM [BreakTypes] ORDER BY [TimeValue]">
    </asp:SqlDataSource>
    <asp:Button ID="SaveButton" runat="server" Text="Save" 
        onclick="SaveButton_Click" />
</asp:Content>
