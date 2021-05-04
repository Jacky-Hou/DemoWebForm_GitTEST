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
    public partial class Step4 : System.Web.UI.Page
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
            DT.Columns.Add("工作項目");
            DT.Columns.Add("危險識別");
            DT.Columns.Add("幅度");
            DT.Columns.Add("機率");
            DT.Columns.Add("風險等級");
            DT.Columns.Add("MOL");
            //DT.Columns.Add("COM");
            //DT.Columns.Add("MOL(風險控制方法)");
            //DT.Columns.Add("MOL(作法說明)");
            //DT.Columns.Add("COM(風險控制方法)");
            //DT.Columns.Add("COM(作法說明)");
            DT.Columns.Add("直覺法");
            DT.Columns.Add("成本效益");
            //DT.Columns.Add("決策矩陣");
            DT.Columns.Add("預期風險");
            //DT.Columns.Add("決定");

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
                dr[6] = p[6];
                dr[7] = p[7];
                dr[8] = p[8];
                //dr[9] = p[9];
                //dr[10] = p[10];
                //dr[11] = p[11];
                //dr[12] = p[12];
                //dr[13] = p[13];


                DT.Rows.Add(dr);
            }

            ThisDataGrid.DataSource = DT;
            ThisDataGrid.DataBind();
        }

        //string checkbox = "<input type='checkbox' id='chk_Man' onchange='CauseClassify(this.id)' />決策點選";
        //string RiskLevel = "<select id='sel_RiskLevel_{0}'><option value='EH1'>EH1 [災難_頻繁]</option><option value='EH2'>EH2 [災難_很可能]</option><option value='EH3'>EH3 [嚴重_頻繁]</option><option value='H4'>H4  [嚴重_很可能]</option><option value='H5'>H5  [中等_頻繁]</option><option value='H6'>H6  [災難_偶而]</option><option value='H7'>H7  [嚴重_偶而]</option><option value='H8'>H8  [災難_很考]</option><option value='M9'>M9  [中等_很可能]</option><option value='M10'>M10 [中等_偶而]</option><option value='M11'>M11 [嚴重_很少]</option><option value='M12'>M12 [災難_幾乎不]</option><option value='M13'>M13 [輕微_頻繁]</option><option value='L14'>L14 [中等_很少]</option><option value='L15'>L15 [嚴重_幾乎不]</option><option value='L16'>L16 [中等_幾乎不]</option><option value='L17'>L17 [輕微_很可能]</option><option value='L18'>L18 [輕微_偶而]</option><option value='L19'>L19 [輕微_很少]</option><option value='L20'>L20 [輕微_幾乎不]</option></select>";

        string INS_Btn = @"<input type='button' onclick='INS_Model({0})' value='修改' />";
        string COST_Btn = @"<input type='button' onclick='COST_Model({0})' value='修改' />";
        string DEC_Btn = @"<input type='button' onclick='DEC_Model({0})' value='修改' />";


        protected List<string[]> ProjectArray()
        {
            List<string[]> workHazard = new List<string[]>();
            //workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 機務故障", "災難", "偶而", "H6", "已設定", "已設定", "已設定", "", "", "H4", Confirm });
            //workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 空域臨時更改", "中等", "很少", "L14", "已設定", "已設定", "未點選", "", "", "H8", Confirm });
            //workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一在航路上無法與管制單位構聯", "輕微", "頻繁", "M13", "已設定", "已設定", "點選", "", "", "M10", Confirm });
            //workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一管制單位引導錯誤", "中等", "幾乎不", "L16", "已設定", "已設定", "未選", "", "", "L14", Confirm });
            //workHazard.Add(new string[] { "空中階段", "[初步危險分析法] 攔截諸元保持不當", "輕微", "偶而", "L18", "已設定", "已設定", "點選", "", "", "H6", Confirm });
            //workHazard.Add(new string[] { "空中階段", "[萬一] 萬一雷達脫鎖", "中等", "很可能", "M9", "已設定", "已設定", "點選", "", "", "H5", Confirm });
            //workHazard.Add(new string[] { "空中階段", "[萬一] 萬一未檢查武器電門是否在模擬位置", "災難", "頻繁", "EH1", "已設定", "已設定", checkbox, "", "", string.Format(RiskLevel, 7), Confirm });
            //workHazard.Add(new string[] { "起飛離場階段", "[初步危險分析法] 起飛時吸鳥", "嚴重", "偶而", "H7", "已設定", "已設定", checkbox, "", "", string.Format(RiskLevel, 8), Confirm });
            //workHazard.Add(new string[] { "起飛離場階段", "[初步危險分析法] 起飛離場時飛機故障", "輕微", "幾乎不", "L20", "已設定", "已設定", checkbox, "", "", string.Format(RiskLevel, 9), Confirm });
            //workHazard.Add(new string[] { "起飛離場階段", "[萬一] 萬一滾行時發動機火警", "嚴重", "很少", "M11", "已設定", "已設定", checkbox, "", "", string.Format(RiskLevel, 10), Confirm });

            workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一在航路上無法與管制單位構聯", "輕微", "頻繁", "M13", "已設定", string.Format(INS_Btn, 1), string.Format(COST_Btn, 1), "L14" });
            workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一管制單位引導錯誤", "中等", "幾乎不", "L16", "已設定", string.Format(INS_Btn, 2), string.Format(COST_Btn, 2),  "H6" });
            workHazard.Add(new string[] { "空中階段", "[假設狀況法] 萬一雷達脫鎖", "中等", "很可能", "M9", "已設定", string.Format(INS_Btn, 3), string.Format(COST_Btn, 3), "H5" });
            workHazard.Add(new string[] { "空中階段", "[假設狀況法] 萬一未檢查武器電門是否在模擬位置", "災難", "頻繁", "EH1", "已設定", string.Format(INS_Btn, 4), string.Format(COST_Btn, 4), "" });
            workHazard.Add(new string[] { "起飛離場階段", "[初步危險分析法] 起飛離場時飛機故障", "輕微", "幾乎不", "L20", "已設定", string.Format(INS_Btn, 5), string.Format(COST_Btn, 5), "" });
            workHazard.Add(new string[] { "起飛離場階段", "[假設狀況法] 萬一滾行時發動機火警", "嚴重", "很少", "M11", "已設定", string.Format(INS_Btn, 6), string.Format(COST_Btn, 6), "" });

            return workHazard;
        }

    }
}