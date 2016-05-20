using System;
using System.Collections.Generic;
using System.Linq;
using SoftwareAssociates.ProCareHealth.Web.UI;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.UI.HtmlControls;

namespace SoftwareAssociates.ProCareHealth
{
    public partial class FullReport : SoftwareAssociates.ProCareHealth.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
                this.FullGridView.DataBind();
        }

        protected void ApprovableUserDropDownList_DataBound(object sender, EventArgs e)
        {
            ///ApprovableUserDropDownList.SelectedIndex = 0;
        }

        protected void ParametersChanged(object sender, EventArgs e)
        {
            this.FullGridView.DataBind();
        }

        protected void ApprovableUsersSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            this.DataContext.GetApprovableUsers(this.UserName);
        }


        protected void UpdateExporLink()
        {
            ExportHyperLink.NavigateUrl = String.Format(
                "~/ExportCSV.ashx?DateFrom={0:yyyy'-'MM'-'dd}&DateTo={1:yyyy'-'MM'-'dd}",
                Convert.ToDateTime(DateFromDropDownList.SelectedValue),
                Convert.ToDateTime(DateToDropDownList.SelectedValue));
            if ( IncludeUnapprovedCheckBox.Checked )
                this.ExportHyperLink.NavigateUrl += "&IncludeUnapproved=yes";
            if ( !String.IsNullOrEmpty( CompanyDropDownList.SelectedValue) )
                this.ExportHyperLink.NavigateUrl += ( "&CompanyId=" + CompanyDropDownList.SelectedValue );
        }

        protected void ExportHyperLink_PreRender(object sender, EventArgs e)
        {
            UpdateExporLink();
        }

        protected void DateFromDropDownList_DataBound(object sender, EventArgs e)
        {
            DateFromDropDownList.SelectedIndex = 1;
        }

        protected void DateToDropDownList_DataBound(object sender, EventArgs e)
        {
            DateToDropDownList.SelectedIndex = 0;
        }

    }
}