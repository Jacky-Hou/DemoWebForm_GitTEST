<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step2.aspx.cs" Inherits="WebSite.Jquery.Step2" %>

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

        var RiskLevel = {
            "災難_頻繁": "EH1",
            "災難_很可能": "EH2",
            "嚴重_頻繁": "EH3",
            "嚴重_很可能": "H4",
            "中等_頻繁": "H5",
            "災難_偶而": "H6",
            "嚴重_偶而": "H7",
            "災難_很少": "H8",
            "中等_很可能": "M9",
            "中等_偶而": "M10",
            "嚴重_很少": "M11",
            "災難_幾乎不": "M12",
            "輕微_頻繁": "M13",
            "中等_很少": "L14",
            "嚴重_幾乎不": "L15",
            "中等_幾乎不": "L16",
            "輕微_很可能": "L17",
            "輕微_偶而": "L18",
            "輕微_很少": "L19",
            "輕微_幾乎不": "L20"
        };


        function btn_Send_Next() {
            var form = $("#form2")[0];
            form.action = "Step3.aspx";
            form.submit();
        }

        function btn_Send_Previous() {
            var form = $("#form2")[0];
            form.action = "Step1.aspx";
            form.submit();

        }

        function RiskLevel(id) {

        }

        function AddDataGridView(ID) {

            if ($("#work").val() == "") {
                alert("工作項目不得為空!!");
                return;
            }

            if ($("#Hazard").val() == "") {
                alert("工作項目不得為空!!");
                return;
            }

            var GridRow = "<tr><td>" + $("#work").val() + "</td><td>" + $("#Hazard").val() + "</td><td>" + $("#sel_Amplitude option:selected").text().split('.')[1] + "</td><td>" + $("#sel_Probability option:selected").text().split('.')[1] + "</td><td>" + $("#sel_RiskLevel").val() + "</td></tr>";
            $("#ThisDataGrid").append(GridRow);
        }

        function AmplitudeLevel(tr, td) {
            var Amplitude = GetAmplitude(tr, td);
            var Probability = GetProbability(tr, td + 1);
            var Key = RiskLevel[Amplitude + "_" + Probability];
            $("#ThisDataGrid tr:eq(" + tr + ") td:eq(" + (td + 2) + ")").text(Key);
        }

        function ProbabilityLevel(tr, td) {
            var Amplitude = GetAmplitude(tr, td - 1);
            var Probability = GetProbability(tr, td);
            var Key = RiskLevel[Amplitude + "_" + Probability];
            $("#ThisDataGrid tr:eq(" + tr + ") td:eq(" + (td + 1) + ")").text(Key);
        }


        function FnAmplitude(tr, td) {
            var Amplitude = "<select id='sel_Amplitude_" + tr + td + "' onchange='AmplitudeLevel(" + tr + "," + td + ")'><option value ='1'>I.災難</option><option value='2'>II.嚴重</option><option value ='3'>III.中等</option><option value='4'>IV.輕微</option></select>";
            return Amplitude;
        }

        function FnProbability(tr, td) {
            var Probability = "<select id='sel_Probability_" + tr + td + "' onchange='ProbabilityLevel(" + tr + "," + td + ")'><option value = 'A'>A.頻繁</option><option value='B'>B.很可能</option><option value = 'C' >C.偶而</option><option value='D'>D.很少</option><option value = 'E' >E.幾乎不可能</ option ></ select >";
            return Probability;
        }


        function FnEdit(tr, td) {
            var Edit = "<input id='Edit_" + tr + td + "' type='button' onclick='Edit(" + tr + "," + td + ")' value='修改' />";
            return Edit;
        }

        function FnConfirm(tr, td) {
            var Confirm = "<input id='Confirm_" + tr + td + "' type='button' onclick='Confirm(" + tr + "," + td + ")' value='確認' />";
            return Confirm;
        }

        function Edit(tr, td) {
            $("#ThisDataGrid tr:eq(" + tr + ") td:eq(" + (td - 3) + ")").html(FnAmplitude(tr, td - 3));
            $("#ThisDataGrid tr:eq(" + tr + ") td:eq(" + (td - 2) + ")").html(FnProbability(tr, td - 2));
            $("#ThisDataGrid tr:eq(" + tr + ") td:eq(" + td + ")").html(FnConfirm(tr, td));
            $("#ThisDataGrid tr:eq(" + tr + ") td:eq(" + (td - 1) + ")").text("EH1");
        }

        function Confirm(tr, td) {
            var Amplitude = GetAmplitude(tr, td - 3);
            var Probability = GetProbability(tr, td - 2);
            $("#ThisDataGrid tr:eq(" + tr + ") td:eq(" + (td - 3) + ")").text(Amplitude);
            $("#ThisDataGrid tr:eq(" + tr + ") td:eq(" + (td - 2) + ")").text(Probability);
            $("#ThisDataGrid tr:eq(" + tr + ") td:eq(" + td + ")").html(FnEdit(tr, td));

        }

        function GetAmplitude(tr, td) {
            var Amplitude = $("#sel_Amplitude_" + tr + td + " option:selected").text().split('.')[1];
            return Amplitude;
        }

        function GetProbability(tr, td) {
            var Probability = $("#sel_Probability_" + tr + td + " option:selected").text().split('.')[1];
            return Probability;
        }

    </script>
