<%@ Page Title="User Administration" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="True" 
    CodeBehind="Admin.aspx.cs" Inherits="SoftwareAssociates.ProCareHealth.Admin.UserAdmin" %>
<%@ Register Assembly="ProCareHealthTimeSheets" Namespace="SoftwareAssociates.ProCareHealth" TagPrefix="cc1" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:GridView ID="AllUsersGridView" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" 
        DataSourceID="AllUsersSource"
        RowHeaderColumn="UserName"
        GridLines="None"  
        CssClass="mGrid"  
        PagerStyle-CssClass="pgr"  
        AlternatingRowStyle-CssClass="alt" 
        SelectedRowStyle-CssClass="selected" 
        onrowdatabound="AllUsersGridView_RowDataBound" 
        onselectedindexchanged="AllUsersGridView_SelectedIndexChanged" 
        EnablePersistedSelection="True" >
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" 
                ReadOnly="True" SortExpression="Id" Visible="False" />
            <asp:BoundField DataField="UserName" HeaderText="User Name" 
                SortExpression="UserName" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            <asp:BoundField DataField="FullName" HeaderText="Full Name" SortExpression="FullName" />
            <asp:BoundField DataField="CompanyName" HeaderText="Company Name" 
                SortExpression="CompanyName" />
            <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Styles/icons/eye.png" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="AllUsersSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SoftwareAssociates.ProCareHealth.Properties.Settings.MainSqlConnection %>" 
        SelectCommand="GetAllUsers" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <div style="float:right" >
    <asp:Button ID="NewUserButton" runat="server" Text="New User" 
        onclick="NewUserButton_Click" />
    </div>
    <asp:Panel ID="UserDetailsPanel" runat="server"  Visible="False">
    <asp:ValidationSummary ID="UserParameterValidationSummary" runat="server" />
        <table width="100%">
        <tr>
        <td width="60%">
        <table width="100%">
        <tr><td width="30%" >
    <asp:Label ID="EmailLabel" runat="server" Text="Email: " 
                AssociatedControlID="EmailTextBox" style="font-weight: 700" ></asp:Label>
    </td><td>
    <asp:TextBox ID="EmailTextBox" runat="server" Width="80%" />
    <asp:RequiredFieldValidator ID="EmailRequiredFieldValidator" runat="server" ErrorMessage="Email address is mandatory!" ControlToValidate="EmailTextBox" Display="Dynamic" Text="*" />
    <asp:ValidatorCalloutExtender ID="EmailRequiredFieldValidator_ValidatorCalloutExtender" 
        runat="server" Enabled="True" TargetControlID="EmailRequiredFieldValidator">
    </asp:ValidatorCalloutExtender>
    <asp:RegularExpressionValidator ID="EmailRegularExpressionValidator"
        runat="server" ErrorMessage="Wrong Email address!" 
        ControlToValidate="EmailTextBox" Display="Dynamic" Text="*" 
        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
    </td></tr>
    <tr><td>
    <asp:Label ID="UserNameLabel" runat="server" Text="[User Name]: " 
            AssociatedControlID="UserNameTextBox" style="font-weight: 700" />
    </td><td>
    <asp:TextBox ID="UserNameTextBox" runat="server" ToolTip="User Name - Optional" />
    </td></tr>
    <tr><td>
    <asp:Label ID="PasswordLabel" runat="server" Text="Password: " 
            AssociatedControlID="PasswordTextBox" style="font-weight: 700" />
    </td><td>
    <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" />
            <asp:PasswordStrength ID="PasswordTextBox_PasswordStrength" runat="server" 
                Enabled="True" PreferredPasswordLength="5" StrengthIndicatorType="BarIndicator" 
                TargetControlID="PasswordTextBox">
            </asp:PasswordStrength>
    </td></tr>
    <tr><td>
    <asp:Label ID="Password2Label" runat="server" Text="Confirm Password: " 
            AssociatedControlID="Password2TextBox" style="font-weight: 700" />
    </td><td>
    <asp:TextBox ID="Password2TextBox" runat="server" TextMode="Password" />
    <asp:CompareValidator ID="PasswordCompareValidator" runat="server" 
        ErrorMessage="Passwords should be equal!" Text="*"
        ControlToCompare="PasswordTextBox" 
        ControlToValidate="Password2TextBox" />
    </td></tr>
    <tr><td>
    <asp:Label ID="FirstNameLabel" runat="server" Text="First Name: " 
            AssociatedControlID="FirstNameTextBox" style="font-weight: 700" />
    </td><td>
    <asp:TextBox ID="FirstNameTextBox" runat="server" Width="75%" />
    </td></tr>
    <tr><td>
    <asp:Label ID="LastNameLabel" runat="server" Text="LastName: " 
            AssociatedControlID="LastNameTextBox" style="font-weight: 700" />
    </td><td>
    <asp:TextBox ID="LastNameTextBox" runat="server" Width="75%" />
    </td></tr>
    <tr><td>
    <asp:Label ID="CompanyLabel" runat="server" Text="Company: " 
            AssociatedControlID="CompanyDropDownList" style="font-weight: 700" />
    </td><td>
    <asp:DropDownList ID="CompanyDropDownList" runat="server" 
        AppendDataBoundItems="True" DataSourceID="CompanyLinqDataSource" 
        DataTextField="Name" DataValueField="Id" >
        <asp:ListItem Selected="True"></asp:ListItem>
    </asp:DropDownList>
    <asp:LinqDataSource ID="CompanyLinqDataSource" runat="server" 
        ContextTypeName="SoftwareAssociates.ProCareHealth.WorkSheetDataClassesDataContext" 
        EntityTypeName="" Select="new (Id, Name)" TableName="Companies" />
    </td></tr>
    <tr><td>
    <asp:Label ID="EmpNoLabel" runat="server" Text="Code:"  ToolTip="Empoyee Number / Code"
            AssociatedControlID="EmpNoTextBox" style="font-weight: 700" />
    </td><td>
    <asp:TextBox ID="EmpNoTextBox" runat="server" Width="40%" ToolTip="Empoyee Number / Code" />
    </td></tr>
    <tr><td>
    <asp:Label ID="LockLabel" runat="server" Text="Locked: " 
            AssociatedControlID="LockedCheckBox" style="font-weight: 700" />
    </td><td>
        <asp:CheckBox ID="LockedCheckBox" runat="server" Text="Locked" />
    </td></tr>


