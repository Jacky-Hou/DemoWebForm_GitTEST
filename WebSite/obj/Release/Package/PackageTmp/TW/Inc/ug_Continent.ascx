<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ug_Continent.ascx.cs" Inherits="WebSite.TW.Inc.ug_Continent" %>

<script>
    var ContinentArry = "<%=Continent%>".split(',');
    function SetAddrSelOpt() {

        //地區
        $.each(ContinentArry, function (Key, Val) {
            var ValAry = Val.split('&');
            var PublicOption = $("#PublicOption").html();
            PublicOption = PublicOption.replace("%Public%", ValAry[0].toString())
                .replace("%PublicName%", ValAry[1].toString())
            $("#selContinentID").append(PublicOption);
        })
    }

    //地區選擇
    function ChgContinent(e) {

        $("#selCityID").empty();
        $("#selAreaID").empty();

        var PublicOption = $("#PublicOption").html();
        PublicOption = PublicOption.replace("%Public%", "0")
            .replace("%PublicName%", "----城市----")
        $("#selCityID").append(PublicOption);

        var PublicOption = $("#PublicOption").html();
        PublicOption = PublicOption.replace("%Public%", "0")
            .replace("%PublicName%", "----區域----")
        $("#selAreaID").append(PublicOption);

        $("#txtZipCodeID").val("");

        if ($(e).val() != 1) {
            $("#selCityID").prop('disabled', true);
            $("#selAreaID").prop('disabled', true);
        }
        else {
            $("#selCityID").prop('disabled', false);

            $.each(CityArry, function (Key, Val) {
                var ValAry = Val.split('&');
                if (ValAry[2].toString() == $(e).val()) {
                    var PublicOption = $("#PublicOption").html();
                    PublicOption = PublicOption.replace("%Public%", ValAry[0].toString())
                        .replace("%PublicName%", ValAry[1].toString())
                    $("#selCityID").append(PublicOption);
                }
            })
        }
    }

    function ChkEmptyAddr(mZipCodeSts, mAddrName, mPrefix) {
        if (mPrefix == null) mPrefix = '';

        var f = document.frmUG;
        var y = "";

        var strContinentObjName = "sel" + mPrefix + "ContinentID";
        var strCityObjName = "sel" + mPrefix + "CityID";
        var strAreaObjName = "sel" + mPrefix + "AreaID";
        var strZipCodeObjName = "txt" + mPrefix + "ZipCode";
        var strZipCodeTwoObjName = "txt" + mPrefix + "ZipCodeTwo";
        var strAddrObjName = "txt" + mPrefix + "Addr";

        var dom_objContinentID = document.getElementById(strContinentObjName);
        var dom_objCityID = document.getElementById(strCityObjName);
        var dom_objAreaID = document.getElementById(strAreaObjName);

        if (mAddrName != "") { mAddrName += " - " }

        if (mZipCodeSts == 1)		//地址:一般text輸入
        {
            y += ChkEmpty(strZipCodeObjName, mAddrName + '郵遞區號', 'ChkBlock(\'num\',\'txtReceiver_ZipCode\',\'' + strAddrName + '郵遞區號\');', '');
        } else if (mZipCodeSts == 2)	//地址:下拉式
        {
            y += ChkEmpty(strContinentObjName, mAddrName + '地區', '', '');
            if (dom_objContinentID.value == "0") { y += mAddrName + '地區　必須選擇資料!!<br>'; }
            if (dom_objCityID.value == "0" && dom_objCityID.disabled == false) { y += mAddrName + '城市　必須選擇資料!!<br>'; }
            if (dom_objAreaID.value == "0" && dom_objAreaID.disabled == false) { y += mAddrName + '區域　必須選擇資料!!<br>'; }
            if (dom_objContinentID.value == "1") {/*Taiwan*/
                y += ChkEmpty(strZipCodeObjName, mAddrName + '地址 : 郵遞區號前3碼', 'ChkBlock(\'num\',\'txtZipCode\',\'' + mAddrName + '地址 : 郵遞區號前3碼\');', '');
            }
            if (ChkEmpty(strZipCodeTwoObjName) == '') { y += ChkBlock('num', strZipCodeTwoObjName, mAddrName + '地址 : 郵遞區號後2碼'); }
        }
        y += ChkEmpty(strAddrObjName, mAddrName + '地址', '');
        return y;
    }

</script>

<span>
    <label for="selContinentID" style="display: none;">地區</label>
    <select name="selContinentID" id="selContinentID" onchange="ChgContinent(this)">
        <option value="0"><%=FirstIndex%></option>
    </select>
</span>

<script type="text/template" id="PublicOption">
    <option value="%Public%">%PublicName%</option>
</script>
