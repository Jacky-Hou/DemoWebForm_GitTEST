<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ug_AcctHowKnow.ascx.cs" Inherits="WebSite.TW.Inc.ug_AcctHowKnow" %>

<script>
    var AcctHowKnowArry = "<%=AcctHowKnow%>".split(',');
    function SetAcctHowKnowSelOpt() {
        //如何得知
        $.each(AcctHowKnowArry, function (Key, Val) {
            var PublicOption = $("#PublicOption").html();
            PublicOption = PublicOption.replace("%Public%", Val)
                .replace("%PublicName%", Val)
            $("#selHowKnow").append(PublicOption);
        })
    }
</script>

<select name="selHowKnow" id="selHowKnow">
    <option value="" selected="selected">請選擇</option>
</select>

<script type="text/template" id="PublicOption">
    <option value="%Public%">%PublicName%</option>
</script>
