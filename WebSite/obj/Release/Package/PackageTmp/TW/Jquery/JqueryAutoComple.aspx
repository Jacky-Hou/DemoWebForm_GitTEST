<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JqueryAutoComple.aspx.cs" Inherits="WebSite.Jquery.JqueryAutoComple" %>

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

    <%--    <style>
        .ui-autocomplete {
            max-height: 200px;
            overflow-y: auto;
            /* prevent horizontal scrollbar */
            overflow-x: hidden;
        }
        /* IE 6 doesn't support max-height
   * we use height instead, but this forces the menu to always be this tall
   */
        * html .ui-autocomplete {
            height: 200px;
        }
    </style>--%>
    <script>
        var JsonArray = [];
        var WorkNameTags = [];
        var HazardNameTage = [];
        var WorkList;

        $(function () {
            WorkList = "<%=WorkList%>".split(',');

            WorkList.forEach(function (key) {
                WorkNameTags.push(key.split('&')[1]);
                JsonArray.push({ "ID": key.split('&')[0], "Name": key.split('&')[1] });
            })


<%--        WorkNameTags = "<%=WorkList%>".split(',')--%>
            //var WorkNameTags = [
            //    "ActionScript",
            //    "AppleScript",
            //    "Asp",
            //    "BASIC",
            //    "C",
            //    "C++",
            //    "Clojure",
            //    "COBOL",
            //    "ColdFusion",
            //    "Erlang",
            //    "Fortran",
            //    "Groovy",
            //    "Haskell",
            //    "Java",
            //    "JavaScript",
            //    "Lisp",
            //    "Perl",
            //    "PHP",
            //    "Python",
            //    "Ruby",
            //    "Scala",
            //    "Scheme"
            //];

            $("#work").autocomplete({
                source: WorkNameTags,
                minLength: 0,
                select: function (event, ui) {
                    var Name = ui.item.value;
                    var filteredObj = JsonArray.find(function (item, i) {
                        if (item.Name == Name) {
                            Name = "";
                            $.ajax({
                                type: "POST",
                                url: "JqueryAutoComple.aspx/GetHazardName",
                                data: { "WorkProjectsID": item.ID }
                                //contentType: 'application/json; charset=utf-8'
                            }).done(function (res) {
                                HazardNameTage = res.split(',');
                                $("#Hazard").autocomplete({
                                    source: HazardNameTage,
                                    minLength: 0
                                }).focus(function () {
                                    $(this).autocomplete('search', $(this).val())
                                });
                            });
                        }
                    })
                }
            }).focus(function () {
                $(this).autocomplete('search', $(this).val())
            });
        });
    </script>
</head>

<body>
    <div class="ui-widget">
        <label for="work">工作項目: </label>
        <input id="work" />

        <label for="Hazard">危險項目: </label>
        <input id="Hazard" style="width:50%"/>

    </div>
</body>
</html>
