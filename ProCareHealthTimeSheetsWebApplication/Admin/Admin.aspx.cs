using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SoftwareAssociates.ProCareHealth.Admin
{

    public partial class UserAdmin : SoftwareAssociates.ProCareHealth.Web.UI.Page
    {
        const string
            AdmRole = "Administrators",
            ApproverRole = "Approvers",
            EmpRole = "Employees";
            


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
                this.Session["CurrentUserId"] = null;
        }

        private User _currentUser;
        public User CurrentUser
        {
            get
            {
                if (_currentUser == null)
                {
                    if ( this.Session["CurrentUserId"] == null ||
                        String.IsNullOrEmpty( this.Session["CurrentUserId"].ToString() ) ) {
                        _currentUser = null;
                    } else {
                        _currentUser = this.DataContext.Users.SingleOrDefault(u => u.Id == Convert.ToInt32(this.Session["CurrentUserId"]));
                    }
                }
                return _currentUser;
            }
        }

        protected void AllUsersGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add(
                    "onclick", this.Page.ClientScript.GetPostBackEventReference(
                        (GridView)sender,
                        "Select$"+e.Row.RowIndex.ToString() ));
            }

        }

        protected void ApproverRoleCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            bool isChecked = ((CheckBox)sender).Checked;
            this.UpdateAssignedCompanyPanel( isChecked);
            if ( this.CurrentUser != null ) {
                this.updateUserRole( this.CurrentUser.UserName, ApproverRole, isChecked );
            }
        }

        private void UpdateAssignedCompanyPanel(Boolean showPanel)
        {
            this.AssignedCompaniesPanel.Visible =
                this.AssignedCompaniesPanel.Enabled =
                this.AssignedCompaniesDataList.Visible =
                this.AssignedCompaniesDataList.Enabled = showPanel;
            if (this.AssignedCompaniesDataList.Enabled)
            {
                this.UserCompaniesSource.DataBind();
                this.AssignedCompaniesDataList.DataBind();
            }
        }

        protected void AllUsersGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.Session["CurrentUserId"] = this.AllUsersGridView.SelectedDataKey["Id"];
            this.UpdateUserDetailPanel();
            
        }

        private void UpdateUserDetailPanel(Boolean showPanel = true)
        {
            this.UserDetailsPanel.Visible = showPanel;
            if ( this.UserDetailsPanel.Visible) {
                if (this.CompanyDropDownList.Items.Count < 2)
                    this.CompanyDropDownList.DataBind();

                if (this.Session["CurrentUserId"] != null)
                {
                    User user = this.DataContext.Users.SingleOrDefault(u => u.Id == Convert.ToInt32(this.Session["CurrentUserId"]));
                    this.UserNameTextBox.Text = user.UserName;
                    this.EmailTextBox.Text = user.Email;
                    this.FirstNameTextBox.Text = user.FirstName;
                    this.LastNameTextBox.Text = user.LastName;
                    this.EmpNoTextBox.Text = user.Code;
                    if (this.CompanyDropDownList.Items.Count < 2) this.CompanyDropDownList.DataBind();
                    this.CompanyDropDownList.SelectedValue = user.CompanyWorkingFor_Id.ToString();
                    MembershipUser membership = Membership.GetUser(user.UserName);
                    this.EmployeeRoleCheckBox.Checked
                        = Roles.IsUserInRole(user.UserName, EmpRole);
                    this.ApproverRoleCheckBox.Checked
                        = Roles.IsUserInRole(user.UserName, ApproverRole);
                    this.AdministratorRoleCheckBox.Checked
                        = Roles.IsUserInRole(user.UserName, AdmRole);
                    this.UpdateAssignedCompanyPanel(this.ApproverRoleCheckBox.Checked);
                    this.LockedCheckBox.Checked = !membership.IsApproved;
                }
                else // Prepare empty detail form for a new user
                {
                    this.UserNameTextBox.Text
                        = this.EmailTextBox.Text
                        = this.FirstNameTextBox.Text
                        = this.LastNameTextBox.Text
                        = this.PasswordTextBox.Text
                        = this.Password2TextBox.Text;
                    this.CompanyDropDownList.SelectedValue = "";
                    this.EmployeeRoleCheckBox.Checked
                        = this.ApproverRoleCheckBox.Checked
                        = this.AdministratorRoleCheckBox.Checked = false;
                    UpdateAssignedCompanyPanel(false);
                }

            }
        }

        protected void NewUserButton_Click(object sender, EventArgs e)
        {
            // Unselect GridView
            this.AllUsersGridView.SelectedIndex = -1;
            this.Session["CurrentUserId"] = null;
            this.UpdateUserDetailPanel();
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            User user;

            if (this.UserNameTextBox.Text == "")
                this.UserNameTextBox.Text = this.EmailTextBox.Text;
            if ( this.Session["CurrentUserId"] == null )
            { 
                user = new User() {
                    UserName = this.UserNameTextBox.Text
                };
                this.DataContext.Users.InsertOnSubmit( user);                    
            } else
                user = this.DataContext.Users.SingleOrDefault(u => u.Id == Convert.ToInt32(this.Session["CurrentUserId"]));

            user.Email = this.EmailTextBox.Text;
            user.FirstName = this.FirstNameTextBox.Text;
            user.LastName = this.LastNameTextBox.Text;
            if ( !String.IsNullOrEmpty(this.CompanyDropDownList.SelectedValue) )
                user.CompanyWorkingFor_Id = Int32.Parse( this.CompanyDropDownList.SelectedValue );
            if (!String.IsNullOrEmpty(this.EmpNoTextBox.Text ))
                user.Code = this.EmpNoTextBox.Text;


            MembershipUser membershipUser;
            if (this.Session["CurrentUserId"] == null)
            {
                membershipUser = Membership.CreateUser(
                    user.UserName,
                    this.PasswordTextBox.Text,
                    user.Email);
            } else {
                membershipUser =  Membership.GetUser(user.UserName);
            }

            if (this.Session["CurrentUserId"] != null && this.PasswordTextBox.Text != "" )
            {
                string resetPwd = membershipUser.ResetPassword();
                membershipUser.ChangePassword(resetPwd, this.PasswordTextBox.Text);
            }

            this.updateUserRole(user.UserName, EmpRole, this.EmployeeRoleCheckBox.Checked );
            this.updateUserRole(user.UserName, AdmRole, this.AdministratorRoleCheckBox.Checked);
            membershipUser.IsApproved = !LockedCheckBox.Checked;
            
            foreach (DataListItem dli in this.AssignedCompaniesDataList.Items)
            {
                CheckBoxWithValue checkBox = (CheckBoxWithValue)dli.FindControl("AssignedCompanyCheckBoxWithValue");
                int companyId = Convert.ToInt32(checkBox.Value);
                UserCompany uc = user.UserCompanies.SingleOrDefault(c => c.Companies_Id == companyId);
                if (uc == null && checkBox.Checked) // Add
                {
                    uc = new UserCompany();
                    uc.User = user;
                    uc.Companies_Id = companyId;
                    user.UserCompanies.Add(uc);
                }
                else if (uc != null && !checkBox.Checked) // Remove
                {
                    this.DataContext.UserCompanies.DeleteOnSubmit(uc);
                    user.UserCompanies.Remove(uc);
                }
            }

            Membership.UpdateUser(membershipUser);
            this.DataContext.SubmitChanges();
            this.AllUsersGridView.DataBind();
        }


        public void updateUserRole(string UserName, string RoleName, Boolean addToRole)
        {
            Boolean belongsToRole = Roles.IsUserInRole(UserName, RoleName);
            if (belongsToRole && !addToRole) // Remove the role
                Roles.RemoveUserFromRole(UserName, RoleName);
            else if ( !belongsToRole && addToRole ) // Add the role
                Roles.AddUserToRole(UserName, RoleName);
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            Membership.DeleteUser(this.CurrentUser.UserName, true);
            this.DataContext.Users.DeleteOnSubmit(this.CurrentUser);
            this.DataContext.SubmitChanges();
            this.AllUsersGridView.DataBind();
        }

    }
}