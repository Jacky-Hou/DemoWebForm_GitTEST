using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebSite.DBClass;

namespace WebSite.TW.oAuthLine
{
    public partial class LineLoginStatus : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static string LineLogin(string hidLoginSts, string hidUID, string hidUEmail, string hidUName)
        {
            JObject JO = new JObject();
            if (hidLoginSts == "success")
            {
                string Msg = string.Empty;
                string LoginID = string.Empty;
                string PSW = string.Empty;
                string DBSts = "D";
                DataTable dt = Get_ugAcct("getByLineID", hidUID);
                AcctInfo Vip = new AcctInfo();

                if (dt.Rows.Count > 0)
                {
                    LoginID = dt.Rows[0]["LoginID"].ToString();
                    PSW = dt.Rows[0]["PSW"].ToString();
                    DBSts = dt.Rows[0]["DBSts"].ToString();
                }
                else if (dt.Rows.Count == 0 && hidUEmail != "")
                {
                    dt = Get_ugAcct("getByLineEmail", hidUEmail);
                    if (dt.Rows.Count > 0)
                    {
                        Vip.LineID = hidUID;
                        Vip.AcctID = dt.Rows[0]["LoginID"].ToString();
                        Update_ugAcct("UpdateToLINEID", Vip);

                        LoginID = dt.Rows[0]["LoginID"].ToString();
                        PSW = dt.Rows[0]["PSW"].ToString();
                        DBSts = dt.Rows[0]["DBSts"].ToString();

                    }
                    else
                    {
                        Vip.LoginID = hidUEmail;
                        Vip.Psw = hidUID;
                        Vip.LineID = hidUID;
                        Vip.AcctName = hidUName;
                        Vip.Email = hidUEmail;
                        Insert_ugAcct("InsertByLine", Vip);

                        LoginID = hidUEmail;
                        PSW = hidUID;
                        DBSts = "A";
                    }
                }

                if (DBSts == "D")
                    Msg = "您的帳號已被停權";
                //JO.Add("LineStatue", "您的帳號已被停權");

                if (hidUEmail == "")
                    Msg = "您的Email 資料設定為未公開，無法以此加入";
                //JO.Add("LineStatue", "您的Email 資料設定為未公開，無法以此加入");

                if (LoginID != "" && PSW != "" && Msg == "")
                    FrontMemberLogin(LoginID, PSW);

                if (Msg == "")
                    Msg = "login";

                JO.Add("LineStatue", Msg);
            }

            return JsonConvert.SerializeObject(JO);

        }

        public static void FrontMemberLogin(string LoginID, string Psw)
        {
            string Msg = "";
            if (LoginID != "" && Psw != "")
            {
                DataTable dt = Get_ugAcct("getAllByLineID", LoginID);
                if (dt.Rows.Count == 0)
                    Msg = "您輸入的資料有誤!!";
                else
                {
                    if (dt.Rows[0]["Psw"].ToString() != Psw)
                        Msg = "您輸入的資料有誤!!";
                    else if (dt.Rows[0]["DBSts"].ToString() == "D")
                        Msg = "您輸入的資料有誤!!";
                    else
                    {
                        //if (m_strAcctDueDate == "Y") '會員使用期限
                        //{
                        string Date = DateTime.Now.ToString("yyyy/MM/dd");
                        if (dt.Rows[0]["UpSts"].ToString() == "Y" || (dt.Rows[0]["BgnDate"].ToString().CompareTo(Date) < 0 && dt.Rows[0]["EndDate"].ToString().CompareTo(Date) > 0))
                            Msg = "您的登入帳號已超過使用期限!!";
                        //}

                        if (Msg == "")
                        {
                            HttpContext.Current.Session["scAcctID"] = dt.Rows[0]["AcctID"].ToString();
                            HttpContext.Current.Session["scAcctCatID"] = dt.Rows[0]["AcctCatID"].ToString();
                            HttpContext.Current.Session["scIDType"] = dt.Rows[0]["IDType"].ToString();
                            HttpContext.Current.Session["scLoginID"] = dt.Rows[0]["LoginID"].ToString();
                            HttpContext.Current.Session["scPID"] = dt.Rows[0]["PID"].ToString();
                            HttpContext.Current.Session["scCompany"] = dt.Rows[0]["Company"].ToString();
                            HttpContext.Current.Session["scAcctName"] = dt.Rows[0]["AcctName"].ToString();
                            HttpContext.Current.Session["scNickName"] = dt.Rows[0]["NickName"].ToString();
                            if (HttpContext.Current.Session["scNickName"].ToString() == "" || HttpContext.Current.Session["scNickName"] == null)
                                HttpContext.Current.Session["scNickName"] = dt.Rows[0]["AcctName"].ToString();
                            HttpContext.Current.Session["scSex"] = dt.Rows[0]["Sex"].ToString();
                            HttpContext.Current.Session["scMarriage"] = dt.Rows[0]["Marriage"].ToString();
                            HttpContext.Current.Session["scBirth"] = dt.Rows[0]["Birth"].ToString();
                            HttpContext.Current.Session["scEmail"] = dt.Rows[0]["Email"].ToString();
                            HttpContext.Current.Session["scContinentID"] = dt.Rows[0]["ContinentID"].ToString();
                            HttpContext.Current.Session["scCityID"] = dt.Rows[0]["CityID"].ToString();
                            HttpContext.Current.Session["scAreaID"] = dt.Rows[0]["AreaID"].ToString();
                            HttpContext.Current.Session["scZipCode"] = dt.Rows[0]["ZipCode"].ToString();
                            HttpContext.Current.Session["scZipCodeTwo"] = dt.Rows[0]["ZipCodeTwo"].ToString();
                            HttpContext.Current.Session["scAddr"] = dt.Rows[0]["Addr"].ToString();
                            HttpContext.Current.Session["scTel"] = dt.Rows[0]["Tel"].ToString();
                            HttpContext.Current.Session["scCell"] = dt.Rows[0]["Cell"].ToString();
                            HttpContext.Current.Session["scFax"] = dt.Rows[0]["Fax"].ToString();

                            //if (m_strAcctDueDate == "Y") '會員使用期限
                            //{
                            HttpContext.Current.Session["scEndDate"] = dt.Rows[0]["EndDate"].ToString();
                            if (dt.Rows[0]["UpSts"].ToString() == "Y")
                                HttpContext.Current.Session["scEndDate"] = "無限期";
                            //}

                            HttpContext.Current.Session["scLoginNum"] = Convert.ToInt32(dt.Rows[0]["LoginNum"].ToString()) + 1;

                            AcctInfo Vip = new AcctInfo();
                            Vip.Loginnum = HttpContext.Current.Session["scLoginNum"].ToString();
                            Vip.UpdUser = "Web Site";
                            Vip.AcctID = dt.Rows[0]["AcctID"].ToString();
                            Update_ugAcct("UpdateByLINE", Vip);

                            HttpContext.Current.Session["scOrdNum"] = dt.Rows[0]["OrdNum"].ToString();
                            HttpContext.Current.Session["scForumNum"] = dt.Rows[0]["ForumNum"].ToString();
                            HttpContext.Current.Session["scEdu"] = dt.Rows[0]["Edu"].ToString();
                            HttpContext.Current.Session["scOccu"] = dt.Rows[0]["Occu"].ToString();

                        }
                    }
                }

                //if(Msg == "" && m_strAcctCatNum) '等級名稱
                if (Msg == "")
                {
                    dt = Get_ugAcctCat(HttpContext.Current.Session["scAcctCatID"].ToString());
                    if (dt.Rows.Count > 0)
                        HttpContext.Current.Session["scCatName"] = dt.Rows[0]["CatName"].ToString();
                }
            }
            else
                Msg = "您輸入的資料有誤!!";
        }

