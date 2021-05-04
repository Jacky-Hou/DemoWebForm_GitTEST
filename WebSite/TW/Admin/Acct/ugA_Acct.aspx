<%@ Page Language="C#" MasterPageFile="~/TW/Admin/Inc/Basic.Master" AutoEventWireup="true" CodeBehind="ugA_Acct.aspx.cs" Inherits="WebSite.TW.Admin.Acct.ugA_Acct" %>

<%@ Register Src="~/TW/Admin/Acct/ugA_incLeft.ascx" TagPrefix="uc1" TagName="ugA_incLeft" %>
<%@ Register Src="~/TW/Admin/Inc/ugA_MsgBox.ascx" TagPrefix="uc1" TagName="ugA_MsgBox" %>
<%@ Register Src="~/TW/Admin/Inc/ugA_Pagination.ascx" TagPrefix="uc1" TagName="ugA_Pagination" %>
<%@ Register Src="~/TW/Inc/ug_AcctCatID.ascx" TagPrefix="uc1" TagName="ug_AcctCatID" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../JS/jquery.jqGrid.min.js"></script>
    <script>
        var Par = { Sort: "", Desc: "" };  // Sort:排序類別，Desc:排序上升或下降 
        var AcctID = { All: [], Del: [] }; // All:當前分頁所有資料，Del:當前分頁欲刪除資料
        var SearchList = [];               // 查詢條件
        var DBStsList = [];                // 啟動終止
        var AllData;
        var Today = CurrentDt();
        var ComeBackDesc = "<%=Desc%>";
        var ComeBackSort = "<%=Sort%>";
        var ComeBackPgNum = "<%=PgNum%>";
        var SearchTemp = "<%=SearchList%>";

        function initialize() {
            $("#body").addClass('Acct');

            SetAcctCatIDSelOpt();

            if ("<%=AcctCatID%>" != "") {
                //從會員層級會員人數連結進入
                var Search = { Column: "", Val: "" }
                Search.Column = "AcctCatID";
                Search.Val = "<%=AcctCatID%>"
                SearchList.push(Search);
                $("#chkboxAcctCatID").prop("checked", true);
                $("#selAcctCatID").val("<%=AcctCatID%>");
            } else {
                if (SearchTemp != "") {
                    var SearchArry = SearchTemp.split(',');
                    $.each(SearchArry, function (Key, Val) {
                        var ValArry = Val.split('&');
                        if (ValArry[1] == "true" && ValArry[2] != "") {

                            if ((ValArry[0] != "AcctCatID" && ValArry[0] != "VIPConfirm") || ((ValArry[0] == "AcctCatID" && ValArry[1] == "true" && ValArry[2] != "0") || (ValArry[0] == "VIPConfirm" && ValArry[1] == "true" && ValArry[2] != "A"))) {

                                var Search = { Column: "", Val: "" }
                                Search.val = ValArry[2];
                                Search.Column = ValArry[0];
                                SearchList.push(Search);
                            }
                            $("#chkbox" + ValArry[0]).prop('checked', true);
                        }
                        if (ValArry[0] == "AcctCatID" || ValArry[0] == "VIPConfirm")
                            $("#sel" + ValArry[0]).val(ValArry[2]);
                        else
                            $("#txt" + ValArry[0]).val(ValArry[2]);
                    })
                }
            }

            GetAcct(DrawTable, ComeBackSort, ComeBackPgNum);
            //GetDropDownAcctCat(SetDropDown);
            CheckBoxSelect(AcctID);
            RegClickEvent();
        }

        //當前日期
        function CurrentDt() {
            debugger;
            var currentDt = new Date();
            var mm = currentDt.getMonth() + 1;
            if (mm.toString().length < 2)
                mm = "0" + mm;
            var dd = currentDt.getDate();
            if (dd.toString().length < 2)
                dd = "0" + dd;
            var yyyy = currentDt.getFullYear();
            var date = yyyy + '/' + mm + '/' + dd;
            return date;
        }

        function RegClickEvent() {

            $("#lbut_Del1,#lbut_Del2").on('click', function (e) {

                if (AcctID.Del.length == 0) {
                    $("#lab_Msg").html("刪除項目　請至少選擇一項!!");
                    return;
                }

                if (AcctID.Del.length > 0 && confirm(" 您確定要刪除所選資料嗎?")) {
                    $.ajax({
                        type: "POST",
                        url: "ugA_Acct.aspx/DelAcctUser",
                        data: JSON.stringify({ "AcctID": AcctID.Del }),
                        contentType: 'application/json; charset=utf-8'
                    }).done(function (res) {
                        var jdata = $.parseJSON(res.d)
                        if (jdata.Redirect != undefined)
                            window.location.href = jdata.Redirect;
                        else {
                            if (jdata.ReturnCode != "0") {
                                $("#lab_Msg").html("刪除完成");
                                if (AcctID.All.length - AcctID.Del.length == 0 && Par.PgNum != 1) //當頁顯示資料全刪除且不能為第1頁
                                    Par.PgNum = Par.PgNum - 1;
                                AcctID.Del.length = 0;                          //刪除紀錄
                                PageListClick(Par.PgNum, Par.Sort);             //按下分頁動作
                            } else
                                $("#lab_Msg").html("刪除失敗");
                        }
                    })
                }
            })

            $("#lbut_DBSts1,#lbut_DBSts2").on('click', function () {

                DBStsList.length = 0;
                $.each(AllData, function (Key, Val) {
                    var jdata = { "AcctID": Val.ACCTID, "DBSts": $("#selDBSts_" + Val.ACCTID).val() }
                    DBStsList.push(jdata);
                })

                $.ajax({
                    type: "POST",
                    url: "ugA_Acct.aspx/UpdateDBSts",
                    data: JSON.stringify({ "DBSts": DBStsList }),
                    contentType: 'application/json; charset=utf-8'
                }).done(function (res) {
                    var jdata = $.parseJSON(res.d)
                    if (jdata.Redirect != undefined)
                        window.location.href = jdata.Redirect;
                    else {
                        if (jdata.ReturnCode == "1") {
                            $("#lab_Msg").html("修改完成");
                            PageListClick(Par.PgNum, Par.Sort);
                        }
                    }
                })
            })

            $("#lbut_Search1,#lbut_Search2").on('click', function () {
                var Msg = "";
                SearchList.length = 0;

                Msg = GetSearch(Msg);

                Par.PgNum = 1;

                if (Msg == "") {
                    $.ajax({
                        type: "POST",
                        url: "ugA_Acct.aspx/GetAcct",
                        data: JSON.stringify({ "Par": Par, "Search": SearchList, "SearchCheck": true }),
                        contentType: 'application/json; charset=utf-8'
                    }).done(function (res) {
                        var jdata = $.parseJSON(res.d)
                        if (jdata.Redirect != undefined)
                            window.location.href = jdata.Redirect;
                        else {
                            var data = $.parseJSON(jdata.AcctData);
                            DrawTable(data, "");
                            if (data.length > 0)
                                DrawPageList(jdata.PgNumCurrent, jdata.PgLimit, jdata.PgTotal, "");  //分頁 (以按下分頁號碼角度看)
                        }
                    })

                } else
                    $("#lab_Msg").html(Msg)
            })

            $("#selAcctCatID").on('change', function () {
                CheckBoxTick('chkboxAcctCatID');
            })

            $("#lbut_CleanSearch1,#lbut_CleanSearch2").on('click', function () {
                $("input[type='checkbox']").prop('checked', false);
                $("#selAcctCatID,#selVIPConfirm").prop('selectedIndex', 0);
                $("#lab_Msg").html("");
            })
        }

        function GetSearch(Msg) {

              //使用Foreach checkbox 元件
              //$("input:checkbox[name='radSType']").each(function () {
              $("input[type='checkbox'][name='radSType']").each(function () {
                    if (this.checked == true) {
                        var id;
                        if (this.id.indexOf("VIPConfirm") != -1 || this.id.indexOf("AcctCatID") != -1)
                            id = this.id.replace("chkbox", "sel")
                        else
                            id = this.id.replace("chkbox", "txt")

                        if ($("#" + id).val() == "") {

                            if (Msg != "")
                                Msg += "<br>";

                            switch (id) {
                                case "txtLoginID":
                                    Msg += "電子郵件 必須輸入資料!!"
                                    break;
                                case "txtAcctName":
                                    Msg += "姓名 必須輸入資料!!"
                                    break;
                                case "txtTel":
                                    Msg += "連絡電話 必須輸入資料!!"
                                    break;
                                case "txtCell":
                                    Msg += "手機 必須輸入資料!!"
                                    break;
                            }
                        } else {
                            if ((this.id.indexOf("AcctCatID") == -1 && this.id.indexOf("VIPConfirm") == -1) || ((this.id.indexOf("AcctCatID") != -1 && $("#selAcctCatID").val() != "0") || (this.id.indexOf("VIPConfirm") != -1 && $("#selVIPConfirm").val() != "A"))) {
                                var Search = { Column: "", Val: "" }
                                Search.Val = $("#" + id).val();
                                id = id.replace("txt", "").replace("sel", "")
                                Search.Column = id;
                                SearchList.push(Search);
                            }
                        }
                    }
            })

            return Msg;
        }

        function GetAcct(callback, Sort, PgNum) {
            var Par = SortChange("AcctCatID", Sort, PgNum, ComeBackDesc)
            $.ajax({
                type: "POST",
                url: "ugA_Acct.aspx/GetAcct",
                data: JSON.stringify({ "Par": Par, "Search": SearchList }),
                contentType: 'application/json; charset=utf-8'
            }).done(function (res) {
                var jdata = $.parseJSON(res.d)
                if (jdata.Redirect != undefined)
                    window.location.href = jdata.Redirect;
                else {
                    var data = $.parseJSON(jdata.AcctData);
                    callback(data, Sort);
                    if (data.length > 0)
                        DrawPageList(jdata.PgNumCurrent, jdata.PgLimit, jdata.PgTotal, Sort);  //分頁 (以按下分頁號碼角度看)
                }
            })
        }

        //function GetDropDownAcctCat(callback) {

        //    $.ajax({
        //        type: "POST",
        //        url: "ugA_AcctCat.aspx/GetAcctCat",
        //        data: JSON.stringify(Par),
        //        contentType: 'application/json;charset=utf-8'
        //    }).done(function (res) {
        //        var jdata = $.parseJSON(res.d);
        //        var data = $.parseJSON(jdata.AcctCateData);
        //        callback(data);
        //    })
        //}

        //function SetDropDown(res) {
        //    var AcctCatID_option = $("#CatName_option").html();
        //    AcctCatID_option = AcctCatID_option.replace("%CatName%", "全部")
        //        .replace("%AcctCatID%", "0");
        //    $("#selAcctCatID").append(AcctCatID_option);
        //    $.each(res, function (Key, Val) {
        //        var AcctCatID_option = $("#CatName_option").html();
        //        AcctCatID_option = AcctCatID_option.replace("%CatName%", Val.CatName)
        //            .replace("%AcctCatID%", Val.AcctCatID);
        //        $("#selAcctCatID").append(AcctCatID_option);
        //    })
        //}

        function UserAddEdit(AcctID) {
            fromActionGo(AcctID, "","<%=AddModifyUrl%>")
        }

        function ExcelExport() {
            fromActionGo("", "Y", "ugA_Acct.aspx")
        }

        function fromActionGo(AcctID, ExcelExport, Url) {
            $("#HideInputList").empty();
            var HideInput = $("#HideInput").html();
            HideInput = HideInput.replace(/\%AcctID%/g, AcctID)
                .replace(/\%Sort%/g, Par.Sort)
                .replace(/\%Desc%/g, Par.Desc)
                .replace(/\%PgNum%/g, Par.PgNum)
                .replace(/\%chkboxAcctCatID%/g, $("#chkboxAcctCatID").prop('checked'))
                .replace(/\%chkboxLoginID%/g, $("#chkboxLoginID").prop('checked'))
                .replace(/\%chkboxAcctName%/g, $("#chkboxAcctName").prop('checked'))
                .replace(/\%chkboxTel%/g, $("#chkboxTel").prop('checked'))
                .replace(/\%chkboxCell%/g, $("#chkboxCell").prop('checked'))
                .replace(/\%chkboxVIPConfirm%/g, $("#chkboxVIPConfirm").prop('checked'))
                .replace(/\%AcctCatID%/g, $("#selAcctCatID").val())
                .replace(/\%LoginID%/g, $("#txtLoginID").val())
                .replace(/\%AcctName%/g, $("#txtAcctName").val())
                .replace(/\%Tel%/g, $("#txtTel").val())
                .replace(/\%Cell%/g, $("#txtCell").val())
                .replace(/\%VIPConfirm%/g, $("#selVIPConfirm").val())
                .replace(/\%ExcelExport%/g, ExcelExport)

            $("#HideInputList").append(HideInput);

            $("#form1").prop('action', Url);
            $("#form1").prop('method', 'post');
                $("#form1").submit();
        }


        //排序
        function DataSort(Sort) {
            Par.SortEnter = true;   //排序切換
            GetAcct(DrawTable, Sort, 1)
        }

        //按下分頁動作
        function PageListClick(PgNum, Sort) {
            Par.SortEnter = false;      //不做排序切換
            GetAcct(DrawTable, Sort, PgNum)
        }

        function DrawTable(res, Sort) {
            AllData = res;
            AcctID.All.length = 0;
            $(".css_PageList").empty();
            $("#Table_List").empty();
            $("#Table_List").append($("#Table_Title").html());
            $.each(res, function (Key, Val) {
                var Table_Data = $("#Table_Data").html();
                Table_Data = Table_Data.replace(/\%LoginID%/g, Val.LOGINID == null ? "" : Val.LOGINID)
                    .replace(/\%AcctName%/g, Val.ACCTNAME == null ? "" : Val.ACCTNAME)
                    .replace(/\%VipCardNum%/g, Val.VIPCARDNUM == null ? "" : Val.VIPCARDNUM)
                    .replace(/\%EndDate%/g, Val.UPSTS == "Y" ? "無期限" : Date.parse(Val.ENDDATE) < Date.parse(Today) ? Val.ENDDATE += "(已到期)" : Val.ENDDATE)
                    .replace(/\%Email%/g, Val.EMAIL == null ? "" : Val.EMAIL)
                    .replace(/\%LoginNum%/g, Val.LOGINNUM == null ? "" : Val.LOGINNUM)
                    .replace(/\%AcctID%/g, Val.ACCTID == null ? "" : Val.ACCTID)
                    .replace(/\%CatName%/g, Val.CATNAME == null ? "" : Val.CATNAME)
                $("#Table_List").append(Table_Data);

                if (Date.parse(Val.ENDDATE) < Date.parse(Today))
                    $("#EndDate_" + Val.ACCTID).addClass("css_GrayTxt");
                else if (Val.UPSTS == "Y")
                    $("#EndDate_" + Val.ACCTID).addClass("css_GreenTxt");

                //設定啟動終止
                if (Val.DBSTS == "A")
                    $("#selDBSts_" + Val.ACCTID + " option[value=A]").attr('selected', 'selected');
                else
                    $("#selDBSts_" + Val.ACCTID + " option[value=D]").attr('selected', 'selected');

                AcctID.All.push(Val.ACCTID);

            })

            //Table 標題文字
            if (Sort == "")
                $("#AcctCatID").text($("#AcctCatID").text() + "↑"); //第一次Page_load之後
            else
                $("#" + Sort).text($("#" + Sort).text() + (Par.Desc == "N" ? "↑" : "↓"));

            PagePermission(res);

        }

        function CheckBoxTick(name) {
            $("#" + name).prop('checked', true);
        }

        function PagePermission(res) {

            if (res.length == 0) {
                $("#lbut_Excel1,#lbut_Excel2").css('display', 'none')
                $("#lbut_DBSts1,#lbut_DBSts2").css('display', 'none')
                $("#lbut_Del1,#lbut_Del1").css('display', 'none')
                $("#Panel_Del").css('display', 'none');
                $("#Panel_Num").css('display', 'none');
            } else {
                $("#lbut_Excel1,#lbut_Excel2").show();
                $("#lbut_DBSts1,#lbut_DBSts2").show();
                $("#lbut_Del1,#lbut_Del1").show();
                $("#Panel_Del").show();
                $("#Panel_Num").show();
            }

        }

        function MouseOut(e) {
            if (e.rowIndex % 2 == 0)
                return 'even';
            else
                return 'odd';
        }

        function DeleteCheck(e, id) {
            ArrayPushSplice(e, id, AcctID);
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
                            <div id="lbut_Add1" onclick="UserAddEdit('')" class="FnBu_icon_add ControlBut">新增</div>
                            <div id="lbut_Excel1" onclick="ExcelExport()" class="FnBu_icon_change ControlBut">轉成Excel</div>
                            <div id="lbut_Search1" class="FnBu_icon_search ControlBut">查詢</div>
                            <div id="lbut_CleanSearch1" class="FnBu_icon_cleanSearch ControlBut">清除查詢</div>
                            <div id="lbut_DBSts1" class="FnBu_icon_startAndEnd ControlBut">啟動<span style="font-family: '新細明體'">/</span>終止</div>
                            <div id="lbut_Del1" class="FnBu_icon_delete ControlBut">刪除</div>
                        </div>
                        <!-- ---------- 功能項 End  ---------- -->

                        <!-- ---------- 下拉選單 Start---------- -->
                        <div class="menuWrapper">
                            <div class="menuLeft">

                                <input type="checkbox" name="radSType" id="chkboxAcctCatID" value="C"><span>會員等級：</span>
                                <uc1:ug_AcctCatID runat="server" FirstIndex="全部" ID="ug_AcctCatID" />
                                <%--                            <select name="selAcctCatID" id="selAcctCatID" onchange="CheckBoxTick('chkboxAcctCatID')">
                                </select>--%>
                            </div>
                            <div class="menuRight">
                                <input type="checkbox" name="radSType" id="chkboxLoginID" value="P" onclick=""><span>電子郵件：</span>
                                <input type="text" name="txtLoginID" id="txtLoginID" value="" size="16" maxlength="255" onclick="CheckBoxTick('chkboxLoginID')">
                            </div>
                            <div class="menuLeft">
                                <input type="checkbox" name="radSType" id="chkboxAcctName" value="N" onclick=""><span>姓名：</span>
                                <input type="text" name="txtAcctName" id="txtAcctName" value="" size="16" maxlength="32" onclick="CheckBoxTick('chkboxAcctName')">
                            </div>
                            <div class="menuRight">
                                <input type="checkbox" name="radSType" id="chkboxTel" value="T" onclick=""><span>聯絡電話：</span>
                                <input type="text" name="txtTel" id="txtTel" value="" size="26" maxlength="26" onclick="CheckBoxTick('chkboxTel')">
                            </div>
                            <div class="menuLeft">
                                <input type="checkbox" name="radSType" id="chkboxCell" value="M" onclick=""><span>手機：</span>
                                <input type="text" name="txtCell" id="txtCell" value="" size="26" maxlength="12" onclick="CheckBoxTick('chkboxCell')">
                            </div>
                            <div class="menuRight">
                                <input type="checkbox" name="radSType" id="chkboxVIPConfirm" value="Vip"><span>門市會員：</span>
                                <select name="selVIPConfirm" id="selVIPConfirm" onchange="CheckBoxTick('chkboxVIPConfirm')">
                                    <option value="A">全部</option>
                                    <option value="N">待確認</option>
                                    <option value="Y">已確認</option>
                                </select>
                            </div>
                        </div>
                        <!-- ---------- 下拉選單 End---------- -->

                        <!-- ---------- 列表開始 Start---------- -->
                        <uc1:ugA_Pagination runat="server" PageSize="5" ID="ugA_Pagination1" />
                        <table style="width: 100%; border: 0; padding: 0; border-spacing: 0; text-align: center" class="tbStyle01">
                            <tbody id="Table_List"></tbody>
                        </table>
                        <uc1:ugA_Pagination runat="server" />
                        <!-- ---------- 列表結束 End  ---------- -->

                        <!-- ---------- 功能項 Start---------- -->
                        <div class="FnBu_wrapper">
                            <div id="lbut_Add2" onclick="UserAddEdit('')" class="FnBu_icon_add ControlBut">新增</div>
                            <div id="lbut_Excel2" onclick="ExcelExport()" class="FnBu_icon_change ControlBut">轉成Excel</div>
                            <div id="lbut_Search2" class="FnBu_icon_search ControlBut">查詢</div>
                            <div id="lbut_CleanSearch2" class="FnBu_icon_cleanSearch ControlBut">清除查詢</div>
                            <div id="lbut_DBSts2" class="FnBu_icon_startAndEnd ControlBut">啟動<span style="font-family: '新細明體'">/</span>終止</div>
                            <div id="lbut_Del2" class="FnBu_icon_delete ControlBut">刪除</div>
                        </div>
                        <!-- ---------- 功能項 End  ---------- -->

                    </td>
                </tr>
            </tbody>
        </table>
        <table id="jqGrid"></table>
    </div>
    <!--right END-->

    <%--====================================== Component ================================================--%>

    <script type="text/template" id="Table_Title">
        <tr>
            <th class="w-150 m768-hide">
                <div><a id="AcctCatID" href="javascript:DataSort('AcctCatID');" title="依會員等級排序">會員等級</a></div>
            </th>
            <th>
                <div><a id="LoginID" href="javascript:DataSort('LoginID');" title="依電子郵件排序">電子郵件</a></div>
            </th>
            <th class="w-200 m768-hide">
                <div><a id="AcctName" href="javascript:DataSort('AcctName');" title="依姓名排序">姓名</a></div>
            </th>
            <th class="w-120 m768-hide m1200-hide">
                <div><a id="VipCardNum" href="javascript:DataSort('VipCardNum');" title="依門市會員卡號排序">門市會員卡號</a></div>
            </th>
            <th class="date m768-hide">
                <div><a id="EndDate" href="javascript:DataSort('EndDate');" title="依使用期限排序">使用期限</a></div>
            </th>
            <th class="detail-80 m768-hide">
                <div><a id="Email" href="javascript:DataSort('Email');" title="依電子郵件排序">電子郵件</a></div>
            </th>
            <th class="click-num m768-hide m1200-hide">
                <div><a id="LoginNum" href="javascript:DataSort('LoginNum');" title="依登錄次數排序">登錄次數</a></div>
            </th>
            <th class="edit">
                <div>修改</div>
            </th>
            <th class="dbsts">
                <div><a id="DBSts" href="javascript:DataSort('DBSts');" title="依啟動/終止排序">啟動/終止</a></div>
            </th>
            <th class="del">
                <div>刪除</div>
            </th>
        </tr>
    </script>

    <script type="text/template" id="Table_Data">
        <tr class="odd" onmouseover="this.className='Title_over'" onmouseout="this.className='odd'">
            <td align="left">%CatName%</td>
            <td align="left">%LoginID%</td>
            <td align="left" class="m768-hide">%AcctName%</td>
            <td align="left" class="m768-hide m1200-hide">%VipCardNum%</td>
            <td align="center" class="m768-hide"><span id="EndDate_%AcctID%" class="">%EndDate%<br>
                <span style="font-size: 7pt"></span></span></td>
            <td align="center" class="m768-hide"><a href="mailto:%Email%">
                <img src="../Images/Icon_Email.gif" border="0" alt="%Email%"></a></td>
            <td align="center" class="m768-hide m1200-hide">%LoginNum%</td>
            <td align="center"><a href="javascript:UserAddEdit('%AcctID%');">
                <img src="../Images/Icon_Modify.gif" border="0" alt="修改"></a></td>
            <td align="center">
                <select id="selDBSts_%AcctID%">
                    <option value="A" class="css_RedTxt">啟動</option>
                    <option value="D" class="css_GreenTxt">終止</option>
                </select>
            </td>
            <td align="center">
                <input type="checkbox" id="chkDelete_%AcctID%" onchange="DeleteCheck(this,%AcctID%)" name="chkDelete">
            </td>
        </tr>
    </script>

    <script type="text/template" id="HideInput">
        <input type="hidden" name='chkboxAcctCatID' value='%chkboxAcctCatID%' />
        <input type="hidden" name='chkboxLoginID' value='%chkboxLoginID%' />
        <input type="hidden" name='chkboxAcctName' value='%chkboxAcctName%' />
        <input type="hidden" name='chkboxTel' value='%chkboxTel%' />
        <input type="hidden" name='chkboxCell' value='%chkboxCell%' />
        <input type="hidden" name='chkboxVIPConfirm' value='%chkboxVIPConfirm%' />

        <input type="hidden" name='AcctCatID' value='%AcctCatID%' />
        <input type="hidden" name='LoginID' value='%LoginID%' />
        <input type="hidden" name='AcctName' value='%AcctName%' />
        <input type="hidden" name='Tel' value='%Tel%' />
        <input type="hidden" name='Cell' value='%Cell%' />
        <input type="hidden" name='VIPConfirm' value='%VIPConfirm%' />
        <input type="hidden" name='AcctID' value='%AcctID%' />

        <input type="hidden" name='ExcelExport' value='%ExcelExport%' />
        <%--匯出Excel--%>
        <input type="hidden" name='Sort' value='%Sort%' />
        <%--欄位排序--%>
        <input type="hidden" name='Desc' value='%Desc%' />
        <%--順向逆向--%>
        <input type="hidden" name='PgNum' value='%PgNum%' />
        <%--紀錄分頁--%>
    </script>
    --%>


</asp:Content>
