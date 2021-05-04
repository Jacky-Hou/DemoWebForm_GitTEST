using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Web;
using WebSite.TW.Admin.Acct;
using WebSite.TW.Member;

namespace WebSite
{
    public class AcctDBSts
    {
        public string AcctID;
        public string DBSts;
    }

    public class AcctInfo
    {
        public string AcctID;
        public string AcctCatID;
        public string LoginID;
        public string Upsts;
        public string BgnDate;
        public string EndDate;
        public string Psw;
        public string VipCardNum;
        public string VIPConfirm;
        public string Company;
        public string AcctName;
        public string Sex;
        public string Birth;
        public string Email;
        public string ContinentID;
        public string CityID;
        public string AreaID;
        public string ZipCode;
        public string ZipCodeTwo;
        public string Addr;
        public string Tel;
        public string Cell;
        public string Fax;
        public string Occu;
        public string Edu;
        public string Marriage;
        public string HowKnow;
        public string IsEPaper;
        public string FrontCaptchaCode; //驗證碼
        public string CSRFtoken;
        public string Loginnum;
        public string Ordnum;
        public string Forumnum;
        public string DBSts;
        public string Descr;
        public string CreUser;
        public string CreDate;
        public string UpdUser;
        public string UpdDate;
        public string FBID;
        public string GPID;
        public string LineID;
    }

    public class AcctCatInfo
    {
        public string AcctCatID;
        public string CatCode;
        public string CatName;
        public string UpSts;
        public string DueDate;
        public string DueDateSts;
        public string DBSts;
        public string CreUser;
        public string CreDate;
    }

    public class Account
    {
        //搜尋條件所以拆開
        public DataTable Get_ugAcct(string reqFType, List<SearchInfo> Search)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();
            DataTable dt;

            switch (reqFType)
            {
                case "getBySearch":  //取會員數 有帶條件搜尋
                    sb.Append(" Select CATNAME,LOGINID,ACCTID,EMAIL,ACCTNAME,VIPCARDNUM,ENDDATE,LOGINNUM ");
                    sb.Append(" ,u1.ACCTCATID,u1.DBSTS,u1.UPSTS from ugAcct u1");
                    sb.Append(" Left Join ugAcctCat u2 On u1.ACCTCATID = u2.ACCTCATID ");
                    break;
                case "getBySearchToExcel":
                    sb.Append(" Select CaTName,iif (u1.UpSts = 'Y','無期限',BgnDate + '~' + EndDate) as [DateRang],LoginID,AcctID,VipCardNum,VIPConfirm,Company,AcctName,Sex,Birth ");
                    sb.Append(" ,Addr,Tel,Cell,Fax,Occu,Edu,Marriage,HowKnow,IsePaPer,u1.CreDate,LoginDate,LoginNum,OrdNum,ForumNum");
                    sb.Append(" ,u1.DBSts from ugAcct u1");
                    sb.Append(" Left Join ugAcctCat u2 On u1.ACCTCATID = u2.ACCTCATID ");
                    break;
            }

            for (int i = 0; i < Search.Count; i++)
            {
                //不為會員等級、門市會員或為會員等級!=全部與門市會員!=全部 才 加入條件搜尋
                //改前端判斷
                //if ((Search[i].Column != "AcctCatID" && Search[i].Column != "VIPConfirm") || ((Search[i].Column == "AcctCatID" && Search[i].Val != "0") || (Search[i].Column == "VIPConfirm" && Search[i].Val != "A")))
                //{
                if (paralist.Count == 0)
                    sb.Append(" Where");

                sb.Append(" ");

                if (Search[i].Column == "AcctCatID")
                    sb.Append("u1." + Search[i].Column + " like @" + Search[i].Column);
                else
                    sb.Append(Search[i].Column + " like @" + Search[i].Column);

                //不為最後條件且"下一筆"不為會員等級、門市會員或為會員等級 != 全部及為門市會員 != 全部 才 加入and
                if (i != Search.Count - 1)
                {
                    //改前端判斷
                    //if((Search[i + 1].Column != "AcctCatID" && Search[i + 1].Column != "VIPConfirm") || ((Search[i + 1].Column == "AcctCatID" && Search[i + 1].Val != "0") || (Search[i + 1].Column == "VIPConfirm" && Search[i + 1].Val != "A")))
                    sb.Append(" and");
                }
                paralist.Add(DbAcs.BuildDbParameter("@" + Search[i].Column, "%" + Search[i].Val + "%"));
                //}
            }

