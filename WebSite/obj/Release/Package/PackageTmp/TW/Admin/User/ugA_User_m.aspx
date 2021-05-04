<%@ Page Language="C#" MasterPageFile="~/TW/Admin/Inc/Basic.Master" AutoEventWireup="true" CodeBehind="ugA_User_m.aspx.cs" Inherits="WebSite.TW.Admin.User.ugA_User_m" %>

<%@ Register Src="~/TW/Admin/User/ugA_incLeft.ascx" TagPrefix="uc1" TagName="ugA_incLeft" %>
<%@ Register Src="~/TW/Admin/Inc/ugA_MsgBox.ascx" TagPrefix="uc1" TagName="ugA_MsgBox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        var UserAdd = {};
        var UserModify = {};
        var MenuUserItem = [];

        function initialize() {
            GetMenuCheckbox(DrawTable);
            RegClickEvent();

            //判斷使用者ID
            if ("<%=UserID%>" != "") {
                //修改使用者
                $("#lbut_add1,#lbut_add2").css('display', 'none');
                if ("<%=Type_All%>" != "Y" && "<%=Type_Update%>" != "Y") { //不是最高權限，也沒有修改權限
                    //瀏覽使用者
                    $("#lbut_modify1,#lbut_modify2").css('display', 'none')
                }
            } else {
                //新增使用者
                $("#lbut_modify1,#lbut_modify2").css('display', 'none')
                $("#txtPsw,#txtPswCheck").prop('placeholder', "");
            }

        }

        function RegClickEvent() {
            $("#lbut_browse1,#lbut_browse2").on('click', function () {
                window.location.href = "<%=GoToUserUrl%>" + "?Sort=" + "<%=Sort%>" + "&Desc=" + "<%=Desc%>" + "&PgNum=" + <%=PgNum%>;
            })

            //新增帳號
            $("#lbut_add1,#lbut_add2").on('click', function () {

                var Msg = "";

                //欄位正規判斷
                Msg = Regex(Msg, "Y");

                if (Msg == "") {
                    UserAdd.UserID = "";
                    UserAdd.LoginID = $("#txtLoginID").val();
                    UserAdd.Psw = $("#txtPsw").val();
                    UserAdd.UserName = $("#txtUserName").val();
                    UserAdd.HighUser = $("input[name='radHighUser']:checked").val();
                    UserAdd.Descr = $("#txtDescr").val();
                    UserAdd.DBSts = $("#selDBSts").val();

                    //最高則清除一般勾選項目選項
                    if (UserAdd.HighUser == "Y")
                        MenuUserItem.length = 0;

                    $.ajax({
                        type: "POST",
                        url: "ugA_User_m.aspx/AddMenuUser",
                        data: JSON.stringify({ "User": UserAdd, "MenuUserItem": MenuUserItem }),
                        contentType: "application/Json;charset=utf-8"
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
                                MenuUserItem.length = 0;
                            }
                        }
                    })
                } else
                    $("#lab_Msg").html(Msg);

            })

            //修改帳號
            $("#lbut_modify1,#lbut_modify2").on('click', function () {
                var Msg = "";
                var PswRule = "";

                if ($("#txtPsw").val() == "" && $("#txtPswCheck").val() == "") //密碼未輸入不需確認
                    PswRule = "N";
                else
                    PswRule = "Y";

                //欄位正規判斷
                Msg = Regex(Msg, PswRule);

                if (Msg == "") {
                    UserModify.UserID = $("#txtUserID").val();
                    UserModify.LoginID = $("#txtLoginID").val();
                    UserModify.Psw = $("#txtPsw").val();
                    UserModify.UserName = $("#txtUserName").val();
                    UserModify.HighUser = $("input[name='radHighUser']:checked").val();
                    UserModify.Descr = $("#txtDescr").val();
                    UserModify.DBSts = $("#selDBSts").val();

                    //最高則清除一般勾選項目選項
                    if (UserModify.HighUser == "Y")
                        MenuUserItem.length = 0;

                    $.ajax({
                        type: "POST",
                        url: "ugA_User_m.aspx/UpdateMenuUser",
                        data: JSON.stringify({ "User": UserModify, "MenuUserItem": MenuUserItem }),
                        contentType: "application/Json;charset=utf-8"
                    }).done(function (res) {
                        var jdata = $.parseJSON(res.d)
                        if (jdata.Redirect != undefined)
                            window.location.href = jdata.Redirect;
                        else {
                            if (jdata.strSuccess != "") {
                                $("#lab_Msg").html(jdata.strSuccess)
                                $("#txtPsw").val("");
                                $("#txtPswCheck").val("");
                            } else if (jdata.strAlertMsg != "")
                                $("#lab_Msg").html(jdata.strAlertMsg);
                        }
                    })
                }
                else
                    $("#lab_Msg").html(Msg);

            })

        }

        //取Checkbox
        function GetMenuCheckbox(callback) {

            $.ajax({
                type: "POST",
                url: "ugA_User_m.aspx/GetMenuCheckbox",
                data: JSON.stringify({ "UserID":"<%=UserID%>" }),
                contentType: "application/json; charset=utf-8"
            }).done(function (res) {
                var jdata = $.parseJSON(res.d)
                if (jdata.Redirect != undefined)
                    window.location.href = jdata.Redirect;
                else {
                    var data = $.parseJSON(jdata.MenuUserItemData)
                    callback(data);
                }
            })
        }

        var i = 1;
        var CatName;
        var strId = "";

        //畫Table(新增、修改)
        function DrawTable(res) {

            $.each(res, function (key, Val) {
                if (CatName != Val.CatName) {
                    var Table_Title = $("#Table_Title").html();
                    Table_Title = Table_Title.replace("%CatName%", Val.CatName);
                    $("#Table_List").append(Table_Title);
                    CatName = Val.CatName;  //單元權限標題
                }

                var Table_data = $("#Table_Data").html();
                Table_data = Table_data.replace("%Count%", i).replace("%MenuName%", Val.MenuName)
                    .replace(/\%ID%/g, Val.MenuID);

                $("#Table_List").append(Table_data);

                //勾選狀態_(非新增帳號)及做勾選記錄 Start
                if ("<%=UserID%>" != "") {
                    if (Val.Type_All_Item == "Y" || Val.Type_Look_Item == "Y" || Val.Type_Add_Item == "Y" || Val.Type_Update_Item == "Y" || Val.Type_Del_Item == "Y") {

                        var MenuUser = { MenuID: "", Type_All: "", Type_Look: "", Type_Add: "", Type_Update: "", Type_Del: "" };

                        MenuUser.MenuID = Val.MenuID;
                        if (Val.Type_All_Item == "Y") {
                            $("#radType_All_" + Val.MenuID).prop('checked', true);
                            MenuUser.Type_All = "Y";
                        }
                        if (Val.Type_Look_Item == "Y") {
                            $("#radType_Look_" + Val.MenuID).prop('checked', true);
                            MenuUser.Type_Look = "Y";
                        }
                        if (Val.Type_Add_Item == "Y") {
                            $("#radType_Add_" + Val.MenuID).prop('checked', true);
                            MenuUser.Type_Add = "Y";
                        }
                        if (Val.Type_Update_Item == "Y") {
                            $("#radType_Update_" + Val.MenuID).prop('checked', true);
                            MenuUser.Type_Update = "Y";
                        }
                        if (Val.Type_Del_Item == "Y") {
                            $("#radType_Del_" + Val.MenuID).prop('checked', true);
                            MenuUser.Type_Del = "Y";
                        }
                        MenuUserItem.push(MenuUser);
                    }
                }
                //勾選狀態_(非新增帳號)及做勾選記錄 End

                //新增將底下資訊隱藏
                if ("<%=UserID%>" == "") {
                    $("#Panel_Line").css('display', 'none');
                    $("#Panel_CreUser").css('display', 'none');
                    $("#Panel_CreDate").css('display', 'none');
                    $("#Panel_UpdUser").css('display', 'none');
                    $("#Panel_UpdDate").css('display', 'none');
                }

                //新增，修改，刪除(判斷隱藏)
                if (Val.Type_Add != "Y") {
                    $("#radType_Add_" + Val.MenuID).css('display', 'none');
                    $("#spanType_Add_" + Val.MenuID).text("");
                }
                if (Val.Type_Update != "Y") {
                    $("#radType_Update_" + Val.MenuID).css('display', 'none');
                    $("#spanType_Update_" + Val.MenuID).text("");
                }
                if (Val.Type_Del != "Y") {
                    $("#radType_Del_" + Val.MenuID).css('display', 'none');
                    $("#spanType_Del_" + Val.MenuID).text("");
                }

                //權限
                if ("<%=HighUser%>" == "Y")
                    $('input:radio[name="radHighUser"]').filter('[value="Y"]').prop('checked', true);
                else
                    $('input:radio[name="radHighUser"]').filter('[value="N"]').prop('checked', true);

                //終止啟動"
                if ("<%=DBSts%>" == "A" || "<%=UserID%>" == "") //使用者修改時狀態為A及新增使用者顯示啟動
                    $("#selDBSts option[value=A]").prop('selected', true);
                else
                    $("#selDBSts option[value=D]").prop('selected', true);

                //註冊CheckBoxClick事件 Start
                if (i == 1 || res.length == i - 1)
                    strId += "#radType_All_" + Val.MenuID + ",#radType_Look_" + Val.MenuID + ",#radType_Add_" + Val.MenuID + ",#radType_Update_" + Val.MenuID + ",#radType_Del_" + Val.MenuID;
                else if (res.length != i - 1)
                    strId += ",#radType_All_" + Val.MenuID + ",#radType_Look_" + Val.MenuID + ",#radType_Add_" + Val.MenuID + ",#radType_Update_" + Val.MenuID + ",#radType_Del_" + Val.MenuID;
                //註冊CheckBoxClick事件 End

                i++;
            })

            //記錄單元權限
            RegCheckBoxEvent(strId);
        }



        function RegCheckBoxEvent(strId) {

            $(strId).on('change', function (e) {
                var IdList = e.target.id.split("_") //取id
                //確認當下勾選狀態
                if ($("#" + e.target.id).prop("checked")) {

                    var MUT = MenuUserItem.find(function (item, index, array) {
                        return item.MenuID == IdList[2]; //Array find 回傳符合條件的item
                    })

                    var strId = IdList[0] + "_" + IdList[1];

                    if (MUT != undefined) {
                        //在MenuUserItem有找到記錄

                        //移除原先加入的資料
                        var ind = MenuUserItem.indexOf(MUT)
                        MenuUserItem.splice(ind, 1)

                        if (strId == "radType_All")
                            MUT.Type_All = "Y";
                        else if (strId == "radType_Look")
                            MUT.Type_Look = "Y";
                        else if (strId == "radType_Add")
                            MUT.Type_Add = "Y";
                        else if (strId == "radType_Update")
                            MUT.Type_Update = "Y";
                        else if (strId == "radType_Del")
                            MUT.Type_Del = "Y";

                        MenuUserItem.push(MUT);

                    } else {
                        //在MenuUserItem未找到記錄，新增新記錄

                        var MenuUser = { MenuID: "", Type_All: "", Type_Look: "", Type_Add: "", Type_Update: "", Type_Del: "" };

                        //新增資料
                        MenuUser.MenuID = IdList[2];
                        if (strId == "radType_All")
                            MenuUser.Type_All = "Y";
                        else if (strId == "radType_Look")
                            MenuUser.Type_Look = "Y";
                        else if (strId == "radType_Add")
                            MenuUser.Type_Add = "Y";
                        else if (strId == "radType_Update")
                            MenuUser.Type_Update = "Y";
                        else if (strId == "radType_Del")
                            MenuUser.Type_Del = "Y";
                        MenuUserItem.push(MenuUser);
                    }
                }
                else {
                    //取消前，勾選在MenuUserItem一定有紀錄

                    //從陣列取出
                    var MUT = MenuUserItem.find(function (item, index, array) {
                        return item.MenuID == IdList[2];
                    })

                    //移除原先加入的資料
                    var ind = MenuUserItem.indexOf(MUT)
                    MenuUserItem.splice(ind, 1)

                    var strId = IdList[0] + "_" + IdList[1];
                    if (strId == "radType_All")
                        MUT.Type_All = "";
                    else if (strId == "radType_Look")
                        MUT.Type_Look = "";
                    else if (strId == "radType_Add")
                        MUT.Type_Add = "";
                    else if (strId == "radType_Update")
                        MUT.Type_Update = "";
                    else if (strId == "radType_Del")
                        MUT.Type_Del = "";

                    //其中一欄位不為空字串才加入陣列
                    if (MUT.Type_All != "" || MUT.Type_Look != "" || MUT.Type_Add != "" || MUT.Type_Update != "" || MUT.Type_Del != "")
                        MenuUserItem.push(MUT);

                }
            })
        }

        function Regex(Msg, PswRule) {

            if ($("#txtLoginID").val() == "")
                Msg += "帳號　必須輸入資料!! <br>";
            else if ($("#txtLoginID").val() < 3)
                Msg += "帳號　長度錯誤(最少需輸入3個字)!! <br>";
            else
                Msg += ChkBlock("anum", "txtLoginID", "帳號");

            if (PswRule == "Y") {
                if ($("#txtPsw").val() == "")
                    Msg += "密碼　必須輸入資料!!<br>";
                else {
                    Msg += ChkBlock("PW6-16AanumSC", "txtPsw", "密碼");
                    if ($("#txtPsw").val() != $("#txtPswCheck").val())
                        Msg += "密碼與密碼確認　必須相同!! <br>";
                }
            }

            if ($("#txtUserName").val() == "")
                Msg += "姓名　必須輸入資料!!<br>";

            return Msg;
        }

        function PageReset() {

            $("#txtUserID").val("");
            $("#txtLoginID").val("");
            $("#txtPsw").val("");
            $("#txtPswCheck").val("");
            $("#txtUserName").val("");
            $("#txtDescr").val("");

            $("#lab_CreUser").text("");
            $("#lab_CreDate").text("");
            $("#lab_UpdUser").text("");
            $("#lab_UpdDate").text("");

            $("#selDBSts option[value=A]").prop('selected', true);
            $('input:radio[name="radHighUser"]').filter('[value="N"]').prop('checked', true);

            MenuUserItem.length = 0;
            $(strId).prop('checked', false);
        }

    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--file="../Inc/ugA_incLeft.asp"  START -->
    <uc1:ugA_incLeft runat="server" ID="ugA_incLeft" />
    <!--file="../Inc/ugA_incLeft.asp"  END -->
    <!--right START-->
    <div class="right">
        <table width="95%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <uc1:ugA_MsgBox runat="server" ID="ugA_MsgBox" Status="修改" Location="權限修改" />

                    <!-- ---------- 功能項 Start---------- -->
                    <div class="FnBu_wrapper">
                        <div id="lbut_browse1" class="FnBu_icon_browse ControlBut">瀏覽</div>
                        <div id="lbut_add1" class="FnBu_icon_add ControlBut">新增</div>
                        <div id="lbut_modify1" class="FnBu_icon_modify ControlBut">修改</div>
                    </div>
                    <!-- ---------- 功能項 End  ---------- -->

                    <br>

                    <!-- ---------- 表單 Start  ---------- -->
                    <div class="ContentDivWrapper">
                        <div class="ContentDiv">
                            <div class="ss_add_subject"><span class="ss_add_star">＊</span>帳　　號</div>
                            <div class="RightDiv">
                                <input type="hidden" id="txtUserID" value="<%=UserID%>" />
                                <input type="text" id="txtLoginID" maxlength="16" value="<%=LoginID%>" />
                                <span style="color: #FF0000">（請輸入3~16個英文或數字組合的帳號）</span>
                            </div>
                        </div>
                        <div class="ContentDiv">
                            <div class="ss_add_subject"><span class="ss_add_star">＊</span>密　　碼</div>
                            <div class="RightDiv">
                                <input type="password" style="display: none" />
                                <%--防止記憶密碼帶入正常欄位--%>
                                <input type="password" id="txtPsw" maxlength="16" autocomplete="off" placeholder="請輸入新密碼, 若沒有要變更則不用輸入" />
                                <span style="color: #FF0000">（請輸入6~16個包含大寫英文,小寫英文,數字及特殊字元組合的密碼）</span>
                            </div>
                        </div>
                        <div class="ContentDiv">
                            <div class="ss_add_subject"><span class="ss_add_star">＊</span>密碼確認</div>
                            <div class="RightDiv">
                                <input type="password" id="txtPswCheck" maxlength="16" autocomplete="off" placeholder="請輸入新密碼, 若沒有要變更則不用輸入" />
                            </div>
                        </div>
                        <div class="ContentDiv">
                            <div class="ss_add_subject"><span class="ss_add_star">＊</span>姓　　名</div>
                            <div class="RightDiv">
                                <input type="text" style="display: none" />
                                <%--防止記憶密碼帶入正常欄位--%>
                                <input type="text" id="txtUserName" autocomplete="off" maxlength="128" value="<%=UserName%>" />
                            </div>
                        </div>
                        <div class="ContentDiv">
                            <div class="ss_add_subject">最高權限</div>
                            <div class="RightDiv">
                                <input type="radio" name="radHighUser" value="N"><span class="Label">一般</span>
                                <input type="radio" name="radHighUser" value="Y"><span class="Label">最高</span>
                                <span class="Label" style="color: #FF0000">&nbsp;&nbsp;(如選擇"最高"，則擁有全部"單元權限")</span>
                            </div>
                        </div>
                        <div class="ContentDiv">
                            <hr>
                        </div>
                        <div class="ContentDiv" id="divPermissionArea" runat="server">
                            <div class="ss_add_subject"><span class="ss_add_star">＊</span>單元權限</div>
                            <div class="RightDiv">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tbody id="Table_List">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="ContentDiv" id="divPermissionLine" runat="server">
                            <hr color="#cccccc" size="1">
                        </div>

                        <!-- ------------- textarea欄位處理 Start ------------- -->
                        <div class="ContentDiv">
                            <div class="ss_add_subject">備註</div>
                            <div class="RightDiv">
                                <textarea id="txtDescr" rows="10" cols="75"><%=Descr%></textarea>
                            </div>
                        </div>
                        <!-- ------------- textarea欄位處理 End   ------------- -->

                        <div class="ContentDiv">
                            <div class="ss_add_subject">狀態</div>
                            <div class="RightDiv">
                                <select id="selDBSts">
                                    <option class="css_RedTxt" value="A">啟動</option>
                                    <option class="css_GreenTxt" value="D">終止</option>
                                </select>
                            </div>
                        </div>

                        <!-- ------------- 編輯資訊 Start ------------- -->
                        <div id="Panel_Line" class="ContentDiv">
                        </div>
                        <div id="Panel_CreUser" class="ContentDiv">
                            <div class="ss_add_subject">建立者</div>
                            <div class="css_RedTxt">
                                <span id="lab_CreUser"><%=CreUser%></span>
                            </div>
                        </div>
                        <div id="Panel_CreDate" class="ContentDiv">
                            <div class="ss_add_subject">建立日期</div>
                            <div class="css_RedTxt">
                                <span id="lab_CreDate"><%=CreDate%></span>
                            </div>
                        </div>
                        <div id="Panel_UpdUser" class="ContentDiv">
                            <div class="ss_add_subject">編輯者</div>
                            <div class="css_RedTxt">
                                <span id="lab_UpdUser"><%=UpdUser%></span>
                            </div>
                        </div>
                        <div id="Panel_UpdDate" class="ContentDiv">
                            <div class="ss_add_subject">編輯日期</div>
                            <div class="css_RedTxt">
                                <span id="lab_UpdDate"><%=UpdDate%></span>
                            </div>
                        </div>
                        <div class="ContentDiv">
                        <!-- ------------- 編輯資訊 End   ------------- -->

                        </div>
                        <!-- ---------- 表單 End ---------- -->

                        <table align="center">
                            <tr>
                                <td>有<span class="ss_add_star">＊</span>之欄位，資料不可空白！</td>
                            </tr>
                        </table>

                        <br>
                    </div>
                    <!-- ---------- 功能項 Start---------- -->
                    <div class="FnBu_wrapper">
                        <div id="lbut_browse2" class="FnBu_icon_browse ControlBut">瀏覽</div>
                        <div id="lbut_add2" class="FnBu_icon_add ControlBut">新增</div>
                        <div id="lbut_modify2" class="FnBu_icon_modify ControlBut">修改</div>
                    </div>
                    <!-- ---------- 功能項 End  ---------- -->
                </td>
            </tr>
        </table>
    </div>

    <%--====================================== Component ================================================--%>

    <script type="text/template" id="Table_Title">
        <tr>
            <td style="background-color: #CCCCCC; padding: 4px;" colspan="6" align="center">%CatName%</td>
        </tr>
    </script>

    <script type="text/template" id="Table_Data">
        <tr id="Menu_%ID%">
            <td>%Count%) %MenuName%</td>
            <td>
                <input type="checkbox" id="radType_All_%ID%" value="Y"><span id="spanType_All_%ID%">全部</span></td>
            <td>
                <input type="checkbox" id="radType_Look_%ID%" value="Y"><span id="spanType_Look_%ID%">瀏覽</span></td>
            <td>
                <input type="checkbox" id="radType_Add_%ID%" value="Y"><span id="spanType_Add_%ID%">新增</span></td>
            <td>
                <input type="checkbox" id="radType_Update_%ID%" value="Y"><span id="spanType_Update_%ID%">修改</span></td>
            <td>
                <input type="checkbox" id="radType_Del_%ID%" value="Y"><span id="spanType_Del_%ID%">刪除</span></td>
        </tr>
    </script>

</asp:Content>
