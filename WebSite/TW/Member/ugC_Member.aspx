<%@ Page Language="C#" MasterPageFile="~/TW/Inc/Basic.Master" AutoEventWireup="true" CodeBehind="ugC_Member.aspx.cs" Inherits="WebSite.TW.Member.ugC_Member" %>

<%@ Register Src="~/TW/Member/ugC_incPageMenuTop.ascx" TagPrefix="uc1" TagName="ugC_incPageMenuTop" %>
<%@ Register Src="~/TW/Inc/ug_AcctOccu.ascx" TagPrefix="uc1" TagName="ug_AcctOccu" %>
<%@ Register Src="~/TW/Inc/ug_AcctEdu.ascx" TagPrefix="uc1" TagName="ug_AcctEdu" %>
<%@ Register Src="~/TW/Inc/ug_AcctHowKnow.ascx" TagPrefix="uc1" TagName="ug_AcctHowKnow" %>
<%@ Register Src="~/TW/Inc/ug_ContinentCityArea.ascx" TagPrefix="uc1" TagName="ug_ContinentCityArea" %>

<%--<%@ Register Src="~/TW/ugC_incTop.ascx" TagPrefix="uc1" TagName="ugC_incTop" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src='<%=ResolveUrl("../JS/ChkField.js")%>'></script>
    <script>
        var City;
        var Area;
        var VipCardNum = null;
        var Upsts = "Y";
        var VipAdd = {};
        var AcctCatID = 1;
        var CSRF = "";

        function initialize() {

            $("body").removeClass("Default");
            $("body").addClass("Member");

            CSRF = $("#CSRFtoken").val();
            SetAddrSelOpt();                     //地址 ug_ContinentCityArea.ascx
            SetAcctOccuSelOpt();                 //職業 ug_AcctOccu.ascx
            SetAcctEduSelOpt();                  //學歷 ug_AcctEdu.ascx
            SetAcctHowKnowSelOpt();              //如何得知 ug_AcctHowKnow.ascx

            //Top選單目前位置
            $("#SlideMenu a").removeClass('Active');
            $("#TopVipAdd").addClass('Active');
        }

        function SendData() {

            var Msg = "";
            Msg = Regex(Msg);
            if (Msg != "") {
                Msg = Msg.replace(/\<br>/g, "\r\n");
                alert(Msg);
                return;
            }

            if (!$("#ReguCheckbox").prop("checked")) {
                Msg += "您必須檢閱並同意約定條款，才能進行會員申請作業，感謝您的配合!!";
                alert(Msg);
                return;
            }

            VipAdd.AcctCatID = AcctCatID;
            VipAdd.LoginID = $("#txtLoginID").val();
            VipAdd.Psw = $("#txtPsw").val();
            VipAdd.Company = $("#txtCompany").val();
            VipAdd.AcctName = $("#txtAcctName").val();
            VipAdd.Sex = $("input[name='radSex']:checked").val();
            VipAdd.Birth = $("#txtBirth").val();
            VipAdd.Email = $("#txtLoginID").val();
            VipAdd.ContinentID = $("#selContinentID").val();
            VipAdd.CityID = $("#selCityID").val();
            VipAdd.AreaID = $("#selAreaID").val();
            VipAdd.ZipCode = $("#txtZipCodeID").val();
            VipAdd.ZipCodeTwo = $("#txtZipCodeTwo").val();
            VipAdd.Addr = $("#txtAddr").val();
            VipAdd.Tel = $("#txtTel").val();
            VipAdd.Cell = $("#txtCell").val();
            VipAdd.Fax = $("#txtFax").val();
            VipAdd.Occu = $("#selOccu").val();
            VipAdd.Edu = $("#selEdu").val();
            VipAdd.Marriage = $("input[name='radMarriage']:checked").val();
            VipAdd.HowKnow = $("#selHowKnow").val();
            VipAdd.IsEPaper = $("input[name='radIsEPaper']:checked").val();
            VipAdd.VipCardNum = VipCardNum;
            VipAdd.Upsts = Upsts;
            VipAdd.FrontCaptchaCode = $("#txtCaptchacode").val();   //驗證碼
            VipAdd.CSRFtoken = CSRF;

            $.ajax({
                type: "POST",
                url: "ugC_Member.aspx/AddVipAccount",
                data: JSON.stringify({ "Vip": VipAdd }),
                contentType: "application/Json;charset=utf-8"
            }).done(function (res) {
                var jdata = $.parseJSON(res.d)
                if (jdata.strAlertMsg != "") {
                    alert(jdata.strAlertMsg)
                    $("#txtCaptchacode").val("");
                    $("#txtPsw").val("");
                    $("#txtPswCheck").val("");
                    ReloadCaptcha('imgCaptcha');
                } else
                    window.location.href = "ugC_Member_Final.aspx";
            })

        }

        function chkLogin() {
            var txtLoginID = $("#txtLoginID").val();

            $.ajax({
                type: "POST",
                url: "ugC_Member.aspx/CheckLoginID",
                data: JSON.stringify({ "LoginID": txtLoginID, "CSRFtoken": CSRF }),
                contentType: "application/Json;charset=utf-8"
            }).done(function (res) {
                if (res.d == 2)
                    $("#spanLoginID").text(" inValid Access ");
                else if (res.d == 0)
                    $("#spanLoginID").text("（請輸入E-Mail帳號)");
                else if (res.d == 1)
                    $("#spanLoginID").text("此電子郵件已有人使用!! (請重新輸入)");
            })
        }

        function Regex(Msg) {

            //ChkEmpty檢查有無輸入及格式
            //Msg += ChkEmpty('txtLoginID', '電子郵件', "ChkBlock(\'email\',\'txtLoginID\',\'電子郵件\');", ''); //透過eval執行字串ChkBlock Function
            if ($("#txtLoginID").val() == "")
                Msg+= "電子郵件　必須輸入資料!! \r\n";
            else
                Msg += ChkBlock('email', 'txtLoginID', '電子郵件');

            //有無輸入及格式分開
            if ($("#txtPsw").val() == "")
                Msg += "密碼　必須輸入資料!! \r\n";
            else {
                if ($("#txtPsw").val().length < 6)
                    Msg += "密碼 格式錯誤!! \r\n"
                else
                    Msg += ChkBlock("Aanum", "txtPsw", "密碼");
                if ($("#txtPsw").val() != $("#txtPswCheck").val())
                    Msg += "密碼與密碼確認　必須相同!! \r\n";
            }

            if ($("#txtAcctName").val() == "")
                Msg += "姓名　必須輸入資料!! \r\n";

            if ($("#txtBirth").val() == "")
                Msg += "出生日期　必須輸入資料!! \r\n";
            else
                Msg += ChkDate($("#txtBirth").val(), "出生日期");

            Msg += ChkEmptyAddr("2", "聯絡");		//地址的判斷

            if ($("#txtTel").val() == "" && $("#txtCell").val() == "")
                Msg += '聯絡電話、手機請至少輸入一個!! \r\n';
            else {
                if ($("#txtTel").val() != "")
                    Msg += ChkBlock('tel', "txtTel", '聯絡電話');
                if ($("#txtCell").val() != "")
                    Msg += ChkBlock('ctel', "txtCell", '手機');
            }

            if ($("#txtFax").val() != "")
                Msg += ChkBlock('tel', "txtFax", '傳真');

            if ($("#txtCaptchacode").val() == "")
                Msg += "驗證碼 必須輸入資料!! \r\n"

            return Msg;
        }

        function ReloadCaptcha(id) {
            var src = $("#" + id).attr('src');
            var url = src + "?DataTime=" + Date.now();
            $.ajax({
                type: "GET",
                url: url
            }).done(function () {
                $("#" + id).attr("src", url)
            })
        }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--    <div class="Wrapper">
        <header class="Header">
            <uc1:ugC_incTop runat="server" ID="ugC_incTop" />
        </header>--%>

    <!--內頁版頭開始-->
    <div class="PageTitleWrapper">
        <header class="PageTitle">
            <p class="BreadCrumbs"><a href="/tw/home/" title="回首頁">首頁</a> &gt; <a href="/tw/member" title="<%=FrontMenuName%>"><%=FrontMenuName%></a> &gt; <%=CurrentPageName%></p>
            <h1><%=CurrentPageName%></h1>
        </header>
    </div>
    <!--內頁版頭結束-->
    <!--內頁內容開始-->
    <section class="PageMenuTop">
        <!--響應式次選單-->
        <uc1:ugC_incPageMenuTop runat="server" ID="ugC_incPageMenuTop" />
    </section>
    <section class="PageContent">
        <article class="PageArticle">
            <div id="tbContent">
                <div class="ProcessFlow">
                    <div class="Step_o"><span class="No">1</span><span class="Name">填寫基本資料</span></div>
                    <div class="Step"><span class="No">2</span><span class="Name">完成註冊</span></div>
                </div>

                <div class="memberform">
                    <ul>

                        <li>
                            <div>
                                <label for="txtLoginID"><span class="notice">*&nbsp;</span>電子郵件</label>
                            </div>
                            <div class="form-box">
                                <input type="text" name="txtLoginID" id="txtLoginID" value="" maxlength="255" class="length-xl" onblur="chkLogin();" onkeypress="return KeyPressBlock(event,'email');">
                                <span id="spanLoginID" class="notice">（請輸入E-Mail帳號）</span>
                            </div>
                        </li>

                        <li>
                            <div>
                                <label for="txtPsw"><span class="notice">*&nbsp;</span>密碼</label>
                            </div>
                            <div class="form-box">
                                <input type="password" name="txtPsw" id="txtPsw" value="" maxlength="16" class="length-xl" placeholder="" onkeypress="return KeyPressBlock(event,'Aanum');">
                                <span class="notice">（請輸入6~16個英文或數字組合的密碼）</span>
                            </div>
                        </li>
                        <li>
                            <div>
                                <label for="txtPswCheck"><span class="notice">*&nbsp;</span>密碼確認</label>
                            </div>
                            <div class="form-box">
                                <input type="password" name="txtPswCheck" id="txtPswCheck" value="" maxlength="16" class="length-xl" placeholder="" onkeypress="return KeyPressBlock(event,'Aanum');">
                            </div>
                        </li>
                        <li>
                            <div>
                                <label for="txtCompany"><span class="notice">&nbsp;&nbsp;&nbsp;</span>公司名稱</label>
                            </div>
                            <div class="form-box">
                                <input type="text" name="txtCompany" id="txtCompany" value="" maxlength="128" class="length-xxl">
                            </div>
                        </li>
                        <li>
                            <div>
                                <label for="txtAcctName"><span class="notice">*&nbsp;</span>姓名</label>
                            </div>
                            <div class="form-box">
                                <input type="text" name="txtAcctName" id="txtAcctName" value="" maxlength="32" class="length-s">
                            </div>
                        </li>
                        <li>
                            <div>
                                <label><span class="notice">*&nbsp;</span>性別</label>
                            </div>
                            <div class="form-box">
                                <input type="radio" name="radSex" id="radSex1" value="M" checked="checked">
                                <label for="radSex1">男</label>
                                <input type="radio" name="radSex" id="radSex2" value="F">
                                <label for="radSex2">女</label>
                            </div>
                        </li>
                        <li>
                            <div>
                                <label for="txtBirth"><span class="notice">*&nbsp;</span>出生日期</label>
                            </div>
                            <div class="form-box">
                                <input type="text" name="txtBirth" id="txtBirth" value="" maxlength="10" class="length-s" onkeypress="return KeyPressBlock(event,'date');">
                                <span class="notice">（西元年/月/日；EX：1980/01/01）</span>
                            </div>
                        </li>
                        <li>
                            <div>
                                <label for="txtAddr"><span class="notice">*&nbsp;</span>聯絡地址</label>
                            </div>
                            <div class="form-box">
                                <uc1:ug_ContinentCityArea runat="server" FirstIndex="請選擇地區,請選擇城市,請選擇區域" ID="ug_ContinentCityArea" />
                                <%--地址--%>
                                <span>(</span>
                                <span>
                                    <label for="txtZipCodeID" style="display: none;">郵遞區號前三碼</label>
                                    <input type="text" name="txtZipCode" id="txtZipCodeID" value="" maxlength="3" class="length-xxs" onkeypress="return KeyPressBlock(event,'num');">
                                </span>
                                <span>+</span>
                                <span>
                                    <label for="txtZipCodeID" style="display: none;">郵遞區號後二碼</label>
                                    <input type="text" name="txtZipCodeTwo" id="txtZipCodeTwo" value="" maxlength="2" class="length-xxxs" onkeypress="return KeyPressBlock(event,'num');">
                                </span>
                                <span>)</span><span>-</span>
                                <span>
                                    <input type="text" name="txtAddr" id="txtAddr" value="" maxlength="128" class="length-s"></span>
                                <span class="notice">（3+2郵遞區號-地址）</span>
                            </div>
                        </li>

                        <li>
                            <div>
                                <label for="txtTel"><span class="notice">*&nbsp;</span>聯絡電話</label>
                            </div>
                            <div class="form-box">
                                <input type="text" name="txtTel" id="txtTel" value="" maxlength="26" class="length-s" onkeypress="return KeyPressBlock(event,'tel');">
                                <span class="notice">（聯絡電話.手機至少輸入一個）</span>
                            </div>
                        </li>
                        <li>
                            <div>
                                <label for="txtCell"><span class="notice">*&nbsp;</span>手機</label>
                            </div>
                            <div class="form-box">
                                <input type="text" name="txtCell" id="txtCell" value="" maxlength="12" class="length-s" onkeypress="return KeyPressBlock(event,'ctel');">
                            </div>
                        </li>
                        <li>
                            <div>
                                <label for="txtFax"><span class="notice">&nbsp;&nbsp;&nbsp;</span>傳真</label>
                            </div>
                            <div class="form-box">
                                <input type="text" name="txtFax" id="txtFax" value="" maxlength="26" class="length-s" onkeypress="return KeyPressBlock(event,'tel');">
                            </div>
                        </li>
                        <li>
                            <div>
                                <label for="selOccu"><span class="notice">&nbsp;&nbsp;&nbsp;</span>職業</label>
                            </div>
                            <div class="form-box">
                                <uc1:ug_AcctOccu runat="server" ID="ug_AcctOccu" />
                                <%--職業--%>
                            </div>
                        </li>
                        <li>
                            <div>
                                <label for="selEdu"><span class="notice">&nbsp;&nbsp;&nbsp;</span>學歷</label>
                            </div>
                            <div class="form-box">
                                <uc1:ug_AcctEdu runat="server" ID="ug_AcctEdu" />
                                <%--學歷--%>
                            </div>
                        </li>
                        <li>
                            <div>
                                <label><span class="notice">&nbsp;&nbsp;&nbsp;</span>婚姻狀況</label>
                            </div>
                            <div class="form-box">
                                <input type="radio" name="radMarriage" id="radMarriage1" value="N" checked="checked">
                                <label for="radMarriage1">未婚</label>
                                <input type="radio" name="radMarriage" id="radMarriage2" value="Y">
                                <label for="radMarriage2">已婚</label>
                            </div>
                        </li>
                        <li>
                            <div>
                                <label><span class="notice">&nbsp;&nbsp;&nbsp;</span>如何得知</label>
                            </div>
                            <div class="form-box">
                                <uc1:ug_AcctHowKnow runat="server" ID="ug_AcctHowKnow" />
                                <%--如何得知--%>
                            </div>
                        </li>
                        <li>
                            <div>
                                <label><span class="notice">&nbsp;&nbsp;&nbsp;</span>訂閱電子報</label>
                            </div>
                            <div class="form-box">
                                <input type="radio" name="radIsEPaper" id="radIsEPaper1" value="Y" checked="checked">
                                <label for="radIsEPaper1">是</label>
                                <input type="radio" name="radIsEPaper" id="radIsEPaper2" value="N">
                                <label for="radIsEPaper2">否</label>
                            </div>
                        </li>

                        <li>
                            <div>
                                <label for="txtCaptchacode"><span class="notice">*&nbsp;</span>輸入驗證碼</label>
                            </div>
                            <div class="form-box">
                                <span>
                                    <input type="text" name="txtCaptchacode" id="txtCaptchacode" value="" maxlength="6" onkeypress="if(window.event ? event.keyCode == 13 : event.which == 13){SetCmd('a',0);};return KeyPressBlock(event,'num');">
                                </span><span class="Code">
                                    <img src="../ugC_Captcha.aspx" id="imgCaptcha" alt="驗證碼圖片"></span> <span><a href="javascript:void(0)" id="lbut_Captchacode" onclick="ReloadCaptcha('imgCaptcha')" title="更新驗證碼">更新驗證碼</a> </span><span><a href="../Captcha-Text/ugC_Captcha-Text.aspx" target="_blank" title="文字驗證碼(新視窗開啟)">文字驗證碼</a></span>
                            </div>
                        </li>
                        <li>
                            <div>
                                <input type="hidden" name="CSRFtoken" id="CSRFtoken" value="<%=CSRFtoken%>" />
                            </div>
                        </li>
                    </ul>
                </div>

                <div>
                    <small>
                        <input type="checkbox" name="chkAgree" id="ReguCheckbox" value="Y">
                        我已詳細閱讀<a href="/tw/member/ugC_Member_Regulation.aspx" target="_blank" title="服務條款(新視窗開啟)">uGear 優吉兒網站設計約定條款</a>，並同意接受內容所有款項規定 
                    </small>
                </div>

                <p class="Center">有 <span class="notice">*</span> 項目之欄位，資料不可空白！</p>
                <div class="Btn_Two"><a class="GoBack" href="#" onclick="document.frmUG.reset();return false;" title="重新填寫"><i class="fa fa-pencil"></i>重新填寫</a> <a class="GoBack Active" href="#" onclick="SendData()" title="確定送出"><i class="fa fa-check"></i>確定送出</a> </div>

            </div>
        </article>
    </section>
    <%--    </div>--%>
    <!--內頁內容結束-->

</asp:Content>
