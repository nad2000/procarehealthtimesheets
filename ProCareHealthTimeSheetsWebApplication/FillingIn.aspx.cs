using System;
using System.Collections.Generic;
using System.Linq;
using SoftwareAssociates.ProCareHealth.Web.UI;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareAssociates.ProCareHealth
{
    public partial class FillingIn : SoftwareAssociates.ProCareHealth.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.UserNameHiddenField.Value = this.User.Identity.Name;
                //this.UserDataSource.SelectParameters["UserName"].DefaultValue = this.User.Identity.Name;
            }
        }

      
        protected void WeekEndingDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.TimeSheetGridView.DataBind();
        }

        protected void WeekEndingDropDownList_DataBound(object sender, EventArgs e)
        {
            this.WeekEndingDropDownList.SelectedIndex = 0;
            this.TimeSheetGridView.DataBind();
        }

        protected void WorkSheetGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            ((GridView)sender).SelectedIndex = e.NewEditIndex;
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            TextBox startedAtTextBox, endedAtTextBox;
            DropDownList breakTypeDropDownList;
            Label dateLabel;
            HiddenField idHiddenField;


            foreach (GridViewRow r in TimeSheetGridView.Rows)
            {
                idHiddenField = (HiddenField)r.FindControl("IdHiddenField");
                dateLabel = (Label)r.FindControl("DateLabel");
                startedAtTextBox = (TextBox)r.FindControl("StartedAtTextBox");
                endedAtTextBox = (TextBox)r.FindControl("EndedAtTextBox");
                breakTypeDropDownList = (DropDownList)r.FindControl("BreakTypeDropDownList");

                // If no time values entered skip:
                /* 
                if (String.IsNullOrEmpty(startedAtTextBox.Text)
                    || String.IsNullOrEmpty(endedAtTextBox.Text)) continue; 
                 */ 

                this.DataContext.UserTimeSheetEntry_Update(
                    (String.IsNullOrEmpty(idHiddenField.Value) ? null : (int?)Convert.ToInt32(idHiddenField.Value)),
                    Convert.ToDateTime(dateLabel.Text),
                    (String.IsNullOrEmpty(startedAtTextBox.Text) ? null : (TimeSpan?)TimeSpan.Parse(startedAtTextBox.Text)),
                    (String.IsNullOrEmpty(endedAtTextBox.Text) ? null : (TimeSpan?)TimeSpan.Parse(endedAtTextBox.Text)),
                    (String.IsNullOrEmpty(breakTypeDropDownList.SelectedValue) ? null : (int?)Convert.ToInt32(breakTypeDropDownList.SelectedValue)),
                    this.UserId);
            }
            this.TimeSheetGridView.DataBind();
        }

        //protected void WorkSheetGridView_RowClicked(object sender, GridViewRowClickedEventArgs args)
        //{
        //    //args.Row.RowState = DataControlRowState.Edit | DataControlRowState.Selected;
        //    GridView gw = ((GridView)sender);
        //    GridViewRow r = args.Row;
        //    gw.SelectedIndex = gw.EditIndex = args.Row.RowIndex;
        //    gw.DataBind();
        //}

    }
}