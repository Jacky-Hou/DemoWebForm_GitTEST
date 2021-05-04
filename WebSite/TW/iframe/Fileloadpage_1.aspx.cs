using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
namespace WebSite.iframe
{
    public partial class Fileloadpage_1 : PublicClass
    {

        //private string SaveOldPhoto = "../Photo/OldPhoto2/";
        private string SaveNewPhoto = "../Photo/OldPhoto/";
        private string sType = "", sNo = "", sFile = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            sType = GetQueryStringInString("Type");
            sFile = GetQueryStringInString("File");
            sNo = GetQueryStringInString("No");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //上傳檔案........
            //string SaveOldPath = Page.MapPath(SaveOldPhoto);
            //CheckFileExist(SaveOldPath);
            SaveNewPhoto = sFile == "" ? SaveNewPhoto : SaveNewPhoto.Replace("OldPhoto", sFile);
            SaveNewPhoto = sType == "F" ? SaveNewPhoto.Replace("Photo/", "Files/") : SaveNewPhoto;
            CheckFileExist(Page.MapPath(SaveNewPhoto));

            if (FileUpload1.HasFile)
            {
                bool CheckFlag = false;
                string fileExtension = System.IO.Path.GetExtension(FileUpload1.FileName).ToLower();
                string[] allowedExtensions = null;
                if (sType == "P")
                    allowedExtensions = new string[] { ".gif", ".png", ".jpeg", ".jpg" };
                else if (sType == "M")
                    allowedExtensions = new string[] { ".mp4", ".mp3", ".wma" };
                if (allowedExtensions != null)
                {
                    for (int i = 0; i < allowedExtensions.Length; i++)
                    {
                        if (fileExtension == allowedExtensions[i])
                        {
                            CheckFlag = true;
                            break;
                        }
                    }
                }
                else
                    CheckFlag = true;

                if (CheckFlag)//這是正確檔案
                {
                    string sFileName = UpLoadFile(FileUpload1, Page.MapPath(SaveNewPhoto), "");
                    if (sFileName != "Error")
                    {
                        if(sType=="P")
                            Response.Write("<script>window.parent.PhotoCallBack('" + sFileName + "','" + sFile + "','" + sNo + "');</script>");
                        else
                            Response.Write("<script>window.parent.FileCallBack('" + sFileName + "','" + sFile + "','" + sNo + "');</script>");
                    }
                    else
                        Response.Write("<script>window.parent.PhotoCallBack('','','" + sNo + "');</script>");
                }
                else
                    Response.Write("<script>window.parent.FileCallBack('','','" + sNo + "');</script>");
            }
            else
                Response.Write("<script>window.parent.PhotoCallBack('','','" + sNo + "');</script>");
        }
    }
}