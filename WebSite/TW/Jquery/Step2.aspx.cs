using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.Jquery
{
    public partial class Step2 : System.Web.UI.Page
    {
        public string work = string.Empty;
        public string Hazard = string.Empty;

        public string WorkList = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            InitDataGridView();
        }

        protected void InitDataGridView()
        {
            DataTable DT = new DataTable("work");
            DT.Columns.Add("工作項目", typeof(string));
            DT.Columns.Add("危險識別", typeof(string));
            DT.Columns.Add("幅度", typeof(string));
            DT.Columns.Add("機率", typeof(string));
            DT.Columns.Add("風險等級", typeof(string));
            DT.Columns.Add(" ", typeof(string));

            //DC.AllowDBNull = false;
            //DC.Unique = true;

            DataRow dr;

            foreach (var p in ProjectArray())
            {
                dr = DT.NewRow();
                dr[0] = p[0];
                dr[1] = p[1];
                dr[2] = p[2];
                dr[3] = p[3];
                dr[4] = p[4];
                dr[5] = p[5];
                DT.Rows.Add(dr);
            }

            ThisDataGrid.DataSource = DT;
            ThisDataGrid.DataBind();

        }

        string Amplitude = "<select id='sel_Amplitude_{0}{1}' onchange='AmplitudeLevel({0},{1})'><option value ='1'>I.災難</option><option value='2'>II.嚴重</option><option value ='3'>III.中等</option><option value='4'>IV.輕微</option></select>";
        string Probability = "<select id='sel_Probability_{0}{1}' onchange='ProbabilityLevel({0},{1})'><option value = 'A'>A.頻繁</option><option value='B'>B.很可能</option><option value = 'C' >C.偶而</option><option value='D'>D.很少</option><option value = 'E' >E.幾乎不可能</ option ></ select >";
        //string RiskLevel = "<select id='sel_RiskLevel_{0}'><option value='EH1'>EH1 [災難_頻繁]</option><option value='EH2'>EH2 [災難_很可能]</option><option value='EH3'>EH3 [嚴重_頻繁]</option><option value='H4'>H4  [嚴重_很可能]</option><option value='H5'>H5  [中等_頻繁]</option><option value='H6'>H6  [災難_偶而]</option><option value='H7'>H7  [嚴重_偶而]</option><option value='H8'>H8  [災難_很考]</option><option value='M9'>M9  [中等_很可能]</option><option value='M10'>M10 [中等_偶而]</option><option value='M11'>M11 [嚴重_很少]</option><option value='M12'>M12 [災難_幾乎不]</option><option value='M13'>M13 [輕微_頻繁]</option><option value='L14'>L14 [中等_很少]</option><option value='L15'>L15 [嚴重_幾乎不]</option><option value='L16'>L16 [中等_幾乎不]</option><option value='L17'>L17 [輕微_很可能]</option><option value='L18'>L18 [輕微_偶而]</option><option value='L19'>L19 [輕微_很少]</option><option value='L20'>L20 [輕微_幾乎不]</option></select>";
        string Edit = "<input id='Edit_{0}{1}' type='button' onclick='Edit({0},{1})' value='修改' />";
        string Confirm = "<input id='Confirm_{0}{1}' type='button' onclick='Confirm({0},{1})' value='確定' />";


        protected List<string[]> ProjectArray()
        {
            List<string[]> workHazard = new List<string[]>();
            workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一在航路上無法與管制單位構聯", "輕微", "頻繁", "M13", string.Format(Edit, 1, 5) });
            workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一管制單位引導錯誤", "中等", "幾乎不", "L16", string.Format(Edit, 2, 5) });
            workHazard.Add(new string[] { "空中階段", "[假設狀況法] 萬一雷達脫鎖", "中等", "很可能", "M9", string.Format(Edit, 3, 5) });
            workHazard.Add(new string[] { "空中階段", "[假設狀況法] 萬一未檢查武器電門是否在模擬位置", string.Format(Amplitude, 4, 2), string.Format(Probability, 4, 3), "EH1", string.Format(Confirm, 4, 5) });
            workHazard.Add(new string[] { "起飛離場階段", "[初步危險分析法] 起飛離場時飛機故障", string.Format(Amplitude, 5, 2), string.Format(Probability, 5, 3), "EH1", string.Format(Confirm, 5, 5) });
            workHazard.Add(new string[] { "起飛離場階段", "[假設狀況法] 萬一滾行時發動機火警", string.Format(Amplitude, 6, 2), string.Format(Probability, 6, 3), "EH1", string.Format(Confirm, 6, 5) });

            return workHazard;
        }

    }
}