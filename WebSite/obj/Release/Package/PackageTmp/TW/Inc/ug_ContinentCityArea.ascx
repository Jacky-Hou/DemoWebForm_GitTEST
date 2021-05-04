<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ug_ContinentCityArea.ascx.cs" Inherits="WebSite.TW.Inc.ug_ContinentCityArea" %>

<script>
    var ContinentArry;
    var CityArry;
    var AreaArry;

    function SetAddrSelOpt() {
        ContinentArry = "<%=Continent%>".split(',');
        CityArry = "<%=City%>".split(',');
        AreaArry = "<%=Area%>".split(',');

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
    function ChgContinent() {

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

        if ($("#selContinentID").val() != 1) {
            $("#selCityID").prop('disabled', true);
            $("#selAreaID").prop('disabled', true);
        }
        else {
            $("#selCityID").prop('disabled', false);

            $.each(CityArry, function (Key, Val) {
                var ValAry = Val.split('&');
                if (ValAry[2].toString() == $("#selContinentID").val()) {
                    var PublicOption = $("#PublicOption").html();
                    PublicOption = PublicOption.replace("%Public%", ValAry[0].toString())
                        .replace("%PublicName%", ValAry[1].toString())
                    $("#selCityID").append(PublicOption);
                }
            })
        }
    }

    //城市選擇
    function ChgCity() {

        $("#selAreaID").empty();
        $("#txtZipCodeID").val("");

        var PublicOption = $("#PublicOption").html();
        PublicOption = PublicOption.replace("%Public%", "0")
            .replace("%PublicName%", "----區域----")
        $("#selAreaID").append(PublicOption);

        if ($("#selCityID").val() == 0)
            $("#selAreaID").prop('disabled', true);
        else {
            $("#selAreaID").prop('disabled', false);

            $.each(AreaArry, function (Key, Val) {
                var ValAry = Val.split('&');
                if (ValAry[2].toString() == $("#selCityID").val()) {
                    var PublicOption = $("#PublicOption").html();
                    PublicOption = PublicOption.replace("%Public%", ValAry[0].toString())
                        .replace("%PublicName%", ValAry[1].toString() + " " + ValAry[3].toString())
                    $("#selAreaID").append(PublicOption);
                }
            })
        }
    }

    //區域選擇
    function ChgArea() {
        if ($("#selAreaID").val() == 0) {
            $("#txtZipCodeID").val("");
        } else {
            $.each(AreaArry, function (Key, Val) {
                var ValAry = Val.split('&');
                if (ValAry[0].toString() == $("#selAreaID").val()) {
                    $("#txtZipCodeID").val(ValAry[3].toString());
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

<%--<div>
    <label for="txtAddr"><span class="notice">*&nbsp;</span>聯絡地址</label>
</div>
<div class="form-box">--%>
<span>
    <label for="selContinentID" style="display: none;">地區</label>
    <select name="selContinentID" id="selContinentID" onchange="ChgContinent()">
        <option value="0"><%=Index[0].ToString()%></option>
    </select>
</span>
<span>
    <label for="selCityID" style="display: none;">城市</label>
    <select name="selCityID" id="selCityID" onchange="ChgCity()" disabled="">
        <option value="0"><%=Index[1].ToString()%></option>
    </select>
</span>
<span>
    <label for="selAreaID" style="display: none;">區域</label>
    <select name="selAreaID" id="selAreaID" onchange="ChgArea()" disabled="">
        <option value="0"><%=Index[2].ToString()%></option>
    </select>
</span>
<%-- <span>(</span>
    <span>.
        <label for="txtZipCodeID" style="display: none;">郵遞區號前三碼</label>
        <input type="text" name="txtZipCode" id="txtZipCodeID" value="" maxlength="3" class="length-xxs" onkeypress="return KeyPressBlock(event,'num');">
    </span>
    <span>+</span>
    <span>
        <label for="txtZipCodeID" style="display: none;">郵遞區號後二碼</label>
        <input type="text" name="txtZipCodeTwo" id="txtZipCodeTwo" value="" maxlength="2" class="length-xxxs" onkeypress="return KeyPressBlock(event,'num');">
    </span>
    <span>)</span><span>-</span>
    <span>
        <input type="text" name="txtAddr" id="txtAddr" value="" maxlength="128" class="length-s"></span>
    <span class="notice">（3+2郵遞區號-地址）</span>--%>
<%--</div>--%>


<script type="text/template" id="PublicOption">
    <option value="%Public%">%PublicName%</option>
</script>