</table>

        </td>
        <td width="25%" valign="top">
            <b>User Roles:</b><br />
            <asp:CheckBox ID="EmployeeRoleCheckBox" runat="server" Text="Employee"  />
            <br />
            <asp:CheckBox ID="ApproverRoleCheckBox" runat="server" Text="Approver"
                AutoPostBack="true" 
                oncheckedchanged="ApproverRoleCheckBox_CheckedChanged" />
            <br />
            <asp:CheckBox ID="AdministratorRoleCheckBox" runat="server" 
                Text="Administrator" />
            <br />
        </td>
        <td valign="top">
            <asp:Panel ID="AssignedCompaniesPanel" runat="server" Visible="false">
                <b>Assigned Companies:</b><br />
                <asp:DataList ID="AssignedCompaniesDataList" runat="server" DataKeyField="Id" 
                    DataSourceID="UserCompaniesSource">
                    <ItemTemplate>
                        <cc1:CheckBoxWithValue
                            ID="AssignedCompanyCheckBoxWithValue"
                            Value='<%# Eval("Id") %>'
                            Text='<%# Eval("Name") %>'
                            Checked='<%# Eval("Assigned") %>'
                            runat="server" />
                    </ItemTemplate>
                </asp:DataList>
            </asp:Panel>
        </td>
        </tr>
        </table>

    <asp:SqlDataSource ID="UserCompaniesSource" runat="server"
        CancelSelectOnNullParameter="false"
        ConnectionString="<%$ ConnectionStrings:SoftwareAssociates.ProCareHealth.Properties.Settings.MainSqlConnection %>" 
        SelectCommand="SELECT c.Id, c.Code, c.Name,
CAST (
CASE 
	WHEN uc.CompanyId IS NULL THEN 0
	ELSE 1
END AS BIT ) AS Assigned
FROM dbo.Companies AS c
LEFT JOIN dbo.UserCompany AS uc
    ON uc.CompanyId = c.Id
	    AND (uc.UsersVerifyingTimeSheets_Id = @Id)
ORDER BY c.Name">
        <SelectParameters>
            <asp:SessionParameter
                Name="Id" 
                DefaultValue=""
                SessionField="CurrentUserId" 
                ConvertEmptyStringToNull="true" DbType="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="UserSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SoftwareAssociates.ProCareHealth.Properties.Settings.MainSqlConnection %>" 
        SelectCommand="User_Select" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="AllUsersGridView" Name="Id" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

        <asp:Button ID="SaveButton" runat="server" Text="Save" 
            onclick="SaveButton_Click" />
        <asp:Button ID="DeleteButton" runat="server" Text="Delete" 
            onclick="DeleteButton_Click" />
        <asp:ConfirmButtonExtender ID="DeleteButton_ConfirmButtonExtender" 
            runat="server" ConfirmText="Are you sure you want to delete this user?" 
            Enabled="True" TargetControlID="DeleteButton">
        </asp:ConfirmButtonExtender>
    </asp:Panel>

    </asp:Content>
