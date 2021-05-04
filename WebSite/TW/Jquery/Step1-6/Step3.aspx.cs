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
    public partial class Step3 : System.Web.UI.Page
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
            DT.Columns.Add("COM");
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
                //dr[7] = p[7];
                //dr[8] = p[8];
                //dr[9] = p[9];
                DT.Rows.Add(dr);
            }

            ThisDataGrid.DataSource = DT;
            ThisDataGrid.DataBind();
        }

        //string MOL_Risk = "<select><option value ='1'> 拒絕 </option><option value='2'>避免</option><option value ='3'> 延後 </option><option value='4'> 轉移 </option><option value='5'> 分散 </option><option value='6'> 補償 </option><option value='7'> 增加 </option><option value='8'> 減低 </option></select>";
        //string MOL_Fun = "<select><option value ='1' > *放棄全盤任務計畫* </option><option value='2'>不執行任何相關作業</option><option value ='3'> 終止所有相關業活動 </option><option value='4'> 完全打消念頭 </option><option value='5'> 全然不接受該風險 </option><option value='6'> 完全不夠理該業務 </option>></select>";

        //string COM_Risk = "<select><option value ='1' > 限制能量 </option><option value='2'>以較安全的方式取代/option></select>";
        //string COM_Fun = "<select><option value ='1' > *限制動量(增速驅動)裝置)* </option><option value='2'>建立效能監控系統</option><option value ='3'> 終止所有相關業活動 </option><option value='4'> 完全打消念頭 </option><option value='5'> 全然不接受該風險 </option><option value='6'> 完全不夠理該業務 </option>></select>";

        string MOL_Btn = @"<input type='button' onclick='MOL_Model({0})' value='修改' />";
        string COM_Btn = @"<input type='button' onclick='COM_Model({0})' value='修改' />";


        //string Edit = "<input id='Edit_{0}' type='button' value='修改' />";
        //string Confirm = "<input id='Confirm_{0}' type='button' onclick='Confirm(this.id)' value='確定' />";


        protected List<string[]> ProjectArray()
        {
            List<string[]> workHazard = new List<string[]>();
            //workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一在航路上無法與管制單位構聯", "輕微", "頻繁", "M13", "拒絕", "完全打消念頭","限制能量", "加裝自動減速系統", string.Format(Edit, 3) });
            //workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一管制單位引導錯誤", "中等", "幾乎不", "L16", "轉移", "轉移更具能量","以較安全的方式替代","遵照SOP步驟", string.Format(Edit, 4) });
            //workHazard.Add(new string[] { "空中階段", "[萬一] 萬一雷達脫鎖", "中等", "很可能", "M9", "拒絕", "繼續尋求新的科技發展再進行", "以較安全的方式替代", "保持安全距離", string.Format(Edit, 6) });
            //workHazard.Add(new string[] { "空中階段", "[萬一] 萬一未檢查武器電門是否在模擬位置", "災難", "頻繁", "EH1", MOL_Risk, MOL_Fun, COM_Risk, COM_Fun, string.Format(Confirm, 7) });
            //workHazard.Add(new string[] { "起飛離場階段", "[初步危險分析法] 起飛離場時飛機故障", "輕微", "幾乎不", "L20", MOL_Risk, MOL_Fun, COM_Risk, COM_Fun, string.Format(Confirm, 9) });
            //workHazard.Add(new string[] { "起飛離場階段", "[萬一] 萬一滾行時發動機火警", "嚴重", "很少", "M11", MOL_Risk, MOL_Fun, COM_Risk, COM_Fun, string.Format(Confirm, 10) });

            workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一在航路上無法與管制單位構聯", "輕微", "頻繁", "M13", string.Format(MOL_Btn, 1), string.Format(COM_Btn, 1) });
            workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一管制單位引導錯誤", "中等", "幾乎不", "L16", string.Format(MOL_Btn, 2), string.Format(COM_Btn, 2) });
            workHazard.Add(new string[] { "空中階段", "[萬一] 萬一雷達脫鎖", "中等", "很可能", "M9", string.Format(MOL_Btn, 3), string.Format(COM_Btn, 3) });
            workHazard.Add(new string[] { "空中階段", "[萬一] 萬一未檢查武器電門是否在模擬位置", "災難", "頻繁", "EH1", string.Format(MOL_Btn, 4), string.Format(COM_Btn, 4) });
            workHazard.Add(new string[] { "起飛離場階段", "[初步危險分析法] 起飛離場時飛機故障", "輕微", "幾乎不", "L20", string.Format(MOL_Btn, 5), string.Format(COM_Btn, 5) });
            workHazard.Add(new string[] { "起飛離場階段", "[萬一] 萬一滾行時發動機火警", "嚴重", "很少", "M11", string.Format(MOL_Btn, 6), string.Format(COM_Btn, 6) });


            return workHazard;
        }

    }
}