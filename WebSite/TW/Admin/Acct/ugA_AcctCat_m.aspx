<%@ Page Language="C#" MasterPageFile="~/TW/Admin/Inc/Basic.Master" AutoEventWireup="true" CodeBehind="ugA_AcctCat_m.aspx.cs" Inherits="WebSite.TW.Admin.Acct.ugA_AcctCat_m" %>

<%@ Register Src="~/TW/Admin/Acct/ugA_incLeft.ascx" TagPrefix="uc1" TagName="ugA_incLeft" %>
<%@ Register Src="~/TW/Admin/Inc/ugA_MsgBox.ascx" TagPrefix="uc1" TagName="ugA_MsgBox" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        var Url = "ugA_AcctCat.aspx";
        var AcctCatModify = {}; //修改使用者單元權限
        var AcctCatAdd = {};    //新增使用者單元權限

        function initialize() {

            //判斷會員等級ID
            if ("<%=AcctCatID%>" != "") {
                //修改會員等級ID
                $("#lbut_add1,#lbut_add2").css('display', 'none');
                if ("<%=Type_All%>" != "Y" && "<%=Type_Update%>" != "Y") { //不是最高權限，也沒有修改權限
                    //瀏覽會員等級ID
                    $("#lbut_modify1,#lbut_modify2").css('display', 'none')
                }
            } else {
                //新增會員等級ID
                $("#lbut_modify1,#lbut_modify2").css('display', 'none')
            }

            if ("<%=UpSts%>" == "Y")
                $('input[name="radUpSts"]').filter('[value="Y"]').prop('checked', true);
            else {
                $('input[name="radUpSts"]').filter('[value="N"]').prop('checked', true);
            }

            $("#txtDueDate").val("<%=DueDate%>");
            if ("<%=DueDateSts%>" == "yyyy")
                $('#selDueDateSts option[alue="yyyy"]').prop('selected', true)
            if ("<%=DueDateSts%>" == "m")
                $('#selDueDateSts option[alue="m"]').prop('selected', true)
            if ("<%=DueDateSts%>" == "d")
                $('#selDueDateSts option[alue="d"]').prop('selected', true)

            $("#lbut_browse1,#lbut_browse2").on('click', function () {
                window.location.href = Url;
            });

            $("#lbut_add1,#lbut_add2").on('click', function () {
                var Msg = "";
                Msg = Regex(Msg);
                if (Msg == "") {
                    AcctCatAdd.CatCode = $("#txtCatCode").val();
                    AcctCatAdd.CatName = $("#txtCatName").val();
                    AcctCatAdd.UpSts = $("input[name='radUpSts']:checked").val();
                    AcctCatAdd.DueDate = $("#txtDueDate").val();
                    AcctCatAdd.DueDateSts = $("#selDueDateSts").val();

                    $.ajax({
                        type: "POST",
                        url: "ugA_AcctCat_m.aspx/AddAcctCat",
                        data: JSON.stringify({ "AcctCat": AcctCatAdd }),
                        contentType: 'application/json;charset=utf-8'
                    }).done(function (res) {
                        var jdata = $.parseJSON(res.d)
                        if (jdata.Redirect != undefined)
                            window.location.href = jdata.Redirect;
                        else {
                            if (jdata.strAlertMsg != "")
                                $("#lab_Msg").html(jdata.strAlertMsg);
                            else if (jdata.strSuccess != "") {
                                $("#lab_Msg").html(jdata.strSuccess)
                                PageReset();
                            }
                        }
                    })
                } else
                    $("#lab_Msg").html(Msg);
            })

            $("#lbut_modify1,#lbut_modify2").on('click', function () {
                var Msg = "";
                Msg = Regex(Msg);
                if (Msg == "") {
                    AcctCatModify.AcctCatID = $("#txtAcctCatID").val();
                    AcctCatModify.CatCode = $("#txtCatCode").val();
                    AcctCatModify.CatName = $("#txtCatName").val();
                    AcctCatModify.UpSts = $("input[name='radUpSts']:checked").val();
                    AcctCatModify.DueDate = $("#txtDueDate").val();
                    AcctCatModify.DueDateSts = $("#selDueDateSts").val();

                    $.ajax({
                        type: "POST",
                        url: "ugA_AcctCat_m.aspx/UpdateAcctCat",
                        data: JSON.stringify({ "AcctCat": AcctCatModify }),
                        contentType: 'application/json;charset=utf-8'
                    }).done(function (res) {
                        var jdata = $.parseJSON(res.d)
                        if (jdata.Redirect != undefined)
                            window.location.href = jdata.Redirect;
                        else {
                            if (jdata.strAlertMsg != "")
                                $("#lab_Msg").html(jdata.strAlertMsg);
                            else if (jdata.strSuccess != "") {
                                $("#lab_Msg").html(jdata.strSuccess)
                            }
                        }
                    })
                } else
                    $("#lab_Msg").html(Msg);

            })
        }

        function Regex(Msg) {
            if ($("#txtCatCode").val() == "")
                Msg += "編號　必須輸入資料!! <br>";

            if ($("#txtCatName").val() == "")
                Msg += "等級名稱　必須輸入資料!! <br>";

            if ($("input[name='radUpSts']:checked").val() == "N") {

                if ($("#txtDueDate").val() == "")
                    Msg += "天數　必須輸入資料!! <br>";
                else {
                    var i = parseFloat($("#txtDueDate").val());
                    if (isNaN(i))
                        Msg += "天數　格式錯誤，必須為數字!!";
                }
            }

            return Msg;
        }

        function PageReset() {

            $("#txtCatCode").val("");
            $("#txtCatName").val("");
            $("#txtDueDate").val("");

            $("#selDBSts option[value=yyyy]").prop('selected', true);
            $('input:radio[name="radUpSts"]').filter('[value="N"]').prop('checked', true);
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
                        <uc1:ugA_MsgBox runat="server" ID="ugA_MsgBox" Status="修改" Location="會員等級" />
                        <!-- ---------- 功能項 Start---------- -->
                        <div class="FnBu_wrapper">
                            <div id="lbut_browse1" class="FnBu_icon_browse ControlBut">瀏覽</div>
                            <div id="lbut_add1" class="FnBu_icon_add ControlBut">新增</div>
                            <div id="lbut_modify1" class="FnBu_icon_modify ControlBut">修改</div>
                        </div>
                        <!-- ---------- 功能項 End  ---------- -->

                        <!-- ---------- 表單 Start  ---------- -->
                        <div class="ContentDivWrapper">
                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>編號</div>
                                <div class="RightDiv">
                                    <input type="hidden" id="txtAcctCatID" value="<%=AcctCatID%>" />
                                    <input type="text" id="txtCatCode" name="txtCatCode" value="<%=CatCode%>" size="25" maxlength="16" onkeypress="return KeyPressBlock(event,'code');">
                                </div>
                            </div>
                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>等級名稱</div>
                                <div class="RightDiv">
                                    <input type="text" id="txtCatName" name="txtCatName" value="<%=CatName%>" size="70" maxlength="128" class="longForm">
                                </div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject"><span class="ss_add_star">＊</span>預設使用期限</div>
                                <div class="RightDiv">
                                    <div class="RightDiv01">
                                        <input type="radio" name="radUpSts" value="Y">
                                        <span class="Label">無限期</span>
                                    </div>
                                    <div class="RightDiv01">
                                        <div class="RightDiv01Left">
                                            <input type="radio" name="radUpSts" value="N">
                                            <span class="Label">設定期限：</span>
                                        </div>
                                        <div class="RightDiv01Right">
                                            天數&nbsp;
										<input style="width: auto; text-align: center;" type="text" name="txtDueDate" id="txtDueDate" size="3" maxlength="10" onkeypress="return KeyPressBlock(event,'num');">
                                            (
										<select name="selDueDateSts" id="selDueDateSts">
                                            <option value="yyyy">年</option>
                                            <option value="m">月</option>
                                            <option value="d">日</option>
                                        </select>
                                            ) <span color="#FF0000">(前台加入會員的使用期限會依照後台所設定)</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- ------------- 編輯資訊 Start ------------- -->
                            <div class="ContentDiv">
                                <hr color="#cccccc" size="1">
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject">編輯者</div>
                                <div class="css_RedTxt"><%=CreUser%></div>
                            </div>

                            <div class="ContentDiv">
                                <div class="ss_add_subject">編輯日期</div>
                                <div class="css_RedTxt"><%=CreDate%></div>
                            </div>
                            <!-- ------------- 編輯資訊 End   ------------- -->

                        </div>
                        <!-- ---------- 表單 End  ---------- -->


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
    <!--right END-->


</asp:Content>
