using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Inc
{
    public partial class ug_Continent : System.Web.UI.UserControl
    {
        ContinentCityArea CCA = new ContinentCityArea();
        string strContinent;
        //string strFirstIndex;

        public string FirstIndex
        {
            get;set;
        }
        public string Continent
        {
            get { return strContinent; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt = CCA.GetContinentCityArea("Continent", "A");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i > 0)
                    strContinent += ",";
                strContinent += dt.Rows[i]["ContinentID"].ToString() + "&" + dt.Rows[i]["ContinentName"].ToString();
            }
        }
    }
}