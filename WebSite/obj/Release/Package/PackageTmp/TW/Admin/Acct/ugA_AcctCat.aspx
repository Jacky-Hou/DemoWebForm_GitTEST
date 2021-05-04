<%@ Page Language="C#" MasterPageFile="~/TW/Admin/Inc/Basic.Master" AutoEventWireup="true" CodeBehind="ugA_AcctCat.aspx.cs" Inherits="WebSite.TW.Admin.Acct.ugA_AcctCat" %>

<%@ Register Src="~/TW/Admin/Acct/ugA_incLeft.ascx" TagPrefix="uc1" TagName="ugA_incLeft" %>
<%@ Register Src="~/TW/Admin/Inc/ugA_MsgBox.ascx" TagPrefix="uc1" TagName="ugA_MsgBox" %>
<%@ Register Src="~/TW/Admin/Inc/ugA_Pagination.ascx" TagPrefix="uc1" TagName="ugA_Pagination" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        var AcctCatID = { All: [], Del: [] };   // All:當前分頁所有資料，Del:當前分頁欲刪除資料

        function initialize() {
            GetAcctCat(DrawTable)
            CheckBoxSelect(AcctCatID);
            RegClickEvent();
        }

        function RegClickEvent() {

            $("#lbut_Del1,#lbut_Del2").on('click', function (e) {

                if (AcctCatID.Del.length == 0) {
                    $("#lab_Msg").html("刪除項目　請至少選擇一項!!");
                    return;
                }
                if (AcctCatID.Del.length > 0 && confirm(" 您確定要刪除所選資料嗎?")) {
                    $.ajax({
                        type: "POST",
                        url: "ugA_AcctCat.aspx/DelAcctCat",
                        data: JSON.stringify({ "AcctCatID": AcctCatID.Del }),
                        contentType: 'application/json; charset=utf-8'
                    }).done(function (res) {
                        var jdata = $.parseJSON(res.d)
                        if (jdata.Redirect != undefined)
                            window.location.href = jdata.Redirect;
                        else {
                            if (jdata.ReturnCode != "0") {
                                $("#lab_Msg").html("刪除完成");
                                ReloadGetAcctCat();
                            } else
                                $("#lab_Msg").html("刪除失敗");
                        }
                    })
                }
            })
        }

        function ReloadGetAcctCat() {
            $(".css_PageList").empty();
            $("#Table_List").empty();
            GetAcctCat(DrawTable)
        }

        function DeleteCheck(e, id) {
            ArrayPushSplice(e, id, AcctCatID);
        }

        function GetAcctCat(callback) {
            $.ajax({
                type: "POST",
                url: "ugA_AcctCat.aspx/GetAcctCat",
                contentType: 'application/json;charset=utf-8'
            }).done(function (res) {
                var jdata = $.parseJSON(res.d);
                var data = $.parseJSON(jdata.AcctCateData);
                callback(data);
            })
        }

        function DrawTable(res) {
            $("#Table_List").append($("#Table_Title").html());
            $.each(res, function (Key, Val) {
                var Table_Data = $("#Table_Data").html();
                Table_Data = Table_Data.replace(/\%CatCode%/g, Val.CatCode)
                    .replace(/\%AcctCatID%/g, Val.AcctCatID)
                    .replace(/\%CatName%/g, Val.CatName)
                    .replace(/\%DueDate%/g, Val.UpSts == "Y" ? "無限期" : Val.DueDate + DateConverCN(Val.DueDateSts))
                    .replace(/\%Count%/g, Val.Count == null ? 0 : Val.Count);
                $("#Table_List").append(Table_Data);

                if (Val.AcctCatID == 1) {
                    $("#DueDate_" + Val.AcctCatID).css('color', "#FF0000");
                    var SpanCatName = $("#SpanCatName").html();
                    $("#CatName_" + Val.AcctCatID).append(SpanCatName);
                }
                else
                    $("#DueDate_" + Val.AcctCatID).css('color', "#006600");

                AcctCatID.All.push(Val.AcctCatID);
            })

            PagePermission();
        }

        function DateConverCN(Date) {
            var CNdate = "";
            switch (Date) {
                case "yyyy":
                    CNdate = "(年)";
                    break;
                case "m":
                    CNdate = "(月)";
                    break;
                case "d":
                    CNdate = "(日)";
                    break;
            }
            return CNdate;
        }

        function UserAddEdit(AcctCatID) {
            fromActionGo(AcctCatID,"<%=AddModifyUrl%>")
        }

        function GoToAcct(AcctCatID) {
            fromActionGo(AcctCatID,"<%=GoToAcctUrl%>")
        }

        function fromActionGo(AcctCatID, Url) {
            $("#HideInputList").empty();
            var HideInput = $("#HideInput").html();
            HideInput = HideInput.replace(/\%AcctCatID%/g, AcctCatID)
            $("#HideInputList").append(HideInput);

            $("#form1").prop('action', Url);
            $("#form1").prop('method', 'post');
            $("#form1").submit();
        }

        function MouseOut(e) {
            if (e.rowIndex % 2 == 0)
                return 'even';
            else
                return 'odd';
        }

        function PagePermission() {

            if ("<%=Type_All%>" == "Y") {
                $("#LookModify").text("修改");
                $(".X_String").css('display', 'none');
            } else {
                if ("<%=Type_Update%>" == "Y")
                    $("#LookModify").text("修改");
                else if ("<%=Type_Update%>" != "Y" && "<%=Type_Look%>" == "Y")
                    $("#LookModify").text("瀏覽");

                if ("<%=Type_Add%>" != "Y") {
                    $("#lbut_Add1,#lbut_Add2").css('display', 'none');
                }
                if ("<%=Type_Update%>" != "Y") {    //沒有修改權限
                    //$("#lbut_DBSts1,#lbut_DBSts2").css('display', 'none')
                    $(".dbsts").css('display', 'none');
                }
                if ("<%=Type_Del%>" != "Y") {       //沒有刪除權限
                    $("#lbut_Del1,#lbut_Del2").css('display', 'none')
                    $(".del").css('display', 'none');
                } else {
                    $(".X_String").css('display', 'none');
                }

            }

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
                        <uc1:ugA_MsgBox runat="server" ID="ugA_MsgBox" Status="瀏覽" Location="會員等級" />
                        <div id="HideInputList">
                        </div>

                        <!-- ---------- 功能項 Start---------- -->
                        <div class="FnBu_wrapper">
                            <div id="lbut_Add1" onclick="UserAddEdit('')" class="FnBu_icon_add ControlBut">新增</div>
                            <div id="lbut_Del1" class="FnBu_icon_delete ControlBut">刪除</div>
                        </div>
                        <!-- ---------- 功能項 End  ---------- -->

                        <!-- ---------- 列表開始 Start---------- -->
                        <uc1:ugA_Pagination runat="server" ID="ugA_Pagination" />
                        <table style="width: 100%; border: 0; padding: 0; border-spacing: 0; text-align: center" class="tbStyle01">
                            <tbody id="Table_List"></tbody>
                        </table>
                        <uc1:ugA_Pagination runat="server" />
                        <!-- ---------- 列表結束 End  ---------- -->

                        <!-- ---------- 功能項 Start---------- -->
                        <div class="FnBu_wrapper">
                            <div id="lbut_Add2" onclick="UserAddEdit('')" class="FnBu_icon_add ControlBut">新增</div>
                            <div id="lbut_Del2" class="FnBu_icon_delete ControlBut">刪除</div>
                        </div>
                        <!-- ---------- 功能項 End  ---------- -->
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <!--right END-->

    <%--====================================== Component ================================================--%>

    <%--Table 標題--%>
    <script type="text/template" id="Table_Title">
        <tr>
            <th width="15%" id="Bgn" class="m768-hide">
                <div><a href="javascript:DataSort();" title="依編號排序">編號</a></div>
            </th>
            <th>
                <div><a href="javascript:DataSort();" title="依等級名稱排序">等級名稱</a></div>
            </th>
            <th class="w-150 m768-hide">
                <div>預設使用期限</div>
            </th>
            <th class="edit">
                <div>修改</div>
            </th>
            <th class="detail-80">
                <div>會員資料</div>
            </th>
            <th class="del">
                <div>刪除</div>
            </th>
        </tr>
    </script>

    <script type="text/template" id="Table_Data">
        <tr onmouseover="this.className='Title_over'" onmouseout="this.className=MouseOut(this)">
            <td align="center" class="m768-hide">%CatCode%</td>
            <td align="left" id="CatName_%AcctCatID%">%CatName%</td>
            <td align="center" class="m768-hide">
                <span id="DueDate_%AcctCatID%">%DueDate%</span>
            </td>
            <td><a href="javascript:UserAddEdit('%AcctCatID%');">
                <img src="../Images/Icon_Modify.gif" border="0" alt="修改">
            </a>
            </td>
            <td>
                <a href="javascript:GoToAcct('%AcctCatID%')">(%Count%)</a>
            </td>
            <td class="del">
                <input id="chkDelete_%AcctCatID%" onchange="DeleteCheck(this,%AcctCatID%)" type="checkbox" /><span class="css_RedTxt X_String">X</span>
            </td>

        </tr>
    </script>

    <script type="text/template" id="HideInput">
        <input type="hidden" name='AcctCatID' value='%AcctCatID%' />
    </script>

    <script type="text/html" id="SpanCatName">
        <span class="css_RedTxt">&nbsp;(前台加入會員，將會使用此預設期限)</span>
    </script>

</asp:Content>