            if (reqFType == "getBySearchToExcel")
                sb.Append(" Order by CaTName");

            dt = DbAcs.GetDBData(sb.ToString(), paralist);
            return dt;

        }

        public string Column;
        public string Val;

        public DataTable Get_ugAcct(string reqFType = "", string par1 = "")
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();
            DataTable dt;
            switch (reqFType)
            {
                case "getByAcctID":
                    sb.Append(" Select * from ugAcct ");
                    sb.Append(" Where ACCTID = @ACCTID ");
                    paralist.Add(DbAcs.BuildDbParameter("@ACCTID", par1));
                    break;
                case "getAllAcct":  //取總會員數
                    sb.Append(" Select CATNAME,LOGINID,ACCTID,EMAIL,ACCTNAME,VIPCARDNUM,ENDDATE,LOGINNUM ");
                    sb.Append(" ,u1.ACCTCATID,u1.DBSTS,u1.UPSTS from ugAcct u1");
                    sb.Append(" Left Join ugAcctCat u2 On u1.ACCTCATID = u2.ACCTCATID ");
                    break;
                case "getAllAcctToExcal":  //取總會員數Excel匯出
                    sb.Append(" Select CaTName,iif (u1.UpSts = 'Y','無期限',BgnDate + '~' + EndDate) as [DateRang],LoginID,AcctID,VipCardNum,VIPConfirm,Company,AcctName,Sex,Birth ");
                    sb.Append(" ,Addr,Tel,Cell,Fax,Occu,Edu,Marriage,HowKnow,IsePaPer,u1.CreDate,LoginDate,LoginNum,OrdNum,ForumNum");
                    sb.Append(" ,u1.DBSts from ugAcct u1");
                    sb.Append(" Left Join ugAcctCat u2 On u1.ACCTCATID = u2.ACCTCATID Order by CaTName");
                    break;
                case "getCount":  //取每個層級會員數
                    sb.Append(" Select AcctCatId,Count(AcctCatId) as [Count] ");
                    sb.Append(" from ugAcct where AcctCatId Between 0 and @AcctCatIDRang ");
                    sb.Append(" Group by AcctCatId ");
                    paralist.Add(DbAcs.BuildDbParameter("@AcctCatIDRang", par1));
                    break;
                case "getByLoginID": //取LoginID
                    sb.Append(" Select LOGINID,ACCTNAME,CREDATE from ugAcct Where LOGINID = @LOGINID ");
                    paralist.Add(DbAcs.BuildDbParameter("@LOGINID", par1));
                    break;
                case "getByLineID":
                    sb.Append("Select LoginID,PSW,DBSts From ugAcct Where LineID = @LineID");
                    paralist.Add(DbAcs.BuildDbParameter("@LineID", par1));
                    break;
                case "getByLineEmail":
                    sb.Append("Select AcctID,LoginID,PSW,DBSts From ugAcct Where email = @Email");
                    paralist.Add(DbAcs.BuildDbParameter("@Email", par1));
                    break;
            }

