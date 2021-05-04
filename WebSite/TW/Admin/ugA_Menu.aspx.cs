using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClassLibrary;

namespace WebSite.TW.Admin
{
    public partial class ugA_Menu : System.Web.UI.Page
    {
        public string TitleStr = GetWebConfig.TitleStr;   //網站顯示的公司名稱
        public string Path = PubicClass.Path;
        public string EndDate = GetWebConfig.EndDate;
        private string quRent, quUse, quCanUse;
        private string backImage;
        public bool rent,expired;
        private long[] qs;
        public AdminSetting AdSetting = new AdminSetting();

        public string BackImage
        {
            get { return backImage; }
        }

        public string QuRent
        {
            get { return quRent; }
        }
        public string QuUse
        {
            get { return quUse; }
        }

        public string QuCanUse
        {
            get { return quCanUse; }
        }
        public long[] Qs
        {
            get { return qs; }
        }

        public string Rent
        {
            get { return rent.ToString().ToLower(); }
        }

        public string Expired
        {
            get { return expired.ToString().ToLower();}
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Utility.CheckSession("saUserID"))
                Response.Redirect("Default.aspx");
            else {
                backImage = AdSetting.GetBackImg();

                rent = PubicClass.isHiSpaceRent;  //有承租空間才會顯示空間容量

                if (rent) //判斷承租空間
                {
                    //if (PubicClass.IsHiSpaceExpiry(0))    //到期
                    //    Response.Redirect(GetWebConfig.HiNetSpace);

                    //Panel_Msg.Visible = PubicClass.IsHiSpaceExpiry(-60);  //剩60天
                    expired = PubicClass.IsHiSpaceExpiry(-60);  //剩60天

                    qs = PubicClass.GetQuota(Server.MapPath("~/"));   //承租空間資訊(承租空間大小、已使用、尚可使用)

                    if (qs[0] != 0) //承租空間
                    {
                        quRent = Utility.GetWebSize(qs[0]);     //承租空間容量
                        quUse = qs[1].ToString();               //已使用
                        quCanUse = Utility.GetWebSize(qs[2]);   //尚可使用容量
                        //_EndDate = GetWebConfig.AppStting("EndDate");
                    }

                }
                ShowMenu(); //承租空間與後台Menu顯示無關
            }
        }

        //顯示後台Menu
        private void ShowMenu()
        {
            DataTable dt = Menus.Get_ugMenu(); //取Menu
            Panel_Page.Controls.Clear();

            foreach (DataRow dr in dt.Rows)
            {
                Panel P0 = new Panel(); //原生前端轉為<div
                P0.CssClass = "menu01";

                Panel P1 = new Panel();
                P1.CssClass = "menu01Pic";

                //取得Url 按下連結控制項時
                HyperLink hl = new HyperLink(); //原生前端轉為<a
                hl.NavigateUrl = dr["MenuUrl"].ToString();  

                //設定圖片位置名稱
                Image img = new Image();
                if (dr["ImgSts"].ToString() == "ImgPath00")
                    img.ImageUrl = "Images/Setting/icon/" + dr["ImgPath00"].ToString(); 
                else
                    img.ImageUrl = "Images/Setting/icon/" + dr["ImgPath01"].ToString();

                hl.Controls.Add(img); //圖片顯示加入HyperLink按下連結控制項
                P1.Controls.Add(hl);  //HyperLink加入至Panel裡
                P0.Controls.Add(P1);  

                P1 = new Panel();
                P1.CssClass = "menu01text"; 

                hl = new HyperLink();
                hl.NavigateUrl = dr["MenuUrl"].ToString();
                hl.Text = dr["MenuName"].ToString();
                P1.Controls.Add(hl);
                P0.Controls.Add(P1);
                Panel_Page.Controls.Add(P0);
            }
        }
    }
}