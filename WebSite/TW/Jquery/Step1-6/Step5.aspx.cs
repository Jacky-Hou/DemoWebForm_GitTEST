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
    public partial class Step5 : System.Web.UI.Page
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
            DT.Columns.Add("直覺法");
            DT.Columns.Add("成本效益");
            DT.Columns.Add("決策矩陣");
            DT.Columns.Add("獎勵與懲戒");

            //DT.Columns.Add("成效");
            //DT.Columns.Add("衡量指標");
            //DT.Columns.Add("獎勵");
            //DT.Columns.Add("獎勵指標");
            //DT.Columns.Add("懲戒");
            //DT.Columns.Add("懲戒指標");
            //DT.Columns.Add("決定");

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
                dr[10] = p[10];
                //dr[11] = p[11];
                //dr[12] = p[12];
                //dr[13] = p[13];
                //dr[14] = p[14];
                //dr[15] = p[15];
                //dr[16] = p[16];

                DT.Rows.Add(dr);
                i++;
            }

            ThisDataGrid.DataSource = DT;
            ThisDataGrid.DataBind();
        }

        //string Execute = "<input type='text' id='inp_Execute' placeholder='輸入執行人員' />";

        //string Effec = "<select><option value ='1'> 回應好評度 </option><option value='2'>迴響度</option><option value ='3'> 樂觀穩度 </option><option value='4'> 凝聚力 </option><option value='5'> 順從度 </option><option value='6'> 變換率 </option><option value='7'> 貫徹度 </option><option value='8'> 減低 </option></select>";
        //string EffecContent = "<input type='text' id='inp_EffecContent' />";

        //string Reward = "<input type='text' id='inp_Reward' placeholder='輸入獎勵人員'/>";
        //string RewardContent = "<select><option value ='1'> 行政獎勵 </option><option value='2'> 個人獎金 </option><option value ='3'> 公開表揚 </option><option value='4'> 放榮譽假 </option><option value='5'> 放特別假 </option><option value='6'> 考績加分 </option><option value='7'> 貫徹度 </option><option value='8'> 減低 </option></select>";
        
        //string penalty = "<input type='text' id='inp_penalty' placeholder='輸入懲戒人員'/>";
        //string penaltyContent = "<select><option value ='1'> 口頭警告 </option><option value='2'> 公開訓誡 </option><option value ='3'> 依公司規定懲處 </option><option value='4'> 加強訓練 </option><option value='5'>重複訓練 </option><option value='6'> 停止值班 </option></select>";


        string RewardDiscipline = "<input type='button' onclick='RewardDiscipline_Model({0})' value='修改' />";
        //string Confirm = "<input id='Confirm_{0}' type='button' onclick='Confirm(this.id)' value='確定' />";


        protected List<string[]> ProjectArray()
        {
            List<string[]> workHazard = new List<string[]>();
            //workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 機務故障", "災難", "偶而", "H6", "完成", "完成", "完成", "完成", "完成", "績優人員", "公開表揚","未達標準人員","口頭警告", Edit });
            //workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 空域臨時更改", "中等", "很少", "L14", "完成", "完成", "完成", "完成", "完成","績優人員","個人獎金", "未達標準人員","公開訓誡", Edit });
            //workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一在航路上無法與管制單位構聯", "輕微", "頻繁", "M13", "拒絕", "完全打消念頭", "限制能量", "加裝自動減速系統", "監察員","績優人員", "放榮譽假", "未達標準人員","依公司規定懲處", Edit });
            //workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一管制單位引導錯誤", "中等", "幾乎不", "L16", "轉移", "轉移更具能量", "以較安全的方式替代", "遵照SOP步驟", "長官", "績優人員","公開表揚", "未達標準人員", "加強訓練", Edit });
            //workHazard.Add(new string[] { "空中階段", "[初步危險分析法] 攔截諸元保持不當", "輕微", "偶而", "L18", "轉移", "繼續尋求新的科技發展再進行", "以較安全的方式替代", "保持安全距離", "安全官",  "績優人員","放特別假", "未達標準人員", "重複訓練", Edit });
            //workHazard.Add(new string[] { "空中階段", "[萬一] 萬一雷達脫鎖", "中等", "很可能", "M9", "避免", "避免高風險", "人員或設施", "增加防撞桿", "事務官", "績優人員","個人獎金", "未達標準人員", "停止值班", Edit });
            //workHazard.Add(new string[] { "空中階段", "[萬一] 萬一未檢查武器電門是否在模擬位置", "災難", "頻繁", "EH1", "避免", "實施封鎖", "人員或設施", "增加安全組件", Execute, Reward, RewardContent, penalty, penaltyContent, Confirm });
            //workHazard.Add(new string[] { "起飛離場階段", "[初步危險分析法] 起飛時吸鳥", "嚴重", "偶而", "H7", "延後", "安排下一班次", "人員或設施", "加裝安全帶", Execute, Reward, RewardContent, penalty, penaltyContent, Confirm });
            //workHazard.Add(new string[] { "起飛離場階段", "[初步危險分析法] 起飛離場時飛機故障", "輕微", "幾乎不", "L20", "轉移", "使用替代品", "以較安全的方式替代", "集合所有人一起待命", Execute, Reward, RewardContent, penalty, penaltyContent, Confirm });
            //workHazard.Add(new string[] { "起飛離場階段", "[萬一] 萬一滾行時發動機火警", "嚴重", "很少", "M11", "分散", "使用干擾物", "以較安全的方式替代", "限制活動範圍", Execute, Reward, RewardContent, penalty, penaltyContent, Confirm });

            workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一在航路上無法與管制單位構聯", "輕微", "頻繁", "M13", "已設定", "已設定", "已設定", "已設定", "已設定", string.Format(RewardDiscipline,1) });
            workHazard.Add(new string[] { "出航及進入空域階段", "[初步危險分析法] 萬一管制單位引導錯誤", "中等", "幾乎不", "L16", "已設定", "已設定", "已設定", "已設定", "已設定", string.Format(RewardDiscipline, 2) });
            workHazard.Add(new string[] { "空中階段", "[萬一] 萬一雷達脫鎖", "中等", "很可能", "M9", "已設定", "已設定", "已設定", "已設定", "已設定", string.Format(RewardDiscipline, 3) });
            workHazard.Add(new string[] { "空中階段", "[萬一] 萬一未檢查武器電門是否在模擬位置", "災難", "頻繁", "EH1", "已設定", "已設定", "已設定", "已設定", "已設定", string.Format(RewardDiscipline, 4) });
            workHazard.Add(new string[] { "起飛離場階段", "[初步危險分析法] 起飛離場時飛機故障", "輕微", "幾乎不", "L20", "已設定", "已設定", "已設定", "已設定", "已設定", string.Format(RewardDiscipline, 5) });
            workHazard.Add(new string[] { "起飛離場階段", "[萬一] 萬一滾行時發動機火警", "嚴重", "很少", "M11", "已設定", "已設定", "已設定", "已設定", "已設定", string.Format(RewardDiscipline, 6) });

            return workHazard;
        }

    }
}