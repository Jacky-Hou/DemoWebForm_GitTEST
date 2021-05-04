using ClassLibrary;
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

namespace WebSite.TW.Admin.User
{
    public partial class ugA_User_m : System.Web.UI.Page
    {
        Menus menus = new Menus();
        ParInfo par = new ParInfo();
        UserInfo user = new UserInfo();
        AdminClass adClass = new AdminClass();
        MenuUserPermission MUPermission = new MenuUserPermission();
        string strGoToUserUrl = "ugA_User.aspx";

        public string UserID
        {
            get { return user.UserID; }
        }
        public string LoginID
        {
            get { return user.LoginID; }
        }

        public string UserName
        {
            get { return user.UserName; }
        }
        public string saUserName
        {
            get { return Utility.getSession("saLoginID"); }
        }

        public string HighUser
        {
            get { return user.HighUser; }
        }
        public string Descr
        {
            get { return user.Descr; }
        }
        public string DBSts
        {
            get { return user.DBSts; }
        }
        public string CreUser
        {
            get { return user.CreUser; }
        }
        public string CreDate
        {
            get { return user.CreDate; }
        }
        public string UpdUser
        {
            get { return user.UpdUser; }
        }
        public string UpdDate
        {
            get { return user.UpdDate; }
        }
        public string Type_All
        {
            get { return MUPermission.Type_All; }
        }
        public string Type_Update
        {
            get { return MUPermission.Type_Update; }
        }
        public int PgNum
        {
            get { return par.PgNum; }
        }
        public string Sort
        {
            get { return par.Sort; }
        }
        public string Desc
        {
            get { return par.Desc; }
        }

        public string GoToUserUrl
        {
            get { return strGoToUserUrl; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Utility.CheckSession("saUserID"))
                Response.Redirect("../Default.aspx");

            user.UserID = Request.Form["UserID"] == null ? "" : Request.Form["UserID"].ToString();
            par.Sort = Request.Form["Sort"] == null ? "" : Request.Form["Sort"].ToString();
            par.Desc = Request.Form["Desc"] == null ? "" : Request.Form["Desc"].ToString();
            par.PgNum = Request.Form["PgNum"] == null ? 1 : int.Parse(Request.Form["PgNum"].ToString());

            if (user.UserID != "")
            {
                SetData(user.UserID);
                adClass.GetUserIDPermission(strGoToUserUrl,ref MUPermission);
            }
        }

        //取新增、修改使用者的Checkbox權限設定
        [WebMethod]
        public static string GetMenuCheckbox(string UserID)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            DataTable dt = Menus.Get_ugMenuCheckBox();
            if (UserID != "")
            {
                Menus menus = new Menus();
                DataTable dtCheckBox = menus.Get_ugMenuPermission("getByUserID", UserID);

                dt.Columns.Add("Type_All_Item");
                dt.Columns.Add("Type_Look_Item");
                dt.Columns.Add("Type_Add_Item");
                dt.Columns.Add("Type_Update_Item");
                dt.Columns.Add("Type_Del_Item");

                foreach (DataRow dr1 in dt.Rows)
                {
                    foreach (DataRow dr2 in dtCheckBox.Rows)
                    {
                        if (dr1["MenuID"].ToString() == dr2["MenuID"].ToString())
                        {
                            dr1["Type_All_Item"] = dr2["Type_All_Item"] == null ? "" : dr2["Type_All_Item"];
                            dr1["Type_Look_Item"] = dr2["Type_Look_Item"] == null ? "" : dr2["Type_Look_Item"];
                            dr1["Type_Add_Item"] = dr2["Type_Add_Item"] == null ? "" : dr2["Type_Add_Item"];
                            dr1["Type_Update_Item"] = dr2["Type_Update_Item"] == null ? "" : dr2["Type_Update_Item"];
                            dr1["Type_Del_Item"] = dr2["Type_Del_Item"] == null ? "" : dr2["Type_Del_Item"];
                        }
                    }
                }
            }

            JO.Add("MenuUserItemData", JsonConvert.SerializeObject(dt));
            return JsonConvert.SerializeObject(JO);
        }

        [WebMethod]
        public static string AddMenuUser(UserInfo User, List<MenuUserPermission> MenuUserItem)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            int UserID;
            string strAlertMsg = "";
            string strSuccess = "";

