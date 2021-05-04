using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Inc
{
    public partial class ug_Area : System.Web.UI.UserControl
    {
        ContinentCityArea CCA = new ContinentCityArea();
        string strArea;

        public string FirstIndex
        {
            get; set;
        }
        public string Area
        {
            get { return strArea; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt = CCA.GetContinentCityArea("Area", "A");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i > 0)
                    strArea += ",";
                strArea += dt.Rows[i]["AreaID"].ToString() + "&" + dt.Rows[i]["AreaName"].ToString() + "&" + dt.Rows[i]["CityID"].ToString() + "&" + dt.Rows[i]["AreaCode"].ToString();
            }
        }
    }
}