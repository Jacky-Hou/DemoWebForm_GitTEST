<%@ Page Language="C#" MasterPageFile="~/TW/Admin/Inc/Basic_Index.Master" AutoEventWireup="true" CodeBehind="ugA_Menu.aspx.cs" Inherits="WebSite.TW.Admin.ugA_Menu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
        <script type="text/javascript">
        function initialize() {
            document.title = "<%=TitleStr%>" + " - 後台管理系統";

            if (<%=Expired%> == true) $("#Panel_Msg").show();   //後台Expired設為字串

            if (<%=Rent%> == true) $("#p_SysMsg").show();

            $("#Panel_BackGround").css("background","url(Images/Setting/background/<%=BackImage%>) top center no-repeat");

            //條件判斷顯示空間容量狀態
            if (<%=Qs[0]%> == 0) {
                $("#lab_SysMsg_1").show();
            } else {
                $("#lab_SysMsg_2").show();
                if (<%=Qs[1]%> < 95)
                    $("#lab_SysMsg_3").hide();
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div id="Panel_BackGround" class="BodyWrapper"></div>
        <div class="Wrapper">
            <!--1.Header START-->
            <header class="Header">
                <ul class="Nav">
                    <li class="nav01"><a href="http://www.ugear.com.tw/" target="_blank">優吉兒網站設計</a></li>
                    <li class="nav02"><a href="http://rwd365.ugear.tw/TW/Inquiry_RWD_01/ugC_Inquiry.asp" target="_blank">問題反應</a></li>
                    <li class="nav03"><a href="../index.html" target="_blank">前台首頁</a></li>
                    <li class="nav04"><a href="ugA_Logout.aspx">系統登出</a></li>
                </ul>

                <p id="p_SysMsg" style="display:none" >
                    <span id="lab_SysMsg_1" class="systemDate" style="display: none">無空間容量限制</span>
                    <span id="lab_SysMsg_2" class="systemDate" style="display: none">空間容量：<%=QuRent%> (已使用 <%=QuUse%> % 的儲存空間，尚剩餘 <%=QuCanUse%>)<br />
                                                                                        例行維修時間：每週一AM0:00~6:00，本系統使用期限至 <%=EndDate%></span>
                    <span id="lab_SysMsg_3" class="systemDate" style="display: none">儲存空間即將超過容量大小限制，屆時將無法上傳檔案，請刪除部份檔案或與uGear優吉兒聯絡以增加容量！</span>
                </p>
            </header>
            <!--1.Header END-->

            <!--2.Pagetop START-->
            <div id="Panel_Msg" class="Pagetop" style="display:none">
                <p>
                    <span class="Pagetop01">※ 本系統使用期限即將到期，</span><span class="Pagetop02">屆時光纖頻寬將無法提供連線登入服務！</span><br />
                    <span class="Pagetop03">※ 請密切注意系統繳費通知信件，</span><span class="Pagetop04">或與 <a href="http://www.ugear.tw/" target="_blank">uGear 優吉兒</a> <a href="http://rwd365.ugear.tw/" target="_blank">網頁設計</a> 聯絡！</span>
                </p>
            </div>
            <!--2.Pagetop END-->

            <!--3.PageContent START-->
            <asp:Panel ID="Panel_Page" runat="server" CssClass="PageContent"></asp:Panel>
            <!--3.PageContent END-->

            <!--4.Footer START-->
            <!-- #Include File="ugA_CopyRight.htm" -->
            <!--4.Footer END-->
        </div>
</asp:Content>
