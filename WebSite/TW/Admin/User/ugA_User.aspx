<%@ Page Language="C#" MasterPageFile="~/TW/Admin/Inc/Basic.Master" AutoEventWireup="true" CodeBehind="ugA_User.aspx.cs" Inherits="WebSite.TW.Admin.User.ugA_User" %>

<%@ Register Src="~/TW/Admin/User/ugA_incLeft.ascx" TagPrefix="uc1" TagName="ugA_incLeft" %>
<%@ Register Src="~/TW/Admin/Inc/ugA_MsgBox.ascx" TagPrefix="uc1" TagName="ugA_MsgBox" %>
<%@ Register Src="~/TW/Admin/Inc/ugA_Pagination.ascx" TagPrefix="uc1" TagName="ugA_Pagination" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        var Par = { Sort: "", Desc: "" };     // Sort:排序類別，Desc:排序上升或下降 
        var UserID = { All: [], Del: [] };    // All:當前分頁所有資料，Del:當前分頁欲刪除資料
        var DBStsList = [];                   // 啟動終止
        var AllData;
        var ComeBackDesc = "<%=Desc%>";
        var ComeBackSort = "<%=Sort%>";
        var ComeBackPgNum = "<%=PgNum%>";

        function initialize() {
            GetMenuUser(DrawTable, ComeBackSort, ComeBackPgNum);  //callback
            CheckBoxSelect(UserID); //在取得當頁資料之後
            RegClickEvent();    //click event
        };

        function RegClickEvent() {

            $("#lbut_Del1,#lbut_Del2").on('click', function (e) {

                if (UserID.Del.length == 0) {
                    $("#lab_Msg").html("刪除項目　請至少選擇一項!!");
                    return;
                }
                if (UserID.Del.length > 0 && confirm(" 您確定要刪除所選資料嗎?")) {
                    //e.preventDefault(); //disable isPostback or Submit //Master元件的 <asp:Content ContentPlaceHolderID run="Server" 的元素關係 Click 會Page_load isPostBack
                    $.ajax({
                        type: "POST",
                        url: "ugA_User.aspx/DelMenuUser",
                        data: JSON.stringify({ "UserID": UserID.Del }),
                        contentType: 'application/json; charset=utf-8'
                    }).done(function (res) {
                        var jdata = $.parseJSON(res.d)
                        if (jdata.Redirect != undefined)
                            window.location.href = jdata.Redirect;
                        else {
                            if (jdata.ReturnCode != "0") {
                                $("#lab_Msg").html("刪除完成");
                                if (UserID.All.length - UserID.Del.length == 0 && Par.PgNum != 1) //當頁顯示資料全刪除且不能為第1頁
                                    Par.PgNum = Par.PgNum - 1;
                                UserID.Del.length = 0;                          //刪除紀錄
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
                    var jdata = { "UserID": Val.UserID, "DBSts": $("#selDBSts_" + Val.UserID).val() }
                    DBStsList.push(jdata);
                })

                $.ajax({
                    type: "POST",
                    url: "ugA_User.aspx/UpdateDBSts",
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
        }

        //取MenuUser資料
        function GetMenuUser(callback, Sort, PgNum) {  //callback => DrawTable函式
            //第一個欄位,排序,第幾個分頁,外部頁面返回Dese紀錄
            var Par = SortChange("LoginID", Sort, PgNum, ComeBackDesc)

            $.ajax({
                type: "POST",
                url: "ugA_User.aspx/GetMenuUser",
                data: JSON.stringify(Par),
                dataType: "Json",
                contentType: 'application/json; charset=utf-8'
            }).done(function (res) {
                var jdata = $.parseJSON(res.d)
                if (jdata.Redirect != undefined)
                    window.location.href = jdata.Redirect;
                else {
                    var data = $.parseJSON(jdata.MenuUserData)
                    callback(data, Sort);
                    if (data.length > 0)
                        DrawPageList(jdata.PgNumCurrent, jdata.PgLimit, jdata.PgTotal, Sort);  //分頁 (以按下分頁號碼角度看)
                }
            }
            )
        }

        //排序
        function DataSort(Sort) {
            Par.SortEnter = true;   //排序切換
            $(".css_PageList").empty();
            $("#Table_List").empty();
            GetMenuUser(DrawTable, Sort, 1)
        }

        //按下分頁動作
        function PageListClick(PgNum, Sort) {
            Par.SortEnter = false;      //不做排序切換
            $(".css_PageList").empty();
            $("#Table_List").empty();
            GetMenuUser(DrawTable, Sort, PgNum)
        }

        //畫Table
        function DrawTable(res, Sort) {

            //只有第一次Table加入標題
            //if (Par.Sort == "")
            //    $("#Table_List").append($("#Table_Title").html());

            AllData = res;
            UserID.All.length = 0;
            $("#Table_List").append($("#Table_Title").html());
            $.each(res, function (Key, Val) {
                //加入Table START
                var Table_data = $("#Table_Data").html();
                Table_data = Table_data.replace(/\%ID%/g, Val.UserID)
                    .replace(/\%LoginID%/g, Val.LoginID).replace(/\%UserName%/g, Val.UserName)
                    .replace(/\%HighUser%/g, Val.HighUser == "Y" ? "最高權限" : "一般權限")

                $("#Table_List").append(Table_data);
                //加入Table END

                //判斷是否為第一個帳號
                if (Val.UserID == 1)
                    $("#chkDelete_" + Val.UserID).css('display', 'none')
                else
                    $("#X_" + Val.UserID).css('display', 'none')

                //權限顏色
                if (Val.HighUser == "Y")
                    $("#HighUser_" + Val.UserID).addClass("css_RedTxt")
                else
                    $("#HighUser_" + Val.UserID).addClass("css_GreenTxt")

                //設定啟動終止
                if (Val.DBSts == "A")
                    $("#selDBSts_" + Val.UserID + " option[value=A]").attr('selected', 'selected');
                else
                    $("#selDBSts_" + Val.UserID + " option[value=D]").attr('selected', 'selected');

                $("#Table_List tr:odd").addClass("odd");               //奇
                $("#Table_List tr:even:not(:first)").addClass("even"); //偶 跳一

                //紀錄 admin account not Add
                if (Val.UserID != 1)
                    UserID.All.push(Val.UserID);
            });

            //Table 標題文字
            if (Sort == "")
                $("#LoginID").text($("#LoginID").text() + "↑"); //第一次Page_load之後
            else
                $("#" + Sort).text($("#" + Sort).text() + (Par.Desc == "N" ? "↑" : "↓"));

            PagePermission();

        }

        //勾選，勾選取消
        function DeleteCheck(e, id) {
            ArrayPushSplice(e, id, UserID);
        }


        function PagePermission() {

            if ("<%=Type_All%>" == "Y") {
                $("#LookModify").text("修改");
            } else {

                if ("<%=Type_Update%>" == "Y")
                    $("#LookModify").text("修改");
                else if ("<%=Type_Update%>" != "Y" && "<%=Type_Look%>" == "Y")
                    $("#LookModify").text("瀏覽");

                if ("<%=Type_Add%>" != "Y") {
                    $("#lbut_Add1,#lbut_Add2").css('display', 'none');
                }
                if ("<%=Type_Update%>" != "Y") {    //沒有修改權限
                    $("#lbut_DBSts1,#lbut_DBSts2").css('display', 'none')
                    $(".dbsts").css('display', 'none');
                }
                if ("<%=Type_Del%>" != "Y") {       //沒有刪除權限
                    $("#lbut_Del1,#lbut_Del2").css('display', 'none')
                    $(".del").css('display', 'none');
                }

            }

        }

        function MouseOut(e) {
            if (e.rowIndex % 2 == 0)
                return 'even';
            else
                return 'odd';
        }

        //新增_修改
        function UserAddEdit(UserID) {
            $("#HideInputList").empty();
            var HideInput = $("#HideInput").html();
            HideInput = HideInput.replace(/\%UserID%/g, UserID)
                .replace(/\%Sort%/g, Par.Sort)
                .replace(/\%Desc%/g, Par.Desc)
                .replace(/\%PgNum%/g, Par.PgNum);
            $("#HideInputList").append(HideInput);

            $("#form1").prop('action', "<%=AddModifyUrl%>");
            $("#form1").prop('method', 'post');
            $("#form1").submit();
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
                        <uc1:ugA_MsgBox runat="server" ID="ugA_MsgBox" Status="瀏覽" Location="權限修改" />

                        <div id="HideInputList">
                        </div>

                        <!-- ---------- 功能項 Start---------- -->
                        <div class="FnBu_wrapper">
                            <div id="lbut_Add1" onclick="UserAddEdit('')" class="FnBu_icon_add ControlBut">新增</div>
                            <div id="lbut_DBSts1" class="FnBu_icon_startAndEnd ControlBut">啟動<span style="font-family: '新細明體'">/</span>終止</div>
                            <div id="lbut_Del1" class="FnBu_icon_delete ControlBut">刪除</div>
                        </div>
                        <!-- ---------- 功能項 End  ---------- -->

                        <!-- ---------- 列表開始 Start---------- -->
                        <uc1:ugA_Pagination runat="server" PageSize="3" ID="ugA_Pagination1" />
                        <table style="width: 100%; border: 0; padding: 0; border-spacing: 0; text-align: center" class="tbStyle01">
                            <tbody id="Table_List">
                            </tbody>
                        </table>
                        <uc1:ugA_Pagination runat="server" />
                        <!-- ---------- 列表結束 End  ---------- -->

                        <!-- ---------- 功能項 Start---------- -->
                        <div class="FnBu_wrapper">
                            <div id="lbut_Add2" onclick="UserAddEdit('')" class="FnBu_icon_add ControlBut">新增</div>
                            <div id="lbut_DBSts2" class="FnBu_icon_startAndEnd ControlBut">啟動<span style="font-family: '新細明體'">/</span>終止</div>
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
            <th>
                <div><a id="LoginID" href="javascript:DataSort('LoginID')" title="登入帳號">登入帳號</a></div>
            </th>
            <th class="m768-hide">
                <div><a id="UserName" href="javascript:DataSort('UserName')" title="姓名">姓名</a></div>
            </th>
            <th class="m768-hide w-100">
                <div><a id="HighUser" href="javascript:DataSort('HighUser')" title="權限">權限</a></div>
            </th>
            <th class="edit">
                <div><a id="LookModify">%LookModify%</a></div>
            </th>
            <th class="dbsts">
                <div><a id="DBSts" href="javascript:DataSort('DBSts')" title="啟動/終止">啟動/終止</a></div>
            </th>
            <th class="del">
                <div>刪除</div>
            </th>
        </tr>
    </script>
    <%--Table 標題--%>

    <%--Table 資料--%>
    <script type="text/template" id="Table_Data">
        <tr id="Table_Data_Content" onmouseover="this.className='Title_over'" onmouseout="this.className=MouseOut(this)">
            <td id="LoginID_%ID%" align="left">%LoginID%</td>
            <td align="left" class="m768-hide">%UserName%</td>
            <td class="m768-hide"><span id="HighUser_%ID%">%HighUser%</span></td>
            <td class="edit">
                <%--                                <a href="../User/<%=UgAUserM%>?ID=%ID%">--%>
                <a href="javascript:UserAddEdit('%ID%')">
                    <img src="../Images/Icon_Modify.gif" border="0" alt="修改"></a>
            </td>
            <td class="dbsts">
                <select id="selDBSts_%ID%">
                    <option value="A">啟動</option>
                    <option value="D">終止</option>
                </select>
            </td>
            <td class="del">
                <input id="chkDelete_%ID%" onchange="DeleteCheck(this,%ID%)" type="checkbox" /><span id="X_%ID%" class="css_RedTxt">X</span>
            </td>
        </tr>
    </script>

    <script type="text/template" id="HideInput">
        <input type="hidden" name='UserID' value='%UserID%' />
        <input type="hidden" name='Sort' value='%Sort%' />
        <%--欄位排序--%>
        <input type="hidden" name='Desc' value='%Desc%' />
        <%--順向逆向--%>
        <input type="hidden" name='PgNum' value='%PgNum%' />
        <%--紀錄分頁--%>
    </script>

</asp:Content>


