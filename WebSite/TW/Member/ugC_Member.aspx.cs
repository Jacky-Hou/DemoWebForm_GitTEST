using ClassLibrary;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Member
{

    public partial class ugC_Member : System.Web.UI.Page
    {
        int intMenuID = 3;
        string strFrontMenuName = "";
        string strCurrentPageName = "";
        string strCSRFtoken;
        static string strMailSubject = "";
        static string strBody = "";
        DataTable dt = new DataTable();
        Menus menus = new Menus();
        ClientClass CC = new ClientClass();
        PubicClass PC = new PubicClass();
        Account account = new Account();

        public string CurrentPageName
        {
            get { return strCurrentPageName; }
        }

        public string FrontMenuName
        {
            get { return strFrontMenuName; }
        }

        public string CSRFtoken
        {
            get { return strCSRFtoken; }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Utility.CheckSession("scAcctID"))
            {
                CC.ClearAcctSessionData();
                strCurrentPageName = "加入會員";
            }
            else
                strCurrentPageName = "修改會員資料";

            dt = menus.Get_ugMenu("getByMenuID", intMenuID.ToString());
            strFrontMenuName = dt.Rows[0]["MenuName_Front"].ToString();

            strCSRFtoken = PC.GetTokern();  //防止 CSRF
        }

        [WebMethod]
        public static string AddVipAccount(AcctInfo Vip)
        {
            JObject JO = new JObject();
            Account account = new Account();
            string strAlertMsg = "";

            if (Vip.CSRFtoken != Utility.getSession("CSRFtoken"))  //Todo CSRF確認
                strAlertMsg = "inValid Access";
            else if (Vip.FrontCaptchaCode != Utility.getSession("FrontCaptchaCode"))
                strAlertMsg = "驗證碼錯誤!!";
            else if (account.Get_ugAcct("getByLoginID", Vip.LoginID).Rows.Count == 1)
                strAlertMsg = "註冊失敗 已有此帳號!!";
            else
            {
                try
                {
                    if (account.Insert_ugAcct("InsertByWeb",Vip) != 1)
                        strAlertMsg = "註冊失敗 -- 請洽網站客服人員!!";
                }
                catch (Exception ex)
                {
                    strAlertMsg = "註冊失敗 -- 請洽網站客服人員!!";
                }
            }

            if (strAlertMsg == "")
                ToMail(Vip);

            JO.Add("strAlertMsg", strAlertMsg);
            return JsonConvert.SerializeObject(JO);
        }

        [WebMethod]
        public static int CheckLoginID(string LoginID, string CSRFtoken)
        {
            Account account = new Account();
            int i;
            if (CSRFtoken != Utility.getSession("CSRFtoken"))   //Todo CSRF確認
                i = 2;
            else
                i = account.Get_ugAcct("getByLoginID", LoginID).Rows.Count;
            return i;
        }


        public static void ToMail(AcctInfo Vip)
        {
            ClientClass.GetCompanyInfo();
            strMailSubject = ClientClass.CompName + " - 加入會員" + ClientClass.EmailSubject;

            strBody += strMailSubject + "<br><br>";
            strBody += "電子郵件：<font color=#FF0000><a href=mailto:" + Vip.Email + " target=_blank>" + Vip.Email + "</a></font><BR>";
            strBody += "密碼：<font color=#FF0000>" + Vip.Psw + "</font><BR>";
            strBody += "公司名稱：<font color=#FF0000>" + Vip.Company + "</font><BR>";
            strBody += "姓名：<font color=#FF0000>" + Vip.AcctName + "</font><BR>";
            strBody += "性別：<font color=#FF0000>" + (Vip.Sex == "M" ? "男" : "女") + "</font><BR>";
            strBody += "出生日期：<font color=#FF0000>" + Vip.Birth + "</font><BR>";
            strBody += "聯絡電話：<font color=#FF0000>" + Vip.Tel + "</font><BR>";
            strBody += "手機：<font color=#FF0000>" + Vip.Cell + "</font><BR>";
            strBody += "傳真：<font color=#FF0000>" + Vip.Fax + "</font><BR>";
            strBody += "職業：<font color=#FF0000>" + Vip.Occu + "</font><BR>";
            strBody += "學歷：<font color=#FF0000>" + Vip.Edu + "</font><BR>";
            strBody += "婚姻狀況：<font color=#FF0000>" + (Vip.Marriage == "N" ? "未婚" : "已婚") + "</font><BR>";
            strBody += "如何得知：<font color=#FF0000>" + Vip.HowKnow + "</font><BR>";
            strBody += "訂閱電子報：<font color=#FF0000>" + (Vip.IsEPaper == "N" ? "否" : "是") + "</font><BR>";

            strBody += "<BR>感謝您的加入！";
            strBody += ClientClass.Email_Bottom;

            SendMail(Vip.Email, ClientClass.Email, ClientClass.MailCompanyName, strBody);
        }


        public static void SendMail(string Account, string FormMail, string FormTitle, string Boby)
        {
            string[] Mail = FormMail.Split(';');

            for (int i = 0; i <= Mail.Length; i++) //Total寄送筆數
            {
                MailMessage msg = new MailMessage();

                if (i == 0)
                    msg.To.Add(Account);    //第一次寄註冊會員
                else
                    msg.To.Add(Mail[i - 1]);  //之後再寄送網站管理員

                msg.From = new MailAddress(Mail[0], FormTitle, System.Text.Encoding.UTF8);
                msg.Subject = strMailSubject;
                msg.Body = Boby;
                msg.IsBodyHtml = true;
                msg.BodyEncoding = System.Text.Encoding.UTF8;

                SmtpClient MySmtp = new SmtpClient("localhost", 25); //本機IIS SMTP設定
                MySmtp.UseDefaultCredentials = false;
                MySmtp.Send(msg);
            }
        }
    }
}