using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.TW.Inc
{
    public partial class ug_ContinentCityArea : System.Web.UI.UserControl
    {
        ContinentCityArea CCA = new ContinentCityArea();
        string strContinent, strCity, strArea;

        public string[] Index
        {
            get { return FirstIndex.Split(','); }
        }

        public string FirstIndex
        {
            get; set;
        }

        public string Continent
        {
            get { return strContinent; }
        }
        public string City
        {
            get { return strCity; }
        }
        public string Area
        {
            get { return strArea; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //strIndex = FirstIndex.Split('-');

            DataTable dt = new DataTable();
            dt = CCA.GetContinentCityArea("Continent", "A");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i > 0)
                    strContinent += ",";
                strContinent += dt.Rows[i]["ContinentID"].ToString() + "&" + dt.Rows[i]["ContinentName"].ToString();
            }

            dt = CCA.GetContinentCityArea("City", "A");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i > 0)
                    strCity += ",";
                strCity += dt.Rows[i]["CityID"].ToString() + "&" + dt.Rows[i]["CityName"].ToString() + "&" + dt.Rows[i]["ContinentID"].ToString();
            }

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