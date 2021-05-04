using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Captcha_Text
{
    public partial class ugC_Captcha_text : System.Web.UI.Page
    {
        private string strCaptchaCode;
        public string CaptchaCode
        {
            get { return strCaptchaCode;}
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            strCaptchaCode = Session["FrontCaptchaCode"].ToString();
        }
    }
}