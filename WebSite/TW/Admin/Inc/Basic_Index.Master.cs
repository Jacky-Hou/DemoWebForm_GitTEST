using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Admin
{
    public partial class Basic_Index : System.Web.UI.MasterPage
    {
        public string backImage;
        public string Path = PubicClass.Path;
        AdminSetting AdSetting = new AdminSetting();
        public string BackImage
        {
            get { return backImage; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            backImage = AdSetting.GetBackImg();
        }
    }
}