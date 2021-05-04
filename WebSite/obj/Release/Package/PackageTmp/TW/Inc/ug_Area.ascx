<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ug_Area.ascx.cs" Inherits="WebSite.TW.Inc.ug_Area" %>

<script>
    var AreaArry = "<%=Area%>".split(',');

    //區域選擇
    function ChgArea(e) {
        if ($(e).val() == 0) {
            $("#txtZipCodeID").val("");
        } else {
            $.each(AreaArry, function (Key, Val) {
                var ValAry = Val.split('&');
                if (ValAry[0].toString() == $(e).val()) {
                    $("#txtZipCodeID").val(ValAry[3].toString());
                }
            })
        }
    }
</script>

<span>
    <label for="selAreaID" style="display: none;">區域</label>
    <select name="selAreaID" id="selAreaID" onchange="ChgArea(this)" disabled="">
        <option value="0"><%=FirstIndex%></option>
    </select>
</span>

<script type="text/template" id="PublicOption">
    <option value="%Public%">%PublicName%</option>
</script>
