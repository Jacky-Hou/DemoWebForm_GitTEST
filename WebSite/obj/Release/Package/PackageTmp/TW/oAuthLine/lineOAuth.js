
var strLinkAuthUrl = "https://access.line.me/oauth2/v2.1/authorize?";
var strLineChannelID = 1653738662; 				            //Channel ID
var strLineSecret = "1cd41ffb764ab9dc4f27f7d47feeb41e";		//Secret
//var strLineRedirectURI = "http://demowebform.ugear.tw/TW/Member/ugC_Member_Login.aspx"; 		//在Line developer 的設定
var strLineRedirectURI = "http://localhost:4432/TW/Member/ugC_Member_Login.aspx"; 		//在Line developer 的設定
var strLineState = "uGearLineLogin"; 						//自訂驗證碼，隨便你填
var strLineScope = "openid%20email%20profile";				//你想要取得 User 的資料

var strLineValidURL = "https://api.line.me/oauth2/v2.1/token";

var _LineURL = strLinkAuthUrl;
_LineURL += "response_type=code";					//token 會回傳參數名 token 的授權碼
_LineURL += "&client_id=" + strLineChannelID;			//Channel ID
_LineURL += "&redirect_uri=" + strLineRedirectURI;	//在Line developer 的設定
_LineURL += "&state=" + strLineState;					//自訂驗證碼，隨便你填
_LineURL += "&scope=" + strLineScope;					//你想要取得 User 的資料


function Linelogin() {
    var winLineLogin = window.open(_LineURL, "LineLogin", 'width=800, height=600');

    var pollTimer = window.setInterval(function () {
        try {
            var winURL = winLineLogin.document.URL;
            //var winURL = winLineLogin.location.pathname;
            //alert(winURL);
            if (winURL.indexOf(strLineRedirectURI) !== -1) {
                window.clearInterval(pollTimer);
                debugger;
                var strQuryString = winLineLogin.document.location.search.substring(1);
                rtnLineToken = get_LineUrlValue(strQuryString, 'code');
                rtnLineState = get_LineUrlValue(strQuryString, 'state');

                if (rtnLineState === strLineState) {
                    validateLineToken(rtnLineToken);
                } else {
                    alert('發生錯誤(1)!!');
                }
                winLineLogin.close();
            }
        }
        catch (e) {
            //alert(e.message);
        }
    }, 1000);
}

function validateLineToken(mToken) {
    $.ajax({
        url: strLineValidURL,
        type: "POST",
        contentType: "application/x-www-form-urlencoded",
        data: {
            grant_type: 'authorization_code'
            , code: mToken
            , redirect_uri: strLineRedirectURI
            , client_id: strLineChannelID
            , client_secret: strLineSecret
        },
        success: function (responseText) {
            debugger;
            console.log(responseText);
            getLineUserInfo(responseText.id_token);
        }
    });
}

//------------ 取得User資料 -----------------
//JWT : Josn Web Token
function getLineUserInfo(mJWT) {
    debugger;
    var jsonPlayload = JSON.parse(atob(mJWT.split('.')[1]));
    setLineLoginType("success", jsonPlayload.sub, jsonPlayload.email, jsonPlayload.name);
}

//------------ 解析網址參數值 -----------------
function get_LineUrlValue(mQueryString, mParamName) {
    var arrParams = mQueryString.split('&');
    var strResult = "";
    var i = 0;

    for (i = 0; i < arrParams.length; i++) {
        var arrParam = arrParams[i].split('=');
        if (arrParam[0] === mParamName) strResult = arrParam[1];
    }

    return strResult;
}

function setLineLoginType(LoginSts, _id, _email, _name) {
    debugger;
    if (LoginSts === undefined)
        LoginSts = "";
    if (_id === undefined)
        _id = "";
    if (_email === undefined)
        _email = "";
    if (_name === undefined)
        _name = "";

    $.ajax({
        type: "POST",
        url: "../oAuthLine/LineLoginStatus.ashx",
        data: { "hidLoginSts": LoginSts, "hidUID": _id, "hidUEmail": _email, "hidUName": _name }
        //contentType: "application/Json;charset=utf-8"
    }).done(function (res) {
        if (res === "login") {
            alert('登入成功!!');
            window.location.reload();
        } else {
            alert(res);
        }
    }).fail(function () {
        alert('發生錯誤(2)!!');

    });
}
