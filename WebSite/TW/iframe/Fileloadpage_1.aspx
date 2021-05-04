<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fileloadpage_1.aspx.cs" Inherits="WebSite.iframe.Fileloadpage_1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style>
        /* ======== 功能選單按鈕 Start ======== */
        input[type="submit"] {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            width: 76px;
            background-image: url('/TW/Admin/Images/Bg_FnBu.gif');
            background-repeat: no-repeat;
            background-position: 50% bottom;
            color: #ffffff;
            text-align: center;
            letter-spacing: 2px;
            vertical-align: bottom;
            padding-bottom: 2px;
            *padding-bottom: 0px;
            margin: 0 5px;
            height: 21px;
            /*font-size:10pt;*/
        }

            input[type="submit"]:hover,{
                width: 76px;
                height: 21px;
                background-image: url('/TW/Admin/Images/Bg_FnBu_o.gif');
                background-repeat: no-repeat;
                background-position: bottom;
                color: #ffffff;
                text-align: center;
                letter-spacing: 2px;
                vertical-align: bottom;
                padding-bottom: 2px;
                *padding-bottom: 0px;
                /*font-size:10pt;*/
            }
        /* ======== 功能選單按鈕 End ======== */
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div style="width: 290px; height: 22px">
                <asp:FileUpload ID="FileUpload1" runat="server" Width="200px" />
                <asp:Button ID="Button1" runat="server" Text="送出" OnClick="Button1_Click" />
            </div>
        </div>
    </form>
</body>
</html>
