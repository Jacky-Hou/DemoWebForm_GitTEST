<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ug_AcctEdu.ascx.cs" Inherits="WebSite.TW.Inc.ug_AcctEdu" %>

<script>
    var AcctEduArry = "<%=AcctEdu%>".split(',');
    function SetAcctEduSelOpt() {
        //學歷
        $.each(AcctEduArry, function (Key, Val) {
            var PublicOption = $("#PublicOption").html();
            PublicOption = PublicOption.replace("%Public%", Val)
                .replace("%PublicName%", Val)
            $("#selEdu").append(PublicOption);
        })
    }
</script>

<select name="selEdu" id="selEdu">
    <option value="" selected="selected">請選擇</option>
</select>

<script type="text/template" id="PublicOption">
    <option value="%Public%">%PublicName%</option>
</script>
