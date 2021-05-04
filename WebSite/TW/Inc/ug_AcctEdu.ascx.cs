using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Inc
{
    public partial class ug_AcctEdu : System.Web.UI.UserControl
    {
        string strAcctEdu = PubicClass.AcctEdu;
        public string AcctEdu
        {
            get { return strAcctEdu; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}