using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace WebSite
{
    public partial class SystemLog : System.Web.UI.Page
    {
        #region Log記錄
        /// <summary>
        /// 寄系統信(給User)
        /// </summary>
        /// <param name="Msg">訊息</param>
        /// <param name="path">檔案路徑</param>
        /// <param name="FunName">函式名稱</param>
        public void LogRecord(string Msg, string errLine, string path, string FunName, string OHID = "", string BID = "")
        {

            string DirFolder = Server.MapPath("~") + "Log";
            string MonthPath = DateTime.Now.Month.ToString();

            if (MonthPath.Length < 2)
                MonthPath = MonthPath.PadLeft(2, '0');

            string SetPath = DirFolder + "\\" + DateTime.Now.Year.ToString() + MonthPath;

            if (!Directory.Exists(SetPath))
                Directory.CreateDirectory(SetPath);

            string FilePath = SetPath + "\\" + DateTime.Now.ToString("yyyyMMdd") + ".txt";

            FileStream fsFile = new FileStream(FilePath, FileMode.Append);
            StreamWriter swWriter = new StreamWriter(fsFile);

            string strMsg = "日期時間: {0}   錯誤訊息: {1}   錯誤行數: {2}   函式: {3}   路徑: {4}   OHID: {5}   BID: {6}";
            swWriter.WriteLine(string.Format(strMsg, DateTime.Now, Msg, errLine, FunName, path, OHID, BID));
            swWriter.Close();
        }
        #endregion
    }
}