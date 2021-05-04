using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClassLibrary;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace WebSite.TW.Admin
{
    public partial class Default : System.Web.UI.Page
    {
        private string backImage;
        private bool expired;
        public static string strIPAddr = "";
        public string Path = PubicClass.Path;
        public string EndDate = GetWebConfig.EndDate;
        public static Log log = new Log();

        public AdminSetting AdSetting = new AdminSetting();
        public PubicClass PubCls = new PubicClass();

        public string BackImage
        {
            get { return backImage; }
        }

        public string Expired
        {
            get { return expired.ToString().ToLower(); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (PubicClass.isHiSpaceRent) //判斷承租空間
            {
                if (PubicClass.IsHiSpaceExpiry(0))    //到期
                    Response.Redirect(GetWebConfig.HiNetSpace);
            }

            //Todo check IP
            strIPAddr = new Utility().getIP();
            if (log.CheckLockIP(strIPAddr) > 0)
            {
                string goUrl = ResolveUrl("ugA_LoginChk.html");
                string script = string.Format("alert('{0}');location.href='{1}';", "IP被鎖定\\n請洽系統管理者協助解鎖...", goUrl); //ClientScript alert 換行符號及雙引號會造成<script> 列出錯，而單引號及換行則會讓<button> 列掛點,換行\n要改為\\n
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", script, true);
            }

            expired = PubicClass.IsHiSpaceExpiry(-60);
            backImage = AdSetting.GetBackImg();

            //Response.Write("<script>alert('IP:" + strIPAddr + "')</script>");
        }

        [WebMethod] //須註明JQuery才可以Call
        public static string AdminLogin(string txtID, string txtPw, string txtCC) //需標註static
        {
            JObject JO = new JObject();
            UgLoginIP ULI = new UgLoginIP();
            Menus menus = new Menus();
            string CaptchaCode = Utility.getSession("BackCaptchaCode");
            string strAlertMsg = "";
            string strLogErrMsg = "";
            string strRedirect = "";
            string strSuccess = "N";
            int i = 0;

            if (log.CheckLockIP(strIPAddr) > 0)    //確認IP
            {
                strAlertMsg = "IP已被鎖定\n請洽系統管理者協助解鎖...";
                strRedirect = "ugA_LoginChk.html";
            }
            else
            {
                if (txtCC != CaptchaCode || txtCC.Replace(" ", "") == "")
                {
                    i = Convert.ToInt32(HttpContext.Current.Session["LoginReCaptchaErrCnt"]);
                    i++;
                    HttpContext.Current.Session.Add("LoginReCaptchaErrCnt", i);

                    if (i >= 8)
                    {
                        //Todo Insert LoginIP Table
                        //strLogErrMsg = "驗證碼輸入錯誤太多次,IP被鎖定";
                        ULI.Descr = "驗證碼輸入錯誤太多次,IP被鎖定";
                        ULI.Allow = "N";
                        ULI.CreUser = "System";
                        ULI.IPAddr = strIPAddr;

                        log.Insert_ugLoginIP(ULI);

                        strAlertMsg = "您登入錯誤太多次,IP已被鎖定\n請洽系統管理者協助解鎖...";
                        strRedirect = "ugA_LoginChk.html";
                    }
                    else
                        strAlertMsg = "驗證碼輸入錯誤，請重新登入";
                }
                else
                {
                    string strLoginID = txtID;
                    int intUserID = 0;
                    string strDBSts, strPsw, strHighUser;

                    DataTable dt = menus.Get_ugMenuUser("getByLoginID", txtID);

                    if (dt.Rows.Count > 0)
                    {
                        
                        intUserID = int.Parse(dt.Rows[0]["UserID"].ToString());
                        strLoginID = dt.Rows[0]["LoginID"].ToString();
                        strDBSts = dt.Rows[0]["DBSts"].ToString();
                        strHighUser = dt.Rows[0]["HighUser"].ToString(); //高權限
                        strPsw = dt.Rows[0]["Psw"].ToString();

                        #region 帳號存在
                        if (strDBSts != "A")
                        {
                            strLogErrMsg = "帳號未啟用";
                            strAlertMsg = "帳號未啟用\n請洽系統管理者協助...";
                            strRedirect = "ugA_LoginChk.html";
                        }
                        else
                        {
                            Cryptography cryptography = new Cryptography();
                            if (strPsw != cryptography.EncryptAES(txtPw, PubicClass.CrypotographyKey, PubicClass.CrypotographyVectory))
                            {
                                #region 密碼檢查
                                i = Convert.ToInt32(HttpContext.Current.Session["LoginPswErrCnt"]);
                                i++;
                                HttpContext.Current.Session.Add("LoginPswErrCnt", i);
                                if (i < 5)
                                {
                                    strLogErrMsg = "第 " + i.ToString() + " 次密碼錯誤";
                                    strAlertMsg = "您的密碼錯誤!!\n您還有" + (5 - i) + "次機會...";
                                }
                                else
                                {
                                    HttpContext.Current.Session["LoginPswErrCnt"] = null;
                                    strDBSts = "D";
                                    menus.Update_ugMenuUser(strLoginID, strDBSts);

                                    strLogErrMsg = "密碼輸入錯誤" + i.ToString() + "次,帳號被終止";
                                    strAlertMsg = "您登入錯誤太多次,帳號已被鎖定\n請洽系統管理者協助解鎖...";
                                    strRedirect = "ugA_LoginChk.html";
                                }
                                #endregion
                            }
                            else
                            {
                                strLogErrMsg = "登入成功";
                                strSuccess = "Y";
                                strRedirect = "ugA_Menu.aspx";

                                Utility.SetSession("saLoginLogID", strLoginID);
                                Utility.SetSession("saUserID", intUserID.ToString());        //UserID
                                //Utility.SetSession("saGroupID", intGroupID.ToString());      //GroupID
                                Utility.SetSession("saLoginID", strLoginID);                 //LoginID
                                Utility.SetSession("saHighUser", strHighUser);               //HighUser

                                HttpContext.Current.Session["LoginPswErrCnt"] = null;
                                HttpContext.Current.Session["LoginIDErrCnt"] = null;
                                HttpContext.Current.Session["LoginReCaptchaErrCnt"] = null;
                            }
                        }
                        #endregion 帳號存在
                    }
                    else
                    {
                        #region 帳號不存在
                        strLogErrMsg = "帳號不存在";
                        strAlertMsg = strLogErrMsg;
                        i = Convert.ToInt32(HttpContext.Current.Session["LoginIDErrCnt"]);
                        i++;
                        HttpContext.Current.Session.Add("LoginIDErrCnt", i);
                        if (i >= 5)
                        {
                            //strLogErrMsg = "嘗試登入錯誤太多次,IP被鎖定";
                            //DenyLoginIP(strIPAddr, strLogErrMsg);
                            //blnAlertAndGo = true;

                            ULI.Descr = "嘗試登入錯誤太多次,IP被鎖定";
                            ULI.Allow = "N";
                            ULI.CreUser = "System";
                            ULI.IPAddr = strIPAddr;

                            log.Insert_ugLoginIP(ULI);

                            strAlertMsg = "您登入錯誤太多次,IP已被鎖定\n請洽系統管理者協助解鎖...";
                            strRedirect = "ugA_LoginChk.html";
                        }
                        #endregion 帳號不存在

                    }


                    #region 更新UgLoginLog
                    UgMenuUserLoginTime UMULT = new UgMenuUserLoginTime();
                    UMULT.LoginID = strLoginID;
                    UMULT.UserID = intUserID;
                    UMULT.IPAddr = strIPAddr;
                    UMULT.LoginTime = DateTime.Now.ToString();

                    log.Insert_ugMenuUserLoginTime(UMULT);
                    #endregion

                }
            }

            JO.Add("Redirect", strRedirect);
            JO.Add("strSuccess", strSuccess);
            JO.Add("strAlertMsg", strAlertMsg);

            return JsonConvert.SerializeObject(JO);
        }
    }
}