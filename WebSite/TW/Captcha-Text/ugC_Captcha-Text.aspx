<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ugC_Captcha-Text.aspx.cs" Inherits="WebSite.TW.Captcha_Text.ugC_Captcha_text" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            驗證碼：<%=CaptchaCode%>
            <br>
            請輸入在原視窗"驗證碼"輸入框
        </div>
    </form>
</body>
</html>
