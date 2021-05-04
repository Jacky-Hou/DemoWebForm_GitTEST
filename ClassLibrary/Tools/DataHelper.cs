using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class DataHelper
    {
        //資料轉換
        public string ShowText(string mData, string mType)
        {
            string strResult = mData;
            switch (mType)
            {
                case "IsePaPer":
                    if (mData == "Y") strResult = "是";
                    else if(mData == "N") strResult = "否";
                    break;
                case "Sex":
                    if (mData == "M") strResult = "男";
                    else if (mData == "F") strResult = "女";
                    break;
                case "VIPConfirm":
                    if (mData == "Y") strResult = "已確認";
                    else if (mData == "N") strResult = "待確認";
                    break;
                //case "4":
                //    if (mData == "1") strResult = "先生";
                //    else if (mData == "2") strResult = "小姐";
                //    break;
                case "Marriage":
                    if (mData == "Y") strResult = "已婚";
                    else if (mData == "N") strResult = "未婚";
                    break;
                case "DBSts":
                case "AgoDBSts":
                    if (mData == "A") strResult = "啟動";
                    else if (mData == "D") strResult = "終止";
                    break;
                //case "7":
                //    if (mData == "1") strResult = "二聯式";
                //    else if (mData == "2") strResult = "三聯式";
                //    else if (mData == "3") strResult = "載具號碼";
                //    else if (mData == "4") strResult = "捐慈善機構";
                //    break;
                //case "8":
                //    if (mData == "CIP") strResult = "統一編號";
                //    else if (mData == "OID" || mData == "SID") strResult = "護照號碼";
                //    else strResult = "身分證字號";
                //    break;
                //case "9":
                //    if (mData == "A") strResult = "訂閱";
                //    else if (mData == "D") strResult = "取消訂閱";
                //    break;
                //case "WorkSts":
                //    if (mData == "Y") strResult = "運行中";
                //    else if (mData == "N") strResult = "維修中";
                //    break;
                //case "ActionSts":
                //    switch (mData)
                //    {
                //        case "R":
                //            strResult = "讀取";
                //            break;
                //        case "I":
                //            strResult = "新增";
                //            break;
                //        case "U":
                //            strResult = "更新";
                //            break;
                //        case "D":
                //            strResult = "刪除";
                //            break;
                //    }
                //    break;
            }
            return strResult;
        }

        //列表顯示是否到期
        public string GetUpStsText(string mUpSts, string mBgnDate, string mEndDate, bool mHtmlType = true, int mDueDays = -15)
        {
            DateTimeHelper dateTimeHelper = new DateTimeHelper();
            string strResult = "";
            if (mUpSts == "Y")
            {
                if (mHtmlType)
                    strResult = "<span class=\"css_GreenTxt\">無限期</span>";
                else
                    strResult = "無限期";
            }
            else if (dateTimeHelper.IsDate(mBgnDate) && dateTimeHelper.IsDate(mEndDate))
            {
                DateTime SDate = Convert.ToDateTime(mBgnDate);
                DateTime EDate = Convert.ToDateTime(mEndDate);
                if (DateTime.Now > EDate)
                {
                    if (mHtmlType)
                        strResult = "<span class=\"css_GrayTxt\">" + mEndDate + "<br><span style=\"font-size:7pt\">(已到期)</span></span>";
                    else
                        strResult = mEndDate + "(已到期)";
                }

                else if (DateTime.Now > EDate.AddDays(mDueDays))
                {
                    if (mHtmlType)
                        strResult = "<span class=\"css_RedTxt\">" + mEndDate + "</span>";
                    else
                        strResult = mEndDate;
                }
                else
                {
                    strResult = mEndDate;
                }
            }
            return strResult;
        }

        //顯示會員讀取限制資訊(是否限制:Y or N)
        public string GetMemStsText(string mMemSts)
        {
            if (mMemSts == "Y")
                return "<span class='css_RedTxt'>僅會員</span>";
            else
                return "<span class='css_GreenTxt'>無限制</span>";
        }
    }
}
