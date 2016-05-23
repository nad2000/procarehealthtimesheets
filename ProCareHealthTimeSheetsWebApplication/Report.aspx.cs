using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.UI.HtmlControls;

namespace SoftwareAssociates.ProCareHealth
{
    public partial class Report : SoftwareAssociates.ProCareHealth.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!this.IsPostBack)
                //this.SummaryGridView.DataBind();
        }

        protected void ApprovableUserDropDownList_DataBound(object sender, EventArgs e)
        {
            if (ApprovableUserDropDownList.Items.Count > 0)
            {
                this.ApprovableUserDropDownList.SelectedIndex = 0;
                this.SummaryGridView.DataBind();
            }
        }
        protected void ParameterDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.SummaryGridView.DataBind();
        }

        protected void ApprovableUsersSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            this.DataContext.GetApprovableUsers(this.UserName);
        }

        protected void SelectDataButton_Click(object sender, EventArgs e)
        {
            this.SummaryGridView.DataBind();
        }

        protected void ExportButton_Click(object sender, EventArgs e)
        {
            string attachment =
                String.Format(
                    "attachment; filename=TimeSheetSummary_{0:yyyy'-'MM'-'dd}_{1:yyyy'-'MM'-'dd}.xls",
                    Convert.ToDateTime( DateFromDropDownList.SelectedValue),
                    Convert.ToDateTime( DateToDropDownList.SelectedValue) );

            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            // Create a form to contain the grid
            HtmlForm frm = new HtmlForm();
            this.SummaryGridView.Parent.Controls.Add(frm);
            frm.Attributes["runat"] = "server";
            frm.Controls.Add(this.SummaryGridView);
            frm.RenderControl(htw);
            //SummaryGridView.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
        }
    }
}