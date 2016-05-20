using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareAssociates.ProCareHealth
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:CheckBoxWithValue runat=server></{0}:CheckBoxWithValue>")]
    public class CheckBoxWithValue : CheckBox
    {
        [Bindable(true)]
        [Category("Value")]
        [DefaultValue("")]
        [Localizable(true)]
        public string Value
        {
            get
            {
                String s = (String)ViewState["Value"];
                return ((s == null) ? String.Empty : s);
            }

            set
            {
                ViewState["Value"] = value;
            }
        }
    }
}
