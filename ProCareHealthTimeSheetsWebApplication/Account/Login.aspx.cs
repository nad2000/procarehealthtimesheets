using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareAssociates.ProCareHealth.Account
{
    public partial class Login : System.Web.UI.Page
    {

        //protected void RegisterHyperLink_Load(object sender, EventArgs e)
        //{
        //    ((HyperLink)sender).NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
        //}
        protected void LoginUser_LoggingIn(object sender, LoginCancelEventArgs e)
        {

            if (this.LoginUser.UserName.Contains("@"))
            {
                this.LoginUser.UserName = 
                    System.Web.Security.Membership.GetUserNameByEmail(this.LoginUser.UserName.ToLower() );
            }
            //System.Web.Security.MembershipUser membership = System.Web.Security.Membership.GetUser(this.LoginUser.UserName );
            //e.Cancel = !membership.IsApproved;
        }

        protected void LoginUser_LoggedIn(object sender, EventArgs e)
        {
            WorkSheetDataClassesDataContext context = new WorkSheetDataClassesDataContext();
            var res = context.GetUserDataByUserName(this.LoginUser.UserName);
            this.Session["UserDetails"] = res.First();
        }

    }
}
