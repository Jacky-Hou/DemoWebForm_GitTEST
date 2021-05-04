using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace WebSite
{
    public class GetWebConfig : System.Web.UI.Page
    {

        private static string titleStr = GetWebConfig.AppStting("CompName");   //網站顯示的公司名稱
        private static string endDate = GetWebConfig.AppStting("EndDate");     //逾期時間
        private static string rentSts = GetWebConfig.AppStting("RentSts");     //承租空間
        private static string quota = GetWebConfig.AppStting("Quota");         //使用空間
        private static string hiNetSpace = GetWebConfig.AppStting("HiNetSpace");
        public static string TitleStr
        {
            get { return titleStr; }
        }
        public static string EndDate
        {
            get { return endDate; }
        }
        public static string RentSts
        {
            get { return rentSts; }
        }
        public static string Quota
        {
            get { return quota; }
        }
        public static string HiNetSpace
        {
            get { return hiNetSpace; }
        }

        public static string AppStting(string txt)
        {
            return WebConfigurationManager.AppSettings[txt].ToString();
        }
        public static ConnectionStringSettings ConnectionString(string txt)
        {
            return WebConfigurationManager.ConnectionStrings[txt];
        }


        //取得網站資料夾大小
        //public static long[] GetQuota(string DirectoryPath)
        //{
        //    long[] Quotas = new long[] { 0, 0, 0 };
        //    long lQuota = 0;
        //    if (GetWebConfig.AppStting("Quota") != "")
        //        lQuota = Convert.ToInt64(GetWebConfig.AppStting("Quota"));

        //    if (isHiSpaceRent && lQuota > 0)
        //    {
        //        DirectoryInfo di = new DirectoryInfo(DirectoryPath);//輸入檔案夾
        //        double d = DirectorySize(di);
        //        int i = (int)(d * 100 / (lQuota > 0 ? lQuota : 1));
        //        Quotas[0] = lQuota;             //0:承租空間(byte)
        //        Quotas[1] = i;                  //1:已使用空間(%)
        //        Quotas[2] = (long)(lQuota - d); //2:尚餘空間(byte)
        //    }

        //    return Quotas;
        //}

        //public static double DirectorySize(DirectoryInfo directoryInfo)
        //{
        //    double Size = 0;
        //    FileInfo[] fi = directoryInfo.GetFiles();
        //    foreach (FileInfo f in fi)
        //        Size += f.Length;

        //    DirectoryInfo[] dis = directoryInfo.GetDirectories();
        //    foreach (DirectoryInfo d in dis)
        //    {
        //        if (d.Name != "System Volume Information" && d.Name.Substring(0, 1) != "$")
        //            Size += DirectorySize(d);
        //    }
        //    return (Size);

        //}

        //取得是否承租空間
        //public static bool isHiSpaceRent
        //{
        //    get
        //    {
        //        string R = GetWebConfig.AppStting("RentSts");
        //        return R.ToLower() == "y" || R.ToLower() == "yes" || R.ToLower() == "true";
        //    }
        //}

        //判斷到期日
        //public static bool IsHiSpaceExpiry(int day)
        //{
        //    DateTime dbEndDate = DateTime.Parse(GetWebConfig.AppStting("EndDate"));
        //    if (isHiSpaceRent && System.DateTime.Now > dbEndDate.AddDays(day))
        //        return true;
        //    return false;
        //}

        //public static bool IsHiSpaceExpiryReminder
        //{
        //    get
        //    {
        //        DateTime dbEndDate = DateTime.Parse(GetWebConfig.AppStting("EndDate"));
        //        if (isHiSpaceRent && System.DateTime.Now > dbEndDate.AddDays(-60))
        //            return true;
        //        return false;

        //    }
        //}

        //public bool IsHiSpaceExpiry
        //{
        //    get
        //    {
        //        DateTime dtEndDate = DateTime.Parse(GetWebConfig.AppStting("EndDate"));
        //        if (isHiSpaceRent && System.DateTime.Now < dtEndDate)
        //            return false;
        //        return true;
        //    }

        //}
    }
}