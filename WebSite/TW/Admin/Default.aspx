<%@ Page Language="C#" MasterPageFile="~/TW/Admin/Inc/Basic_Index.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebSite.TW.Admin.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <script type="text/javascript">
        function initialize() {
            $("#Panel_BackGround").css("background","url(Images/Setting/background/<%=BackImage%>) top center no-repeat");

            if (<%=Expired%> == true) $("#Panel_Msg").show();

            var LoginData = {};
            $("#ibut_Login").on('click', function (e) {
                e.preventDefault(); //disable isPostback or Submit
                LoginData.txtID = $("#txtLoginAdminID").val();
                LoginData.txtPw = $("#txtAdminPW").val();
                LoginData.txtCC = $("#txtCheckcode").val();

                var LoginKeyWord = LoginEnterCh(LoginData);
                if (LoginKeyWord == "") {
                    $.ajax({
                        type: "POST",
                        url: "Default.aspx/AdminLogin",
                        data: JSON.stringify(LoginData), //後台方法直接給帶入參數
                        dataType: "Json",
                        contentType: 'application/json; charset=utf-8'
                    }).done(function (res) {
                        var jdata = $.parseJSON(res.d)
                        if (jdata.strSuccess == "Y")  //登入成功
                            window.location.href = jdata.Redirect;
                        else if (jdata.strSuccess == "N") {   //登入失敗
                            alert(jdata.strAlertMsg);
                            if (jdata.Redirect != "" && jdata.Redirect != null) //條件判斷跳轉
                                window.location.href = jdata.Redirect
                            else
                                ReloadValidateCode('imgCaptcha');
                        }
                    })
                } else
                    alert(LoginKeyWord);
            })
        }

        //Login輸入確認
        function LoginEnterCh(LgData) {
            var LgStr = "";
            if (LgData.txtID == "" || LgData.txtID.replace(" ", "") == "")
                LgStr = " 帳號  必須輸入資料!! \r\n"
            if (LgData.txtPw == "" || LgData.txtPw.replace(" ", "") == "")
                LgStr = LgStr + " 密碼  必須輸入資料!! \r\n"
            if (LgData.txtCC == "" || LgData.txtCC.replace(" ", "") == "")
                LgStr = LgStr + " 驗證碼  必須輸入資料!! \r\n"
            return LgStr;
        }

        function ReloadValidateCode(id) {
            var src = $("#" + id).attr('src');

            var url = src + "?DataTime=" + Date.now();     //防暫存
            $.ajax({
                type: "GET",
                url: url //叫用重新產生
            }).done(function () {
                $("#" + id).attr("src", url);
            })
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="Panel_BackGround" class="BodyWrapper"></div>
    <!--Wrapper 包覆START-->
    <div class="Wrapper loginWrapper">
        <!--1.LoginContent START-->
        <div class="LoginContent">
            <div class="login_logo">
                <img src="Images/Setting/icon/login_logo.png" />
            </div>
            <div class="login_text">
                <p style="margin-bottom: 0.2em; margin-top: 0.5em;">
                    本系統使用期限至 <%=EndDate%>
                    <asp:Label ID="lab_EndDate" runat="server" Text=""></asp:Label>
                </p>
                <p style="margin: 0; padding: 0;">例行維修時間：每週一AM0:00~6:00</p>
                <!--20160202新增紀錄上頁的路徑，用在直接導向後台頁面-->
                <p class="account" style="margin-top: 0.5em;">
                    <input id="txtLoginAdminID" type="text" size="14" />
                </p>
                <p class="password">
                    <input id="txtAdminPW" type="password" autocomplete="off" size="14" />
                </p>
                <p class="Captcha">
                    <input id="txtCheckcode" type="text" size="5" maxlength="6" placeholder="驗證碼" autocomplete="off" />
                    <img id="imgCaptcha" src="../iframe/ValidateCode.aspx" />
                </p>
                <p class="renew">
                    <a id="lbut_Captchacode" href="javascript:void(0)" onclick="ReloadValidateCode('imgCaptcha')" class="FontColor">更新辨識碼</a>
                </p>
                <input id="ibut_Login" type="image" src="Images/Setting/icon/login_bu.png" />
            </div>
        </div>
        <!--1.LoginContent END-->
        <!--2.LoginBottom START-->
        <div id="Panel_Msg" class="LoginBottom" style="display:none">
            <p>
                <span class="LoginBottom01">※ 本系統使用期限即將到期，</span><span class="LoginBottom02">屆時光纖頻寬將無法提供連線登入服務！</span><br />
                <span class="LoginBottom03">※ 請密切注意系統繳費通知信件，</span><span class="LoginBottom04">或與 <a href="http://www.ugear.tw/" target="_blank">uGear 優吉兒</a> <a href="http://bmws010.ugear.tw/" target="_blank">網頁設計</a> 聯絡！</span>
            </p>
        </div>
        <!--2.LoginBottom END-->

        <!--3.Footer START-->
        <!-- #Include File="ugA_CopyRight.htm" -->
        <!--3.Footer END-->
    </div>
    <!--Wrapper 包覆END-->
</asp:Content>

