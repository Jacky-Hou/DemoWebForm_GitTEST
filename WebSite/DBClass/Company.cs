using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace WebSite.DBClass
{
    public class Company
    {
        public DataTable GetHomeImg()
        {
            StringBuilder sb = new StringBuilder();
            DBAccess DbAcs = new DBAccess();

            sb.Append(" Select CompanyName,MailCompanyName,CalendarType ");
            sb.Append(" ,Email,webDescr,webKeyWord,ImgPath01 From ugHomeImg ");

            DataTable dt = DbAcs.GetDBData(sb.ToString());

            return dt;
        }

    }


}