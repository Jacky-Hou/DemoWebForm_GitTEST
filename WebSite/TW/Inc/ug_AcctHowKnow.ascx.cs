using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Inc
{
    public partial class ug_AcctHowKnow : System.Web.UI.UserControl
    {
        string strAcctHowKnow = PubicClass.AcctHowKnow;
        public string AcctHowKnow
        {
            get { return strAcctHowKnow; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}