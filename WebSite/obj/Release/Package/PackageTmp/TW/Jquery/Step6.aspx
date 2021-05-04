<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step6.aspx.cs" Inherits="WebSite.Jquery.Step6" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <%--<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>

    <link href="../JS/jquery.ui/jquery-ui.css" rel="stylesheet" />
    <script src="../JS/jquery.ui/jquery-1.12.4.js"></script>
    <script src="../JS/jquery.ui/jquery-ui.min.js"></script>

    <script>

        function btn_Send_Next() {
            var form = $("#form5")[0];
            form.action = "Step6.aspx";
            form.submit();
        }

        function btn_Send_Previous() {
            var form = $("#form5")[0];
            form.action = "Step5.aspx";
            form.submit();

        }
    </script>
</head>

<body>
    <h2>步驟6.監督與檢討</h2>
    <form id="form5" action="Step3.aspx" method="post">
<%--        <div>
            <label for="work">工作項目顯示: </label>
            <input id="work" name="work" />
        </div>
        <br />
        <div id="div_PHA">
            <label for="Hazard">危險項目顯示: </label>
            <input id="Hazard" name="Hazard" onchange="HazardEven(this.value)" />
            <input type="button" onclick="btn_Send()" value="送出" />
        </div>--%>

        <br />
        <label style="font-weight: bold">監督與檢討</label>
        <asp:DataGrid ID="ThisDataGrid" runat="server">
        </asp:DataGrid>

        <br />

        <div id="div_WIT">
            <label>執行日期</label>
            <input type="text" id="inp_cal" placeholder="輸入日期" />
        </div>

        <br />
        <input type="button" onclick="btn_Send_Previous()" value="上一步" />
        <input type="button" onclick="btn_Send_Next()" value="下一步" />
    </form>
</body>
</html>
