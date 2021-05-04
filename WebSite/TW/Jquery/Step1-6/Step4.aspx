<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step4.aspx.cs" Inherits="WebSite.Jquery.Step4" %>

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


    <script>

        function btn_Send_Next() {
            var form = $("#form4")[0];
            form.action = "Step5.aspx";
            form.submit();
        }

        function btn_Send_Previous() {
            var form = $("#form4")[0];
            form.action = "Step3.aspx";
            form.submit();

        }

        function INS_Model(id) {
            debugger;
            //var Add = "<input id='Add_" + id + "' type='button' onclick='Edit(this.id)' value='新增' />"
            var ChkBox = " <input type='checkbox' onchange='DecisionMaking({0})' /></select>"

            Istbody = $("#ist-body");
            Istbody.empty();

            var HeaderText = "<tr><td>工作項目</td><td>危險識別</td><td>風險控制方法</td><td>作法說明</td><td>決策點選</td></tr>";
            Istbody.append(HeaderText);

            if (id == 1)
                Istbody.append("<tr><td>出航及進入空域階段</td><td>[初步危險分析法] 萬一在航路上無法與管制單位構聯</td><td>拒絕</td><td>完全打消念頭</td><td>" + ChkBox + "</td></tr>")
            else if (id == 2)
                Istbody.append("<tr><td>出航及進入空域階段</td><td>[初步危險分析法] 萬一管制單位引導錯誤</td><td>轉移</td><td>轉移更具能量</td><td>" + ChkBox + "</td></tr>")
            else if (id == 3)
                Istbody.append("<tr><td>空中階段</td><td>[萬一] 萬一雷達脫鎖</td><td>拒絕</td><td>繼續尋求新的科技發展再進行</td><td>" + ChkBox + "</td></tr>")
            else if (id == 4)
                Istbody.append("<tr><td>空中階段</td><td>[萬一] 萬一未檢查武器電門是否在模擬位置</td><td>避免</td><td>實施封鎖</td><td>" + ChkBox + "</td></tr>")
            else if (id == 5)
                Istbody.append("<tr><td>[初步危險分析法] 起飛離場時飛機故障</td><td>延後</td><td>安排下一班次</td><td>" + ChkBox + "</td></tr>")
            else if (id == 6)
                Istbody.append("<tr><td>起飛離場階段</td><td>[萬一] 萬一滾行時發動機火警</td><td>分散</td><td>使用干擾物</td><td>" + ChkBox + "</td></tr>")

            $("#IST").modal({ show: true });

        }


        function COST_Model(id) {

            //var Add = "<input id='Add_" + id + "' type='button' onclick='Edit(this.id)' value='新增' />"
            var ChkBox = " <input type='checkbox' onchange='DecisionMaking({0})' /></select>"
            var CostSelect = "<select id='sel_Cost_" + id + "''><option value ='1' >1</option><option value='2'>2</option><option value ='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option></select>"
            var BenefitSelect = "<select id='sel_Benefit_" + id + "''><option value ='1' >1</option><option value='2'>2</option><option value ='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option></select>"
            var Label = "<label id='leb_" + id + "' ></label>";

            var Edit = "<input id='Edit_" + id + "' type='button' onclick='Edit(this.id)' value='修改'>"
            var Confirm = "<input id='Confirm_" + id + "' type='button' onclick='Confirm(this.id)' value='確定' />";

            Costbody = $("#cost-body");
            Costbody.empty();

            var HeaderText = "<tr><td>工作項目</td><td>危險識別</td><td>工具</td><td>作法說明</td><td>成本</td><td>效益</td><td>比率(效率/成本)</td><td>決策點選</td><td>決定</td></tr>";
            Costbody.append(HeaderText);

            if (id == 1)
                Costbody.append("<tr><td>出航及進入空域階段</td><td>[初步危險分析法] 萬一在航路上無法與管制單位構聯</td><td>拒絕</td><td>完全打消念頭</td><td>4</td><td>3</td><td><label id='leb_" + id + "' >1.25</label></td><td>" + ChkBox + "</td><td>" + Edit + "</td></tr>")
            else if (id == 2)
                Costbody.append("<tr><td>出航及進入空域階段</td><td>[初步危險分析法] 萬一管制單位引導錯誤</td><td>轉移</td><td>轉移更具能量</td><td>3</td><td>4</td><td><label id='leb_" + id + "' >1.33</label></td><td>" + ChkBox + "</td><td>" + Edit + "</td></tr>")
            else if (id == 3)
                Costbody.append("<tr><td>空中階段</td><td>[萬一] 萬一雷達脫鎖</td><td>拒絕</td><td>繼續尋求新的科技發展再進行</td><td>3</td><td>4</td><td><label id='leb_" + id + "' >1.33</label></td><td>" + ChkBox + "</td><td>" + Edit + "</td></tr>")
            else if (id == 4)
                Costbody.append("<tr>><td>空中階段</td><td>[萬一] 萬一未檢查武器電門是否在模擬位置</td><td>避免</td><td>實施封鎖</td><td>4</td><td>5</td><td><label id='leb_" + id + "' >1.25</label></td><td>" + ChkBox + "</td><td>" + Edit + "</td></tr>")
            else if (id == 5)
                Costbody.append("<tr><td>起飛離場階段</td><td>[初步危險分析法] 起飛離場時飛機故障</td><td>延後</td><td>安排下一班次</td><td>" + CostSelect + "</td><td>" + BenefitSelect + "</td><td>" + Label + "</td><td>" + ChkBox + "</td><td>" + Confirm + "</td></tr>")
            else if (id == 6)
                Costbody.append("<tr><td>起飛離場階段</td><td>[萬一] 萬一滾行時發動機火警</td><td>分散</td><td>使用干擾物</td><td>" + CostSelect + "</td><td>" + BenefitSelect + "</td><td>" + Label + "</td><td>" + ChkBox + "</td><td>" + Confirm + "</td></tr>")

            $("#COST").modal({ show: true });

        }


        function DEC_Model(id) {

            //var Add = "<input id='Add_" + id + "' type='button' onclick='Edit(this.id)' value='新增' />"
            var ChkBox = " <input type='checkbox' onchange='DecisionMaking({0})' /></select>"
            var CostSelect = "<select id='sel_Cost_" + id + "''><option value ='1' >1</option><option value='2'>2</option><option value ='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option></select>"
            var BenefitSelect = "<select id='sel_Benefit_" + id + "''><option value ='1' >1</option><option value='2'>2</option><option value ='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option></select>"
            var Label = "<label id='leb_" + id + "' ></label>";

            Costbody = $("#dec-body");
            Costbody.empty();

            var HeaderText = "<tr><td></td><td>評分因素</td><td>低成本</td><td>容易執行</td><td>人員積極餐與</td><td>與習慣一致</td><td>容易整合</td><td>容易衡量</td><td>低風險</td><td>決策點選</td><td>總計</td></tr>";
            Costbody.append(HeaderText);

            if (id == 1)
                Costbody.append("<tr><td>[拒絕] 完全打消念頭</td><td>0</td><td>0</td>><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>" + ChkBox + "</td><td></td></tr>")
            else if (id == 2)
                Costbody.append("<tr><td>[轉移] 轉移更具能量</td><td>0</td><td>0</td>><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>" + ChkBox + "</td><td>0</td></tr>")
            else if (id == 3)
                Costbody.append("<tr><td>[拒絕] 繼續尋求新的科技發展再進行</td><td>0</td><td>0</td>><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>" + ChkBox + "</td><td>0</td></tr>")
            else if (id == 4)
                Costbody.append("<tr><td>[避免] 萬實施封鎖</td><td>0</td><td>0</td>><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>" + ChkBox + "</td><td>0</td></tr>")
            else if (id == 5)
                Costbody.append("<tr><td>[延後] 安排下一班次</td><td>0</td><td>0</td>><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>" + ChkBox + "</td><td>0</td></tr>")
            else if (id == 6)
                Costbody.append("<tr><td>[分散] 使用干擾物</td><td>0</td><td>0</td>><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>" + ChkBox + "</td><td>0</td></tr>")

            $("#DEC").modal({ show: true });

        }

    </script>
