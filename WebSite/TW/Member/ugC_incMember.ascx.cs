using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Member
{
    public partial class ugC_incMember : System.Web.UI.UserControl
    {
        string strCSRFtoken;
        Cryptography cryptography = new Cryptography();
        public string CSRFtoken
        {
            get { return strCSRFtoken; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //防止 CSRF
            strCSRFtoken = cryptography.EncryptAES(Guid.NewGuid().ToString(), PubicClass.CrypotographyKey, PubicClass.CrypotographyVectory);
            Session["CSRFtoken"] = strCSRFtoken;
        }
    }
}