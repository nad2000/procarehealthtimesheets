using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SoftwareAssociates.ProCareHealth
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.User.IsInRole("Approvers")) this.Response.Redirect("~/Approving3.aspx", true);
            else if (this.User.IsInRole("Administrators")) this.Response.Redirect("~/Admin/Admin.aspx", true);
            else /* if (this.User.IsInRole("Employees")) */ this.Response.Redirect("~/FillingIn.aspx", true);
        }
    }
}