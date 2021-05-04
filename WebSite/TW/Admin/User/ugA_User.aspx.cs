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

namespace WebSite.TW.Admin.User
{
    public partial class ugA_User : System.Web.UI.Page
    {
        string strAddModifyUrl = "ugA_User_m.aspx";
        static int intPgTotal = 0;
        static int intPgLimit = 3; //設定一次可顯示幾個分頁，
        static int intPgSize;      //一頁幾筆
        ParInfo par = new ParInfo();
        MenuUserPermission MUPermission = new MenuUserPermission();
        AdminClass adClass = new AdminClass();

        public string Type_All
        {
            get { return MUPermission.Type_All; }
        }
        public string Type_Look
        {
            get { return MUPermission.Type_Look; }
        }
        public string Type_Add
        {
            get { return MUPermission.Type_Add; }
        }
        public string Type_Update
        {
            get { return MUPermission.Type_Update; }
        }
        public string Type_Del
        {
            get { return MUPermission.Type_Del; }
        }
        public string HightUser
        {
            get { return MUPermission.HightUser; }
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
        public int PageSize
        {
            get { return intPgSize; }
        }

        public string AddModifyUrl
        {
            get { return strAddModifyUrl; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Utility.CheckSession("saUserID"))
                Response.Redirect("../Default.aspx");

            par.Sort = Request.QueryString["Sort"] == null ? "" : Request.QueryString["Sort"].ToString();
            par.PgNum = Request.QueryString["PgNum"] == null ? 1 : int.Parse(Request.QueryString["PgNum"].ToString());
            par.Desc = Request.QueryString["Desc"] == null ? "" : Request.QueryString["Desc"].ToString();

            intPgSize = ugA_Pagination1.PageSize;
            adClass.GetUserIDPermission(Request.Url.Segments[Request.Url.Segments.Length - 1], ref MUPermission);

        }

        [WebMethod]
        public static string GetMenuUser(string Sort, string Desc, int PgNum)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            //if (Sort == "")
            //    dt = menus.Get_ugMenuUser();  //第一次只取資料
            //else

            DataTable dt = Menus.Get_ugMenuUser();  //第一次只取資料
            DataView dv = dt.DefaultView;
            if (Desc == "Y")
                dv.Sort = Sort + " desc";
            else
                dv.Sort = Sort;
            dt = dv.ToTable();
            //}

            if (dt.Rows.Count > 0)
            {
                //intPgSize計算有多少分頁
                if (dt.Rows.Count / intPgSize == 0)
                    intPgTotal = 1;
                else
                    intPgTotal = (dt.Rows.Count / intPgSize) + (dt.Rows.Count % intPgSize > 0 ? 1 : 0);
            }

            DataTable dtTemp = dt.Clone();
            DataRow drT;

            int start = (PgNum * intPgSize) - intPgSize;    //開始區間
            int end = 0;

            if (dt.Rows.Count > start + intPgSize)          //判斷dt資料總數大於目前區間
                end = PgNum * intPgSize - 1;                 //目前區間最後一筆資料
            else
                end = dt.Rows.Count - 1;                     //dt資料總數

            for (int i = start; i <= end; i++)
            {
                drT = dt.Rows[i];
                dtTemp.ImportRow(dt.Rows[i]);
            }

            JO.Add("PgNumCurrent", PgNum);
            JO.Add("PgLimit", intPgLimit);
            JO.Add("PgTotal", intPgTotal);
            JO.Add("MenuUserData", JsonConvert.SerializeObject(dtTemp));
            return JsonConvert.SerializeObject(JO);
        }

        [WebMethod]
        public static string DelMenuUser(string[] UserID)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            int i;
            Menus menus = new Menus();

            try
            {
                i = menus.Delete_ugMenuUser(UserID); //Delete Finish return Delete Count
            }
            catch (Exception ex)
            {
                i = 0;
            }
            JO.Add("ReturnCode", i);
            return JsonConvert.SerializeObject(JO);
        }

        [WebMethod]
        public static string UpdateDBSts(List<UserDBSts> DBSts)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            int i;
            Menus menus = new Menus();
            try
            {
                i = menus.Update_DBSts(DBSts);
            }
            catch (Exception ex)
            {
                i = 0;
            }
            JO.Add("ReturnCode", i);
            return JsonConvert.SerializeObject(JO); //Update Finish return 0
        }

    }
}