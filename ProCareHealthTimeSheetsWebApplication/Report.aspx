<%@ Page Title="Reports" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" 
         CodeBehind="Report.aspx.cs" 
         Inherits="SoftwareAssociates.ProCareHealth.Report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:DropDownList runat="server" ID="ApprovableUserDropDownList" 
        AutoPostBack="True" DataSourceID="ApprovableUsersSource" DataTextField="Name" 
        DataValueField="UserName" 
        onselectedindexchanged="ParameterDropDownList_SelectedIndexChanged" 
        ondatabound="ApprovableUserDropDownList_DataBound" 
        AppendDataBoundItems="True" >
        <asp:ListItem Selected="True" Text="ALL" Value="ALL"></asp:ListItem>
    </asp:DropDownList>
    <asp:DropDownList ID="DateFromDropDownList" runat="server" 
        AutoPostBack="True" DataSourceID="WeekBeginningDateSource" DataTextField="WeekBeginningDate" 
        DataValueField="WeekBeginningDate" DataTextFormatString="{0:d}"
        onselectedindexchanged="ParameterDropDownList_SelectedIndexChanged" >
    </asp:DropDownList>
    <asp:DropDownList ID="DateToDropDownList" runat="server" 
        AutoPostBack="True" DataSourceID="WeekEndingDateSource" DataTextField="WeekEndingDate" 
        DataValueField="WeekEndingDate" DataTextFormatString="{0:d}"
        onselectedindexchanged="ParameterDropDownList_SelectedIndexChanged" >
    </asp:DropDownList>
    <asp:GridView ID="SummaryGridView" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataSourceID="TimeSheetSummarySource"
        GridLines="None"  
        CssClass="mGrid"  
        PagerStyle-CssClass="pgr"  
        AlternatingRowStyle-CssClass="alt" >
        <Columns>
            <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="StartDate" HeaderText="Start Date" ReadOnly="True" 
                SortExpression="StartDate" DataFormatString="{0:d}" />
            <asp:BoundField DataField="EndDate" HeaderText="End Date" ReadOnly="True" 
                SortExpression="EndDate" DataFormatString="{0:d}" />
            <asp:TemplateField HeaderText="Approved Total Time" 
                SortExpression="ApprovedTotalTime">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server"
                    Text='<%# TotalTimeFormated( Eval("ApprovedTotalTime")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle ForeColor="#006600" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Not Approved Total" 
                SortExpression="NotApprovedTotalTime">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" 
                        Text='<%# TotalTimeFormated( Eval("NotApprovedTotalTime")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle ForeColor="Red" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Approved Breaks" 
                SortExpression="ApprovedTotalBreakTime">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" 
                        Text='<%# TotalTimeFormated( Eval("ApprovedTotalBreakTime")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle ForeColor="#006600" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="NotApproved Breaks" 
                SortExpression="NotApprovedTotalBreakTime">
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" 
                        Text='<%# TotalTimeFormated( Eval("NotApprovedTotalBreakTime")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle ForeColor="Red" />
            </asp:TemplateField>
            <asp:BoundField DataField="Comments" 
                HeaderText="Comments" ReadOnly="True" 
                SortExpression="Comments" />
        </Columns>
    </asp:GridView>
    <asp:Button ID="ExportButton" runat="server" Text="Export" 
        onclick="ExportButton_Click" />
    <asp:LinqDataSource ID="ApprovableUsersSource" runat="server" 
        ContextTypeName="SoftwareAssociates.ProCareHealth.WorkSheetDataClassesDataContext" 
        onselecting="ApprovableUsersSource_Selecting" AutoPage="False" 
        AutoSort="False" EnableObjectTracking="False" EntityTypeName="User" TableName="Users" >
    </asp:LinqDataSource>
    <asp:SqlDataSource ID="TimeSheetSummarySource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SoftwareAssociates.ProCareHealth.Properties.Settings.MainSqlConnection %>" 
        SelectCommand="GetTimeSheetSummary" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="ReportRequestedBy_Id" SessionField="UserId" Type="Int32" ConvertEmptyStringToNull="true" Direction="Input" />
            <asp:ControlParameter ControlID="DateFromDropDownList" DbType="Date" 
                Name="DateFrom" PropertyName="SelectedValue" ConvertEmptyStringToNull="true" Direction="Input" />
            <asp:ControlParameter ControlID="DateToDropDownList" DbType="Date" 
                Name="DateTo" PropertyName="SelectedValue" ConvertEmptyStringToNull="true" Direction="Input" />
            <asp:ControlParameter ControlID="ApprovableUserDropDownList" Name="UserName" 
                PropertyName="SelectedValue" Type="String" ConvertEmptyStringToNull="true" Direction="Input" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="WeekBeginningDateSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SoftwareAssociates.ProCareHealth.Properties.Settings.MainSqlConnection %>" 
        SelectCommand="GetWeekBeginningDates" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="10" Name="Count" Type="Byte" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="WeekEndingDateSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SoftwareAssociates.ProCareHealth.Properties.Settings.MainSqlConnection %>" 
        SelectCommand="GetWeekEndingDates" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="10" Name="Count" Type="Byte" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
