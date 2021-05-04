<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step3.aspx.cs" Inherits="WebSite.Jquery.Step3" %>

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
                max-width: 1600px;
            }
        }
    </style>

    <script>

        function btn_Send_Next() {
            var form = $("#form3")[0];
            form.action = "Step4.aspx";
            form.submit();
        }

        function btn_Send_Previous() {
            var form = $("#form3")[0];
            form.action = "Step2.aspx";
            form.submit();

        }

        var MOL_Risk = "<select><option value ='1'> 拒絕 </option><option value='2'>避免</option><option value ='3'> 延後 </option><option value='4'> 轉移 </option><option value='5'> 分散 </option><option value='6'> 補償 </option><option value='7'> 增加 </option><option value='8'> 減低 </option></select>";
        var MOL_Fun = "<select><option value ='1' > *放棄全盤任務計畫* </option><option value='2'>不執行任何相關作業</option><option value ='3'> 終止所有相關業活動 </option><option value='4'> 完全打消念頭 </option><option value='5'> 全然不接受該風險 </option><option value='6'> 完全不夠理該業務 </option>></select>";

        function MOL_Model(id) {

            var Add = "<input id='Add_" + id + "' type='button' onclick='Edit(this.id)' value='新增' />"
            var Edit = "<input id='Edit_" + id + "' type='button' onclick='Edit(this.id)' value='修改'>"
            var Confirm = "<input id='Confirm_" + id + "' type='button' onclick='Confirm(this.id)' value='確定' />";

            Molbody = $("#mol-body");
            Molbody.empty();

            var HeaderText = "<tr><td>新增</td><td>工作項目</td><td>危險識別</td><td>MOL(風險控制方法)</td><td>MOL(作法說明)</td><td>決定</td></tr>";
            Molbody.append(HeaderText);

            if (id == 1)
                Molbody.append("<tr><td>" + Add + "</td><td>出航及進入空域階段</td><td>[初步危險分析法] 萬一在航路上無法與管制單位構聯</td><td>拒絕</td><td>完全打消念頭</td><td>" + Edit + "</td></tr>")
            else if (id == 2)
                Molbody.append("<tr><td>" + Add + "</td><td>出航及進入空域階段</td><td>[初步危險分析法] 萬一管制單位引導錯誤</td><td>轉移</td><td>轉移更具能量</td><td>" + Edit + "</td></tr>")
            else if (id == 3)
                Molbody.append("<tr><td>" + Add + "</td><td>空中階段</td><td>[萬一] 萬一雷達脫鎖</td><td>拒絕</td><td>繼續尋求新的科技發展再進行</td><td>" + Edit + "</td></tr>")
            else if (id == 4)
                Molbody.append("<tr><td>" + Add + "</td><td>空中階段</td><td>[萬一] 萬一未檢查武器電門是否在模擬位置</td><td>" + MOL_Risk + "</td><td>" + MOL_Fun + "</td><td>" + Confirm + "</td></tr>")
            else if (id == 5)
                Molbody.append("<tr><td>" + Add + "</td><td>[初步危險分析法] 起飛離場時飛機故障</td><td>" + MOL_Risk + "</td><td>" + MOL_Fun + "</td><td>" + Confirm + "</td></tr>")
            else if (id == 6)
                Molbody.append("<tr><td><input id='Add_" + id + "' type='button' onclick='Edit(this.id)' value='新增' /></td><td>起飛離場階段</td><td>[萬一] 萬一滾行時發動機火警</td><td>" + MOL_Risk + "</td><td>" + MOL_Fun + "</td><td>" + Confirm + "</td></tr>")

            $("#MOL").modal({ show: true });

        }

        var Edit = "<input id='Edit_{0}' type='button' value='修改' />";
        var Confirm = "<input id='Confirm_{0}' type='button' onclick='Confirm(this.id)' value='確定' />";

        var COM_Risk = "<select><option value ='1' > 限制能量 </option><option value='2'>以較安全的方式取代/option></select>";
        var COM_Fun = "<select><option value ='1' > *限制動量(增速驅動)裝置)* </option><option value='2'>建立效能監控系統</option><option value ='3'> 終止所有相關業活動 </option><option value='4'> 完全打消念頭 </option><option value='5'> 全然不接受該風險 </option><option value='6'> 完全不夠理該業務 </option>></select>";

        function COM_Model(id) {

            var Add = "<input id='Add_" + id + "' type='button' onclick='Edit(this.id)' value='新增' />"
            var Edit = "<input id='Edit_" + id + "' type='button' onclick='Edit(this.id)' value='修改'>"
            var Confirm = "<input id='Confirm_" + id + "' type='button' onclick='Confirm(this.id)' value='確定' />";

            combody = $("#com-body");
            combody.empty();

            var HeaderText = "<tr><td>新增</td><td>工作項目</td><td>危險識別</td><td>COM(風險控制方法)</td><td>COM(作法說明)</td><td>決定</td></tr>";
            combody.append(HeaderText);

            if (id == 1)
                combody.append("<tr><td>" + Add + "</td><td>出航及進入空域階段</td><td>[初步危險分析法] 萬一在航路上無法與管制單位構聯</td><td>限制能量</td><td>加裝自動減速系統</td><td>" + Edit + "</td></tr>")
            else if (id == 2)
                combody.append("<tr><td>" + Add + "</td><td>出航及進入空域階段</td><td>[初步危險分析法] 萬一管制單位引導錯誤</td><td>以較安全的方式替代</td><td>遵照SOP步驟</td><td>" + Edit + "</td></tr>")
            else if (id == 3)
                combody.append("<tr><td>" + Add + "</td><td>空中階段</td><td>[萬一] 萬一雷達脫鎖</td><td>以較安全的方式替代</td><td>保持安全距離</td><td>" + Edit + "</td></tr>")
            else if (id == 4)
                combody.append("<tr><td>" + Add + "</td><td>空中階段</td><td>[萬一] 萬一未檢查武器電門是否在模擬位置</td><td>" + COM_Risk + "</td><td>" + COM_Fun + "</td><td>" + Confirm + "</td></tr>")
            else if (id == 5)
                combody.append("<tr><td>" + Add + "</td><td>[初步危險分析法] 起飛離場時飛機故障</td><td>" + COM_Risk + "</td><td>" + COM_Fun + "</td><td>" + Confirm + "</td></tr>")
            else if (id == 6)
                combody.append("<tr><td>" + Add + "</td><td>起飛離場階段</td><td>[萬一] 萬一滾行時發動機火警</td><td>" + COM_Risk + "</td><td>" + COM_Fun + "</td><td>" + Confirm + "</td></tr>")

            $("#COM").modal({ show: true });

        }

    </script>
</head>

<body>
    <h2>步驟3:分析風險控制</h2>
    <form id="form3" action="Step3.aspx" method="post">

        <%--    <div>
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
        <label style="font-weight: bold">分析風險控制</label>
        <asp:DataGrid ID="ThisDataGrid" runat="server">
        </asp:DataGrid>

        <br />
        <input type="button" onclick="btn_Send_Previous()" value="上一步" />
        <input type="button" onclick="btn_Send_Next()" value="下一步" />

        <%--=======================================================================================================================================--%>

        <%-- MOL--%>
        <!-- Modal -->
        <div class="modal fade" id="MOL" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document" style="width: 1000px">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">MOL 主選單</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <table border='1' style='border-collapse: collapse; margin: 5px'>
                        <tbody class="modal-body" id="mol-body">
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

        <%-- COM--%>
        <!-- Modal -->
        <div class="modal fade" id="COM" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document" style="width: 1000px">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">COM 選擇矩陣</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <table border='1' style='border-collapse: collapse; margin: 5px'>
                        <tbody class="modal-body" id="com-body">
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
