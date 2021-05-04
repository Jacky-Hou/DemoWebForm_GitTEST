<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ugC_incMember.ascx.cs" Inherits="WebSite.TW.Member.ugC_incMember" %>

<div id="tbContent">
    <form name="frmLoginUG" id="frmLoginUG" method="post" action="">
        <div class="memberlogin memberloginWrap">
            <div class="memberlogin_Left">
                <ul>
                    <li>
                        <div>
                            <label for="txtLoginID">電子郵件</label>
                        </div>
                        <div class="memberlogin_box">
                            <input type="text" name="txtLoginID" id="txtLoginID" maxlength="255">
                        </div>
                    </li>
                    <li>
                        <div>
                            <label for="txtPsw">會員密碼</label>
                        </div>
                        <div class="memberlogin_box">
                            <input type="password" name="txtPsw" id="txtPsw" autocomplete="off">
                        </div>
                    </li>
                    <li>
                        <div>
                            <label onblur="txtLoginCaptchacode">驗證碼</label>
                        </div>
                        <div class="memberlogin_box">
                            <input type="text" name="txtLoginCaptchacode" id="txtLoginCaptchacode" onkeypress="">
                            <span class="Captcha">
                                <img src="../ugC_Captcha.aspx" id="imgCaptcha"></span>
                            <%--                                <a href="#" onclick="ReloadCaptcha('imgCaptcha');" title="更新驗證碼">更新驗證碼</a> --%>
                            <a href="javascript:void(0)" id="lbut_Captchacode" onclick="ReloadCaptcha('imgCaptcha')" title="更新驗證碼">更新驗證碼</a>
                            <a href="/tw/Captcha-Text/ugC_Captcha-Text.aspx" target="_blank" title="文字驗證碼(新視窗開啟)">文字驗證碼</a>
                        </div>
                    </li>
                    <li class="Login_Btn"><a href="#" onclick="SetLoginCmd('login');return false;" title="登入"><i class="fa fa-sign-in"></i>登入</a></li>
                    <li class="Login_Btn_Two">
                        <ul>
                            <%--                            <li><a href="/tw/Member/Forgot-Password" title="忘記密碼">忘記密碼</a></li>--%>
                            <li><a href="/tw/Member/ugC_Member.aspx" title="加入會員">加入會員</a></li>
                        </ul>
                    </li>
                    <li>
                        <div>
                            <input type="hidden" name="CSRFtoken" id="CSRFtoken" value="<%=CSRFtoken%>" />
                        </div>
                    </li>
                </ul>
            </div>
            <div class="memberlogin_Right">
                <ul>
                    <li class="Login_Btn FacebookLogin_Btn"><a href="#" onclick="fnLoginFb();return false;" title="Facebook 登入"><i class="fa fa-facebook-square" aria-hidden="true"></i>Facebook 登入</a></li>
                    <li class="Login_Btn GoogleLogin_Btn"><a href="#" onclick="GPlogin();return false;" title="GMail 登入"><i class="fa fa-google-plus-official" aria-hidden="true"></i>GMail 登入</a></li>
                    <li class="Login_Btn LineLogin_Btn"><a href="#" onclick="Linelogin();return false;" title="Line 登入"><i class="fa fa-line-official" aria-hidden="true"></i>Line 登入</a></li>
                </ul>
            </div>
        </div>

    </form>
</div>

