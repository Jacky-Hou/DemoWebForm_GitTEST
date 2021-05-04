<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step1.aspx.cs" Inherits="WebSite.Jquery.Step1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <%--<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>

    <link href="../JS/jquery.ui/jquery-ui.css" rel="stylesheet" />
    <script src="../JS/jquery.ui/jquery-1.12.4.js"></script>
    <script src="../JS/jquery.ui/jquery-ui.min.js"></script>

    <script>
        var JsonArray = [];
        var WorkNameTags = [];
        var HazardNameTage = [];
        var WorkList;

        $(function () {

            WorkList = "<%=WorkList%>".split(',');

            WorkList.forEach(function (key) {
                WorkNameTags.push(key.split('&')[1]);
                JsonArray.push({ "ID": key.split('&')[0], "Name": key.split('&')[1] });
            })


<%--        WorkNameTags = "<%=WorkList%>".split(',')--%>
            //var WorkNameTags = [
            //    "ActionScript",
            //    "AppleScript",
            //    "Asp",
            //    "BASIC",
            //    "C",
            //    "C++",
            //    "Clojure",
            //    "COBOL",
            //    "ColdFusion",
            //    "Erlang",
            //    "Fortran",
            //    "Groovy",
            //    "Haskell",
            //    "Java",
            //    "JavaScript",
            //    "Lisp",
            //    "Perl",
            //    "PHP",
            //    "Python",
            //    "Ruby",
            //    "Scala",
            //    "Scheme"
            //];

            $("#inp_work").autocomplete({
                source: WorkNameTags,
                minLength: 0,
                select: function (event, ui) {
                    var Name = ui.item.value;
                    JsonArray.find(function (item, i) {
                        if (item.Name == Name) {
                            Name = "";
                            $.ajax({
                                type: "POST",
                                url: "JqueryAutoComple.aspx/GetHazardName",
                                data: { "WorkProjectsID": item.ID }
                                //contentType: 'application/json; charset=utf-8'
                            }).done(function (res) {
                                HazardNameTage = res.split(',');
                                $("#inp_Hazard").autocomplete({
                                    source: HazardNameTage,
                                    minLength: 0,
                                    select: function (event, ui2) {
                                        $("#inp_Hazard").attr('size', ui2.item.value.length * 5);
                                    }
                                }).focus(function () {
                                    $(this).autocomplete('search', $(this).val())
                                });
                            });
                        }
                    })
                }
            }).focus(function () {
                //搜尋全部
                $(this).autocomplete('search', $(this).val())
            });


            $("#inp_work").val("<%=work%>");
            $("#inp_Hazard").val("<%=Hazard%>");

        });

        //function btn_Work_Click() {

        //    //$("#div_Tool").show();
        //    $("#div_OA").show();
        //    $("#div_PHA").show();
        //    $("#div_WIT").show();
        //    $("#div_SP").show();
        //    $("#div_LD").show();
        //    $("#div_CHANGE").show();
        //    $("#div_CE").show();
        //}

        //function sel_Tool_Change() {

        //    $("#div_OA").hide();
        //    $("#div_PHA").hide();
        //    $("#div_WIT").hide();
        //    $("#div_SP").hide();
        //    $("#div_LD").hide();
        //    $("#div_CHANGE").hide();
        //    $("#div_CE").hide();

        //    var sel = $("#sel_Tool option:selected").val();
        //    $("#div_" + sel).show();
        //}

        var datas = {};
        function AddDataGridView(id, Show) {

            var ID = id.split('_')[1];

            if ($("#inp_work").val() == "") {
                alert("工作項目不得為空!!");
                return;
            }

            if ($("#inp_Hazard").val() == "" && ID == "Hazard") {
                alert("危險項目不可為空!!");
                return;
            }

            if ($("#inp_WIT").val() == "" && ID == "WIT") {
                alert("假設狀況法不可為空!!");
                return;
            }

            if (($("#inp_SP_Title").val() == "" || $("#inp_SP_Content").val() == "") && ID == "SP") {
                alert("情境或情境描述不可為空!!");
                return;
            }

            var Del = "<input id='Del_" + id + "' type='button' onclick='Del(this.id)' value='刪除'>"

            var value = "";
            var GridRow = "";
            if (Show == "導因歸類") {
                value += "[危險項目] " + $("#Hazard").val() + " [" + Show + "]";
                if ($("#chk_Man").is(":checked"))
                    value += " 人員:" + $("#sel_Man").val();
                if ($("#chk_Machine").is(":checked"))
                    value += " 機械:" + $("#sel_Machine").val();
                if ($("#chk_Milieu").is(":checked"))
                    value += " 環境:" + $("#sel_Milieu").val();
                if ($("#chk_Manage").is(":checked"))
                    value += " 管理:" + $("#sel_Manage").val();
                if ($("#chk_Task").is(":checked"))
                    value += " 任務:" + $("#sel_Task").val();

                GridRow = "<tr><td>" + $("#inp_work").val() + "</td><td>" + value + "</td><td>" + Del + "</td></tr>";

            } else if (Show == "情境程序") {
                value = "[情境] " + $("#inp_" + ID + "_Title").val() + " [情境描述] " + $("#inp_" + ID + "_Content").val();
                GridRow = "<tr><td>" + $("#inp_work").val() + "</td><td>" + value + "</td><td>" + Del + "</td></tr>";
            }
            else {
                value = $("#inp_" + ID).val();
                GridRow = "<tr><td>" + $("#inp_work").val() + "</td><td>" + "[" + Show + "] " + value + "</td><td>" + Del + "</td></tr>";
            }

            //var GridRow = "<tr><td>" + $("#work").val() + "</td><td>" + "[" + Show + "] " + value + "</td></tr>";
            $("#ThisDataGrid").append(GridRow);

            //$.ajax({
            //    type: "POST",
            //    url: "Step1.aspx",
            //    data: datas
            //    //contentType: 'application/json; charset=utf-8'
            //}).done(function (res) {
            //    if (res == "OK")
            //        alert(show + "新增完成");
            //})
        }


        //function btn_OA_Click() {
        //    if ($("#inp_OA").val() == "") {
        //        alert("需輸入工作項目")
        //        return;
        //    }

        //    var OA = $("#inp_OA").val();
        //    WorkNameTags.push(OA);
        //    $("#work").val(OA)

        //    $("#inp_OA").val("")
        //    alert("新增工作項目完成")
        //}

        //function btn_PHA_Click() {
        //    if ($("#inp_PHA").val() == "") {
        //        alert("需輸入危險分析")
        //        return;
        //    }

        //    var PHA = $("#inp_PHA").val();
        //    HazardNameTage.push(PHA);
        //    $("#Hazard").val(PHA);

        //    $("#inp_PHA").val("");
        //    alert("新增危險分析完成")
        //}

        //function btn_SP_Click() {
        //    if ($("#inp_SP_Title").val() == "" || $("#inp_SP_Content").val() == "") {
        //        alert("需輸入情境或描述內容")
        //        return;
        //    }

        //    SituationNameTags.push($("#inp_SP_Title").val() + "-" + $("#inp_SP_Content").val())
        //    $("#inp_SP_Title").val("")
        //    $("#inp_SP_Content").val("")
        //    alert("新增情境完成")
        //}

        function btn_Send() {

            //if ($("#work").val() == "") {
            //    alert("工作項目不可為空");
            //    return;
            //}

            //if ($("#Hazard").val() == "") {
            //    alert("危險項目不可為空")
            //    return;
            //}

            var form = $("#form1");
            form.submit();

            $("#inp_work").val("");
            $("#inp_Hazard").val("");

        }

        function CauseClassify(id) {
            var Cat = id.split('_')[1];
            if ($("#" + id).is(":checked")) {
                $("#sel_" + Cat).append("<option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option>")
            } else {
                $("#sel_" + Cat).empty();
            }
        }

    </script>
