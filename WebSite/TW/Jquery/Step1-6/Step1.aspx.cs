using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebSite.Jquery;

namespace WebSite.Jquery
{
    public partial class Step1 : System.Web.UI.Page
    {
        public string work = string.Empty;
        public string Hazard = string.Empty;

        public string WorkList = string.Empty;

        public string WorkProjectsID = string.Empty;
        public string WorkText = string.Empty;
        public string ValueText = string.Empty;


        DBCon dbCon = new DBCon();

        protected void Page_Load(object sender, EventArgs e)
        {
            WorkProjectsID = Request.Form["WorkProjectsID"];
            WorkText = Request.Form["WorkText"];
            ValueText = Request.Form["ValueText"];

            if (WorkProjectsID != null)
                GetHazardName(WorkProjectsID);
            //else if (WorkText != null && ValueText != null)
            //    AddGridView(WorkText, ValueText);
            else
            {
                if (Request.Form["work"] != null)
                    work = Request.Form["work"];

                if (Request.Form["Hazard"] != null)
                    Hazard = Request.Form["Hazard"];

                GetWorkListName();

                InitDataGridView();
            }
        }

        //public void AddGridView(string WorkText,string ValueText)
        //{
        //    DataTable DT;
        //    DataRow dr;
        //    if ((DataTable)ThisDataGrid.DataSource != null)
        //        DT = (DataTable)ThisDataGrid.DataSource;
        //    else
        //    {
        //        DT = new DataTable("work");
        //        DT.Columns.Add("工作項目", typeof(string));
        //        DT.Columns.Add("危險識別", typeof(string));
        //    }

        //    dr = DT.NewRow();
        //    dr[0] = WorkText;
        //    dr[1] = ValueText;
        //    DT.Rows.Add(dr);
        //    ThisDataGrid.DataSource = DT;
        //    ThisDataGrid.DataBind();

        //    Response.Write("OK");
        //    Response.End();

        //    //DataTable DT = (DataTable)ThisDataGrid.DataSource;
        //    //DataRow dr = DT.NewRow();
        //    //dr["ID"] = "iPhone XS";
        //    //dr["Hazard"] = 57000;
        //    //DT.Rows.Add(dr);
        //    //ThisDataGrid.DataSource = DT;
        //    //ThisDataGrid.DataBind();

        //}

        public void GetWorkListName()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" Select WorkProjectsID,WorkName from ugWorkProjects order by WorkName ");

            DataTable dt = dbCon.GetSqlTable(sb.ToString());

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i == 0)
                    WorkList += dt.Rows[i]["WorkProjectsID"].ToString() + "&" + dt.Rows[i]["WorkName"].ToString();
                else
                    WorkList += "," + dt.Rows[i]["WorkProjectsID"].ToString() + "&" + dt.Rows[i]["WorkName"].ToString();
            }
        }

        public void GetHazardName(string WorkProjectsID)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" Select HazardName from ugHazardProject where WorkProjectsID=" + WorkProjectsID + "  order by HazardName ");

            DataTable dt = dbCon.GetSqlTable(sb.ToString());

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i == 0)
                    WorkList += dt.Rows[i]["HazardName"].ToString();
                else
                    WorkList += "," + dt.Rows[i]["HazardName"].ToString();
            }

            Response.Write(WorkList);
            Response.End();
        }


        protected void InitDataGridView()
        {
            DataTable DT = new DataTable("work");
            DT.Columns.Add("工作項目", typeof(string));
            DT.Columns.Add("危險識別", typeof(string));
            //DC.AllowDBNull = false;
            //DC.Unique = true;
            
            DataRow dr;

            foreach (var p in ProjectArray())
            {
                dr = DT.NewRow();
                dr[0] = p[0];
                dr[1] = p[1];
                DT.Rows.Add(dr);
            }

            ThisDataGrid.DataSource = DT;
            ThisDataGrid.DataBind();

        }

        protected List<string[]> ProjectArray()
        {
            List<string[]> workHazard = new List<string[]>();
            workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一在航路上無法與管制單位構聯" });
            workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一管制單位引導錯誤" });
            workHazard.Add(new string[] { "空中階段", "[萬一] 萬一雷達脫鎖" });
            workHazard.Add(new string[] { "空中階段", "[萬一] 萬一未檢查武器電門是否在模擬位置" });
            workHazard.Add(new string[] { "起飛離場階段", "[初步危險分析法] 起飛離場時飛機故障" });
            workHazard.Add(new string[] { "起飛離場階段", "[萬一] 萬一滾行時發動機火警" });

            return workHazard;
        }
    }
}