using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Web;

namespace WebSite
{
    public class Event
    {
        public DataTable Get_EventRec(string reqFType, string par1 = "")
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();
            DataTable dt;

            switch (reqFType)
            {
                case "getByAcctID":
                    sb.Append(" Select Count(*) as [EventRecCount],AcctID From ugEventRec ");
                    if (par1 != "")
                    {
                        sb.Append(" Where AcctID=@AcctID");
                        paralist.Add(DbAcs.BuildDbParameter("@AcctID", par1));
                    }
                    sb.Append(" Group by AcctID ");
                    break;
            }

            if (paralist.Count > 0)
                dt = DbAcs.GetDBData(sb.ToString(), paralist);
            else
                dt = DbAcs.GetDBData(sb.ToString());

            return dt;
        }
    }
}