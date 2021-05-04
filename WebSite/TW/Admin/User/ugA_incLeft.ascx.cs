﻿using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Admin.User
{
    public partial class ugA_incLeft : System.Web.UI.UserControl
    {
        private string backImage;
        private string[] menudata;
        public AdminSetting AdSetting = new AdminSetting();
        public Menus menus = new Menus();

        public string BackImage
        {
            get { return backImage; }
        }
        public string[] MenuData
        {
            get { return menudata; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!Utility.CheckSession("saLoginID"))
            //    Response.Redirect("../Default.aspx");

            backImage = AdSetting.GetBackImg();
            menudata = menus.Get_MenuInfo(Request.Url.Segments[3]);
         
        }
    }
}