</head>

<body>
    <h2>步驟4.下達控制決策</h2>
    <form id="form4" action="Step3.aspx" method="post">
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
        <label style="font-weight: bold">下達控制決策</label>
        <asp:DataGrid ID="ThisDataGrid" runat="server">
        </asp:DataGrid>

        <br />
        <input type="button" onclick="btn_Send_Previous()" value="上一步" />
        <input type="button" onclick="btn_Send_Next()" value="下一步" />


        <%--=======================================================================================================================================--%>

        <%-- INS--%>
        <!-- Modal -->
        <div class="modal fade" id="IST" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document" style="width: 1000px">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">直覺法</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <table border='1' style='border-collapse: collapse; margin: 5px'>
                        <tbody class="modal-body" id="ist-body">
                        </tbody>
                    </table>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <%--=======================================================================================================================================--%>

        <%-- COST--%>
        <!-- Modal -->
        <div class="modal fade" id="COST" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document" style="width: 1000px">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">成本效益</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <table border='1' style='border-collapse: collapse; margin: 5px'>
                        <tbody class="modal-body" id="cost-body">
                        </tbody>
                    </table>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- DEC--%>
        <!-- Modal -->
        <div class="modal fade" id="DEC" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document" style="width: 1000px">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">決策矩陣</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <table border='1' style='border-collapse: collapse; margin: 5px'>
                        <tbody class="modal-body" id="dec-body">
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
