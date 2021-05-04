using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace WebSite
{
    public class ParInfo
    {
        public string Sort;
        public string Desc;
        public int PgNum;
    }

    public class AdminClass : System.Web.UI.Page
    {
        Menus menus = new Menus();
        public static int intAcctCatIDRang = 100; //<後台>會員等級的數目0~10;0即代表無分類==>包含ugA_AcctCat.asp.ugA_Showroom.Price的設定
        public static void ClearSession(int Type)
        {
            if (Type == 1)
            {
                HttpContext.Current.Session["saLoginID"] = "";      //LoginID
                HttpContext.Current.Session["saUserID"] = "";       //UserID
                HttpContext.Current.Session["saHighUser"] = "";     //最高權限(Y or N)
                HttpContext.Current.Session["saUgear"] = "";        //uGear的員工
                HttpContext.Current.Session["saUgearUser"] = "";
                HttpContext.Current.Session["saNowMenuID"] = "";

                HttpContext.Current.Session["Type_Update_Acct"] = "";   //ugA_OrdCat.asp,ugA_AcctOrd.asp至會員ugA_Acct_m.asp用到的Session
                HttpContext.Current.Session["Type_Update_Order"] = "";  //Paper/ugA_Ord.asp至訂單資料用到的Session
                HttpContext.Current.Session["saCKeditor_IsAuthorized"] = false;
            }
            HttpContext.Current.Session["Type_All"] = "";
            HttpContext.Current.Session["Type_Look"] = "";
            HttpContext.Current.Session["Type_Add"] = "";
            HttpContext.Current.Session["Type_Update"] = "";
            HttpContext.Current.Session["Type_Del"] = "";
            HttpContext.Current.Session["MenuName"] = "";
            HttpContext.Current.Session["MenuName_EN"] = "";
            HttpContext.Current.Session["MenuName_Front"] = "";
            HttpContext.Current.Session["MenuUrl_Front"] = "";
        }

        public void GetUserIDPermission(string GetByUrl, ref MenuUserPermission MUPermission)
        {
            DataTable dt = menus.Get_ugMenuPermission("getByUserID_Permission", GetByUrl, Utility.getSession("saUserID"));  //取MenuUserItem權限

            MUPermission.HightUser = Utility.getSession("saHighUser");
            if (MUPermission.HightUser == "Y")    //登入是否為最高權限判斷
            {
                MUPermission.Type_All = "Y";
                MUPermission.Type_Add = "Y";
                MUPermission.Type_Look = "Y";
                MUPermission.Type_Add = "Y";
                MUPermission.Type_Update = "Y";
                MUPermission.Type_Del = "Y";
            }
            else
            {
                if (dt.Rows.Count > 0)
                {
                    MUPermission.Type_Add = dt.Rows[0]["Type_All"].ToString();
                    if (MUPermission.Type_Add == "Y")
                    {
                        MUPermission.Type_Look = "Y";
                        MUPermission.Type_Add = "Y";
                        MUPermission.Type_Update = "Y";
                        MUPermission.Type_Del = "Y";
                    }
                    else
                    {
                        MUPermission.Type_Look = dt.Rows[0]["Type_Look"].ToString();
                        MUPermission.Type_Add = dt.Rows[0]["Type_Add"].ToString();
                        MUPermission.Type_Update = dt.Rows[0]["Type_Update"].ToString();
                        MUPermission.Type_Del = dt.Rows[0]["Type_Del"].ToString();
                    }
                }
            }
        }
    }
}
