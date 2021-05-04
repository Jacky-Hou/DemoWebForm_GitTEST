using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClassLibrary;

namespace WebSite.TW.Admin
{
    public partial class ugA_Logout : System.Web.UI.Page
    {
        Menu mu = new Menu();
        Utility Utli = new Utility();
        Log log = new Log();
        protected void Page_Load(object sender, EventArgs e)
         {
            int saLoginLogID = Utli.getSessionInInt("saLoginLogID");
            if (saLoginLogID > 0)
            {
                var dt = log.Get_ugLoginLog(saLoginLogID);
                if (dt.Rows.Count > 0)
                {
                    log.Update_ugLoginLog(saLoginLogID);
                }
            }
            AdminClass.ClearSession(1);
            Response.Redirect("Default.aspx"); 
        }
    }
}