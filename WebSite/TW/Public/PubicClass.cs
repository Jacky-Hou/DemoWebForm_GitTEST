using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace WebSite
{
    public class PubicClass : System.Web.UI.Page
    {
        Cryptography cryptography = new Cryptography();
        private static string crypotographyKey = "1HJD9YPVIE7MBYK8";           //長度為 16/24/32 bytes
        private static string crypotographyVectory = "VOICE2341HAN4851";       //長度為 16 bytes
        private static string strPath = "TW";                                     //檔案路徑

        private static string strAcctOccu = "資訊業,金融業,製造業,電子業,營建業,進出口業,運輸業,其它";
        private static string strAcctEdu = "小學,國中,高中,專科,大學,碩士,博士";
        private static string strAcctHowKnow = "親朋好友介紹,網站廣告連結,DM傳單海報,報章雜誌廣告或報導,公車廣告,電子報,其他";

        public static string Path
        {
            get { return strPath; }
        }

        public static string CrypotographyKey
        {
            get { return crypotographyKey; }
        }
        public static string CrypotographyVectory
        {
            get { return crypotographyVectory; }
        }

        public static string AcctOccu
        {
            get { return strAcctOccu; }
        }

        public static string AcctEdu
        {
            get { return strAcctEdu; }
        }

        public static string AcctHowKnow
        {
            get { return strAcctHowKnow; }
        }

        //是否承租空間
        public static bool isHiSpaceRent
        {
            get
            {
                string R = GetWebConfig.RentSts;
                return R.ToLower() == "y" || R.ToLower() == "yes" || R.ToLower() == "true";
            }
        }

        //判斷到期日
        public static bool IsHiSpaceExpiry(int day)
        {
            DateTime dbEndDate = DateTime.Parse(GetWebConfig.EndDate + " 23:59:59");
            if (PubicClass.isHiSpaceRent && System.DateTime.Now > dbEndDate.AddDays(day))
                return true;
            return false;
        }

        //取得網站資料夾大小
        public static long[] GetQuota(string DirectoryPath)
        {
            long[] Quotas = new long[] { 0, 0, 0 };
            long lQuota = 0;
            if (GetWebConfig.Quota != "")
                lQuota = Convert.ToInt64(GetWebConfig.Quota);

            if (isHiSpaceRent && lQuota > 0)
            {
                DirectoryInfo di = new DirectoryInfo(DirectoryPath);//輸入檔案夾
                double d = DirectorySize(di);
                int i = (int)(d * 100 / (lQuota > 0 ? lQuota : 1));
                Quotas[0] = lQuota;             //0:承租空間(byte)
                Quotas[1] = i;                  //1:已使用空間(%)
                Quotas[2] = (long)(lQuota - d); //2:尚餘空間(byte)
            }

            return Quotas;
        }

        public static double DirectorySize(DirectoryInfo directoryInfo)
        {
            double Size = 0;
            FileInfo[] fi = directoryInfo.GetFiles();
            foreach (FileInfo f in fi)
                Size += f.Length;

            DirectoryInfo[] dis = directoryInfo.GetDirectories();
            foreach (DirectoryInfo d in dis)
            {
                if (d.Name != "System Volume Information" && d.Name.Substring(0, 1) != "$")
                    Size += DirectorySize(d);
            }
            return (Size);
        }

        public string GetTokern()
        {
            //防止 CSRF
            Session["CSRFtoken"] = cryptography.EncryptAES(Guid.NewGuid().ToString(), PubicClass.CrypotographyKey, PubicClass.CrypotographyVectory); ;
            return Session["CSRFtoken"].ToString();

        }

        //public string GetStringDtValue(DataTable dt,string ColumnName)
        //{
        //    if (dt.Rows.Count == 1)
        //    {
        //        if (dt.Rows[0][ColumnName] != null && dt.Rows[0][ColumnName].ToString() != "")
        //            return dt.Rows[0][ColumnName].ToString();
        //        else
        //            return "";
        //    }
        //    else
        //    {
        //        foreach (DataRow dr in dt.Rows)
        //        {
        //            if (dr[ColumnName] != null && dr[ColumnName].ToString() != "")
        //                return dr[ColumnName].ToString();
        //            else
        //                return "";
        //        }
        //    }
        //}
    }
}