using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClassLibrary;
using WebSite.TW.Admin;
using WebSite.TW.Admin.User;

namespace WebSite
{
    public class UserDBSts
    {
        public string UserID;
        public string DBSts;
    }

    public class UserInfo
    {
        public string UserID;
        public string LoginID;
        public string Psw;
        public string UserName;
        public string HighUser;
        public string Descr;
        public string DBSts;
        public string CreUser;
        public string CreDate;
        public string UpdUser;
        public string UpdDate;
    }

    public class MenuUserPermission
    {
        public string MenuID;
        public string Type_All;
        public string Type_Look;
        public string Type_Add;
        public string Type_Update;
        public string Type_Del;
        public string HightUser;
    }

    public class Menus
    {
        public static DataTable Get_ugMenuUser()
        {
            DataTable dt;
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            //取所有資料
            sb.Append(" Select * From ugMenuUser ");
            dt = DbAcs.GetDBData(sb.ToString());
            return dt;
        }

        public DataTable Get_ugMenuUser(string reqFType, string par1 = "", string par2 = "", string par3 = "")
        {
            DataTable dt;
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            switch (reqFType)
            {
                case "getByUserID":             //透過帳號驗證
                    sb.Append(" Select * From ugMenuUser where UserID = @UserID ");
                    paralist.Add(DbAcs.BuildDbParameter("@UserID", par1)); //par1 = UserID
                    break;
                case "getByLoginID":            //取ugMenuUser資料
                    sb.Append(" Select UserID,LoginID,DBSts,HighUser,Psw ");
                    sb.Append(" From ugMenuUser ");
                    sb.Append(" where LoginID = @LoginID ");
                    paralist.Add(DbAcs.BuildDbParameter("@LoginID", par1)); //par1 = LoginID
                    break;
                case "getByLoginID_CheckUser":  //判斷該LoginID是否存在(新增)
                    sb.Append(" Select LoginID from ugMenuUser where LoginID = @LoginID");
                    paralist.Add(DbAcs.BuildDbParameter("@LoginID", par1)); //par1 = LoginID
                    break;
                case "getByUserID_LoginID_CheckUser":  //判斷該LoginID是否存在(修改，除了自己以外)
                    sb.Append(" Select LoginID from ugMenuUser where LoginID = @LoginID and UserID <> @UserID" );
                    paralist.Add(DbAcs.BuildDbParameter("@LoginID", par1)); //par1 = LoginID
                    paralist.Add(DbAcs.BuildDbParameter("@UserID", par2)); //par1 = LoginID
                    break;
                case "getByUserID_Permission":  //取該UserID有無對該單元內容修改裡為全部、修改權限
                    sb.Append(" Select u2.Type_All,u2.Type_Update from (( ugMenu u1");
                    sb.Append(" left join ugMenuUserItem u2 on u1.MenuID = u2.MenuID ) ");
                    sb.Append(" left join ugMenuUser u3 on u2.UserID = u3.UserID ) ");
                    sb.Append(" Where u1.MenuUrl like @MenuUrl And u2.UserID =@UserID ");
                    paralist.Add(DbAcs.BuildDbParameter("@MenuUrl", "%" + par1 + "%")); //par1 = LoginID
                    paralist.Add(DbAcs.BuildDbParameter("@UserID", par2)); //par1 = LoginID
                    break;
                //case "getBySort": //從多少取到多少 待測
                //    sb.Append(" SELECT TOP @Start * FROM ");
                //    sb.Append(" (SELECT TOP @Start * FROM ");
                //    sb.Append(" (SELECT TOP @End * FROM ugMenuUser ORDER BY @Sort )");
                //    sb.Append("  a ORDER BY @Sort DESC) a ORDER BY @Sort  ");
                //    paralist.Add(DbAcs.BuildDbParameter("@Sort", par1)); //par1 = LoginID
                //    paralist.Add(DbAcs.BuildDbParameter("@Start", int.Parse(par3) - int.Parse(par2) + 1)); //par1 = LoginID
                //    paralist.Add(DbAcs.BuildDbParameter("@End", int.Parse(par3) * 2)); //par1 = LoginID
                //    break;
                default:
                    break;
            }

            if (paralist.Count > 0)
                dt = DbAcs.GetDBData(sb.ToString(), paralist);
            else
                dt = DbAcs.GetDBData(sb.ToString());
            return dt;
        }

