<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FBorLineshare.aspx.cs" Inherits="WebTest.Test.FBorLineshare" %>

<!DOCTYPE html>

<html>
<head>
    <title>Your Website Title</title>
    <!-- You can use Open Graph tags to customize link previews.
    Learn more: https://developers.facebook.com/docs/sharing/webmasters -->

    <meta property="og:url" content="http://demowebform.ugear.tw/Test/FBorLineshare.aspx" />
    <meta property="og:type" content="website" />
    <meta property="og:title" content='測驗結果' />
    <meta property="og:site_name" content="uGear 優吉兒網站設計">
    <meta property="og:description" content="防災學習測驗" />
<%--    <meta property="og:image" content="http://demowebform.ugear.tw/tw/Images/mario.png" />--%>
    <meta property="og:image" content="" />
    <meta property="og:image:width" content="200" />
    <meta property="og:image:height" content="200" />


    <%--    <script src="Js/jquery-1.12.4.js"></script>--%>
    <script src="../Scripts/jquery-1.9.1.js"></script>

    <script>
        $(document).ready(function () {
            var Url = encodeURIComponent("http://demowebform.ugear.tw/Test/FBorLineshare.aspx");
            $("#LineShare").attr("href", "https://social-plugins.line.me/lineit/share?url=" + Url);
            $("#FBShare").attr("href", "https://www.facebook.com/sharer/sharer.php?kid_directed_site=0&sdk=joey&u=" + Url + "&display=popup&ref=plugin&src=share_button");
        })


    </script>

</head>
<body>

    <!-- Load Facebook SDK for JavaScript -->
    <%--    <div id="fb-root"></div>
    <script>(function (d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.0";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));</script>

    <!-- Your share button code -->
    <div class="fb-share-button"
        data-href="http://demowebform.ugear.tw/Test/FBorLineshare.aspx"
        data-layout="button_count">
    </div>--%>

    <%-- ==============================================--%>

    <%--<div id="fb-root"></div>
    <script async defer src="https://connect.facebook.net/zh_TW/sdk.js#xfbml=1&version=v7.0">
    </script>
    <div class="fb-share-button" data-href="http://10.168.168.78:10003/tw/Exam/ugC_Exam_Ans.aspx?ID=59&CID=4&ERCID=31" data-layout="button" data-size="large">
        分享
    </div>--%>

    <a id="FBShare">FB分享</a>

    <%-- ==============================================--%>

    <%--<div class="line-it-button" data-lang="zh_Hant" data-type="share-a" data-ver="3" data-url="http://10.168.168.78:10003/tw/Exam/ugC_Exam_Ans.aspx?ID=59&CID=4&ERCID=31" data-color="default" data-size="large" data-count="false" style="display: none;"></div>
    <script src="https://d.line-scdn.net/r/web/social-plugin/js/thirdparty/loader.min.js" async="async" defer="defer"></script>--%>

    <a id="LineShare">Line分享</a>

</body>
</html>
