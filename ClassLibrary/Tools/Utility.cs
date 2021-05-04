using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClassLibrary
{
    public class Utility
    {
        #region Deal with Web Countrols
        //取得項目複選的 Value 值
        public string getSelectedValueList(CheckBoxList mObject)
        {
            StringBuilder sbValueList = new StringBuilder();

            foreach (ListItem item in mObject.Items)
            {
                if (item.Selected)
                {
                    sbValueList.Append(item.Value.Trim() + ",");
                }
            }

            sbValueList = sbValueList.Remove(sbValueList.Length - 1, 1);
            return sbValueList.ToString();
        }
        //設定項目複選的 Value 值
        public void setSelectedValueList(string mValueList, CheckBoxList mObject)
        {
            if (mValueList != null && mObject != null)
            {
                List<string> lstValueID = mValueList.Split(',').ToList();
                ListItem item;
                foreach (string value in lstValueID)
                {
                    item = mObject.Items.FindByValue(value);
                    if (item != null)
                    {
                        item.Selected = true;
                    }
                }
            }
        }


        public RadioButton getCheckedRadio(ControlCollection ctrls, string mGroupName)
        {
            RadioButton checkedRadio = new RadioButton();
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is RadioButton)
                {
                    RadioButton nowRadio = (RadioButton)ctrl;
                    if (nowRadio.Checked & nowRadio.GroupName == mGroupName)
                    {
                        checkedRadio = nowRadio;
                        break;
                    }
                }
            }
            return checkedRadio;
        }

        #region 取得網頁上控制項的底層必要元件
        public static T FindControl<T>(Control startingControl, string id) where T : Control
        {
            // 取得 T 的預設值，通常是 null
            T found = default(T);

            int controlCount = startingControl.Controls.Count;

            if (controlCount > 0)
            {
                for (int i = 0; i < controlCount; i++)
                {
                    Control activeControl = startingControl.Controls[i];
                    if (activeControl is T)
                    {
                        found = startingControl.Controls[i] as T;
                        if (string.Compare(id, found.ID, true) == 0) break;
                        else found = null;
                    }
                    else
                    {
                        found = FindControl<T>(activeControl, id);
                        if (found != null) break;
                    }
                }
            }
            return found;
        }
        #endregion 取得網頁上控制項的底層必要元件
        #endregion Deal with Web Countrols


        #region Deal With Session

        public static void SetSession(string sTitle, string sValue)
        {
            if (HttpContext.Current.Session[sTitle] == null)
                HttpContext.Current.Session.Add(sTitle, sValue);
            else
                HttpContext.Current.Session[sTitle] = sValue;
            HttpContext.Current.Session.Timeout = 200;
        }

        //public string getSession(string mTitle)
        public static string getSession(string mTitle)
        {
            string strValue = "";
            if (HttpContext.Current.Session[mTitle] != null)
            {
                strValue = HttpContext.Current.Session[mTitle].ToString();
            }
            return strValue;
        }
        public int getSessionInInt(string mTitle)
        {
            int i = 0;
            if (HttpContext.Current.Session[mTitle] != null)
            {
                try { i = Convert.ToInt32(HttpContext.Current.Session[mTitle]); }
                catch { i = 0; }
            }
            return i;
        }
        #endregion Deal With Session

        public string getIP()
        {
            string IP = "";
            if (System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_ForWARDED_For"] == null)
                IP = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"].ToString();
            else
                IP = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_ForWARDED_For"].ToString();
            return IP;

            //var host = Dns.GetHostEntry(Dns.GetHostName());
            //foreach (var ip in host.AddressList)
            //{
            //    if (ip.AddressFamily == AddressFamily.InterNetwork)
            //    {
            //        IP = ip.ToString();
            //    }
            //}
            //return IP;
        }

        public static string GetWebSize(long PlaceSize)
        {
            if (PlaceSize < 1024)
                return PlaceSize.ToString() + " Bytes";
            else
            {
                double dblFormatedSize = PlaceSize / Math.Pow(1024, 1);
                if (dblFormatedSize < 1024)
                    return dblFormatedSize.ToString("0.##") + " MB";
                else
                    dblFormatedSize = dblFormatedSize / Math.Pow(1024, 1);  // to GB
                if (dblFormatedSize < 1024)
                    return dblFormatedSize.ToString("0.##") + " GB";
                else
                {
                    dblFormatedSize = dblFormatedSize / Math.Pow(1024, 1);  // to TB
                    return dblFormatedSize.ToString("0.##") + " TB";
                }
            }
        }

        // 取得UserID Session
        public static bool CheckSession(string User)
        {
            string userid = getSession(User);
            if (userid != "")
                return true;
            return false;

        }

        //取得後台登入者ID，長出Menu圖示
        public static int GetBackUserID()
        {
            string sUserID = getSession("saUserID");
            return Convert.ToInt32(sUserID != "" ? sUserID : "-1");
        }

        public string SetToken()
        {
            string tokenKey = Guid.NewGuid() + DateTime.Now.Ticks.ToString();
            System.Security.Cryptography.MD5CryptoServiceProvider md5 =
                    new System.Security.Cryptography.MD5CryptoServiceProvider();
            byte[] b = md5.ComputeHash(System.Text.Encoding.UTF8.GetBytes(tokenKey));
            return BitConverter.ToString(b).Replace("-", string.Empty);
        }

    }
}