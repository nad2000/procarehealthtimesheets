using System.Web.UI.WebControls;

namespace SoftwareAssociates.ProCareHealth
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void MainContent_Load(object sender, System.EventArgs e)
        {
            if (this.Page is SoftwareAssociates.ProCareHealth.Web.UI.Page)
            {
                if( !this.IsPostBack ) {
                    string companyName = ((SoftwareAssociates.ProCareHealth.Web.UI.Page)this.Page).UserCompanyName;
                    if ( !string.IsNullOrEmpty( companyName) ) {
                        this.TitleLabel.Text = companyName + " / ProCare Health Timesheets";
                    }
                }
            }

        }

        public SoftwareAssociates.ProCareHealth.GetUserDataByUserNameResult UserDetails {
            get {
                return (SoftwareAssociates.ProCareHealth.GetUserDataByUserNameResult)Session["UserDetails"];
            }
        }
            
    }
}
