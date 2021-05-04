<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ug_City.ascx.cs" Inherits="WebSite.TW.Inc.ug_City" %>

<script>
    var CityArry = "<%=City%>".split(',');

    //城市選擇
    function ChgCity(e) {

        $("#selAreaID").empty();
        $("#txtZipCodeID").val("");

        var PublicOption = $("#PublicOption").html();
        PublicOption = PublicOption.replace("%Public%", "0")
            .replace("%PublicName%", "----區域----")
        $("#selAreaID").append(PublicOption);

        if ($(e).val() == 0)
            $("#selAreaID").prop('disabled', true);
        else {
            $("#selAreaID").prop('disabled', false);

            $.each(AreaArry, function (Key, Val) {
                var ValAry = Val.split('&');
                if (ValAry[2].toString() == $(e).val()) {
                    var PublicOption = $("#PublicOption").html();
                    PublicOption = PublicOption.replace("%Public%", ValAry[0].toString())
                        .replace("%PublicName%", ValAry[1].toString() + " " + ValAry[3].toString())
                    $("#selAreaID").append(PublicOption);
                }
            })
        }
    }
</script>

<span>
    <label for="selCityID" style="display: none;">城市</label>
    <select name="selCityID" id="selCityID" onchange="ChgCity(this)" disabled="">
        <option value="0"><%=FirstIndex%></option>
    </select>
</span>

<script type="text/template" id="PublicOption">
    <option value="%Public%">%PublicName%</option>
</script>

