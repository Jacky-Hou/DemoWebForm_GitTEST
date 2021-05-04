using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Inc
{
    public partial class ug_AcctOccu : System.Web.UI.UserControl
    {
        string strAcctOccu = PubicClass.AcctOccu;
        public string AcctOccu
        {
            get { return strAcctOccu; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}