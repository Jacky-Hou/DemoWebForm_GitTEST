<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ug_AcctCatID.ascx.cs" Inherits="WebSite.TW.Inc.ug_AcctCatID" %>

<script>
    function SetAcctCatIDSelOpt() {
        var AcctCatIDArry = "<%=AcctCatID%>".split(',');

        if ("<%=FirstIndex%>" != "") {
            var AcctCatID_option = $("#CatName_option").html();
            AcctCatID_option = AcctCatID_option.replace("%CatName%", "<%=FirstIndex%>")
                .replace("%AcctCatID%", "0")
                .replace("%Upsts%", "");
            $("#selAcctCatID").append(AcctCatID_option);
        }
        $.each(AcctCatIDArry, function (Key, Val) {
            var ValAry = Val.split('&');
            var AcctCatID_option = $("#CatName_option").html();
            AcctCatID_option = AcctCatID_option.replace("%AcctCatID%", ValAry[0].toString())
                .replace("%CatName%", ValAry[1].toString())
                .replace("%UpSts%", ValAry[2].toString());
            $("#selAcctCatID").append(AcctCatID_option);
        })
    }
</script>

<select name="selAcctCatID" id="selAcctCatID">
</select>

<script type="text/html" id="CatName_option">
    <option value="%AcctCatID%" upsts="%UpSts%">%CatName%</option>
</script>


