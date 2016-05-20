using System;
using System.Collections.Generic;
using System.Linq;
using SoftwareAssociates.ProCareHealth.Web.UI;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareAssociates.ProCareHealth
{
    public partial class Approving2 : SoftwareAssociates.ProCareHealth.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.SetWeekEndingParameter();
            }

        }

        private void SetWeekEndingParameter()
        {
            this.TimeSheetSource.SelectParameters["WeekEndingDate"].DefaultValue
                = String.Format("{0:d}",
                ThisWeekButton.Enabled ? this.DataContext.LastWeekEndingDate()
                                       : this.DataContext.ThisWeekEndingDate());
        }

        protected void ApprovableUsersSource_Selecting( object sender, LinqDataSourceSelectEventArgs e)
        {
            this.DataContext.GetApprovableUsers(this.UserName);
        }

        protected void WeekButton_Click(object sender, EventArgs e)
        {
            ThisWeekButton.Enabled = !(LastWeekButton.Enabled = !LastWeekButton.Enabled);
            this.SetWeekEndingParameter();
            this.TimeSheetGridView.DataBind();
        }

        protected void ApprovableUserDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.TimeSheetGridView.DataBind();
        }


        private int _sumOfTotalTime = 0;

        protected void TimeSheetGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow
                            && !(DataBinder.Eval(e.Row.DataItem, "TotalTime") is DBNull))
            {
                int total = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalTime"));
                this._sumOfTotalTime += total;
            }
            else if (e.Row.RowType == DataControlRowType.Footer )
            {
                if (this._sumOfTotalTime > 0)
                {
                    TimeSheetGridView.ShowFooter = true;
                    ((Label)e.Row.FindControl("SumOfTotalTimeLabel")).Text = 
                        this.TotalTimeFormated( this._sumOfTotalTime.ToString() );
                }
                else
                    TimeSheetGridView.ShowFooter = false;
            }

        }

        protected void ApprovableUserDropDownList_DataBound(object sender, EventArgs e)
        {
            if (ApprovableUserDropDownList.Items.Count > 0)
            {
                ApprovableUserDropDownList.SelectedIndex = 0;
                TimeSheetGridView.DataBind();
            }
        }

        protected void TimeSheetGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            ((GridView)sender).SelectedIndex = e.NewEditIndex;
        }

        protected void TimeSheetGridView_DataBinding(object sender, EventArgs e)
        {
            this._sumOfTotalTime = 0;
            foreach ( GridViewRow r in TimeSheetGridView.Rows ) 
                r.RowState = DataControlRowState.Edit;
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            TextBox startedAtTextBox, endedAtTextBox, commentTextBox;
            DropDownList breakTypeDropDownList;
            CheckBox isApprovedCheckBox;
            Label dateLabel, idLabel;
            

            foreach (GridViewRow r in TimeSheetGridView.Rows)
            {
                idLabel = (Label)r.FindControl("IdLabel");
                dateLabel = (Label)r.FindControl("DateLabel");
                startedAtTextBox = (TextBox)r.FindControl("StartedAtTextBox");
                endedAtTextBox = (TextBox)r.FindControl("EndedAtTextBox");
                breakTypeDropDownList = (DropDownList)r.FindControl("BreakTypeDropDownList");
                isApprovedCheckBox = (CheckBox)r.FindControl("IsApprovedCheckBox");
                commentTextBox = (TextBox)r.FindControl("CommentTextBox");

                // If no time values entered skip:
                if (String.IsNullOrEmpty(startedAtTextBox.Text)
                    || String.IsNullOrEmpty(endedAtTextBox.Text)) continue;

                this.DataContext.ApproverTimeSheetEntry_Update(
                    (String.IsNullOrEmpty(idLabel.Text) ? null : (int?)Convert.ToInt32(idLabel.Text)),
                    Convert.ToDateTime(dateLabel.Text),
                    (String.IsNullOrEmpty(startedAtTextBox.Text) ? null : (TimeSpan?)TimeSpan.Parse(startedAtTextBox.Text)),
                    (String.IsNullOrEmpty(endedAtTextBox.Text) ? null : (TimeSpan?)TimeSpan.Parse(endedAtTextBox.Text)),
                    (String.IsNullOrEmpty(breakTypeDropDownList.SelectedValue) ? null : (int?)Convert.ToInt32(breakTypeDropDownList.SelectedValue)),
                    isApprovedCheckBox.Checked,
                    commentTextBox.Text,
                    this.UserId,
                    this.ApprovableUserDropDownList.SelectedValue);

            }
            this.TimeSheetGridView.DataBind();
        }

    }
}
