using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebSite
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            WriteLogFile(Request.Url.AbsoluteUri);

            #region for acunetix scan - Possible sensitive directories
            //錯誤頁面時導回首頁
            if (Request.QueryString["aspxerrorpath"] != null)
                if (Request.QueryString["aspxerrorpath"].ToString() != string.Empty)
                    Response.Redirect("/index.aspx", true);
            #endregion for acunetix scan - Possible sensitive directories

            ShowGallery();
            //Get_ugAcct();

        }

        public void Get_ugAcct()
        {
            DBAccess DbAcs = new DBAccess();
            StringBuilder sb = new StringBuilder();
            sb.Append(" Select ");
            DataTable dt = DbAcs.GetDBData(sb.ToString());
            int i = int.Parse(dt.Rows[0]["Email"].ToString());
        }

        public void WriteLogFile(string Logtxt)
        {
            string DirFolder = Server.MapPath("~") + @"\Log"; //或 Application.StartupPath + string DirFolder = Application.StartupPath + @"\Log";
            string MonthPath = DateTime.Now.Month.ToString();

            if (MonthPath.Length < 2)
                MonthPath = MonthPath.PadLeft(2, '0');

            string SetPath = DirFolder + "\\" + DateTime.Now.Year.ToString() + MonthPath;

            if (!Directory.Exists(SetPath))
                Directory.CreateDirectory(SetPath);

            string FilePath = SetPath + "\\" + DateTime.Now.ToString("yyyyMMdd") + ".txt";

            FileStream fsFile = new FileStream(FilePath, FileMode.Append);
            StreamWriter swWriter = new StreamWriter(fsFile);

            swWriter.WriteLine(string.Format("{0}   {1}", DateTime.Now, Logtxt));
            swWriter.Close();
        }


        private void ShowGallery()
        {
            ul_album.Controls.Clear();
            string Text = "測試";

            HtmlGenericControl div, p, h2;
            HyperLink hl;

            div = new HtmlGenericControl("div");
            div.Attributes.Add("class", "swiper-slide");

            hl = new HyperLink();
            hl.NavigateUrl = "../MediaRoom/Gallery_List.aspx";
            hl.ToolTip = Text;

            p = new HtmlGenericControl("p");
            p.InnerText = Text;
            hl.Controls.Add(p);

            //img = new Image();
            //img.CssClass = "Photo";
            //hl.Controls.Add(img);
            //img.AlternateText = Text;
            //img.Attributes.Add("loading", "lazy");
            //hl.Controls.Add(img);

            //imgbg = new Image();
            //imgbg.CssClass = "Bg";
            //imgbg.ImageUrl = "images/Layout/Bg_DefAlbumPhoto.png";
            //imgbg.AlternateText = Text;
            //imgbg.Attributes.Add("loading", "lazy");
            //hl.Controls.Add(imgbg);

            h2 = new HtmlGenericControl("h2");
            h2.Controls.Add(hl);

            div.Controls.Add(h2);
            ul_album.Controls.Add(div);
        }

    }
}