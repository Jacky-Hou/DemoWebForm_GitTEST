using ClassLibrary;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Admin.Acct
{
    public partial class ugA_Acct_m : System.Web.UI.Page
    {
        string strAcctID, strSearchList;
        string strSystemCard,strEventRecCount;
        string strUrl = "ugA_Acct.aspx";
        Event ev = new Event();
        ParInfo par = new ParInfo();
        AcctInfo acct = new AcctInfo();
        AdminClass adClass = new AdminClass();
        MenuUserPermission MUPermission = new MenuUserPermission();

        public string SystemCard
        {
            get { return strSystemCard; }
        }

        public string ACCTCATID
        {
            get { return acct.AcctCatID; }
        }
        public string UPSTS
        {
            get { return acct.Upsts; }
        }
        public string BGNDATE
        {
            get { return acct.BgnDate; }
        }
        public string ENDDATE
        {
            get { return acct.EndDate; }
        }
        public string LOGINID
        {
            get { return acct.LoginID; }
        }
        public string PSW
        {
            get { return acct.Psw; }
        }
        public string VIPCARDNUM
        {
            get { return acct.VipCardNum; }
        }
        public string VIPConfirm
        {
            get { return acct.VIPConfirm; }
        }
        public string COMPANY
        {
            get { return acct.Company; }
        }
        public string ACCTNAME
        {
            get { return acct.AcctName; }
        }
        public string SEX
        {
            get { return acct.Sex; }
        }

        public string BIRTH
        {
            get { return acct.Birth; }
        }
        public string CONTINENTID
        {
            get { return acct.ContinentID; }
        }
        public string CITYID
        {
            get { return acct.CityID; }
        }
        public string AREAID
        {
            get { return acct.AreaID; }
        }
        public string ZIPCODE
        {
            get { return acct.ZipCode; }
        }
        public string ZIPCODETWO
        {
            get { return acct.ZipCodeTwo; }
        }
        public string ADDR
        {
            get { return acct.Addr; }
        }
        public string CELL
        {
            get { return acct.Cell; }
        }
        public string TEL
        {
            get { return acct.Tel; }
        }
        public string FAX
        {
            get { return acct.Fax; }
        }
        public string OCCU
        {
            get { return acct.Occu; }
        }
        public string EDU
        {
            get { return acct.Edu; }
        }
        public string MARRIAGE
        {
            get { return acct.Marriage; }
        }
        public string HOWKNOW
        {
            get { return acct.HowKnow; }
        }
        public string ISEPAPER
        {
            get { return acct.IsEPaper; }
        }
        public string LoginDate
        {
            get { return acct.CreDate; }
        }
        public string LOGINNUM
        {
            get { return acct.Loginnum; }
        }
        public string ORDNUM
        {
            get { return acct.Ordnum; }
        }
        public string FORUMNUM
        {
            get { return acct.Forumnum; }
        }
        public string EventRecCount
        {
            get { return strEventRecCount; }
        }
        public string DBSTS
        {
            get { return acct.DBSts; }
        }
        public string DESCR
        {
            get { return acct.DBSts; }
        }

        public string CREUSER
        {
            get { return acct.CreUser; }
        }
        public string CREDATE
        {
            get { return acct.CreDate; }
        }
        public string UPDUSER
        {
            get { return acct.UpdUser; }
        }
        public string UPDDATE
        {
            get { return acct.UpdDate; }
        }
        public string AcctID
        {
            get { return strAcctID; }
        }
        public string Sort
        {
            get { return par.Sort; }
        }
        public int PgNum
        {
            get { return par.PgNum; }
        }
        public string Desc
        {
            get { return par.Desc; }
        }
        public string SearchList
        {
            get { return strSearchList; }
        }
        public string GoToUrl
        {
            get { return strUrl; }
        }
        public string Type_All
        {
            get { return MUPermission.Type_All; }
        }
        public string Type_Update
        {
            get { return MUPermission.Type_Update; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Utility.CheckSession("saUserID"))
                Response.Redirect("../Default.aspx");

            strAcctID = Request.Form["AcctID"] == null ? "" : Request.Form["AcctID"].ToString();
            par.Sort = Request.Form["Sort"] == null ? "" : Request.Form["Sort"].ToString();
            par.PgNum = Request.Form["PgNum"] == null ? 1 : int.Parse(Request.Form["PgNum"].ToString());
            par.Desc = Request.Form["Desc"] == null ? "" : Request.Form["Desc"].ToString();

            if (strAcctID != "")
            {
                SetData(strAcctID);
                adClass.GetUserIDPermission(strUrl,ref MUPermission);
            }

            strSearchList = GetAcctPageRecord();

        }

        public string GetAcctPageRecord()
        {
            string searchList = "";
            searchList += "AcctCatID&" + Request.Form["chkboxAcctCatID"].ToString() + "&" + Request.Form["AcctCatID"].ToString();
            searchList += ",";
            searchList += "LoginID&" + Request.Form["chkboxLoginID"].ToString() + "&" + Request.Form["LoginID"].ToString();
            searchList += ",";
            searchList += "AcctName&" + Request.Form["chkboxAcctName"].ToString() + "&" + Request.Form["AcctName"].ToString();
            searchList += ",";
            searchList += "Tel&" + Request.Form["chkboxTel"].ToString() + "&" + Request.Form["Tel"].ToString();
            searchList += ",";
            searchList += "Cell&" + Request.Form["chkboxCell"].ToString() + "&" + Request.Form["Cell"].ToString();
            searchList += ",";
            searchList += "VIPConfirm&" + Request.Form["chkboxVIPConfirm"].ToString() + "&" + Request.Form["VIPConfirm"].ToString();

            return searchList;
        }

        [WebMethod]
        public static string UpdateAcct(AcctInfo Vip)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            Account account = new Account();
            string strAlertMsg = "";
            string strSuccess = "";

            try
            {
                if (account.Update_ugAcct("UpdateByWeb",Vip) == 1)
                    strSuccess = "修改成功";
                else
                    strAlertMsg = "修改失敗!!";
            }
            catch (Exception ex)
            {
                strAlertMsg = "修改失敗!!";
            }

            JO.Add("strSuccess", strSuccess);
            JO.Add("strAlertMsg", strAlertMsg);
            return JsonConvert.SerializeObject(JO);
        }


        [WebMethod]
        public static string AddVipAccount(AcctInfo Vip)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            Account account = new Account();
            string strAlertMsg = "";
            string strSuccess = "";

            //if (Vip.CSRFtoken != Utility.getSession("CSRFtoken"))  //Todo CSRF確認
            //    strAlertMsg = "inValid Access";
            //else 
            //if (Vip.FrontCaptchaCode != Utility.getSession("FrontCaptchaCode"))
            //    strAlertMsg = "驗證碼錯誤!!";
            //else 

            DataTable dt = account.Get_ugAcct("getByLoginID", Vip.LoginID);
            if (dt.Rows.Count == 1)
                strAlertMsg = string.Format("新增失敗-- 已有此電子郵件（姓名：{0}；註冊時間：{1}）!!", dt.Rows[0]["ACCTNAME"].ToString(), dt.Rows[0]["CREDATE"].ToString());
            else
            {
                try
                {
                    if (account.Insert_ugAcct("InsertByWeb",Vip) == 1)
                        strSuccess = "新增成功";
                    else
                        strAlertMsg = "新增失敗!!";
                }
                catch (Exception ex)
                {
                    strAlertMsg = "新增失敗!!";
                }
            }

            //if (strAlertMsg == "")
            //ToMail(Vip);

            JO.Add("strSuccess", strSuccess);
            JO.Add("strAlertMsg", strAlertMsg);
            return JsonConvert.SerializeObject(JO);
        }


        public void SetData(string AcctID)
        {
            Account account = new Account();
            DataTable dt1 = account.Get_ugAcct("getByAcctID", AcctID);

            foreach (DataRow dr in dt1.Rows)
            {
                acct.AcctCatID = dr["ACCTCATID"].ToString();
                acct.BgnDate = dr["BGNDATE"].ToString();
                acct.EndDate = dr["ENDDATE"].ToString();
                acct.LoginID = dr["LOGINID"].ToString();
                acct.Upsts = dr["UPSTS"].ToString();
                acct.Psw = dr["PSW"].ToString();
                acct.VipCardNum = dr["VIPCARDNUM"].ToString();
                acct.VIPConfirm = dr["VIPConfirm"].ToString();
                acct.Company = dr["COMPANY"].ToString();
                acct.AcctName = dr["ACCTNAME"].ToString();
                acct.Birth = dr["BIRTH"].ToString();
                acct.Sex = dr["SEX"].ToString();
                acct.ContinentID = dr["CONTINENTID"].ToString();
                acct.CityID = dr["CITYID"].ToString();
                acct.AreaID = dr["AREAID"].ToString();
                acct.ZipCode = dr["ZIPCODE"].ToString();
                acct.ZipCodeTwo = dr["ZIPCODETWO"].ToString();
                acct.Addr = dr["ADDR"].ToString();
                acct.Tel = dr["TEL"].ToString();
                acct.Cell = dr["CELL"].ToString();
                acct.Fax = dr["FAX"].ToString();
                acct.Occu = dr["OCCU"].ToString();
                acct.Edu = dr["EDU"].ToString();
                acct.Marriage = dr["MARRIAGE"].ToString();
                acct.HowKnow = dr["HOWKNOW"].ToString();
                acct.IsEPaper = dr["ISEPAPER"].ToString();
                acct.LoginID = dr["LoginDate"].ToString();
                acct.Loginnum = dr["LOGINNUM"].ToString();
                acct.Ordnum = dr["ORDNUM"].ToString();
                acct.Forumnum = dr["FORUMNUM"].ToString();
                acct.DBSts = dr["DBSTS"].ToString();
                acct.Descr = dr["DESCR"].ToString();
                acct.CreUser = dr["CREUSER"].ToString();
                acct.CreDate = dr["CREDATE"].ToString();
                acct.UpdUser = dr["UPDUSER"].ToString();
                acct.UpdDate = dr["UPDDATE"].ToString();
            }

            strSystemCard = "Z" + acct.AcctCatID.PadLeft(5, '0');

            DataTable dt2 = ev.Get_EventRec("getByAcctID",acct.AcctCatID);
            foreach (DataRow dr in dt2.Rows)
                strEventRecCount = dr["EventRecCount"].ToString();
        }
    }
}