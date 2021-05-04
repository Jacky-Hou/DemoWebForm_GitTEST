<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FBshare.aspx.cs" Inherits="WebSite.Jquery.FBshare" %>

<!DOCTYPE html>

<html prefix='og: http://ogp.me/ns#'>
<head>
    <title>Your Website Title</title>
    <!-- You can use Open Graph tags to customize link previews.
    Learn more: https://developers.facebook.com/docs/sharing/webmasters -->

    <meta property="og:url" content="http://www.yahoo.com.tw" />
    <meta property="og:type" content="website" />
    <meta property="og:title" content='測驗結果' />
    <meta property="og:description" content="防災學習測驗" />
    <meta property="og:image" content="https://cnet1.cbsistatic.com/img/-B3kmqxu8sB6pYlTVZqRF9_cJB0=/2020/04/16/7d6d8ed2-e10c-4f91-b2dd-74fae951c6d8/bazaart-edit-app.jpg" />

</head>
<body>

    <!-- Load Facebook SDK for JavaScript -->
<%--    <div id="fb-root"></div>--%>
<%--    <script>(function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.0";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));</script>--%>

    <!-- Your share button code -->
<%--    <div class="fb-share-button"
        data-href="http://10.168.168.78:10003/tw/Exam/ugC_Exam_Ans.aspx?ID=59&CID=4&ERCID=31"
        data-layout="button_count">
    </div>--%>

    <div id="fb-root"></div>
    <script async defer src="https://connect.facebook.net/zh_TW/sdk.js#xfbml=1&version=v7.0">
    </script>

    <div class="fb-share-button" data-href="http://10.168.168.78:10003/tw/Exam/ugC_Exam_Ans.aspx?ID=59&CID=4&ERCID=31" data-layout="button" data-size="large">
        分享
    </div>
    
</body>
</html>