            if (paralist.Count > 0)
                dt = DbAcs.GetDBData(sb.ToString(), paralist);
            else
                dt = DbAcs.GetDBData(sb.ToString());
            return dt;
        }

        public int Insert_ugAcct(string reqFType, AcctInfo Vip)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            switch (reqFType)
            {
                case "InsertByWeb":
                    sb.Append(" Insert Into ugAcct(ACCTCATID,LOGINID ");
                    sb.Append(" ,PSW,COMPANY,ACCTNAME,SEX,BIRTH,EMAIL ");
                    sb.Append(" ,CONTINENTID,CITYID,AREAID,ZIPCODE,ZIPCODETWO ");
                    sb.Append(" ,ADDR,TEL,CELL,FAX,OCCU,EDU,MARRIAGE,HOWKNOW");
                    sb.Append(" ,ISEPAPER,CREUSER,CREDATE,VIPCARDNUM,UPSTS ");
                    sb.Append(" ,BGNDATE,ENDDATE,VIPConfirm ) ");
                    sb.Append("  Values ");
                    sb.Append(" (@ACCTCATID,@LOGINID,@PSW,@COMPANY,@ACCTNAME ");
                    sb.Append(" ,@SEX,@BIRTH,@EMAIL,@CONTINENTID,@CITYID ");
                    sb.Append(" ,@AREAID,@ZIPCODE,@ZIPCODETWO,@ADDR,@TEL ");
                    sb.Append(" ,@CELL,@FAX,@OCCU,@EDU,@MARRIAGE ");
                    sb.Append(" ,@HOWKNOW,@ISEPAPER,@CREUSER,@CREDATE,Null,@UPSTS ");
                    sb.Append(" ,@BGNDATE,@ENDDATE,@VIPConfirm ) ");

                    paralist.Add(DbAcs.BuildDbParameter("@ACCTCATID", Vip.AcctCatID));
                    paralist.Add(DbAcs.BuildDbParameter("@LOGINID", Vip.LoginID));
                    paralist.Add(DbAcs.BuildDbParameter("@PSW", Vip.Psw));
                    paralist.Add(DbAcs.BuildDbParameter("@COMPANY", Vip.Company));
                    paralist.Add(DbAcs.BuildDbParameter("@ACCTNAME", Vip.AcctName));
                    paralist.Add(DbAcs.BuildDbParameter("@SEX", Vip.Sex));
                    paralist.Add(DbAcs.BuildDbParameter("@BIRTH", Vip.Birth));
                    paralist.Add(DbAcs.BuildDbParameter("@EMAIL", Vip.Email));
                    paralist.Add(DbAcs.BuildDbParameter("@CONTINENTID", Vip.ContinentID));
                    paralist.Add(DbAcs.BuildDbParameter("@CITYID", Vip.CityID));
                    paralist.Add(DbAcs.BuildDbParameter("@AREAID", Vip.AreaID));
                    paralist.Add(DbAcs.BuildDbParameter("@ZIPCODE", Vip.ZipCode));
                    paralist.Add(DbAcs.BuildDbParameter("@ZIPCODETWO", Vip.ZipCodeTwo));
                    paralist.Add(DbAcs.BuildDbParameter("@ADDR", Vip.Addr));
                    paralist.Add(DbAcs.BuildDbParameter("@TEL", Vip.Tel));
                    paralist.Add(DbAcs.BuildDbParameter("@CELL", Vip.Cell));
                    paralist.Add(DbAcs.BuildDbParameter("@FAX", Vip.Fax));
                    paralist.Add(DbAcs.BuildDbParameter("@OCCU", Vip.Occu));
                    paralist.Add(DbAcs.BuildDbParameter("@EDU", Vip.Edu));
                    paralist.Add(DbAcs.BuildDbParameter("@MARRIAGE", Vip.Marriage));
                    paralist.Add(DbAcs.BuildDbParameter("@HOWKNOW", Vip.HowKnow));
                    paralist.Add(DbAcs.BuildDbParameter("@ISEPAPER", Vip.IsEPaper));
                    paralist.Add(DbAcs.BuildDbParameter("@CREUSER", "Web Site"));
                    paralist.Add(DbAcs.BuildDbParameter("@CREDATE", DateTime.Now.ToString()));
                    //paralist.Add(DbAcs.BuildDbParameter("@VIPCARDNUM", Vip.VipCardNum));
                    paralist.Add(DbAcs.BuildDbParameter("@UPSTS", Vip.Upsts));
                    paralist.Add(DbAcs.BuildDbParameter("@BGNDATE", Vip.BgnDate));
                    paralist.Add(DbAcs.BuildDbParameter("@ENDDATE", Vip.EndDate));
                    paralist.Add(DbAcs.BuildDbParameter("@VIPConfirm", Vip.VIPConfirm));
                    break;
                case "InsertByLine":
                    sb.Append(" Insert Into ugAcct(LOGINID,PSW,LINEID,ACCTNAME,EMAIL,UPSTS) ");
                    sb.Append("  Values ");
                    sb.Append(" (@LOGINID,@PSW,@LINEID,@ACCTNAME,@EMAIL,'Y' ");
                    paralist.Add(DbAcs.BuildDbParameter("@LOGINID", Vip.LoginID));
                    paralist.Add(DbAcs.BuildDbParameter("@PSW", Vip.Psw));
                    paralist.Add(DbAcs.BuildDbParameter("@LINEID", Vip.LineID));
                    paralist.Add(DbAcs.BuildDbParameter("@ACCTNAME", Vip.AcctName));
                    paralist.Add(DbAcs.BuildDbParameter("@EMAIL", Vip.Email));
                    break;
            }
            return DbAcs.CUD(sb.ToString(), paralist);
        }

        public int Update_ugAcct(string reqFType, AcctInfo Vip)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            switch (reqFType)
            {
                case "UpdateByWeb":
                    sb.Append("  Update ugAcct set ");
                    sb.Append("  ACCTCATID=@ACCTCATID ");
                    if (Vip.Psw != "")
                        sb.Append("  ,PSW=@PSW ");
                    sb.Append("  ,COMPANY=@COMPANY ");
                    sb.Append(" ,ACCTNAME=@ACCTNAME,SEX=@SEX,BIRTH=@BIRTH,CONTINENTID=@CONTINENTID ");
                    sb.Append(" ,CITYID=@CITYID,AREAID=@AREAID,ZIPCODE=@ZIPCODE,ZIPCODETWO=@ZIPCODETWO ");
                    sb.Append(" ,ADDR=@ADDR,TEL=@TEL,CELL=@CELL,FAX=@FAX,OCCU=@OCCU,EDU=@EDU ");
                    sb.Append(" ,MARRIAGE=@MARRIAGE,HOWKNOW=@HOWKNOW,ISEPAPER=@ISEPAPER,CREUSER=@CREUSER ");
                    sb.Append(" ,CREDATE=@CREDATE,VIPCARDNUM=null,UPSTS=@UPSTS ");
                    sb.Append(" ,BGNDATE=@BGNDATE,ENDDATE=@ENDDATE,VIPConfirm=@VIPConfirm  ");
                    sb.Append("  Where ACCTID=@ACCTID ");

                    paralist.Add(DbAcs.BuildDbParameter("@ACCTCATID", Vip.AcctCatID));
                    if (Vip.Psw != "")
                        paralist.Add(DbAcs.BuildDbParameter("@PSW", Vip.Psw));
                    paralist.Add(DbAcs.BuildDbParameter("@COMPANY", Vip.Company));
                    paralist.Add(DbAcs.BuildDbParameter("@ACCTNAME", Vip.AcctName));
                    paralist.Add(DbAcs.BuildDbParameter("@SEX", Vip.Sex));
                    paralist.Add(DbAcs.BuildDbParameter("@BIRTH", Vip.Birth));
                    paralist.Add(DbAcs.BuildDbParameter("@CONTINENTID", Vip.ContinentID));
                    paralist.Add(DbAcs.BuildDbParameter("@CITYID", Vip.CityID));
                    paralist.Add(DbAcs.BuildDbParameter("@AREAID", Vip.AreaID));
                    paralist.Add(DbAcs.BuildDbParameter("@ZIPCODE", Vip.ZipCode));
                    paralist.Add(DbAcs.BuildDbParameter("@ZIPCODETWO", Vip.ZipCodeTwo));
                    paralist.Add(DbAcs.BuildDbParameter("@ADDR", Vip.Addr));
                    paralist.Add(DbAcs.BuildDbParameter("@TEL", Vip.Tel));
                    paralist.Add(DbAcs.BuildDbParameter("@CELL", Vip.Cell));
                    paralist.Add(DbAcs.BuildDbParameter("@FAX", Vip.Fax));
                    paralist.Add(DbAcs.BuildDbParameter("@OCCU", Vip.Occu));
                    paralist.Add(DbAcs.BuildDbParameter("@EDU", Vip.Edu));
                    paralist.Add(DbAcs.BuildDbParameter("@MARRIAGE", Vip.Marriage));
                    paralist.Add(DbAcs.BuildDbParameter("@HOWKNOW", Vip.HowKnow));
                    paralist.Add(DbAcs.BuildDbParameter("@ISEPAPER", Vip.IsEPaper));
                    paralist.Add(DbAcs.BuildDbParameter("@CREUSER", "Web Site"));
                    paralist.Add(DbAcs.BuildDbParameter("@CREDATE", DateTime.Now.ToString()));
                    //paralist.Add(DbAcs.BuildDbParameter("@VIPCARDNUM", null));
                    paralist.Add(DbAcs.BuildDbParameter("@UPSTS", Vip.Upsts));
                    paralist.Add(DbAcs.BuildDbParameter("@BGNDATE", Vip.BgnDate));
                    paralist.Add(DbAcs.BuildDbParameter("@ENDDATE", Vip.EndDate));
                    paralist.Add(DbAcs.BuildDbParameter("@VIPConfirm", Vip.VIPConfirm));
                    paralist.Add(DbAcs.BuildDbParameter("@ACCTID", Vip.AcctID));
                    break;
                case "UpdateByLine":
                    sb.Append("  Update ugAcct set LINEID=@LINEID Where ACCTID=@ACCTID");
                    paralist.Add(DbAcs.BuildDbParameter("@LINEID", Vip.LineID));
                    paralist.Add(DbAcs.BuildDbParameter("@ACCTID", Vip.AcctID));
                    break;
            }

            return DbAcs.CUD(sb.ToString(), paralist);
        }

        public DataTable Get_AcctCat(string reqFType, string par1 = "", string par2 = "", string par3 = "", string par4 = "")
        {
            DataTable dt;
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            switch (reqFType)
            {
                case "getByAcctCatID":  //取得單一會員層級資料
                    sb.Append(" Select AcctCatID,CatCode,CatName,UpSts,DueDate,DueDateSts,DBSts,CreUser,CreDate from ugAcctCat ");
                    sb.Append(" Where AcctCatID = @AcctCatID ");
                    paralist.Add(DbAcs.BuildDbParameter("@AcctCatID", par1));
                    break;
                case "getByAcctCatIdRange": //取會員等級區間
                    sb.Append(" Select AcctCatID,CatCode,CatName,UpSts,DueDate,DueDateSts,DBSts from ugAcctCat ");
                    sb.Append(" Where AcctCatID Between 0 And @AcctCatID ");
                    paralist.Add(DbAcs.BuildDbParameter("@AcctCatID", par1));
                    break;
                case "getByCatCode_CatName_CheckAcctCat":   //判斷編號、會員等級是否存在(新增)
                    sb.Append(" Select CatCode,CatName from ugAcctCat ");
                    sb.Append(" Where (AcctCatID Between 0 And @AcctCatID) ");
                    sb.Append(" And (CatCode=@CatCode or CatName=@CatName)");
                    paralist.Add(DbAcs.BuildDbParameter("@AcctCatID", par1));
                    paralist.Add(DbAcs.BuildDbParameter("@CatCode", par2));
                    paralist.Add(DbAcs.BuildDbParameter("@CatName", par3));
                    break;
                case "getByHaveCatCode_CatName_CheckAcctCat":   //判斷編號、會員等級是否存在(修改，除了自己以外)
                    sb.Append(" Select CatCode,CatName from ugAcctCat ");
                    sb.Append(" Where (AcctCatID Between 0 And @AcctCatIDRang) ");
                    sb.Append(" And AcctCatID <> @AcctCatID ");
                    sb.Append(" And ((CatCode <> @CatCode And CatName = @CatName) ");
                    sb.Append(" or (CatCode = @CatCode And CatName <> @CatName) ");
                    sb.Append(" or (CatCode = @CatCode And CatName = @CatName)) ");
                    paralist.Add(DbAcs.BuildDbParameter("@AcctCatIDRang", par1));
                    paralist.Add(DbAcs.BuildDbParameter("@AcctCatID", par2));
                    paralist.Add(DbAcs.BuildDbParameter("@CatCode", par3));
                    paralist.Add(DbAcs.BuildDbParameter("@CatName", par4));
                    break;
            }

            if (paralist.Count > 0)
                dt = DbAcs.GetDBData(sb.ToString(), paralist);
            else
                dt = DbAcs.GetDBData(sb.ToString());
            return dt;
        }

        public int Insert_ugAcctCat(AcctCatInfo AcctCat)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            sb.Append(" Insert into ugAcctCat( ");
            sb.Append("  CatCode,CatName,UpSts,DueDateSts,CreUser,CreDate ");
            if (AcctCat.DueDate == "")
                sb.Append("  ) ");
            else
                sb.Append(" ,DueDate)");    //int Type 期限有值存值，無值預設值
            sb.Append(" Values ");
            sb.Append(" (@CatCode,@CatName,@UpSts,@DueDateSts,@CreUser,@CreDate ");
            if (AcctCat.DueDate == "")
                sb.Append(" ) ");
            else
                sb.Append(" ,@DueDate)");   //int Type 期限有值存值，無值預設值

            paralist.Add(DbAcs.BuildDbParameter("@CatCode", AcctCat.CatCode));
            paralist.Add(DbAcs.BuildDbParameter("@CatName", AcctCat.CatName));
            paralist.Add(DbAcs.BuildDbParameter("@UpSts", AcctCat.UpSts));
            paralist.Add(DbAcs.BuildDbParameter("@DueDateSts", AcctCat.DueDateSts));
            paralist.Add(DbAcs.BuildDbParameter("@CreUser", Utility.getSession("saLoginID")));
            paralist.Add(DbAcs.BuildDbParameter("@CreDate", DateTime.Now.ToString()));
            if (AcctCat.DueDate != "")
                paralist.Add(DbAcs.BuildDbParameter("@DueDate", int.Parse(AcctCat.DueDate)));   //int Type 期限有值存值，無值預設值

            return DbAcs.CUD(sb.ToString(), paralist);

        }

        public int Update_ugAcctCat(AcctCatInfo AcctCat)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            sb.Append(" Update ugAcctCat Set CatCode=@CatCode,CatName=@CatName ");
            sb.Append(",UpSts=@UpSts,DueDateSts=@DueDateSts,UpdUser=@UpdUser,UpdDate=@UpdDate ");
            if (AcctCat.DueDate != "") //未勾選一般日期會寫入空字串，導回取不到yyyy
                sb.Append(" ,DueDate=@DueDate ");
            sb.Append(" Where AcctCatID=@AcctCatID ");

            paralist.Add(DbAcs.BuildDbParameter("@CatCode", AcctCat.CatCode));
            paralist.Add(DbAcs.BuildDbParameter("@CatName", AcctCat.CatName));
            paralist.Add(DbAcs.BuildDbParameter("@UpSts", AcctCat.UpSts));
            paralist.Add(DbAcs.BuildDbParameter("@DueDateSts", AcctCat.DueDateSts));
            paralist.Add(DbAcs.BuildDbParameter("@UpdUser", Utility.getSession("saLoginID")));
            paralist.Add(DbAcs.BuildDbParameter("@UpdDate", DateTime.Now.ToString()));
            if (AcctCat.DueDate != "")
                paralist.Add(DbAcs.BuildDbParameter("@DueDate", int.Parse(AcctCat.DueDate)));
            paralist.Add(DbAcs.BuildDbParameter("@AcctCatID", AcctCat.AcctCatID));

            return DbAcs.CUD(sb.ToString(), paralist);
        }

        public int Delete_List(string reqFType, string[] parList)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();

            switch (reqFType)
            {
                case "ugAcct":
                    sb.Append(" Delete From ugAcct where AcctID in ");
                    break;
                case "ugAcctCat":
                    sb.Append(" Delete From ugAcctCat where AcctCatID in ");
                    break;
            }

            string Sql = sb.ToString();
            for (int i = 0; i < parList.Length; i++)
            {
                if (i == 0)
                    Sql += "(@parList_" + i;
                else
                    Sql += ",@parList_" + i;

                paralist.Add(DbAcs.BuildDbParameter("@parList_" + i, parList[i]));
            }
            Sql += ")";

            return DbAcs.CUD(Sql, paralist);
        }


        //public int Delete_ugAcctCat(string[] AcctCatID)
        //{
        //    StringBuilder sb = new StringBuilder();
        //    List<DbParameter> paralist = new List<DbParameter>();
        //    DBAccess DbAcs = new DBAccess();

        //    sb.Append(" Delete From ugAcctCat where AcctCatID in ");
        //    string Sql = sb.ToString();
        //    for (int i = 0; i < AcctCatID.Length; i++)
        //    {
        //        if (i == 0)
        //            Sql += "(@AcctCatID_" + i;
        //        else
        //            Sql += ",@AcctCatID_" + i;

        //        paralist.Add(DbAcs.BuildDbParameter("@AcctCatID_" + i, AcctCatID[i]));
        //    }
        //    Sql += ")";

        //    return DbAcs.CUD(Sql, paralist);
        //}


        public DataTable Get_MemberRegulation()
        {
            StringBuilder sb = new StringBuilder();
            DBAccess DbAcs = new DBAccess();

            sb.Append(" Select Top 1 Descr,DBSts from ugMemberRegulation ");
            DataTable dt = DbAcs.GetDBData(sb.ToString());

            return dt;
        }

        public int Update_DBSts(List<AcctDBSts> DBStsList)
        {
            StringBuilder sb = new StringBuilder();
            List<DbParameter> paralist = new List<DbParameter>();
            DBAccess DbAcs = new DBAccess();
            CmdParameter CPL = new CmdParameter();
            List<CmdParameter> CPList = new List<CmdParameter>();
            foreach (AcctDBSts DBS in DBStsList)
            {
                sb.Append(" Update ugAcct Set DBSts=@DBSts Where AcctID=@AcctID");

                paralist = new List<DbParameter>();
                paralist.Add(DbAcs.BuildDbParameter("@DBSts", DBS.DBSts));
                paralist.Add(DbAcs.BuildDbParameter("@AcctID", DBS.AcctID));

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