        public static DataTable Get_ugMenu()
        {
            DataTable dt;
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();
            string sUserID;
            int intUid;

            if (Utility.getSession("saHighUser") == "Y") //最高
            {
                sb.Append(" Select MenuCatID,MenuID,MenuCode,MenuName,MenuName_Front ");
                sb.Append(" ,MenuUrl,isFrontMenuSet,ImgSts,ImgPath00,ImgPath01,AgoDBSts ");
                sb.Append(" From ugMenu Where DBSts = 'A' Order By AgoDBsts,MenuCatID,MenuCode ");
            }
            else
            {
                sb.Append(" Select MenuCatID,u1.MenuID,MenuCode,MenuName,MenuName_Front ");
                sb.Append(" ,u1.MenuUrl,u1.isFrontMenuSet,u1.ImgSts,u1.ImgPath00,u1.ImgPath01,u1.AgoDBSts ");
                sb.Append(" From ugMenu as u1 Left Join ugMenuUserItem as u2 ON u1.MenuID = u2.MenuID ");
                sb.Append(" Where u1.DBSts = 'A' AND u2.UserID = @UserID ");
                sb.Append(" AND (u2.Type_All='Y' OR u2.TYPE_LOOK = 'Y') "); //在全部、瀏覽_顯示
                sb.Append(" Order By u1.AgoDBsts,u1.MenuCatID,u1.MenuCode ");
                sUserID = Utility.getSession("saUserID");
                intUid = Convert.ToInt32(sUserID != "" ? sUserID : "-1");
                paralist.Add(DbAcs.BuildDbParameter("@UserID", intUid));
            }

            if (paralist.Count > 0)
                dt = DbAcs.GetDBData(sb.ToString(), paralist);
            else
                dt = DbAcs.GetDBData(sb.ToString());
            return dt;
        }

        //取Menu
        public DataTable Get_ugMenu(string reqFType = "", string par1 = "")
        {
            DataTable dt;
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            switch (reqFType)
            {
                case "getByUrl":    //取圖片資料給ugA_incLeft
                    sb.Append(" Select ImgPath00,ImgPath01,MenuName,MenuName_Front,MenuUrl_Front,ImgSts ");
                    sb.Append(" From ugMenu where DBSts =@DBSts and MenuUrl like @MenuUrl ");
                    paralist.Add(DbAcs.BuildDbParameter("@DBSts", 'A'));
                    paralist.Add(DbAcs.BuildDbParameter("@MenuUrl", "%" + par1 + "%")); //par1 = Request.Url.Segments[3]
                    break;
                case "getByMenuID": //取PageTitle上方連結內容文字
                    sb.Append(" Select MenuName_Front From ugMenu Where DBSts = 'A' And MenuID = @MenuID ");
                    paralist.Add(DbAcs.BuildDbParameter("@MenuID", par1));
                    break;
            }

            if (paralist.Count > 0)
                dt = DbAcs.GetDBData(sb.ToString(), paralist);
            else
                dt = DbAcs.GetDBData(sb.ToString());

            return dt;
        }

        public static DataTable Get_ugMenuCheckBox()
        {
            DataTable dt;
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            sb.Append(" Select MenuID,MenuName,MenuUrl,CatName,MenuCode,Type_Add,Type_Update,Type_Del ");
            sb.Append(" From ugMenu u1 left join ugMenuCat u2 ");
            sb.Append(" on u1.MenuCatID = u2.MenuCatID Where u1.DBSts='A' ");
            sb.Append(" Order By u1.MenuCatID,u1.MenuCode");

            dt = DbAcs.GetDBData(sb.ToString());
            return dt;

        }

