using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebSite
{
    public class UgMenuUserLoginTime
    {
        public int UserID;
        public string LoginID;
        public string IPAddr;
        public string LoginTime;
    }

    public class UgLoginIP
    {
        public string IPAddr;
        public string Allow;
        public string Descr;
        public string DBSts;
        public string CreUser;
        public string CreDate;
    }

    public class Log
    {
        //取ugLoginLog筆數
        public DataTable Get_ugLoginLog(int LoginLogID)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            sb.Append(" Select Count(*) From ugLoginLog where LoginLogID = @LoginLogID ");
            paralist.Add(DbAcs.BuildDbParameter("@LoginLogID", LoginLogID));

            DataTable dt = DbAcs.GetDBData(sb.ToString(), paralist);

            return dt;
        }

        //更新LogoutTime時間
        public void Update_ugLoginLog(int LoginLogID)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            sb.Append(" Update ugMenuUserLoginTime Set LogoutTime = @LogoutTime where LoginLogID = @LoginLogID ");

            paralist.Add(DbAcs.BuildDbParameter("@LoginLogID", LoginLogID));
            paralist.Add(DbAcs.BuildDbParameter("@LogoutTime", DateTime.Now.ToString()));

            DbAcs.CUD(sb.ToString(), paralist);
        }

        public void Insert_ugLoginIP(UgLoginIP data)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            sb.Append(" Insert Into ugLoginIP (IPAddr,Allow,Descr,CreUser) ");
            sb.Append(" Values (@IPAddr,@Allow,@Descr,@CreUser) ");
            paralist.Add(DbAcs.BuildDbParameter("@IPAddr", data.IPAddr));
            paralist.Add(DbAcs.BuildDbParameter("@Allow", data.Allow));
            paralist.Add(DbAcs.BuildDbParameter("@Descr", data.Descr));
            paralist.Add(DbAcs.BuildDbParameter("@CreUser", data.CreUser));
            //paralist.Add(new OleDbParameter("@CreDate", data.CreDate));

            DbAcs.CUD(sb.ToString(), paralist);
        }

        public void Insert_ugMenuUserLoginTime(UgMenuUserLoginTime data)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            sb.Append(" Insert Into ugMenuUserLoginTime (LoginTime,LoginID,UserID,IPAddr) ");
            sb.Append(" Values (@LoginTime,@LoginID,@UserID,@IPAddr) ");
            paralist.Add(DbAcs.BuildDbParameter("@LoginTime", data.LoginTime));
            paralist.Add(DbAcs.BuildDbParameter("@LoginID", data.LoginID));
            paralist.Add(DbAcs.BuildDbParameter("@UserID", data.UserID));
            paralist.Add(DbAcs.BuildDbParameter("@IPAddr", data.IPAddr));

            DbAcs.CUD(sb.ToString(), paralist);
        }

        public int CheckLockIP(string LocalIP)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();
            DataTable dt = new DataTable();

            try
            {
                sb.Append(" Select LoginIP_ID From ugLoginIP where IPAddr = @IPAddr And DBSts = 'A' and Allow = 'N' ");
                paralist.Add(DbAcs.BuildDbParameter("@IPAddr", LocalIP));

                dt = DbAcs.GetDBData(sb.ToString(), paralist);
            }
            catch (Exception ex)
            {
                //syslog.LogRecord(ex.Message,Server.MapPath("~"), System.Reflection.MethodBase.GetCurrentMethod().Name);
            }

            return dt.Rows.Count;
        }
    }

}
