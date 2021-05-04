using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Web;

namespace WebSite
{
    public class AdminSetting
    {
        public string GetBackImg()
        {
            string BackgroundImg = "Def_bg01.jpg";
            StringBuilder sb = new StringBuilder();
            DBAccess DbAcs = new DBAccess();
            sb.Append(" Select Top 1 backgroundImg From ugV_AdminSetting ");
            DataTable dt = DbAcs.GetDBData(sb.ToString());

            if (dt.Rows[0]["backgroundImg"] != null && dt.Rows[0]["backgroundImg"].ToString() != "")
                BackgroundImg = dt.Rows[0]["backgroundImg"].ToString();
            return BackgroundImg;
        }
    }
}