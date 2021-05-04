<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ug_AcctOccu.ascx.cs" Inherits="WebSite.TW.Inc.ug_AcctOccu" %>

<script>
    var AcctOccuArry = "<%=AcctOccu%>".split(',');
    function SetAcctOccuSelOpt() {
        //職業
        $.each(AcctOccuArry, function (Key, Val) {
            var PublicOption = $("#PublicOption").html();
            PublicOption = PublicOption.replace("%Public%", Val)
                .replace("%PublicName%", Val)
            $("#selOccu").append(PublicOption);
        })
    }
</script>

<select name="selOccu" id="selOccu">
    <option value="" selected="selected">請選擇</option>
</select>

<script type="text/template" id="PublicOption">
    <option value="%Public%">%PublicName%</option>
</script>
