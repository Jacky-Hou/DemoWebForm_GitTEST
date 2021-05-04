<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoogleCalender.aspx.cs" Inherits="WebTest.GoogleCalender" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="btn_Subscribe" runat="server" OnClick="btn_Subscribe_Click" Text="訂閱日曆 Share0227" />
            <p id="p_State" runat="server"></p>
            <asp:Button ID="btn_Who_Subscribe" runat="server" OnClick="btn_Who_Subscribe_Click" Text="查看訂閱 Share0227" />
            <asp:Panel ID="div_Who_Subscribe" runat="server"></asp:Panel>
            <p id="p_Count" runat="server"></p>
            <asp:Button ID="btn_Create_Reference_Token" runat="server" OnClick="btn_Create_Reference_Token_Click" Text="產生主分享帳號 ReferenceToken" />
            <p id="p_reference_token" runat="server">ReferenceToken_(產生AccessToken令牌) : </p>
        </div>
    </form>
</body>
</html>
