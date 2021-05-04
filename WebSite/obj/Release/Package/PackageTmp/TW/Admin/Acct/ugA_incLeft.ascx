<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ugA_incLeft.ascx.cs" Inherits="WebSite.TW.Admin.ugA_incLeft" %>

<script type="text/javascript">
    $(function () {
        $("#Panel_left").css("background", "url(../Images/Setting/background/<%=BackImage%>) top center no-repeat");
        $("#Img1").attr("src", "../Images/Setting/icon/<%=MenuData[0]%>");
        $("#Span1").text("<%=MenuData[1]%>");

        if (<%=AcctCatIDRang%> <= 0)
            $(".MenuItem ul li:eq(0)").hide();

    })
</script>

<%--<asp:Panel ID="Panel1" runat="server" CssClass="left">--%>
<div id="Panel_left" class="left">
    <!--1.leftTop START-->
    <div class="leftTop">
        <a href="../ugA_Menu.aspx">
            <img src="../Images/UI/Home_icon.png" class="Home_icon" />單　元　總　覽</a>
    </div>
    <!--1.leftTop END-->

    <!--2.MenuTitle START-->
    <div class="MenuTitle">
        <a href="#">
            <img id="Img1"><br />
            <span id="Span1"></span>
        </a>
    </div>
    <!--2.MenuTitle END-->

    <!--3.MenuItem START-->
    <div class="MenuItem">
        <ul>
            <li><a href="ugA_AcctCat.aspx">
                <img src="../Images/UI/MenuItem_icon59.png">會員等級</a> </li>
            <li><a href="ugA_Acct.aspx">
                <img src="../Images/UI/MenuItem_icon60.png">會員資料</a> </li>
            <li><a href="../../Member/ugC_Member_Login.aspx" target="_blank">
                <img src="../Images/UI/MenuItem_icon01.png">前台會員專區</a></li>
        </ul>
    </div>
    <!--3.MenuItem END-->
    <!--4.leftBottom START-->
    <div class="leftBottom">
        <a href="../ugA_Logout.aspx">
            <img src="../Images/UI/Logoff_icon.png" class="Logoff_icon" />系　統　登　出</a>
    </div>
    <!--4.leftBottom END-->
    <%--</asp:Panel>--%>
</div>
