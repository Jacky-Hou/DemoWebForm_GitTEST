using ClassLibrary;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Admin
{
    public partial class ugA_Pagination : System.Web.UI.UserControl
    {
        public int PageSize
        {
            get;set;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!Utility.CheckSession("saLoginID"))
            //    Response.Redirect("../Default.aspx");
        }
    }
}