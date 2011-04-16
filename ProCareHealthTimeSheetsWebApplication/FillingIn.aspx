<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master"
AutoEventWireup="True" CodeBehind="FillingIn.aspx.cs"
Inherits="SoftwareAssociates.ProCareHealth.FillingIn" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="ProCareHealthTimeSheets" Namespace="SoftwareAssociates.ProCareHealth" TagPrefix="ts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="UserNameHiddenField" runat="server" ViewStateMode="Enabled" />
    Week Ending: 
    <asp:DropDownList ID="WeekEndingDropDownList" runat="server" 
        AutoPostBack="True" DataSourceID="WeekEndingDateSource" 
        DataTextField="WeekEndingDate" DataValueField="WeekEndingDate" 
        DataTextFormatString="{0:d}" 
        onselectedindexchanged="WeekEndingDropDownList_SelectedIndexChanged" 
        ondatabound="WeekEndingDropDownList_DataBound">
    </asp:DropDownList>
    <asp:SqlDataSource ID="WeekEndingDateSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SoftwareAssociates.ProCareHealth.Properties.Settings.MainSqlConnection %>" 
        DataSourceMode="DataReader" EnableViewState="False"
        CacheExpirationPolicy="Absolute"
        CacheDuration="43200"
        SelectCommand="GetWeekEndingDates" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="10" Name="Count" Type="Byte" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="TimeSheetGridView" runat="server" AutoGenerateColumns="False" 
        DataSourceID="WorkSheetSource" 
        DataMember="DefaultView"
        DataKeyNames="Date"
        RowHeaderColumn="Date"
        GridLines="None"  
        CssClass="mGrid"  
        PagerStyle-CssClass="pgr"  
        AlternatingRowStyle-CssClass="alt" 
        SelectedRowStyle-CssClass="selected"
        onrowediting="WorkSheetGridView_RowEditing" 
        EnablePersistedSelection="True">
<AlternatingRowStyle CssClass="alt"></AlternatingRowStyle>
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HiddenField ID="IdHiddenField" runat="server" Value='<%# Eval("Id") %>' />
                </ItemTemplate>
                <ControlStyle CssClass="HiddenElement" />
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
                    <asp:TextBox ID="StartedAtTextBox" runat="server" Text='<%# Bind("StartedAt", "{0:hh\:mm}") %>'
                        MaxLength="5" 
                        Enabled='<%# !Convert.ToBoolean(Eval("IsApproved")) %>'></asp:TextBox>
                    <asp:MaskedEditExtender ID="StartedAtMaskedEditExtender" runat="server" 
                        TargetControlID="StartedAtTextBox"
                        Mask="99:99"
                        MaskType="Time"
                        UserTimeFormat="TwentyFourHour"
                        AcceptAMPM="false"
                        AutoComplete="true"
                        AutoCompleteValue="07:00" />
                    <asp:MaskedEditValidator ID="StartedAtMaskedEditValidator" runat="server" 
                        ControlToValidate="StartedAtTextBox"
                        ControlExtender="StartedAtMaskedEditExtender" Display="Dynamic" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Ended At">
                <ItemTemplate>
                    <asp:TextBox ID="EndedAtTextBox" runat="server" Text='<%# Bind("EndedAt", "{0:hh\:mm}") %>' MaxLength="5"
                        Enabled='<%# !Convert.ToBoolean(Eval("IsApproved")) %>'></asp:TextBox>
                    <asp:MaskedEditExtender ID="EndedAtMaskedEditExtender" runat="server" 
                        TargetControlID="EndedAtTextBox"
                        Mask="99:99"
                        MaskType="Time"
                        UserTimeFormat="TwentyFourHour"
                        AcceptAMPM="false"
                        AutoComplete="true"
                        AutoCompleteValue="18:00" >
                    </asp:MaskedEditExtender>
                    <asp:MaskedEditValidator ID="EndedAtMaskedEditValidator" runat="server" 
                        ControlToValidate="EndedAtTextBox"
                        ControlExtender="EndedAtMaskedEditExtender" Display="Dynamic" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Break">
                <ItemTemplate>
                    <asp:DropDownList ID="BreakTypeDropDownList" runat="server" 
                        AppendDataBoundItems="True" DataSourceID="BreakTypeDS" DataTextField="Name" 
                        DataValueField="Id" SelectedValue='<%# Bind("Break_Id") %>'
                        Enabled='<%# !Convert.ToBoolean(Eval("IsApproved")) %>'>
                        <asp:ListItem></asp:ListItem>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Total Time">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server"
                    Text='<%# TotalTimeFormated( Eval("TotalTime"))  %>'>
                    </asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        
<PagerStyle CssClass="pgr"></PagerStyle>

        <SelectedRowStyle CssClass="selected"></SelectedRowStyle>
    </asp:GridView>
    <asp:Button ID="SaveButton" runat="server" Text="Save" 
        onclick="SaveButton_Click" />
    <asp:SqlDataSource ID="UserDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SoftwareAssociates.ProCareHealth.Properties.Settings.MainSqlConnection %>" 
        SelectCommand="GetUserDataByUserName" SelectCommandType="StoredProcedure" 
        DataSourceMode="DataReader" EnableViewState="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="UserNameHiddenField" Name="UserName" 
                PropertyName="Value" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="BreakTypeDS" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="SoftwareAssociates.ProCareHealth.TimeSheetDataSetTableAdapters.BreakTypesTableAdapter">
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="WorkSheetSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SoftwareAssociates.ProCareHealth.Properties.Settings.MainSqlConnection %>" 
        SelectCommand="GetUserTimeSheetEntries" SelectCommandType="StoredProcedure" 
        UpdateCommand="UserTimeSheetEntry_Update" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="UserNameHiddenField" Name="UserName" 
                PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="WeekEndingDropDownList" Type="DateTime"
                Name="WeekEndingDate" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32"  ConvertEmptyStringToNull="true" />
            <asp:Parameter DbType="Date" Name="Date" />
            <asp:Parameter DbType="Time" Name="StartedAt" ConvertEmptyStringToNull="true" />
            <asp:Parameter DbType="Time" Name="EndedAt" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="Break_Id" Type="Int32"  ConvertEmptyStringToNull="true" />
            <asp:SessionParameter Name="ReportedBy_Id" Type="Int32" SessionField="UserId" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>