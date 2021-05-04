<%@ Page Title="" Language="C#" MasterPageFile="~/TW/Admin/Inc/Basic.Master" AutoEventWireup="true" CodeBehind="ugA_Acct_m.aspx.cs" Inherits="WebSite.TW.Admin.Acct.ugA_Acct_m" %>

<%@ Register Src="~/TW/Admin/Acct/ugA_incLeft.ascx" TagPrefix="uc1" TagName="ugA_incLeft" %>
<%@ Register Src="~/TW/Admin/Inc/ugA_MsgBox.ascx" TagPrefix="uc1" TagName="ugA_MsgBox" %>
<%@ Register Src="~/TW/Admin/Inc/ugA_Pagination.ascx" TagPrefix="uc1" TagName="ugA_Pagination" %>
<%@ Register Src="~/TW/Inc/ug_AcctCatID.ascx" TagPrefix="uc1" TagName="ug_AcctCatID" %>
<%@ Register Src="~/TW/Inc/ug_ContinentCityArea.ascx" TagPrefix="uc1" TagName="ug_ContinentCityArea" %>
<%@ Register Src="~/TW/Inc/ug_AcctEdu.ascx" TagPrefix="uc1" TagName="ug_AcctEdu" %>
<%@ Register Src="~/TW/Inc/ug_AcctOccu.ascx" TagPrefix="uc1" TagName="ug_AcctOccu" %>
<%@ Register Src="~/TW/Inc/ug_AcctHowKnow.ascx" TagPrefix="uc1" TagName="ug_AcctHowKnow" %>
<%@ Register Src="~/TW/Admin/Inc/ugA_DatePicket.ascx" TagPrefix="uc1" TagName="ugA_DatePicket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        var AcctAdd = {};
        var AcctModify = {};

        function initialize() {
            SetAcctCatIDSelOpt();   //會員等級
            SetAddrSelOpt();        //地址

            SetAcctOccuSelOpt();    //職業
            SetAcctEduSelOpt();     //學歷
            SetAcctHowKnowSelOpt(); //如何得知

            RegClickEvent();

            //判斷使否會員
            if ("<%=AcctID%>" != "") {
                debugger;
                //修改會員
                $("#lbut_add1,#lbut_add2").css('display', 'none');
                if ("<%=Type_All%>" != "Y" && "<%=Type_Update%>" != "Y") { //不是最高權限，也沒有修改權限
                    //瀏覽使用者
                    $("#lbut_modify1,#lbut_modify2").css('display', 'none')
                }

                $("#selAcctCatID").val("<%=ACCTCATID%>");

                $("#spanAcctCatID").css('display', 'none');

                $("#<%=this.ugA_DatePicket1.ClientID%>_txb_Date").val("<%=BGNDATE%>")
                $("#<%=this.ugA_DatePicket2.ClientID%>_txb_Date").val("<%=ENDDATE%>")

                if ("<%=UPSTS%>" == "Y")
                    $("input:radio[name='radUpSts']").filter("[value='Y']").prop('checked', true)
                else
                    $("input:radio[name='radUpSts']").filter("[value='N']").prop('checked', true)

                $("#spanLoginID").text("（此電子郵件不可修改）");
                $("#txtLoginID").prop("disabled", true);

                $("#selVIPConfirm").val("<%=VIPConfirm%>")

                if ("<%=SEX%>" == "M")
                    $("input:radio[name='radSex']").filter("[value='M']").prop('checked', true);
                else
                    $("input:radio[name='radSex']").filter("[value='F']").prop('checked', true);

                //帶入地址 Start
                $("#selContinentID").val("<%=CONTINENTID%>");
                ChgContinent();
                $("#selCityID").val("<%=CITYID%>");
                ChgCity();
                $("#selAreaID").val("<%=AREAID%>");
                ChgArea();
                //帶入地址 End

                $("#selOccu").val("<%=OCCU%>");
                $("#selEdu").val("<%=EDU%>");

                if ("<%=MARRIAGE%>" == "N")
                    $("input:radio[name='radMarriage']").filter("[value='N']").prop('checked', true);
                else
                    $("input:radio[name='radMarriage']").filter("[value='Y']").prop('checked', true);

                $("#selHowKnow").val("<%=HOWKNOW%>");

                if ("<%=ISEPAPER%>" == "Y")
                    $("input:radio[neme='radIsEPaper']").filter("[value='Y']").prop('checked', true);
                else
                    $("input:radio[neme='radIsEPaper']").filter("[value='N']").prop('checked', true);

                $("#selDBSts").val("<%=DBSTS%>");

            } else {
                //新增會員動作
                $("#lbut_modify1,#lbut_modify2").css('display', 'none')
                $("#VIPAccount").css('display', 'none');
                $("#txtPsw,#txtPswCheck").prop('placeholder', "");

                $("#spanLoginID").text("（請輸入E-Mail帳號；不可修改）");

                $("#selAcctCatID").on('change', function () {
                    if ($('option:selected', this).attr('upsts') == "Y") {
                        $("input:radio[name='radUpSts']").filter("[value='Y']").prop('checked', true);
                        $("#<%=this.ugA_DatePicket1.ClientID%>_txb_Date").val("");
                        $("#<%=this.ugA_DatePicket2.ClientID%>_txb_Date").val("");
                    } else {
                        $("input:radio[name='radUpSts']").filter("[value='N']").prop('checked', true);
                        $("#<%=this.ugA_DatePicket1.ClientID%>_txb_Date").val(CurrentDt());
                        $("#<%=this.ugA_DatePicket2.ClientID%>_txb_Date").val(CurrentDt());
                    }
                })
            }

        }

        function RegClickEvent() {

            $("#lbut_browse1,#lbut_browse2").on('click', function () {
                $("#HideInputList").empty();
                var HideInput = $("#HideInput").html();
                HideInput = HideInput.replace(/\%Sort%/g, "<%=Sort%>")
                    .replace(/\%Desc%/g, "<%=Desc%>")
                    .replace(/\%PgNum%/g, "<%=PgNum%>")
                    .replace(/\%SearchList%/g, "<%=SearchList%>")
                $("#HideInputList").append(HideInput);

                $("#form1").prop('action', "<%=GoToUrl%>");
                $("#form1").prop('method', 'post');
                $("#form1").submit();

            })

            $("#lbut_add1,#lbut_add2").on('click', function () {
                var Msg = "";
                var PswRule = "";
                Msg = Regex(Msg, "Y", "add");

                if (Msg == "") {
                    AcctAdd.AcctCatID = $("#selAcctCatID").val();
                    AcctAdd.LoginID = $("#txtLoginID").val();
                    AcctAdd.UpSts = $("input[name='radUpSts']:checked").val();

                    //無期限則清除日期
                    if (AcctAdd.UpSts == "Y") {
                        $("#<%=this.ugA_DatePicket1.ClientID%>_txb_Date").val("");
                        $("#<%=this.ugA_DatePicket2.ClientID%>_txb_Date").val("");
                    }

                    //日期最大的在結束日期
                    if (Date.parse($("#<%=this.ugA_DatePicket1.ClientID%>_txb_Date").val()) > Date.parse($("#<%=this.ugA_DatePicket2.ClientID%>_txb_Date").val())) {
                        AcctModify.BgnDate = $("#<%=this.ugA_DatePicket2.ClientID%>_txb_Date").val();
                        AcctModify.EndDate = $("#<%=this.ugA_DatePicket1.ClientID%>_txb_Date").val();
                    } else {
                        AcctModify.BgnDate = $("#<%=this.ugA_DatePicket1.ClientID%>_txb_Date").val()
                        AcctModify.EndDate = $("#<%=this.ugA_DatePicket2.ClientID%>_txb_Date").val()
                    }

                    AcctAdd.Psw = $("#txtPsw").val();
                    AcctAdd.VipCardNum = $("#txtVipCardNum").val();
                    AcctAdd.VIPConfirm = $("#selVIPConfirm").val();
                    AcctAdd.Company = $("#txtCompany").val();
                    AcctAdd.AcctName = $("#txtAcctName").val();
                    AcctAdd.Sex = $("input[name='radSex']:checked").val();
                    AcctAdd.Birth = $("#txtBirth").val();
                    AcctAdd.Email = $("#txtLoginID").val();
                    AcctAdd.ContinentID = $("#selContinentID").val();
                    AcctAdd.CityID = $("#selCityID").val();
                    AcctAdd.AreaID = $("#selAreaID").val();
                    AcctAdd.ZipCode = $("#txtZipCodeID").val();
                    AcctAdd.ZipCodeTwo = $("#txtZipCodeTwo").val();
                    AcctAdd.Addr = $("#txtAddr").val();
                    AcctAdd.Tel = $("#txtTel").val();
                    AcctAdd.Cell = $("#txtCell").val();
                    AcctAdd.Fax = $("#txtFax").val();
                    AcctAdd.Occu = $("#selOccu").val();
                    AcctAdd.Edu = $("#selEdu").val();
                    AcctAdd.Marriage = $("input[name='radMarriage']:checked").val();
                    AcctAdd.HowKnow = $("#selHowKnow").val();
                    AcctAdd.IsEPaper = $("input[name='radIsEPaper']:checked").val();
                    AcctAdd.DBSts = $("#selDBSts").val();
                    AcctAdd.Descr = $("#txtDescr").val();

                    $.ajax({
                        type: "POST",
                        url: "ugA_Acct_m.aspx/AddVipAccount",
                        data: JSON.stringify({ "Vip": AcctAdd }),
                        contentType: "application/Json;charset=utf-8"
                    }).done(function (res) {
                        var jdata = $.parseJSON(res.d)
                        if (jdata.Redirect != undefined)
                            window.location.href = jdata.Redirect;
                        else {
                            if (jdata.strSuccess != "") {
                                $("#lab_Msg").html(jdata.strSuccess)
                            } else if (jdata.strAlertMsg != "")
                                $("#lab_Msg").html(jdata.strAlertMsg);
                        }
                    })

                } else
                    $("#lab_Msg").html(Msg);
            })


            $("#lbut_modify1,#lbut_modify2").on('click', function () {
                var Msg = "";
                var PswRule = "";

                if ($("#txtPsw").val() == "" && $("#txtPswCheck").val() == "") //密碼未輸入不需確認
                    PswRule = "N";
                else
                    PswRule = "Y";

                //欄位正規判斷
                Msg = Regex(Msg, PswRule, "modify");

                if (Msg == "") {
                    AcctModify.AcctID = "<%=AcctID%>";
                    AcctModify.AcctCatID = $("#selAcctCatID").val();
                    //AcctModify.LoginID = $("#txtLoginID").val();
                    AcctModify.UpSts = $("input[name='radUpSts']:checked").val();

                    //無期限則清除日期
                    if (AcctAdd.UpSts == "Y") {
                        $("#<%=this.ugA_DatePicket1.ClientID%>_txb_Date").val("");
                        $("#<%=this.ugA_DatePicket2.ClientID%>_txb_Date").val("");
                    }

                    //日期最大的在結束日期
                    if (Date.parse($("#<%=this.ugA_DatePicket1.ClientID%>_txb_Date").val()) > Date.parse($("#<%=this.ugA_DatePicket2.ClientID%>_txb_Date").val())) {
                        AcctModify.BgnDate = $("#<%=this.ugA_DatePicket2.ClientID%>_txb_Date").val();
                        AcctModify.EndDate = $("#<%=this.ugA_DatePicket1.ClientID%>_txb_Date").val();
                    } else {
                        AcctModify.BgnDate = $("#<%=this.ugA_DatePicket1.ClientID%>_txb_Date").val()
                        AcctModify.EndDate = $("#<%=this.ugA_DatePicket2.ClientID%>_txb_Date").val()
                    }

                    AcctModify.Psw = $("#txtPsw").val();
                    AcctModify.VipCardNum = $("#txtVipCardNum").val();
                    AcctModify.VIPConfirm = $("#selVIPConfirm").val();
                    AcctModify.Company = $("#txtCompany").val();
                    AcctModify.AcctName = $("#txtAcctName").val();
                    AcctModify.Sex = $("input[name='radSex']:checked").val();
                    AcctModify.Birth = $("#txtBirth").val();
                    //AcctAdd.Email = $("#txtLoginID").val();
                    AcctModify.ContinentID = $("#selContinentID").val();
                    AcctModify.CityID = $("#selCityID").val();
                    AcctModify.AreaID = $("#selAreaID").val();
                    AcctModify.ZipCode = $("#txtZipCodeID").val();
                    AcctModify.ZipCodeTwo = $("#txtZipCodeTwo").val();
                    AcctModify.Addr = $("#txtAddr").val();
                    AcctModify.Tel = $("#txtTel").val();
                    AcctModify.Cell = $("#txtCell").val();
                    AcctModify.Fax = $("#txtFax").val();
                    AcctModify.Occu = $("#selOccu").val();
                    AcctModify.Edu = $("#selEdu").val();
                    AcctModify.Marriage = $("input[name='radMarriage']:checked").val();
                    AcctModify.HowKnow = $("#selHowKnow").val();
                    AcctModify.IsEPaper = $("input[name='radIsEPaper']:checked").val();
                    AcctModify.DBSts = $("#selDBSts").val();
                    AcctModify.Descr = $("#txtDescr").val();

                    $.ajax({
                        type: "POST",
                        url: "ugA_Acct_m.aspx/UpdateAcct",
                        data: JSON.stringify({ "Vip": AcctModify }),
                        contentType: "application/Json;charset=utf-8"
                    }).done(function (res) {
                        var jdata = $.parseJSON(res.d)
                        if (jdata.Redirect != undefined)
                            window.location.href = jdata.Redirect;
                        else {
                            if (jdata.strSuccess != "") {
                                $("#lab_Msg").html(jdata.strSuccess)
                            } else if (jdata.strAlertMsg != "")
                                $("#lab_Msg").html(jdata.strAlertMsg);
                        }
                    })

                } else
                    $("#lab_Msg").html(Msg);

            })
        }

        //當前日期
        function CurrentDt() {
            var currentDt = new Date();
            var mm = currentDt.getMonth() + 1;
            var dd = currentDt.getDate();
            var yyyy = currentDt.getFullYear();
            var date = yyyy + '/' + mm + '/' + dd;
            return date;
        }

        function Regex(Msg, PswRule, Status) {

            if ($("input[name='radUpSts']:checked").val() == "N") {
                if ($("#<%=this.ugA_DatePicket1.ClientID%>_txb_Date").val() == "")
                    Msg += "使用期限：開始日期　必須選擇資料!! <br>";
                if ($("#<%=this.ugA_DatePicket2.ClientID%>_txb_Date").val() == "")
                    Msg += "使用期限：結束日期　必須選擇資料!! <br>";
            }

            //新增才判斷
            if (Status == "add") {
                if ($("#txtLoginID").val() == "")
                    Msg += "電子郵件　必須輸入資料!! <br>";
                else
                    Msg += ChkBlock("email", "txtLoginID", "電子郵件");
            }

            if (PswRule == "Y") {
                if ($("#txtPsw").val() == "")
                    Msg += "密碼　必須輸入資料!! <br>";
                else {
                    Msg += ChkBlock("Aanum", "txtPsw", "密碼");
                    if ($("#txtPsw").val() != $("#txtPswCheck").val())
                        Msg += "密碼與密碼確認　必須相同!! <br>";
                }
            }

            if ($("#txtAcctName").val() == "")
                Msg += "姓名　必須輸入資料!! <br>";

            if ($("#txtBirth").val() == "")
                Msg += "出生日期　必須輸入資料!! <br>";
            else
                Msg += ChkDate($("#txtBirth").val(), "出生日期");

            Msg += ChkEmptyAddr("2", "聯絡");		//地址的判斷

            if ($("#txtTel").val() == "" && $("#txtCell").val() == "")
                Msg += '聯絡電話、手機請至少輸入一個!! <br>';
            else {
                if ($("#txtTel").val() != "")
                    Msg += ChkBlock('tel', "txtTel", '聯絡電話');
                if ($("#txtCell").val() != "")
                    Msg += ChkBlock('ctel', "txtCell", '手機');
            }

            if ($("#txtFax").val() != "")
                Msg += ChkBlock('tel', "txtFax", '傳真');

            return Msg;
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ugA_incLeft runat="server" ID="ugA_incLeft" />

    <!--right START-->
    <div class="right">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td>
                        <uc1:ugA_MsgBox runat="server" ID="ugA_MsgBox" Status="瀏覽" Location="會員資料" />

                        <div id="HideInputList">
                        </div>
                        <!-- ---------- 功能項 Start---------- -->
                        <div class="FnBu_wrapper">
                            <div id="lbut_browse1" class="FnBu_icon_browse ControlBut">瀏覽</div>
                            <div id="lbut_add1" class="FnBu_icon_add ControlBut">新增</div>
                            <div id="lbut_modify1" class="FnBu_icon_modify ControlBut">修改</div>
                        </div>
                        <!-- ---------- 功能項 End  ---------- -->

                        <!-- ---------- 表單 Start  ---------- -->
                        <div class="ContentDivWrapper" ng-app="appWebsite" ng-controller="ctrlAcct">
                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star"></span>系統卡號(自動)</div>
                                <div class="RightDiv"><%=SystemCard%></div>
                            </div>
                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>會員等級</div>
                                <div class="RightDiv">
                                    <uc1:ug_AcctCatID runat="server" FirstIndex="" ID="ug_AcctCatID" />
                                    <span class="css_RedTxt" id="spanAcctCatID">（新增時，若變更等級，則會將<font color="#006600">【使用期限】</font>自動變更為<font color="#006600">【預設期限】</font>）</span>
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>使用期限</div>
                                <div class="RightDiv">
                                    <input type="radio" name="radUpSts" value="Y" checked=""><span class="Label">無限期</span>
                                    <input type="radio" name="radUpSts" value="N"><span class="Label">設定期限：開始日</span>
                                    <div class="shortFormWrapper">
                                        <uc1:ugA_DatePicket runat="server" ID="ugA_DatePicket1" />
                                        ~ 結束日&nbsp;
                                         <uc1:ugA_DatePicket runat="server" ID="ugA_DatePicket2" />
                                    </div>
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>電子郵件</div>
                                <div class="RightDiv">
                                    <input type="text" name="txtLoginID" id="txtLoginID" size="44" maxlength="255" value="<%=LOGINID%>" onkeypress="return KeyPressBlock(event,'email');">
                                    <font id="txtLoginIDTxt" color="#006600"></font>
                                    <span class="css_RedTxt" id="spanLoginID"></span>
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>密　　碼</div>
                                <div class="RightDiv">
                                    <input type="text" name="txtPsw" id="txtPsw" maxlength="16" size="16" value="" placeholder="請輸入新密碼, 若沒有要變更則不用輸入" onkeypress="return KeyPressBlock(event,'Aanum');">
                                    <span class="css_RedTxt">（請輸入6~16個英文或數字組合的密碼）</span>
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>密碼確認</div>
                                <div class="RightDiv">
                                    <input type="text" name="txtPswCheck" id="txtPswCheck" maxlength="16" size="16" value="" placeholder="請輸入新密碼, 若沒有要變更則不用輸入" onkeypress="return KeyPressBlock(event,'Aanum');">
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star"></span>門市會員卡號</div>
                                <div class="RightDiv">
                                    <input type="text" name="txtVipCardNum" id="txtVipCardNum" maxlength="7" size="16" value="<%=VIPCARDNUM%>" onkeypress="return KeyPressBlock(event,'num');">
                                    <span class="css_RedTxt">（卡號為7碼且為數字）</span>
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star"></span>門市會員狀態</div>
                                <div class="RightDiv">
                                    <select name="selVIPConfirm" id="selVIPConfirm">
                                        <option value="N" selected="" class="css_RedTxt">待確認</option>
                                        <option value="Y" class="css_GreenTxt">已確認</option>
                                    </select>
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star"></span>公司名稱</div>
                                <div class="RightDiv">
                                    <input type="text" name="txtCompany" id="txtCompany" maxlength="128" value="<%=COMPANY%>" size="44">
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>姓名</div>
                                <div class="RightDiv">
                                    <input type="text" name="txtAcctName" id="txtAcctName" maxlength="32" value="<%=ACCTNAME%>" size="32">
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>性別</div>
                                <div class="RightDiv">
                                    <input type="radio" name="radSex" value="M" checked=""><span class="Label">男</span>
                                    <input type="radio" name="radSex" value="F"><span class="Label">女</span>
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>出生日期</div>
                                <div class="RightDiv">
                                    <input type="text" name="txtBirth" id="txtBirth" maxlength="10" size="10" value="<%=BIRTH%>" onkeypress="return KeyPressBlock(event,'date');">
                                    <span class="css_RedTxt">（西元年/月/日）EX：1980/01/01 </span>
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>聯絡區域</div>
                                <div class="RightDiv">
                                    <div class="addressformWrapper">
                                        <uc1:ug_ContinentCityArea runat="server" FirstIndex="----地區----,----城市----,----區域----" ID="ug_ContinentCityArea" />
                                    </div>
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>聯絡地址</div>
                                <div class="RightDiv">
                                    (<input style="width: 50px;" type="text" name="txtZipCodeID" id="txtZipCodeID" maxlength="3" size="3" value="<%=ZIPCODE%>" onkeypress="return KeyPressBlock(event,'num');">
                                    +
	                            <input style="width: 50px;" type="text" name="txtZipCodeTwo" id="txtZipCodeTwo" maxlength="2" size="2" value="<%=ZIPCODETWO%>" onkeypress="return KeyPressBlock(event,'num');">) -
	                            <input class="longForm" type="text" name="txtAddr" id="txtAddr" maxlength="128" size="30" value="<%=ADDR%>">
                                    <span style="color: #FF0000">（3+2郵遞區號-地址）</span>
                                </div>
                            </div>
                            <!--地址-欄位處理-->

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>聯絡電話</div>
                                <div class="RightDiv">
                                    <input type="text" name="txtTel" id="txtTel" maxlength="26" value="<%=TEL%>" size="26" onkeypress="return KeyPressBlock(event,'tel');">
                                    <span class="css_RedTxt">（聯絡電話、手機至少輸入一個）</span>
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>手機</div>
                                <div class="RightDiv">
                                    <input type="text" name="txtCell" id="txtCell" maxlength="12" value="<%=CELL%>" size="26" onkeypress="return KeyPressBlock(event,'ctel');">
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject">傳真</div>
                                <div class="RightDiv">
                                    <input type="text" name="txtFax" id="txtFax" maxlength="26" value="<%=FAX%>" size="26" onkeypress="return KeyPressBlock(event,'tel');">
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject">職業</div>
                                <div class="RightDiv">
                                    <uc1:ug_AcctOccu runat="server" ID="ug_AcctOccu" />
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject">學歷</div>
                                <div class="RightDiv">
                                    <uc1:ug_AcctEdu runat="server" ID="ug_AcctEdu" />
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject">婚姻狀況</div>
                                <div class="RightDiv">
                                    <input type="radio" name="radMarriage" value="N" checked=""><span class="Label">未婚</span>
                                    <input type="radio" name="radMarriage" value="Y"><span class="Label">已婚</span>
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject">如何得知</div>
                                <div class="RightDiv">
                                    <uc1:ug_AcctHowKnow runat="server" ID="ug_AcctHowKnow" />
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject">訂閱電子報</div>
                                <div class="RightDiv">
                                    <input type="radio" name="radIsEPaper" value="Y" checked=""><span class="Label">是</span>
                                    <input type="radio" name="radIsEPaper" value="N"><span class="Label">否</span>
                                </div>
                            </div>
                            <div id="VIPAccount">
                                <div class="ContentDiv">
                                    <div class="ss_add_subject">加入時間</div>
                                    <div class="RightDiv"><span class="css_RedTxt" id="AddTime">"<%=CREDATE%>"</span></div>
                                </div>
                                <div class="ContentDiv">
                                    <div class="ss_add_subject">最近登入時間</div>
                                    <div class="RightDiv"><span class="css_RedTxt" id="LoginDate">"<%=LoginDate%>"</span></div>
                                </div>
                                <div class="ContentDiv">
                                    <div class="ss_add_subject">登錄次數</div>
                                    <div class="RightDiv"><span class="css_RedTxt" id="LoginNum">"<%=LOGINNUM%>"</span> 次</div>
                                </div>
                                <div class="ContentDiv">
                                    <div class="ss_add_subject">購買次數</div>
                                    <div class="RightDiv"><span class="css_RedTxt" id="OrdNum">"<%=ORDNUM%>"</span> 次</div>
                                </div>
                                <div class="ContentDiv">
                                    <div class="ss_add_subject">討論次數</div>
                                    <div class="RightDiv"><span class="css_RedTxt" id="ForumNum">"<%=FORUMNUM%>"</span> 次</div>
                                </div>
                                <div class="ContentDiv">
                                    <div class="ss_add_subject">報名次數</div>
                                    <div class="RightDiv"><span class="css_RedTxt" id="EventRecCount">"<%=EventRecCount%>"</span>次</div>
                                </div>
                            </div>
                            <div class="ContentDiv">
                                <div class="ss_add_subject">狀態</div>
                                <div class="RightDiv">
                                    <select name="selDBSts" id="selDBSts">
                                        <option value="A" selected="" class="css_RedTxt">啟動</option>
                                        <option value="D" class="css_GreenTxt">終止</option>
                                    </select>
                                </div>
                            </div>

                            <div class="ContentDiv" id="editor-textarea-content-0">
                                <div class="ss_add_subject">備註(僅後台顯示)</div>
                                <div class="RightDiv">
                                    <textarea name="txtDescr" id="txtDescr" class="ckeditor" rows="10" cols="75"></textarea>
                                </div>
                            </div>
                            <!--textarea欄位處理-->

                            <!-- ------------- 編輯資訊 Start ------------- -->

                            <!-- ------------- 編輯資訊 End   ------------- -->
                        </div>
                        <!-- ---------- 表單 End  ---------- -->

                        <table align="center">
                            <tbody>
                                <tr>
                                    <td>有<span class="ss_add_star">＊</span>之欄位，資料不可空白！</td>
                                </tr>
                            </tbody>
                        </table>
                        <br>
                        <!-- ---------- 功能項 Start---------- -->
                        <div class="FnBu_wrapper">
                            <div id="lbut_browse2" class="FnBu_icon_browse ControlBut">瀏覽</div>
                            <div id="lbut_add2" class="FnBu_icon_add ControlBut">新增</div>
                            <div id="lbut_modify2" class="FnBu_icon_modify ControlBut">修改</div>
                        </div>
                        <!-- ---------- 功能項 End  ---------- -->
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <script type="text/template" id="HideInput">
        <input type="hidden" name='Sort' value='%Sort%' />
        <%--欄位排序--%>
        <input type="hidden" name='Desc' value='%Desc%' />
        <%--順向逆向--%>
        <input type="hidden" name='PgNum' value='%PgNum%' />
        <%--紀錄分頁--%>
        <input type="hidden" name='SearchList' value='%SearchList%' />
    </script>

    <!--right END-->
</asp:Content>
