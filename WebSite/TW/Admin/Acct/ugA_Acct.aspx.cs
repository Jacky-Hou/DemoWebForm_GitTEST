using ClassLibrary;
using ClosedXML.Excel;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Admin.Acct
{
    public class SearchInfo
    {
        public string Column;
        public string Val;
    }

    public partial class ugA_Acct : System.Web.UI.Page
    {
        string strAcctCatID;
        string searchList;
        string strAddModifyUrl = "ugA_Acct_m.aspx";
        static int intPgTotal = 0;
        static int intPgLimit = 3; //設定一次可顯示幾個分頁，
        static int intPgSize;      //一頁幾筆
        ParInfo par = new ParInfo();
        AdminClass adClass = new AdminClass();
        MenuUserPermission MUPermission = new MenuUserPermission();
        ExcelHelper ExcelHandle = new ExcelHelper();
        DataHelper DataHandle = new DataHelper();
        string[] ExcelColumn = new string[] { "會員等級", "使用期限", "電子郵件", "VIP卡號", "門市會員卡號", "門市會員狀態", "公司名稱", "姓名", "性別", "出生日期", "地址", "聯絡電話", "手機", "傳真", "職業", "學歷", "婚姻狀況", "如何得知", "訂閱電子報", "加入時間", "最近登入時間", "登錄次數", "購買次數", "討論次數", "報名次數", "狀態" };

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
        public string AcctCatID
        {
            get { return strAcctCatID; }
        }
        public string AddModifyUrl
        {
            get { return strAddModifyUrl; }
        }
        public string SearchList
        {
            get { return searchList; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //Todo 暫時Mark
            //if (!Utility.CheckSession("saUserID"))
            //    Response.Redirect("../Default.aspx");
            Utility.SetSession("saUserID", "1");

            if (Request.Form["ExcelExport"] != null && Request.Form["ExcelExport"] == "Y")
                CreateExcel(GetAcctPageRecord());

            strAcctCatID = Request.Form["AcctCatID"] == null ? "" : Request.Form["AcctCatID"].ToString();
            par.Sort = Request.Form["Sort"] == null ? "" : Request.Form["Sort"].ToString();
            par.PgNum = Request.Form["PgNum"] == null ? 1 : int.Parse(Request.Form["PgNum"].ToString());
            par.Desc = Request.Form["Desc"] == null ? "" : Request.Form["Desc"].ToString();
            searchList = Request.Form["SearchList"] == null ? "" : Request.Form["SearchList"].ToString();

            intPgSize = ugA_Pagination1.PageSize;
            adClass.GetUserIDPermission(Request.Url.Segments[Request.Url.Segments.Length - 1], ref MUPermission);

        }

        [WebMethod]
        public static string GetAcct(ParInfo Par, List<SearchInfo> Search)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            Account account = new Account();
            DataTable dt;
            if (Search.Count == 0) //判斷有無搜尋條件
                dt = account.Get_ugAcct("getAllAcct");
            else
                dt = account.Get_ugAcct("getBySearch", Search);

            DataView dv = dt.DefaultView;
            if (Par.Desc == "Y")
                dv.Sort = Par.Sort + " desc";
            else
                dv.Sort = Par.Sort;
            dt = dv.ToTable();

            if (dt.Rows.Count > 0)
            {
                //intPgSize計算有多少分頁
                if (dt.Rows.Count / intPgSize == 0)
                    intPgTotal = 1;
                else
                    intPgTotal = (dt.Rows.Count / intPgSize) + (dt.Rows.Count % intPgSize > 0 ? 1 : 0);
            }

            DataTable dtTemp = dt.Clone();

            int start = (Par.PgNum * intPgSize) - intPgSize;    //開始區間
            int end = 0;

            if (dt.Rows.Count > start + intPgSize)          //判斷dt資料總數大於目前區間
                end = Par.PgNum * intPgSize - 1;                 //目前區間最後一筆資料
            else
                end = dt.Rows.Count - 1;                     //dt資料總數

            for (int i = start; i <= end; i++)
                dtTemp.ImportRow(dt.Rows[i]);

            JO.Add("PgNumCurrent", Par.PgNum);
            JO.Add("PgLimit", intPgLimit);
            JO.Add("PgTotal", intPgTotal);
            JO.Add("AcctData", JsonConvert.SerializeObject(dtTemp));
            return JsonConvert.SerializeObject(JO);
        }

        [WebMethod]
        public static string DelAcctUser(string[] AcctID)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            int i;
            Account account = new Account();

            try
            {
                i = account.Delete_List("ugAcct", AcctID); //Delete Finish return Delete Count
            }
            catch (Exception ex)
            {
                i = 0;
            }
            JO.Add("ReturnCode", i);
            return JsonConvert.SerializeObject(JO);
        }

        [WebMethod]
        public static string UpdateDBSts(List<AcctDBSts> DBSts)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            int i;
            Account account = new Account();

            try
            {
                i = account.Update_DBSts(DBSts);
            }
            catch (Exception ex)
            {
                i = 0;
            }
            JO.Add("ReturnCode", i);
            return JsonConvert.SerializeObject(JO); //Update Finish return 0
        }

        //public void WriteExcelWithNPOI(string extension, List<SearchInfo> Search)

        public void CreateExcel(string searchList)
        {
            List<SearchInfo> SearchList = new List<SearchInfo>();
            if (searchList != "")
            {
                string[] SearchTemp = searchList.Split(',');
                foreach (string s in SearchTemp)
                {
                    string[] SearchArry = s.Split('&');
                    if (SearchArry[1] == "true")
                    {
                        SearchInfo search = new SearchInfo();
                        search.Column = SearchArry[0].ToString();
                        search.Val = SearchArry[2].ToString();
                        SearchList.Add(search);
                    }
                }
            }

            Event ev = new Event();
            Account account = new Account();

            DataTable dt1;
            if (SearchList.Count == 0) //判斷有無搜尋條件
                dt1 = account.Get_ugAcct("getAllAcctToExcal");
            else
                dt1 = account.Get_ugAcct("getBySearchToExcel", SearchList);

            DataTable dt2 = ev.Get_EventRec("getByAcctID");

            dt1.Columns.Add("EventRecCount");
            foreach (DataRow dr1 in dt1.Rows)
            {
                foreach (DataRow dr2 in dt2.Rows)
                {
                    if (dr1["AcctID"] == dr2["AcctID"])
                    {
                        dr1["EventRecCount"] = dr2["EventRecCount"] == null ? "" : dr2["EventRecCount"];
                        break;
                    }
                    else
                        dr1["EventRecCount"] = "0";
                }
            }

            dt1.Columns["DBSts"].SetOrdinal(dt1.Columns.Count - 1);
            dt1.Columns["EventRecCount"].SetOrdinal(dt1.Columns.Count - 2);

            //List<string> reqFTypeList = new List<string>();
            //List<DataTable> dtList = new List<DataTable>();
            //List<string[]> ColumnNameList = new List<string[]>();
            //List<string> sheetNameList = new List<string>();

            //reqFTypeList.Add("ExportByAcct");
            //dtList.Add(dt1);
            //ColumnNameList.Add(new string[] { "會員等級", "使用期限", "電子郵件", "VIP卡號", "門市會員卡號", "門市會員狀態", "公司名稱", "姓名", "性別", "出生日期", "地址", "聯絡電話", "手機", "傳真", "職業", "學歷", "婚姻狀況", "如何得知", "訂閱電子報", "加入時間", "最近登入時間", "登錄次數", "購買次數", "討論次數", "報名次數", "狀態" });
            //sheetNameList.Add("MemberDate_" + DateTime.Now.ToString("yyyy_mm_dd"));

            //reqFTypeList.Add("ExportByDefault");
            //dtList.Add(dt1);
            //ColumnNameList.Add(new string[] { "11", "22", "33", "44", "55", "66", "77", "88", "99", "1010", "1111", "1212", "1313", "1414", "1515", "1616", "1717", "1818", "1919", "2020", "2121", "2222", "2323", "2424", "2525", "2626" });
            //sheetNameList.Add("MemberDate_Test");

            string[] ColumnName = new string[] { "會員等級", "使用期限", "電子郵件", "VIP卡號", "門市會員卡號", "門市會員狀態", "公司名稱", "姓名", "性別", "出生日期", "地址", "聯絡電話", "手機", "傳真", "職業", "學歷", "婚姻狀況", "如何得知", "訂閱電子報", "加入時間", "最近登入時間", "登錄次數", "購買次數", "討論次數", "報名次數", "狀態" };
            string[] ColumnName2 = new string[] { "會員等級2", "使用期限2", "電子郵件2", "VIP卡號2", "門市會員卡號2", "門市會員狀態2", "公司名稱2", "姓名2", "性別2", "出生日期2", "地址2", "聯絡電話2", "手機2", "傳真2", "職業2", "學歷2", "婚姻狀況2", "如何得知2", "訂閱電子報2", "加入時間2", "最近登入時間2", "登錄次數2", "購買次數2", "討論次數2", "報名次數2", "狀態2" };

            XLWorkbook workbook = new XLWorkbook();
            var wsData = workbook.Worksheets.Add("MemberDate_" + DateTime.Now.ToString("yyyy_MM_dd"));
            for (int j = 0; j < ColumnName.Length; j++)
            {
                var v = wsData.Cell(1, j + 1);

                wsData.Cell(1, j + 1).Value = ColumnName[j].ToString();
                ExcelHandle.SetExcelStyle(wsData.Cell(1, j + 1), XLAlignmentHorizontalValues.Center);
            }

            //Cell 列由(1,x) 第1列開始
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                for (int k = 0; k < dt1.Columns.Count; k++)
                {
                    if (dt1.Columns[k].ColumnName == "AcctID")
                        wsData.Cell(i + 2, k + 1).Value = "Z" + dt1.Rows[i]["AcctID"].ToString().PadLeft(5, '0');
                    else if (dt1.Columns[k].ColumnName == "LOGINNUM" || dt1.Columns[k].ColumnName == "ORDNUM" || dt1.Columns[k].ColumnName == "FORUMNUM")
                        wsData.Cell(i + 2, k + 1).Value = dt1.Rows[i][k].ToString() + "次";
                    else if (dt1.Columns[k].ColumnName == "LoginID")
                    {
                        wsData.Cell(i + 2, k + 1).Value = dt1.Rows[i][k].ToString();
                        wsData.Cell(i + 2, k + 1).Hyperlink.ExternalAddress = new Uri(@"mailto:" + dt1.Rows[i][k].ToString() + "?subject=Presents");
                    }
                    else if (dt1.Columns[k].ColumnName == "VIPConfirm")
                        wsData.Cell(i + 2, k + 1).Value = DataHandle.ShowText(dt1.Rows[i][k].ToString(), "VIPConfirm");
                    else if (dt1.Columns[k].ColumnName == "Sex")
                        wsData.Cell(i + 2, k + 1).Value = DataHandle.ShowText(dt1.Rows[i][k].ToString(), "Sex");
                    else if (dt1.Columns[k].ColumnName == "Marriage")
                        wsData.Cell(i + 2, k + 1).Value = DataHandle.ShowText(dt1.Rows[i][k].ToString(), "Marriage");
                    else if (dt1.Columns[k].ColumnName == "IsePaPer")
                        wsData.Cell(i + 2, k + 1).Value = DataHandle.ShowText(dt1.Rows[i][k].ToString(), "IsePaPer");
                    else if (dt1.Columns[k].ColumnName == "DBSts")
                        wsData.Cell(i + 2, k + 1).Value = DataHandle.ShowText(dt1.Rows[i][k].ToString(), "DBSts");

                    else
                        wsData.Cell(i + 2, k + 1).Value = dt1.Rows[i][k].ToString();

                    ExcelHandle.SetExcelStyle(wsData.Cell(i + 2, k + 1), XLAlignmentHorizontalValues.Left);
                }
            }

            var wsData2 = workbook.Worksheets.Add("Sheet2");
            for (int j = 0; j < ColumnName2.Length; j++)
            {
                var v = wsData.Cell(1, j + 1);

                wsData2.Cell(1, j + 1).Value = ColumnName2[j].ToString();
                ExcelHandle.SetExcelStyle(wsData.Cell(1, j + 1), XLAlignmentHorizontalValues.Center);
            }

            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                for (int k = 0; k < dt1.Columns.Count; k++)
                {
                    wsData2.Cell(i + 2, k + 1).Value = dt1.Rows[i][k].ToString();
                }
            }

            ExcelHandle.ExportToExcelWithClosedXML(workbook);

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

    }
}