</head>

<body>
    <h2>步驟1:危險識別</h2>
    <form id="form1" action="Step2.aspx" method="post">
        <div>
            <label for="work">工作項目顯示: </label>
            <input id="inp_work" placeholder="輸入工作項目" />
            <%--        <input type="button" id="btn_OA" onclick="AddDataGridView(this.value,'工作項目');" value="新增工作項目" />--%>

            <%--<label>作業分析(OA)</label>
            <input type="button" id="btn_OA" onclick="btn_OA_Click();" value="增加工作項目" />
            <input type="text" id="inp_OA" placeholder="輸入工作項目" />--%>
        </div>

        <br />
        <div id="div_PHA">
            <div>
                <label for="Hazard">初步危險分析法(PHA) </label>
                <input id="inp_Hazard" placeholder="輸入初步危險分析" />
                <input type="button" id="btn_Hazard" onclick="AddDataGridView(this.id, '初步危險分析');" value="新增初步危險分析" />

            </div>
            <%--<label>初步危險分析(PHA)</label>
            <input type="button" id="btn_PHA" onclick="btn_PHA_Click();" value="增加危險分析" />
            <input type="text" id="inp_PHA" placeholder="輸入危險分析" />--%>
        </div>

        <br />
        <div id="div_WIT">
            <%--        <div>
                <label for="Suppose">假設狀況顯示: </label>
                <input id="Suppose" name="Suppose" />
            </div>--%>
            <label>假設狀況法(WIT)</label>
            <input type="text" id="inp_WIT" placeholder="輸入假設狀況" />
            <input type="button" id="btn_WIT" onclick="AddDataGridView(this.id, '假設狀況')" value="新增假設狀況" />

        </div>

        <br />
        <div id="div_SP">
            <%--            <div>
                <label for="Situation">危險情境顯示: </label>
                <input id="Situation" name="Situation" />
            </div>--%>
            <label>情境程序法(SP)</label>
            <span>情境:</span>
            <input type="text" id="inp_SP_Title" placeholder="輸入情境" />
            <span>情境描述:</span>
            <input type="text" id="inp_SP_Content" placeholder="輸入情境描述" />
            <input type="button" id="btn_SP" onclick="AddDataGridView(this.id, '情境程序')" value="新增情境程序" />

        </div>
        <br />

        <%--    <div id="div_LD">
            <label>邏輯圖表法(LD)</label>
            <input type="text" id="inp_LD" placeholder="輸入邏輯圖表" />
            <input type="button" id="btn_LD" onclick="AddDataGridView(this.id, '邏輯圖表');" value="新增邏輯圖表" />

        </div>
        <br />

        <div id="div_CHANGE">
            <label>變化分析法(CHANGE)</label>
            <input type="text" id="inp_CHANGE" placeholder="輸入變化分析" />
            <input type="button" id="btn_CHANGE" onclick="AddDataGridView(this.id, '變化分析');" value="新增變化分析" />

        </div>
        <br />

        <div id="div_CE">
            <label>因果法(CHANGE)</label>
            <input type="text" id="inp_CE" placeholder="輸入因果法" />
            <input type="button" id="btn_CE" onclick="AddDataGridView(this.id, '因果法');" value="新增因果法" />
        </div>--%>

        <%--        <br />--%>
        <%--        <div id="div_CauseClassify">
            <label>導因歸類</label>
            <input type="checkbox" id="chk_Man" onchange="CauseClassify(this.id)" />人員<select id="sel_Man"></select>
            <input type="checkbox" id="chk_Machine" onchange="CauseClassify(this.id)" />機械<select id="sel_Machine"></select>
            <input type="checkbox" id="chk_Milieu" onchange="CauseClassify(this.id)" />環境<select id="sel_Milieu"></select>
            <input type="checkbox" id="chk_Manage" onchange="CauseClassify(this.id)" />管理<select id="sel_Manage"></select>
            <input type="checkbox" id="chk_Task" onchange="CauseClassify(this.id)" />任務<select id="sel_Task"></select>
            <input type="button" id="btn_CauseClassify" onclick="AddDataGridView(this.id, '導因歸類');" value="新增導因歸類" />
        </div>--%>

        <br />
        <label style="font-weight: bold">工作項目及危險識別</label>
        <asp:DataGrid ID="ThisDataGrid" runat="server">
            <%--  <Columns>
                 <asp:BoundColumn HeaderText="工作項目" DataField="ID" />
                 <asp:BoundColumn HeaderText="危險識別" DataField="Hazard"/>
             </Columns>--%>
        </asp:DataGrid>


        <br />
        <input type="button" onclick="btn_Send()" value="下一步" />
    </form>
</body>
</html>
