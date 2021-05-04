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
    public partial class JqueryAutoComple : System.Web.UI.Page
    {
        public string WorkList = string.Empty;
        DBCon dbCon = new DBCon();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Form["WorkProjectsID"] != null)
                GetHazardName(Request.Form["WorkProjectsID"]);
            else
                GetWorkListName();

        }

        public void GetWorkListName()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" Select WorkProjectsID,WorkName from ugWorkProjects order by WorkName ");

            DataTable dt = dbCon.GetSqlTable(sb.ToString());

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i == 0)
                    WorkList += dt.Rows[i]["WorkProjectsID"].ToString() + "&" + dt.Rows[i]["WorkName"].ToString();
                else
                    WorkList += "," + dt.Rows[i]["WorkProjectsID"].ToString() + "&" + dt.Rows[i]["WorkName"].ToString();
            }
        }

        public void GetHazardName(string WorkProjectsID)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" Select HazardName from ugHazardProject where WorkProjectsID=" + WorkProjectsID + " order by HazardName ");

            DataTable dt = dbCon.GetSqlTable(sb.ToString());

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i == 0)
                    WorkList += dt.Rows[i]["HazardName"].ToString();
                else
                    WorkList += "," + dt.Rows[i]["HazardName"].ToString();
            }

            Response.Write(WorkList);
            Response.End();
        }
    }
}