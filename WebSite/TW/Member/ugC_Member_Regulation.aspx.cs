using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Member
{
    public partial class ugC_Member_Regulation : System.Web.UI.Page
    {
        int intMenuID_1 = 3;
        int intMenuID_2 = 31;
        string strCurrentPageName = "";
        string strFrontMenuName = "";
        DataTable dt = new DataTable();
        Menus menus = new Menus();
        static Account account = new Account();

        public string CurrentPageName
        {
            get { return strCurrentPageName; }
        }

        public string FrontMenuName
        {
            get { return strFrontMenuName; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            dt = menus.Get_ugMenu("getByMenuID", intMenuID_1.ToString());
            strFrontMenuName = dt.Rows[0]["MenuName_Front"].ToString();

            dt = menus.Get_ugMenu("getByMenuID", intMenuID_2.ToString());
            strCurrentPageName = dt.Rows[0]["MenuName_Front"].ToString();
        }

        [WebMethod]
        public static string GetMemberRegulation()  //取服務條款(固定)
        {
            JObject JO = new JObject();
            DataTable dt = account.Get_MemberRegulation();

            JO.Add("MemberRegulationData", JsonConvert.SerializeObject(dt));
            return JsonConvert.SerializeObject(JO);
        }
    }
}