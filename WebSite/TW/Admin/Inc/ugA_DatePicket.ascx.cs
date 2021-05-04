using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Admin.Inc
{
    public partial class ugA_DatePicket : System.Web.UI.UserControl
    {
        public string DisabledDateList { get; set; }
        public string minDate { get; set; }
        public bool W1 { get; set; } = true;
        public bool W2 { get; set; } = true;
        public bool W3 { get; set; } = true;
        public bool W4 { get; set; } = true;
        public bool W5 { get; set; } = true;
        public bool W6 { get; set; } = true;
        public bool W7 { get; set; } = true;    //Sunday

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}