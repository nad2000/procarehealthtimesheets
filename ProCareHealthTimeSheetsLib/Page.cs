using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SoftwareAssociates.ProCareHealth.Web.UI
{
    public class Page : System.Web.UI.Page
    {
        
        protected override void OnLoad(EventArgs e)
        {
            // Before handling Load event:
            if (!this.IsPostBack)
            {
                this.Session["UserId"] = this.UserId;
                this.Session["UserName"] = this.User.Identity.Name;
                this.Session["UserCompanyName"] = this.UserCompanyName;
                this.Session["UserEmailAddress"] = this.UserEmailAddress;
            }
            base.OnLoad(e);
        }

        private string _userCode;
        private string _userFirstName;
        private string _userLastName;
        private string _userFullName;
        private Nullable<int> _userId;
        private string _userCompanyCode;
        private string _userCompanyName;
        private string _userEmailAddress;
        //private string _userName;
        private WorkSheetDataClassesDataContext _context;

        public WorkSheetDataClassesDataContext DataContext
        {
            get
            {

                if (this._context == null) this._context = new WorkSheetDataClassesDataContext();
                return this._context;
            }
        }

        public string UserFullName
        {
            get
            {
                if (this._userFullName == null) this.setUserProperties();
                return this._userFullName;
            }
        }

        public string UserEmailAddress
        {
            get
            {
                if (this._userEmailAddress == null) this.setUserProperties();
                return this._userEmailAddress;
            }
        }

        public string UserCompanyName
        {
            get
            {
                if (this._userCompanyName == null) this.setUserProperties();
                return this._userCompanyName;
            }
        }

        public int? UserId
        {
            get
            {
                if (this._userId == null) this.setUserProperties();
                return this._userId;
            }
        }

        public string UserName
        {
            get
            {
                return this.User.Identity.Name;
            }
        }


        private void setUserProperties()
        {
            var res = this.DataContext.GetUserDataByUserName(this.User.Identity.Name);
            var userDetails = res.First();
            this._userCode = userDetails.Code;
            this._userFullName = userDetails.FullName;
            this._userFirstName = userDetails.FirstName;
            this._userLastName = userDetails.LastName;
            this._userId = userDetails.Id;
            this._userCompanyCode = userDetails.CompanyCode;
            this._userCompanyName = userDetails.CompanyName;
            this._userEmailAddress = userDetails.Email;
        }

        public string TotalTimeFormated(object value)
        {
            if (value is DBNull) return "";
            else
            {
                return (value is DBNull) ? "" :
                String.Format("{0:0}:{1:00}", Convert.ToInt32(value) / 60, Convert.ToInt32(value) % 60);
            };
        }

        public bool RowIsNotApprovedYet(object value)
        {
            return (value is DBNull) || !(bool)value;
        }

        public bool IsInteger(string val)
        {
            int result;
            return int.TryParse(val, out result);
        }

        public SoftwareAssociates.ProCareHealth.GetUserDataByUserNameResult UserDetails
        {
            // Session["UserDetails"] is set up at LogIn:
            get
            {
                return (SoftwareAssociates.ProCareHealth.GetUserDataByUserNameResult)Session["UserDetails"];
            }
        }

    }
}
