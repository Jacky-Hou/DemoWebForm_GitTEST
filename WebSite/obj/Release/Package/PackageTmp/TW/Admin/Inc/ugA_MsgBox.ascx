<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ugA_MsgBox.ascx.cs" Inherits="WebSite.TW.Admin.ugA_MsgBox" %>
<!--右方框架 -  上方編輯資訊(含空間使用資訊)-->

<script type="text/javascript">
    $(function () {
        if (<%=Rent%> = true) {
            $("#img_RentSts").show();
        }
        if (<%=Qs[0]%> == 0) {
            $("#lab_SysMsg_1").show();
        } else {
            $("#lab_SysMsg_2").show();
        }

        $("#span_Status").text("<%=Status%>");
        $("#span_User").text("<%=User%>");
        $("#span_Location").text("<%=Location%>");
    })
</script>

<a name></a>
<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr>
        <td align="right"></td>
    </tr>
</table>
<div class="ss_msgbox_msg_Wrapper">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bordercolor="#FFFFFF">
        <tr>
            <td width="100%" align="center" class="ss_msgbox_msg" id="txtErrMsg">
                <span id="lab_Msg"></span>
            </td>
        </tr>
    </table>
</div>
<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr>
        <td align="left" class="ss_msgbox_status">
            <img id="img_RentSts" src="../Images/Icon_Dot.gif" />
            <span id="lab_SysMsg_1" style="display: none">無空間容量限制</span>
            <span id="lab_SysMsg_2" style="display: none" class="systemDate">空間容量：<%=QuRent%> (已使用 <%=QuUse%> % 的儲存空間，尚剩餘 <%=QuCanUse%>)</span>
            <br />
            <img src="../Images/Icon_Dot.gif"> 狀態：<span id="span_Status"></span>
            <img src="../Images/Icon_Dot.gif"> 使用者：<span id="span_User" ></span>
            <img src="../Images/Icon_Dot.gif"> 目前位置：<span id="span_Location"></span>
        </td>
    </tr>
</table>