        public static DataTable Get_ugAcctCat(string AcctCatID)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();
            DataTable dt;

            sb.Append("Select CatName From ugAcctCat Where AcctCatID =@AcctCatID ");
            paralist.Add(DbAcs.BuildDbParameter("@AcctCatID", AcctCatID));
            dt = DbAcs.GetDBData(sb.ToString(), paralist);
            return dt;
        }

        public static DataTable Get_ugAcct(string reqFType = "", string par1 = "")
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();
            DataTable dt;
            switch (reqFType)
            {
                case "getAllByLineID":
                    sb.Append("Select * From ugAcct Where LoginID = @LineID");
                    paralist.Add(DbAcs.BuildDbParameter("@LineID", par1));
                    break;
                case "getByLineID":
                    sb.Append("Select LoginID,PSW,DBSts From ugAcct Where LineID = @LineID");
                    paralist.Add(DbAcs.BuildDbParameter("@LineID", par1));
                    break;
                case "getByLineEmail":
                    sb.Append("Select AcctID,LoginID,PSW,DBSts From ugAcct Where email = @Email");
                    paralist.Add(DbAcs.BuildDbParameter("@Email", par1));
                    break;
            }

            if (paralist.Count > 0)
                dt = DbAcs.GetDBData(sb.ToString(), paralist);
            else
                dt = DbAcs.GetDBData(sb.ToString());
            return dt;
        }

        public static int Update_ugAcct(string reqFType, AcctInfo Vip)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            switch (reqFType)
            {
                case "UpdateToLINEID":
                    sb.Append("  Update ugAcct set LINEID=@LINEID Where ACCTID=@ACCTID");
                    paralist.Add(DbAcs.BuildDbParameter("@LINEID", Vip.LineID));
                    paralist.Add(DbAcs.BuildDbParameter("@ACCTID", Vip.AcctID));
                    break;
                case "UpdateByLINE":
                    sb.Append("  Update ugAcct set LoginNum=@LOGINNUM,LoginDate=Now() ");
                    sb.Append("  ,UpdDate=Now(),UPDUSER=@UPDUSER ");
                    sb.Append("  Where ACCTID=@ACCTID");

                    paralist.Add(DbAcs.BuildDbParameter("@LOGINNUM", Vip.Loginnum));
                    paralist.Add(DbAcs.BuildDbParameter("@UPDUSER", Vip.UpdUser));
                    paralist.Add(DbAcs.BuildDbParameter("@ACCTID", Vip.AcctID));
                    break;

            }
            return DbAcs.CUD(sb.ToString(), paralist);
        }

        public static int Insert_ugAcct(string reqFType, AcctInfo Vip)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            switch (reqFType)
            {
                case "InsertByLine":
                    sb.Append(" Insert Into ugAcct(LOGINID,PSW,LINEID,ACCTNAME,EMAIL,UPSTS,VIPCARDNUM,ADDR) ");
                    sb.Append("  Values ");
                    sb.Append(" (@LOGINID,@PSW,@LINEID,@ACCTNAME,@EMAIL,'Y',' ',' ') ");
                    paralist.Add(DbAcs.BuildDbParameter("@LOGINID", Vip.LoginID));
                    paralist.Add(DbAcs.BuildDbParameter("@PSW", Vip.Psw));
                    paralist.Add(DbAcs.BuildDbParameter("@LINEID", Vip.LineID));
                    paralist.Add(DbAcs.BuildDbParameter("@ACCTNAME", Vip.AcctName));
                    paralist.Add(DbAcs.BuildDbParameter("@EMAIL", Vip.Email));
                    break;
            }
            return DbAcs.CUD(sb.ToString(), paralist);
        }


    }
}
