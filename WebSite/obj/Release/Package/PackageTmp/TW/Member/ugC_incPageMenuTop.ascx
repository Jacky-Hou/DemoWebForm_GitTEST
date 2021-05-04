<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ugC_incPageMenuTop.ascx.cs" Inherits="WebSite.TW.Member.ugC_incPageMenuTop" %>

<script type="text/javascript">
	<!--
	//function setIncLoginCmd(strCmd){	//logoff登出
	//	var f = document.frmUGIncLogin;
	//	f.hidIncFType.value="";
	//	if(strCmd=="logoff"){f.hidIncFType.value=strCmd;}
	//	f.submit();
	//}
	//-->
</script>

<!--響應式次選單-->
<div id="SlideDownButton"></div>
<div id="SlideUpButton"></div>
<div id="SlideMenu">
    <ul>
        <li>
            <a href="/tw/Member/ugC_Member.aspx" id="TopVipAdd" title="會員登入">加入會員 </a>
        </li>
        <li>
            <a href="/tw/Member/ugC_Member_Login.aspx" id="TopVipLogin" title="會員登入">會員登入 </a>
        </li>

<%--    Todo  20190814 Mark
        <li>    
            <a href="/tw/Member/Forgot-Password" id="TopForgetPw" title="忘記密碼">忘記密碼 </a>
        </li>
        <li>
            <a href="/tw/Member/Epaper" id="TopIsEPaper" title="電子報訂閱">電子報訂閱</a>
        </li>--%>
    </ul>
</div>
