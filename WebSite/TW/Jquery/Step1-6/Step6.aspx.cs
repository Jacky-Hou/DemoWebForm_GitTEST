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
    public partial class Step6 : System.Web.UI.Page
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
            DT.Columns.Add("MOL(風險控制方法)");
            DT.Columns.Add("MOL(作法說明)");
            DT.Columns.Add("COM(風險控制方法)");
            DT.Columns.Add("COM(作法說明)");
            DT.Columns.Add("獎勵與懲戒");

            //DT.Columns.Add("執行人員");
            ////DT.Columns.Add("成效");
            ////DT.Columns.Add("衡量指標");
            //DT.Columns.Add("獎勵");
            //DT.Columns.Add("獎勵指標");
            //DT.Columns.Add("懲戒");
            //DT.Columns.Add("懲戒指標");

            //DC.AllowDBNull = false;
            //DC.Unique = true;

            DataRow dr;

            int i = 0;
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
                dr[9] = p[9];
                //dr[10] = p[10];
                //dr[11] = p[11];
                //dr[12] = p[12];
                //dr[13] = p[13];

                DT.Rows.Add(dr);
                i++;
            }

            ThisDataGrid.DataSource = DT;
            ThisDataGrid.DataBind();
        }


        protected List<string[]> ProjectArray()
        {
            List<string[]> workHazard = new List<string[]>();
            //workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一在航路上無法與管制單位構聯", "輕微", "頻繁", "M13", "拒絕", "完全打消念頭", "限制能量", "加裝自動減速系統", "監察員","績優人員", "放榮譽假", "未達標準人員","依公司規定懲處" });
            //workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一管制單位引導錯誤", "中等", "幾乎不", "L16", "轉移", "轉移更具能量", "以較安全的方式替代", "遵照SOP步驟", "長官", "績優人員","公開表揚", "未達標準人員", "加強訓練" });
            //workHazard.Add(new string[] { "空中階段", "[萬一] 萬一雷達脫鎖", "中等", "很可能", "M9", "避免", "避免高風險", "人員或設施", "增加防撞桿", "事務官", "績優人員","個人獎金", "未達標準人員", "停止值班" });
            //workHazard.Add(new string[] { "空中階段", "[萬一] 萬一未檢查武器電門是否在模擬位置", "災難", "頻繁", "EH1", "避免", "實施封鎖", "人員或設施", "增加安全組件", "主管", "績優人員", "公開表揚", "未達標準人員", "口頭警告" });
            //workHazard.Add(new string[] { "起飛離場階段", "[初步危險分析法] 起飛離場時飛機故障", "輕微", "幾乎不", "L20", "轉移", "使用替代品", "以較安全的方式替代", "集合所有人一起待命", "安全官", "績優人員", "放特別假", "未達標準人員", "重複訓練" });
            //workHazard.Add(new string[] { "起飛離場階段", "[萬一] 萬一滾行時發動機火警", "嚴重", "很少", "M11", "分散", "使用干擾物", "以較安全的方式替代", "限制活動範圍", "事務官", "績優人員", "個人獎金", "未達標準人員", "停止值班" });

            workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一在航路上無法與管制單位構聯", "輕微", "頻繁", "M13", "已完成", "已完成", "已完成", "已完成", "已完成"});
            workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一管制單位引導錯誤", "中等", "幾乎不", "L16", "已完成", "已完成", "已完成", "已完成", "已完成" });
            workHazard.Add(new string[] { "空中階段", "[萬一] 萬一雷達脫鎖", "中等", "很可能", "M9", "已完成", "已完成", "已完成", "已完成", "已完成" });
            workHazard.Add(new string[] { "空中階段", "[萬一] 萬一未檢查武器電門是否在模擬位置", "災難", "頻繁", "EH1", "已完成", "已完成", "已完成", "已完成", "已完成" });
            workHazard.Add(new string[] { "起飛離場階段", "[初步危險分析法] 起飛離場時飛機故障", "輕微", "幾乎不", "L20", "已完成", "已完成", "已完成", "已完成", "已完成" });
            workHazard.Add(new string[] { "起飛離場階段", "[萬一] 萬一滾行時發動機火警", "嚴重", "很少", "M11", "已完成", "已完成", "已完成", "已完成", "已完成" });


            return workHazard;
        }

    }
}