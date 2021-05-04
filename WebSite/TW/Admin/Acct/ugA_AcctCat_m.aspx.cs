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
    public partial class ugA_AcctCat_m : System.Web.UI.Page
    {
        static int intAcctCatIDRang = AdminClass.intAcctCatIDRang;
        string strUrl = "ugA_User.aspx";
        Menus menus = new Menus();
        Account account = new Account();
        AdminClass adClass = new AdminClass();
        AcctCatInfo acctcat = new AcctCatInfo();
        MenuUserPermission MUPermission = new MenuUserPermission();

        public string CatCode
        {
            get { return acctcat.CatCode; }
        }
        public string CatName
        {
            get { return acctcat.CatName; }
        }
        public string UpSts
        {
            get { return acctcat.UpSts; }
        }
        public string DueDate
        {
            get { return acctcat.DueDate; }
        }
        public string DueDateSts
        {
            get { return acctcat.DueDateSts; }
        }
        public string DBSts
        {
            get { return acctcat.DBSts; }
        }
        public string CreUser
        {
            get { return acctcat.CreUser; }
        }
        public string CreDate
        {
            get { return acctcat.CreDate; }
        }

        public string AcctCatID
        {
            get { return acctcat.AcctCatID; }
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

            acctcat.AcctCatID = Request.Form["AcctCatID"] == null ? "" : Request.Form["AcctCatID"].ToString();

            if (acctcat.AcctCatID != "")
            {
                SetData(acctcat.AcctCatID);
                adClass.GetUserIDPermission(strUrl,ref MUPermission);
            }
        }

        public void SetData(string AcctCatID)
        {
            DataTable dt = account.Get_AcctCat("getByAcctCatID", AcctCatID);

            foreach (DataRow dr in dt.Rows)
            {
                acctcat.CatCode = dr["CatCode"].ToString();
                acctcat.CatName = dr["CatName"].ToString();
                acctcat.UpSts = dr["UpSts"].ToString();
                acctcat.DueDate = dr["DueDate"].ToString();
                acctcat.DueDateSts = dr["DueDateSts"].ToString();
                acctcat.DBSts = dr["DBSts"].ToString();
                acctcat.CreUser = dr["CreUser"].ToString();
                acctcat.CreDate = dr["CreDate"].ToString();
            }
        }

        [WebMethod]
        public static string AddAcctCat(AcctCatInfo AcctCat)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            string strAlertMsg = "";
            string strSuccess = "";

            Account account = new Account();
            DataTable dt = account.Get_AcctCat("getByCatCode_CatName_CheckAcctCat", intAcctCatIDRang.ToString(), AcctCat.CatCode, AcctCat.CatName);

            if (dt.Rows.Count > 0)
            {
                bool[] blAcctCat = { false, false };
                foreach (DataRow dr in dt.Rows)
                {
                    if (!blAcctCat[0])
                    {
                        if (dr["CatCode"].ToString() == AcctCat.CatCode)
                        {
                            if (strAlertMsg != "")
                                strAlertMsg += "<br>";
                            strAlertMsg += "新增失敗-- 編號(" + AcctCat.CatCode + ")已存在!!";
                            blAcctCat[0] = true;
                        }
                    }

                    if (!blAcctCat[1])
                    {
                        if (dr["CatName"].ToString() == AcctCat.CatName)
                        {
                            if (strAlertMsg != "")
                                strAlertMsg += "<br>";
                            strAlertMsg += "新增失敗-- 會員等級名稱(" + AcctCat.CatName + ")已存在!!";
                            blAcctCat[1] = true;
                        }
                    }

                    if (blAcctCat[0] && blAcctCat[1])
                        break;
                }
            }
            else
            {
                int i;
                try
                {
                   i = account.Insert_ugAcctCat(AcctCat);
                }
                catch (Exception ex)
                {
                    i = 0;
                }
                if (i == 1)
                    strSuccess = "新增成功";
                else
                    strAlertMsg = "新增失敗";
            }

            JO.Add("strSuccess", strSuccess);
            JO.Add("strAlertMsg", strAlertMsg);
            return JsonConvert.SerializeObject(JO);
        }


        [WebMethod]
        public static string UpdateAcctCat(AcctCatInfo AcctCat)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            string strAlertMsg = "";
            string strSuccess = "";

            Account account = new Account();
            DataTable dt = account.Get_AcctCat("getByHaveCatCode_CatName_CheckAcctCat", intAcctCatIDRang.ToString(), AcctCat.AcctCatID, AcctCat.CatCode, AcctCat.CatName);

            if (dt.Rows.Count > 0)
            {
                bool[] blAcctCat = { false, false };
                foreach (DataRow dr in dt.Rows)
                {
                    if (!blAcctCat[0])
                    {
                        if (dr["CatCode"].ToString() == AcctCat.CatCode)
                        {
                            if (strAlertMsg != "")
                                strAlertMsg += "<br>";
                            strAlertMsg += "修改失敗-- 編號(" + AcctCat.CatCode + ")已存在!!";
                            blAcctCat[0] = true;
                        }
                    }

                    if (!blAcctCat[1])
                    {
                        if (dr["CatName"].ToString() == AcctCat.CatName)
                        {
                            if (strAlertMsg != "")
                                strAlertMsg += "<br>";
                            strAlertMsg += "修改失敗-- 會員等級名稱(" + AcctCat.CatName + ")已存在!!";
                            blAcctCat[1] = true;
                        }
                    }

                    if (blAcctCat[0] && blAcctCat[1])
                        break;
                }
            }
            else
            {
                int i;
                try
                {
                    i = account.Update_ugAcctCat(AcctCat);
                }
                catch (Exception ex)
                {
                    i = 0;
                }
                if (i == 1)
                    strSuccess = "修改成功";
                else
                    strAlertMsg = "修改失敗";
            }

            JO.Add("strSuccess", strSuccess);
            JO.Add("strAlertMsg", strAlertMsg);
            return JsonConvert.SerializeObject(JO);
        }
    }
}