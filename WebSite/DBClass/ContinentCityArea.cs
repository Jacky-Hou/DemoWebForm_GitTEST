using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace WebSite
{
    public class ContinentCityArea
    {
        public DataTable GetContinentCityArea(string reqFType = "",string DBsts = "")
        {
            StringBuilder sb = new StringBuilder();
            DBAccess DbAcs = new DBAccess();
            
            switch (reqFType)
            {
                case "Continent":
                    sb.Append(" Select ContinentID,ContinentName from ugContinent ");
                    if(DBsts == "A")
                        sb.Append(" where DBSts = 'A' ");
                    sb.Append(" Order By ContinentCode ");
                    break;
                case "City":
                    sb.Append(" Select CityID,ContinentID,CityName from ugCity ");
                    if (DBsts == "A")
                        sb.Append(" where DBSts = 'A' ");
                    sb.Append(" Order by CityCode ");
                    break;
                case "Area":
                    sb.Append(" Select CityID,AreaID,AreaName,AreaCode from ugArea ");
                    if (DBsts == "A")
                        sb.Append(" where DBSts = 'A' ");
                    sb.Append(" Order By AreaCode ");
                    break;
            }

            DataTable dt = DbAcs.GetDBData(sb.ToString());
            return dt;
        }
    }
}