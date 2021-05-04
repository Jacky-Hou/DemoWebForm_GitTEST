using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Inc
{
    public partial class ug_City : System.Web.UI.UserControl
    {
        ContinentCityArea CCA = new ContinentCityArea();
        string  strCity;
        public string FirstIndex
        {
            get; set;
        }
        public string City
        {
            get { return strCity; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt = CCA.GetContinentCityArea("City", "A");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i > 0)
                    strCity += ",";
                strCity += dt.Rows[i]["CityID"].ToString() + "&" + dt.Rows[i]["CityName"].ToString() + "&" + dt.Rows[i]["ContinentID"].ToString();
            }
        }
    }
}