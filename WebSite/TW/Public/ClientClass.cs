using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebSite.DBClass;

namespace WebSite
{
    public partial class ClientClass : System.Web.UI.Page
    {
        private static string strCompName = "";
        private static string strMailCompanyName = "";
        private static string strCalendarType = "";
        private static string strEmail = "";
        private static string strWebDescr = "";
        private static string strWebKeyWord = "";
        private static string strImgPath01 = "";
        private static string strEmailSubject = "[uGear優吉兒網站訊息]";
        private static string strEmail_Bottom = "";
        private static string strDomainName = "Test.ugear.tw";
        private static string strCompURL = "http://" + strDomainName;

        static Company Cp = new Company();

        public static string CompName
        {
            get { return strCompName; }
        }
        public static string MailCompanyName
        {
            get { return strMailCompanyName; }
        }
        public static string CalendarType
        {
            get { return strCalendarType; }
        }
        public static string Email
        {
            get { return strEmail; }
        }
        public static string WebDescr
        {
            get { return strWebDescr; }
        }
        public static string Path01
        {
            get { return strWebKeyWord; }
        }
        public static string ImgPath01
        {
            get { return strImgPath01; }
        }
        public static string EmailSubject
        {
            get { return strEmailSubject; }
        }

        public static string Email_Bottom
        {
            get { return strEmail_Bottom; }
            set {
                strEmail_Bottom += "<BR><BR><HR>";
                strEmail_Bottom += "若有任何問題歡迎<a href=mailto:" + strEmail.Split(';')[0] + ">來信</a>洽詢，我們將儘快為您處理!!<BR>";
                strEmail_Bottom += strCompName + "&nbsp;&nbsp;<a href = \"" + strCompURL + "\" >" + strCompURL + "</a>";
            }
        }

        public void ClearAcctSessionData()
        {
            Session["scAcctID"] = "";
            Session["scAcctCatID"] = "";
            Session["scIDType"] = "";
            Session["scLoginID"] = "";
            Session["scCompany"] = "";
            Session["scAcctName"] = "";
            Session["scNickName"] = "";
            Session["scSex"] = "";
            Session["scMarriage"] = "";
            Session["scBirth"] = "";
            Session["scEmail"] = "";
            Session["scContinentID"] = "";
            Session["scCityID"] = "";
            Session["scAreaID"] = "";
            Session["scZipCode"] = "";
            Session["scZipCodeTwo"] = "";
            Session["scAddr"] = "";
            Session["scTel"] = "";
            Session["scCell"] = "";
            Session["scFax"] = "";
            Session["scLoginNum"] = "";
            Session["scOrdNum"] = "";
            Session["scForumNum"] = "";
            Session["scEdu"] = "";
            Session["scOccu"] = "";
            Session["scCatName"] = "";
            Session["scOrdList"] = ""; //購物內容
            Session["scOrdPriceList"] = ""; //會員價內容
            Session["screen_name"] = "";
            Session["scTwitter_user_id"] = "";
            //登入身份別[Member,Facebook,Twitter]
            Session["scCurrentLoginType"] = "";
        }

        public static void GetCompanyInfo()
        {
            DataTable dt = Cp.GetHomeImg();
            strCompName = dt.Rows[0]["CompanyName"].ToString();
            strMailCompanyName = dt.Rows[0]["MailCompanyName"].ToString();
            strCalendarType = dt.Rows[0]["CalendarType"].ToString();
            strEmail = dt.Rows[0]["Email"].ToString();
            strWebDescr = dt.Rows[0]["WebDescr"].ToString();
            strWebKeyWord = dt.Rows[0]["WebKeyWord"].ToString();
            strImgPath01 = dt.Rows[0]["ImgPath01"].ToString();

            Email_Bottom = "";
        }
    }
}