        //新增修改帳號
        public DataTable Get_ugMenuPermission(string reqFType = "", string par1 = "", string par2 = "")
        {
            DataTable dt;
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            switch (reqFType)
            {
                case "getByUserID":             //所有單元權限
                    sb.Append(" Select MenuID,Type_All as Type_All_Item ");
                    sb.Append(" ,Type_Look as Type_Look_Item ");
                    sb.Append(" ,Type_Add as Type_Add_Item ");
                    sb.Append(" ,Type_Update as Type_Update_Item ");
                    sb.Append(" ,Type_Del as Type_Del_Item ");
                    sb.Append(" From ugMenuUserItem ");
                    sb.Append(" Where UserID=@UserID");
                    paralist.Add(DbAcs.BuildDbParameter("@UserID", par1));
                    break;
                case "getByUserID_Permission":  //取單一單元權限
                    sb.Append(" Select u2.Type_All,u2.Type_Look,u2.Type_Add,u2.Type_Update,u2.Type_Del from (( ugMenu u1");
                    sb.Append(" left join ugMenuUserItem u2 on u1.MenuID = u2.MenuID ) ");
                    sb.Append(" left join ugMenuUser u3 on u2.UserID = u3.UserID ) ");
                    sb.Append(" Where u1.MenuUrl like @MenuUrl And u2.UserID =@UserID ");
                    paralist.Add(DbAcs.BuildDbParameter("@MenuUrl", "%" + par1 + "%")); 
                    paralist.Add(DbAcs.BuildDbParameter("@UserID", par2)); 
                    break;
            }

            if (paralist.Count > 0)
                dt = DbAcs.GetDBData(sb.ToString(), paralist);
            else
                dt = DbAcs.GetDBData(sb.ToString());
            return dt;
        }

        //取單一MenuData資料給ugA_incLeft
        public string[] Get_MenuInfo(string UrlSegments)
        {
            string[] str = new string[4];
            DataTable dt = Get_ugMenu("getByUrl", UrlSegments);
            if (dt.Rows.Count > 0)
            {
                str[1] = dt.Rows[0]["MenuName"].ToString();
                if (dt.Rows[0]["ImgSts"].ToString() == "ImgPath00")
                    str[0] = dt.Rows[0]["ImgPath00"].ToString();
                else
                    str[0] = dt.Rows[0]["ImgPath01"].ToString();

                str[2] = "前台" + dt.Rows[0]["MenuName_Front"].ToString();
                str[3] = dt.Rows[0]["MenuUrl_Front"] == null ? "" : dt.Rows[0]["MenuUrl_Front"].ToString();
            }
            return str;
        }

        //更新DBSts
        public void Update_ugMenuUser(string LoginID, string DBSts)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            sb.Append(" Update ugMenuUser Set DBSts=@DBSts where LoginID =@LoginID ");
            paralist.Add(DbAcs.BuildDbParameter("@DBSts", DBSts));
            paralist.Add(DbAcs.BuildDbParameter("@LoginID", LoginID));

            DbAcs.CUD(sb.ToString(), paralist);
        }

        //刪除單、多個使用者
        public int Delete_ugMenuUser(string[] UserID)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            sb.Append(" Delete From ugMenuUser where UserID in ");
            string Sql = sb.ToString();
            for (int i = 0; i < UserID.Length; i++)
            {
                if (i == 0)
                    Sql += "(@UserID_" + i;
                else
                    Sql += ",@UserID_" + i;

                paralist.Add(DbAcs.BuildDbParameter("@UserID_" + i, UserID[i]));
            }
            Sql += ")";