            Menus menus = new Menus();
            DataTable dt = menus.Get_ugMenuUser("getByLoginID_CheckUser", User.LoginID); //確認LoginID

            if (dt.Rows.Count > 0)
                strAlertMsg = "新增失敗 -- 帳號(" + User.LoginID + ")已存在!!";
            else
            {
                Cryptography cryptography = new Cryptography();
                try
                {
                    User.Psw = cryptography.EncryptAES(User.Psw, PubicClass.CrypotographyKey, PubicClass.CrypotographyVectory);
                    UserID = menus.Insert_ugMenuUser(User); //新增使用者
                    if (UserID > 0) //最大UserID
                    {
                        if (MenuUserItem.Count > 0 && User.HighUser != "Y")
                        {
                            try
                            {
                                //一般權限
                                if (menus.Insert_ugMenuUserItem(MenuUserItem, UserID) == 1)
                                    strSuccess = "新增成功";
                                else
                                    strAlertMsg = "帳號(" + User.LoginID + ")新增成功 單元權限新增失敗";
                            }
                            catch (Exception ex)
                            {
                                strSuccess = "";
                                strAlertMsg = "帳號(" + User.LoginID + ")新增成功 單元權限新增失敗";
                            }
                        }
                        else //最高權限
                            strSuccess = "新增成功";
                    }
                    else
                        strAlertMsg = "新增失敗";
                }
                catch (Exception ex)
                {
                    strSuccess = "";
                    strAlertMsg = "新增失敗";
                }
            }

            JO.Add("strSuccess", strSuccess);
            JO.Add("strAlertMsg", strAlertMsg);
            return JsonConvert.SerializeObject(JO);
        }

        [WebMethod]
        public static string UpdateMenuUser(UserInfo User, List<MenuUserPermission> MenuUserItem)
        {
            JObject JO = new JObject();
            if (!Utility.CheckSession("saUserID"))
            {
                JO.Add("Redirect", "../Default.aspx");
                return JsonConvert.SerializeObject(JO);
            }

            string strAlertMsg = "";
            string strSuccess = "";

            Menus menus = new Menus();
            DataTable dt = menus.Get_ugMenuUser("getByUserID_LoginID_CheckUser", User.LoginID, User.UserID); //確認LoginID

            if (dt.Rows.Count > 0)
                strAlertMsg = "修改失敗 -- 帳號(" + User.LoginID + ")已存在!!";
            else
            {
                Cryptography cryptography = new Cryptography();
                try
                {
                    if (User.Psw != "") //修改使用者密碼不為空才加密
                        User.Psw = cryptography.EncryptAES(User.Psw, PubicClass.CrypotographyKey, PubicClass.CrypotographyVectory);

                    int i = menus.Update_ugMenuUser(User);
                    if (i > 0)
                    {
                        try
                        {
                            //先刪除後新增
                            i = menus.Delete_Insert_ugMenuUserItem(MenuUserItem, int.Parse(User.UserID));
                            if (i == 1)
                                strSuccess = "修改成功";
                            else
                                strAlertMsg = "帳號(" + User.LoginID + ")修改成功 單元權限修改失敗";
                        }
                        catch (Exception ex)
                        {
                            strSuccess = "";
                            strAlertMsg = "帳號(" + User.LoginID + ")修改成功 單元權限修改失敗";
                        }
                    }
                    else
                        strAlertMsg = "修改失敗";
                }
                catch (Exception ex)
                {
                    strSuccess = "";
                    strAlertMsg = "新增失敗";
                }
            }
            JO.Add("strSuccess", strSuccess);
            JO.Add("strAlertMsg", strAlertMsg);
            return JsonConvert.SerializeObject(JO);
        }


        public void SetData(string UserID)
        {
            Menus menus = new Menus();
            DataTable dt = menus.Get_ugMenuUser("getByUserID", UserID);

            foreach (DataRow dr in dt.Rows)
            {
                user.LoginID = dr["LoginID"].ToString();
                user.UserName = dr["UserName"].ToString();
                user.HighUser = dr["HighUser"].ToString();
                user.Descr = dr["descr"].ToString();
                user.DBSts = dr["DBSts"].ToString();
                user.CreUser = dr["CreUser"].ToString();
                user.CreDate = dr["CreDate"].ToString();
                user.UpdUser = dr["UpdUser"].ToString();
                user.UpdDate = dr["UpdDate"].ToString();
            }
        }
    }
}