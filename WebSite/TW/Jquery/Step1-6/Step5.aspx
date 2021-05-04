<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step5.aspx.cs" Inherits="WebSite.Jquery.Step5" %>

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

    <link href="../JS/bootstrap.css" rel="stylesheet" />
    <script src="../JS/bootstrap.js"></script>

    <style>
        @media (min-width: 992px) {
            .modal-xl {
                max-width: 1000px;
            }
        }
    </style>

    <script>

        function btn_Send_Next() {
            var form = $("#form5")[0];
            form.action = "Step6.aspx";
            form.submit();
        }

        function btn_Send_Previous() {
            var form = $("#form5")[0];
            form.action = "Step4.aspx";
            form.submit();

        }

        function RewardDiscipline_Model(id) {
            debugger;
            //var Add = "<input id='Add_" + id + "' type='button' onclick='Edit(this.id)' value='新增' />"
            //var ChkBox = " <input type='checkbox' onchange='DecisionMaking({0})' /></select>"
            //var CostSelect = "<select id='sel_Cost_" + id + "''><option value ='1' >1</option><option value='2'>2</option><option value ='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option></select>"
            //var BenefitSelect = "<select id='sel_Benefit_" + id + "''><option value ='1' >1</option><option value='2'>2</option><option value ='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option></select>"
            //var Label = "<label id='leb_" + id + "' ></label>";

            var Reward = "<input type='text' id='inp_Reward_" + id + "' placeholder='輸入獎勵人員'/>";
            var RewardContent = "<select><option value ='1'> 行政獎勵 </option><option value='2'> 個人獎金 </option><option value ='3'> 公開表揚 </option><option value='4'> 放榮譽假 </option><option value='5'> 放特別假 </option><option value='6'> 考績加分 </option><option value='7'> 貫徹度 </option><option value='8'> 減低 </option></select>";

            var penalty = "<input type='text' id='inp_penalty_" + id + "' placeholder='輸入懲戒人員'/>";
            var penaltyContent = "<select><option value ='1'> 口頭警告 </option><option value='2'> 公開訓誡 </option><option value ='3'> 依公司規定懲處 </option><option value='4'> 加強訓練 </option><option value='5'>重複訓練 </option><option value='6'> 停止值班 </option></select>";

            var Edit = "<input id='Edit_" + id + "' type='button' onclick='Edit(this.id)' value='修改'>"
            var Confirm = "<input id='Confirm_" + id + "' type='button' onclick='Confirm(this.id)' value='確定' />";

            Costbody = $("#RewardDiscipline-body");
            Costbody.empty();

            var HeaderText = "<tr><td>工作項目</td><td>危險識別</td><td>獎勵</td><td>獎勵指標</td><td>懲戒</td><td>懲戒指標</td><td>決定</td></tr>";
            Costbody.append(HeaderText);

            if (id == 1)
                Costbody.append("<tr><td>出航及進入空域階段</td><td>[初步危險分析法] 萬一在航路上無法與管制單位構聯</td><td>績優人員</td><td>公開表揚</td><td>未達標準人員</td><td>口頭警告</td><td>決定</td><td>" + Edit + "</td></tr>")
            else if (id == 2)
                Costbody.append("<tr><td>出航及進入空域階段</td><td>[初步危險分析法] 萬一管制單位引導錯誤</td><td>績優人員</td><td>個人獎金</td><td>未達標準人員</td><td>公開訓誡</td><td>" + Edit + "</td></tr>")
            else if (id == 3)
                Costbody.append("<tr><td>空中階段</td><td>[萬一] 萬一雷達脫鎖</td><td>績優人員</td><td>放榮譽假</td><td>未達標準人員</td><td>依公司規定懲處</td><td>" + Edit + "</td></tr>")
            else if (id == 4)
                Costbody.append("<tr>><td>空中階段</td><td>[萬一] 萬一未檢查武器電門是否在模擬位置</td><td>" + Reward + "</td><td>" + RewardContent + "</td><td>" + penalty + "</td><td>" + penaltyContent + "</td><td>" + Confirm + "</td></tr>")
            else if (id == 5)
                Costbody.append("<tr><td>起飛離場階段</td><td>[初步危險分析法] 起飛離場時飛機故障</td><td>" + Reward + "</td><td>" + RewardContent + "</td><td>" + penalty + "</td><td>" + penaltyContent + "</td><td>" + Confirm + "</td></tr>")
            else if (id == 6)
                Costbody.append("<tr><td>起飛離場階段</td><td>[萬一] 萬一滾行時發動機火警</td><td>" + Reward + "</td><td>" + RewardContent + "</td><td>" + penalty + "</td><td>" + penaltyContent + "</td><td>" + Confirm + "</td></tr>")

            $("#RewardDiscipline").modal({ show: true });

        }


    </script>
</head>

<body>
    <h2>步驟5.執行風險控制</h2>
    <form id="form5" action="Step3.aspx" method="post">
        <%--        <div>
            <label for="work">工作項目顯示: </label>
            <input id="work" name="work" />
        </div>
        <br />
        <div id="div_PHA">
            <label for="Hazard">危險項目顯示: </label>
            <input id="Hazard" name="Hazard" onchange="HazardEven(this.value)" />
            <input type="button" onclick="btn_Send()" value="送出" />
        </div>--%>

        <br />
        <label style="font-weight: bold">執行風險控制</label>
        <asp:DataGrid ID="ThisDataGrid" runat="server">
        </asp:DataGrid>

        <br />
        <input type="button" onclick="btn_Send_Previous()" value="上一步" />
        <input type="button" onclick="btn_Send_Next()" value="下一步" />


        <%-- DEC--%>
        <!-- Modal -->
        <div class="modal fade" id="RewardDiscipline" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document" style="width: 1000px">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">獎勵與懲戒</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <table border='1' style='border-collapse: collapse; margin: 5px'>
                        <tbody class="modal-body" id="RewardDiscipline-body">
                        </tbody>
                    </table>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