</head>

<body>
    <h2>步驟2:風險評估</h2>
    <form id="form2" method="post">
        <%--        <div>
            <label for="work">工作項目顯示: </label>
            <input id="work" name="work" />
        </div>
        <br />

        <div id="div_PHA">
            <div>
                <label for="Hazard">危險項目顯示: </label>
                <input id="Hazard" name="Hazard" onchange="HazardEven(this.value)" />
                <label>幅度:</label>
                <select id="sel_Amplitude" onchange="RiskLevel(this.id)">
                    <option value="1">I.災難</option>
                    <option value="2">II.嚴重</option>
                    <option value="3">III.中等</option>
                    <option value="4">IV.輕微</option>
                </select>
                <label>機率:</label>
                <select id="sel_Probability" onchange="RiskLevel(this.id)">
                    <option value="A">A.頻繁</option>
                    <option value="B">B.很可能</option>
                    <option value="C">C.偶而</option>
                    <option value="D">D.很少</option>
                    <option value="E">E.幾乎不可能</option>
                </select>
                <label>風險等級:</label>
                <select id="sel_RiskLevel">
                    <option value="EH1">EH1 [災難_頻繁]</option>
                    <option value="EH2">EH2 [災難_很可能]</option>
                    <option value="EH3">EH3 [嚴重_頻繁]</option>
                    <option value="H4">H4  [嚴重_很可能]</option>
                    <option value="H5">H5  [中等_頻繁]</option>
                    <option value="H6">H6  [災難_偶而]</option>
                    <option value="H7">H7  [嚴重_偶而]</option>
                    <option value="H8">H8  [災難_很考]</option>
                    <option value="M9">M9  [中等_很可能]</option>
                    <option value="M10">M10 [中等_偶而]</option>
                    <option value="M11">M11 [嚴重_很少]</option>
                    <option value="M12">M12 [災難_幾乎不]</option>
                    <option value="M13">M13 [輕微_頻繁]</option>
                    <option value="L14">L14 [中等_很少]</option>
                    <option value="L15">L15 [嚴重_幾乎不]</option>
                    <option value="L16">L16 [中等_幾乎不]</option>
                    <option value="L17">L17 [輕微_很可能]</option>
                    <option value="L18">L18 [輕微_偶而]</option>
                    <option value="L19">L19 [輕微_很少]</option>
                    <option value="L20">L20 [輕微_幾乎不]</option>
                </select>
                <input type="button" id="btn_PHA" onclick="AddDataGridView(this.id);" value="新增風險評估" />
            </div>
        </div>--%>

        <br />
        <label style="font-weight: bold">風險評估</label>
        <asp:DataGrid ID="ThisDataGrid" runat="server">
        </asp:DataGrid>

        <br />
        <input type="button" onclick="btn_Send_Previous()" value="上一步" />
        <input type="button" onclick="btn_Send_Next()" value="下一步" />
    </form>
</body>
</html>
