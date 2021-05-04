using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Admin
{
    public partial class ugA_MsgBox : System.Web.UI.UserControl
    {
        public bool Rent;
        private long[] qs;
        private string quRent, quUse, quCanUse;

        public string Status
        {
            get; set;
        }
        public string User
        {
            get; set;
        }
        public string Location
        {
            get; set;
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
            get { return qs;}
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!Utility.CheckSession("saLoginID"))
            //    Response.Redirect("../Default.aspx");

            Rent = PubicClass.isHiSpaceRent;  //有承租空間才會顯示空間容量
            qs = PubicClass.GetQuota(Server.MapPath("~/"));

            if (qs[0] != 0) //承租空間
            {
                quRent = Utility.GetWebSize(qs[0]);     //承租空間容量
                quUse = qs[1].ToString();               //已使用
                quCanUse = Utility.GetWebSize(qs[2]);   //尚可使用容量
                                                        //_EndDate = GetWebConfig.AppStting("EndDate");
            }
            //lab_User.Text = Utility.getSession("saLoginID");
            User = Utility.getSession("saLoginID");

        }
    }
}