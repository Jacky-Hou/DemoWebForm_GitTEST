using ClassLibrary;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Admin.Acct
{
    public partial class ugA_AcctCat : System.Web.UI.Page
    {
        string strAddModifyUrl = "ugA_AcctCat_m.aspx";
        string strGoToAcctUrl = "ugA_Acct.aspx";
        static int intAcctCatIDRang = AdminClass.intAcctCatIDRang;
        AdminClass adClass = new AdminClass();
        MenuUserPermission MUPermission = new MenuUserPermission();

        public string Type_All
        {
            get { return MUPermission.Type_All; }
        }
        public string Type_Look
        {
            get { return MUPermission.Type_Look; }
        }
        public string Type_Add
        {
            get { return MUPermission.Type_Add; }
        }
        public string Type_Update
        {
            get { return MUPermission.Type_Update; }
        }
        public string Type_Del
        {
            get { return MUPermission.Type_Del; }
        }
        public string HightUser
        {
            get { return MUPermission.HightUser; }
        }
        public string AddModifyUrl
        {
            get { return strAddModifyUrl; }
        }

        public string GoToAcctUrl
        {
            get {return strGoToAcctUrl; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Utility.CheckSession("saUserID"))
                Response.Redirect("../Default.aspx");
            adClass.GetUserIDPermission(Request.Url.Segments[Request.Url.Segments.Length - 1], ref MUPermission);

        }

        [WebMethod]
        public static string GetAcctCat()
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            Account account = new Account();
            DataTable dt = account.Get_AcctCat("getByAcctCatIdRange", intAcctCatIDRang.ToString());
            DataTable dtAcct = account.Get_ugAcct("getCount", intAcctCatIDRang.ToString());
            dt.Columns.Add("Count");

            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataRow drAcct in dtAcct.Rows)
                {
                    if (dr["AcctCatId"].ToString() == drAcct["AcctCatId"].ToString())
                        dr["Count"] = drAcct["Count"];
                }
            }

            JO.Add("AcctCateData", JsonConvert.SerializeObject(dt));
            return JsonConvert.SerializeObject(JO);
        }

        [WebMethod]
        public static string DelAcctCat(string[] AcctCatID)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            int i;
            Account account = new Account();
            try
            {
                //i = Ac.Delete_ugAcctCat(AcctCatID); //Delete Finish return Delete Count
                i = account.Delete_List("ugAcctCat", AcctCatID); //Delete Finish return Delete Count
            }
            catch (Exception ex)
            {
                i = 0;
            }

            JO.Add("ReturnCode", i);
            return JsonConvert.SerializeObject(JO);
        }

    }
}