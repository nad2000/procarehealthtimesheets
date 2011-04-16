<%@ Page Title="Reports" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="True" 
         CodeBehind="FullReport.aspx.cs" 
         Inherits="SoftwareAssociates.ProCareHealth.FullReport" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<%-- 
    <asp:Label ID="Label5" runat="server" Text="Label" AssociatedControlID="ApprovableUserDropDownList">User</asp:Label>
    <asp:DropDownList runat="server" ID="ApprovableUserDropDownList" 
        AutoPostBack="True" DataSourceID="ApprovableUsersSource"
        DataTextField="FullName" 
        DataValueField="UserName" 
        onselectedindexchanged="ParametersChanged" 
        ondatabound="ApprovableUserDropDownList_DataBound" 
        AppendDataBoundItems="True" >
        <asp:ListItem Selected="True" Enabled="true" Text="ALL" Value="ALL"></asp:ListItem>
    </asp:DropDownList> --%>
    <asp:Label ID="CompanyLabel" runat="server" Text="Label" AssociatedControlID="CompanyDropDownList">Company:</asp:Label>
    <asp:DropDownList ID="CompanyDropDownList" runat="server" 
        DataSourceID="CompanyDataSource" DataTextField="Name" DataValueField="Id" 
        onselectedindexchanged="ParametersChanged" 
        AutoPostBack="True" AppendDataBoundItems="True">
        <asp:ListItem Selected="True" Enabled="true"></asp:ListItem>
    </asp:DropDownList>
    <asp:Label ID="Label6" runat="server" Text="Label" AssociatedControlID="DateFromDropDownList">Date From:</asp:Label>
    <asp:DropDownList ID="DateFromDropDownList" runat="server" 
        AutoPostBack="True" DataSourceID="WeekBeginningDateSource" DataTextField="WeekBeginningDate" 
        DataValueField="WeekBeginningDate" DataTextFormatString="{0:d}"
        onselectedindexchanged="ParametersChanged" 
        ondatabound="DateFromDropDownList_DataBound" >
    </asp:DropDownList>
    <asp:Label ID="Label7" runat="server" Text="Label" AssociatedControlID="DateToDropDownList">Date To:</asp:Label>
    <asp:DropDownList ID="DateToDropDownList" runat="server" 
        AutoPostBack="True" DataSourceID="WeekEndingDateSource" DataTextField="WeekEndingDate" 
        DataValueField="WeekEndingDate" DataTextFormatString="{0:d}"
        onselectedindexchanged="ParametersChanged" 
        ondatabound="DateToDropDownList_DataBound" >
    </asp:DropDownList>
    <asp:CheckBox ID="IncludeUnapprovedCheckBox" runat="server" Checked="true" 
        Text="Include Unapproved"  AutoPostBack="true"
        oncheckedchanged="ParametersChanged" />
    <asp:GridView ID="FullGridView" runat="server" 
        AllowSorting="True"
        AutoGenerateColumns="False"
        DataSourceID="FullReportSource"
        GridLines="None"  
        CssClass="mGrid"  
        PagerStyle-CssClass="pgr"  
        AlternatingRowStyle-CssClass="alt" >
    <AlternatingRowStyle CssClass="alt"></AlternatingRowStyle>
        <Columns>
            <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
            <asp:BoundField DataField="FullName" HeaderText="Full Name" ReadOnly="True" 
                SortExpression="FullName" />
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:d}" />
            <asp:BoundField DataField="StartedAt" HeaderText="Started At"  DataFormatString="{0:hh\:mm}"
                SortExpression="StartedAt" />
            <asp:BoundField DataField="EndedAt" HeaderText="Ended At"  DataFormatString="{0:hh\:mm}"
                SortExpression="EndedAt" />
            <asp:BoundField DataField="BreakTypeName" HeaderText="Break" 
                SortExpression="BreakTypeName" />
            <asp:TemplateField HeaderText="Total Time">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server"
                    Text='<%# TotalTimeFormated( Eval("TotalTime"))  %>'>
                    </asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CheckBoxField DataField="IsApproved" HeaderText="Approved" 
                SortExpression="IsApproved" />
            <asp:BoundField DataField="Comment" HeaderText="Comment" 
                SortExpression="Comment" />
        </Columns>

<PagerStyle CssClass="pgr"></PagerStyle>
    </asp:GridView>

    <%--  
    <asp:Button ID="ExportButton" runat="server" Text="Export" 
        onclick="ExportButton_Click" /> --%>
    <asp:HyperLink ID="ExportHyperLink" runat="server" 
        NavigateUrl="~/ExportCSV.ashx" onprerender="ExportHyperLink_PreRender">Expor...</asp:HyperLink>
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

    <asp:SqlDataSource ID="FullReportSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SoftwareAssociates.ProCareHealth.Properties.Settings.MainSqlConnection %>" 
        SelectCommand="GetFullTimeSheetRecords"
        SelectCommandType="StoredProcedure"
        CancelSelectOnNullParameter="False" >
        <SelectParameters>
        <%--
            <asp:ControlParameter ControlID="ApprovableUserDropDownList" Name="UserName" 
                PropertyName="SelectedValue" Type="String" ConvertEmptyStringToNull="true" />   --%>
            <asp:SessionParameter Name="ReportRequestedBy_Id" SessionField="UserId" Type="Int32" ConvertEmptyStringToNull="true" />
            <asp:ControlParameter ControlID="DateFromDropDownList" DbType="Date" 
                Name="DateFrom" PropertyName="SelectedValue" ConvertEmptyStringToNull="true"/>
            <asp:ControlParameter ControlID="DateToDropDownList" DbType="Date" 
                Name="DateTo" PropertyName="SelectedValue" ConvertEmptyStringToNull="true" />
            <asp:ControlParameter ControlID="IncludeUnapprovedCheckBox" 
                Name="IncludeUnapproved" PropertyName="Checked" Type="Boolean" ConvertEmptyStringToNull="true" />
            <asp:ControlParameter ControlID="CompanyDropDownList" Name="CompanyId" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="UserName" Type="String" ConvertEmptyStringToNull="true" />
        </SelectParameters> 
    </asp:SqlDataSource>
    <asp:LinqDataSource ID="CompanyDataSource" runat="server" 
        ContextTypeName="SoftwareAssociates.ProCareHealth.WorkSheetDataClassesDataContext" 
        EntityTypeName="" OrderBy="Name" Select="new (Id, Name)" TableName="Companies">
    </asp:LinqDataSource>
</asp:Content>
