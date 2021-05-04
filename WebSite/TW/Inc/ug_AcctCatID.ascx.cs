using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Inc
{
    public partial class ug_AcctCatID : System.Web.UI.UserControl
    {
        string strAcctCatID;
        int intAcctCatIDRang = AdminClass.intAcctCatIDRang;

        public string FirstIndex
        {
            get;set;
        }
        public string AcctCatID
        {
            get { return strAcctCatID; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Account account = new Account();
            DataTable dt = account.Get_AcctCat("getByAcctCatIdRange", intAcctCatIDRang.ToString());
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i > 0)
                    strAcctCatID += ",";
                strAcctCatID += dt.Rows[i]["AcctCatID"].ToString() + "&" + dt.Rows[i]["CatName"].ToString() + "&" + dt.Rows[i]["UpSts"].ToString();
            }
        }
    }
}