            return DbAcs.CUD(Sql, paralist);
        }

        public int Insert_ugMenuUser(UserInfo User)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            sb.Append(" Insert Into ugMenuUser (LoginID,Psw,UserName,Descr,HighUser,DBSts,CreUser,CreDate) ");
            sb.Append(" Values (@LoginID,@Psw,@UserName,@Descr,@HighUser,@DBSts,@CreUser,@CreDate) ");
            paralist.Add(DbAcs.BuildDbParameter("@LoginID", User.LoginID));
            paralist.Add(DbAcs.BuildDbParameter("@Psw", User.Psw));
            paralist.Add(DbAcs.BuildDbParameter("@UserName", User.UserName));
            paralist.Add(DbAcs.BuildDbParameter("@Descr", User.Descr));
            paralist.Add(DbAcs.BuildDbParameter("@HighUser", User.HighUser));
            paralist.Add(DbAcs.BuildDbParameter("@DBSts", User.DBSts));
            paralist.Add(DbAcs.BuildDbParameter("@CreUser", Utility.getSession("saLoginID"))); //TODO
            paralist.Add(DbAcs.BuildDbParameter("@CreDate", DateTime.Now.ToString()));

            return DbAcs.CUD(sb.ToString(), paralist, true);
        }

        public int Update_ugMenuUser(UserInfo User)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            sb.Append(" Update ugMenuUser Set LoginID=@LoginID,UserName=@UserName,Descr=@Descr ");
            sb.Append(" ,HighUser=@HighUser,DBSts=@DBSts,UpdUser=@UpdUser,UpdDate=@UpdDate ");
            if (User.Psw != "")
                sb.Append(" ,Psw = @Psw ");
            sb.Append(" where UserID=@UserID ");
            paralist.Add(DbAcs.BuildDbParameter("@LoginID", User.LoginID));
            paralist.Add(DbAcs.BuildDbParameter("@UserName", User.UserName));
            paralist.Add(DbAcs.BuildDbParameter("@Descr", User.Descr));
            paralist.Add(DbAcs.BuildDbParameter("@HighUser", User.HighUser));
            paralist.Add(DbAcs.BuildDbParameter("@DBSts", User.DBSts));
            paralist.Add(DbAcs.BuildDbParameter("@UpdUser", Utility.getSession("saLoginID"))); //TODO
            paralist.Add(DbAcs.BuildDbParameter("@UpdDate", DateTime.Now.ToString()));
            if (User.Psw != "")
                paralist.Add(DbAcs.BuildDbParameter("@Psw", User.Psw));
            paralist.Add(DbAcs.BuildDbParameter("@UserID", User.UserID));

            return DbAcs.CUD(sb.ToString(), paralist);
        }

        public int Insert_ugMenuUserItem(List<MenuUserPermission> MenuUserItem, int UseID, List<CmdParameter> refCPList = null)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            CmdParameter CPL;
            List<CmdParameter> CPList = new List<CmdParameter>();

            foreach (MenuUserPermission MUP in MenuUserItem)
            {
                sb.Append(" Insert into ugMenuUserItem (UserID,MenuID,Type_All,Type_Look,Type_Add,Type_Update,Type_Del)  ");
                sb.Append(" Values (@UserID,@MenuID,@Type_All,@Type_Look,@Type_Add,@Type_Update,@Type_Del)  ");

                paralist = new List<DbParameter>();
                paralist.Add(DbAcs.BuildDbParameter("@UserID", UseID));
                paralist.Add(DbAcs.BuildDbParameter("@MenuID", MUP.MenuID));
                paralist.Add(DbAcs.BuildDbParameter("@Type_All", MUP.Type_All));
                paralist.Add(DbAcs.BuildDbParameter("@Type_Look", MUP.Type_Look));
                paralist.Add(DbAcs.BuildDbParameter("@Type_Add", MUP.Type_Add));
                paralist.Add(DbAcs.BuildDbParameter("@Type_Update", MUP.Type_Update));
                paralist.Add(DbAcs.BuildDbParameter("@Type_Del", MUP.Type_Del));

                CPL = new CmdParameter();
                CPL.Cmd = sb.ToString();
                CPL.Par = paralist;

                if (refCPList != null)
                    refCPList.Add(CPL);
                else
                    CPList.Add(CPL);

                sb.Clear();
            }

            if (refCPList != null)
                return DbAcs.CUD(refCPList);
            else
                return DbAcs.CUD(CPList);
        }

        public int Delete_Insert_ugMenuUserItem(List<MenuUserPermission> MenuUserItem, int UseID)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();
            CmdParameter CPL = new CmdParameter();
            List<CmdParameter> CPList = new List<CmdParameter>();

            sb.Append(" Delete From ugMenuUserItem Where UserID=@UserID");
            paralist.Add(DbAcs.BuildDbParameter("@UserID", UseID));

            CPL.Cmd = sb.ToString();
            CPL.Par = paralist;

            CPList.Add(CPL);
            int i = Insert_ugMenuUserItem(MenuUserItem, UseID, CPList);
            return i;

        }

        public int Update_DBSts(List<UserDBSts> DBStsList)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();
            CmdParameter CPL = new CmdParameter();
            List<CmdParameter> CPList = new List<CmdParameter>();
            foreach (UserDBSts DBS in DBStsList)
            {
                sb.Append(" Update ugMenuUser Set DBSts=@DBSts Where UserID=@UserID");

                paralist = new List<DbParameter>();
                paralist.Add(DbAcs.BuildDbParameter("@DBSts", DBS.DBSts));
                paralist.Add(DbAcs.BuildDbParameter("@UserID", DBS.UserID));

                CPL.Cmd = sb.ToString();
                CPL.Par = paralist;

                CmdParameter CPLClone = new CmdParameter();
                CPLClone = (CmdParameter)CPL.Clone();

                CPList.Add(CPLClone);

                sb.Clear();
            }

            return DbAcs.CUD(CPList);
        }
    }
}
