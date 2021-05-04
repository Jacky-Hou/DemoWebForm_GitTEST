/*============================================================
 //  判斷輸入的值,是否為0
	ChkNumZero(f.txtDueDate.value,'設定期限：天數')
============================================================*/
function ChkNumZero(objName, strTitle){
	var isZero=1;
	var intCnt=0;
	for(intCnt=0; intCnt<objName.length; intCnt++){
		if(objName.charAt(intCnt) != '0' ) return"";
	}
	if(isZero=1){return(strTitle + "　不能為0!!<br>");}
}
/*============================================================
 // 驗證身份證字號格式
	y+=ChkIdentity(f.txtPID.value,'');
	y+=ChkEmpty('txtPID','身分證字號','ChkIdentity(document.frmUG.txtPID.value,\'\',document.frmUG.radSex)','');
============================================================*/
function ChkIdentity(strPID,strTitle,radSex){
	var intCnt=0;
	if(strTitle==""){strTitle = "您";}	
	if( strPID.length == 0 ){return"";}
	
	var strMatchID = strPID;
	if(strMatchID.length<10){return strTitle + "的身分證字號不滿10個字!!<br>";}
	
	var strGetValue = strMatchID.charAt(0);
	if(strGetValue<"A" || strGetValue> "Z"){return strTitle + "的身分證字號第一碼必須是大寫的英文字母 !<br>";}
	
	strGetValue = strMatchID.charAt(1);
	if(strGetValue!="1" && strGetValue!="2"){return strTitle + "的身分證字號第二碼有問題!!<br>";}
	
	for(intCnt=1;intCnt<10;intCnt++){
		if(isNaN(parseFloat(strMatchID.charAt(intCnt)))){return strTitle + "的身分證字號第二到十碼有問題!!<br>";break;}
	}
	
	var strMatchAlpha = new Array("A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","U","V","X","Y","W","Z","I","O");
	var strMatchNum = new Array("10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35");
	var intMatchNum=0;
	for(intCnt=0;intCnt<strMatchAlpha.length;intCnt++){
		if(strMatchID.charAt(0)==strMatchAlpha[intCnt]){intMatchNum=intCnt;}
	}
	
	var intCount1 = parseFloat(strMatchNum[intMatchNum].charAt(0)) + (parseFloat(strMatchNum[intMatchNum].charAt(1)) * 9);
	var intCount2 = 0;
	for(intCnt=1;intCnt<strMatchID.length-1;intCnt++){
		intCount2 = intCount2 + parseFloat(strMatchID.charAt(intCnt))*(9-intCnt);
	}
	
	var intCount3 = parseFloat(strMatchID.charAt(9));
	var intCount4 = intCount1 + intCount2 + intCount3;
	if((intCount4 % 10)!=0){return strTitle + "的身分證字號有問題!!<br>";}
	
	if(radSex!=null){
		for(intCnt=0;intCnt<radSex.length;intCnt++){
			if(radSex[intCnt].checked){
				switch(radSex[intCnt].value)
				{
					case "M":
						if(strPID.charAt(1)!='1') return "身分證字號與性別不符!!<br>";
						break;
					case "F":
						if(strPID.charAt(1)!='2') return "身分證字號與性別不符!!<br>";
						break;
					default:
						break;
				}
			}
		}
	}
	return "";
}
/*============================================================
  // 驗證公司統編格式
	y+=ChkCompanyIdno(document.frmUG.txtPID.value);
	y+=ChkEmpty('txtPID','統一編號','ChkCompanyIdno(document.frmUG.txtPID.value);','');
============================================================*/
function ChkCompanyIdno(strCompanyIdno){
	var res = new Array(8);
	var key = "12121241";
	var isModeTwo = false;	//第七個數是否為七
	var result = 0;

	if(strCompanyIdno.length != 8){return "統一編號不可少於或多於8碼!!<br>";}
	for(var i=0; i<8; i++){
		var tmp = strCompanyIdno.charAt(i) * key.charAt(i);
		res[i] = Math.floor(tmp/10) + (tmp%10);		/*取出十位數和個位數相加*/
		if(i == 6 && strCompanyIdno.charAt(i) == 7)
			isModeTwo = true;
	}
	for(var s=0; s<8; s++)
		result += res[s];
	
	if(isModeTwo){
		//如果第七位數為7
		if((result % 10) != 0 && ((result + 1) % 10) != 0){return "統一編號有問題!!<br>";}
	}else
		if((result % 10) != 0){return "統一編號有問題!!<br>";}
	return "";
}
/*============================================================
 // 驗證日期格式2009/07/31
	ChkDate(f.txtBgnDate.value,'使用期限：開始日期')
============================================================*/
function ChkDate(strDate, strTitle) {
	var intCnt=0;
	
	if(strDate.length != 10) return(strTitle + "　格式錯誤，須為yyyy/mm/dd!!<br>");
	//if(strDate.length < 8) return(strTitle + "　格式錯誤，少於8位數!!<br>");
	var arrDate = new Array(strDate.split("/").length);
	arrDate = strDate.split("/");
 
	if(arrDate.length != 3) return(strTitle + "　格式錯誤,須為yyyy/mm/dd!!<br>");
	else{
	    for(intCnt=0; intCnt<strDate.length; intCnt++){
    	    if(!((strDate.charAt(intCnt) >= '0' && strDate.charAt(intCnt) <= '9' ) || ( strDate.charAt(intCnt) == '/'))) {
    	        return(strTitle + "　不能有 數字 及 / 以外的字元!!<br>");
    	    }
    	}
		
		if(arrDate[0].length != 4) return(strTitle + "　年須為四位數!!<br>");
		if(arrDate[1].length > 2 || arrDate[1].length < 1) return(strTitle + "　月份格式錯誤(須為二位數)!!<br>");
		if(arrDate[2].length > 2 || arrDate[2].length < 1) return(strTitle + "　天數格式錯誤(須為二位數)!!<br>");
		if(arrDate[1] > 12) return(strTitle + "　月不可大於12!!<br>");
		if(Number(arrDate[1]) < 1) return(strTitle + "　月不可小於1!!<br>");
		if(Number(arrDate[2]) < 1) return(strTitle + "　" + arrDate[1] + "月 天數不正確!!<br>");	
		
		if(arrDate[1] == 2){
			if((arrDate[0] % 4 != 0) && (arrDate[2] > 28))return(strTitle + "　" + arrDate[0] + "年2月不可大於28天!!<br>");
			else if(arrDate[2] > 29) return(strTitle + "　" + arrDate[0] + "年2月不可大於29天!!<br>");
		}
		else{
			if((arrDate[1] == 1) || (arrDate[1] == 3) || (arrDate[1] == 5) || (arrDate[1] == 7) || (arrDate[1] == 8) || (arrDate[1] == 10) || (arrDate[1] == 12)){
				if(arrDate[2] > 31) return(strTitle + "　" + arrDate[1] + "月不可大於31天!!<br>");
			}
			else if(arrDate[2] > 30) return(strTitle + "　" + arrDate[1] + "月不可大於30天!!<br>");
		}
	}	
	return"";
}
/*============================================================
 // 驗證長度
	ChkLenLessOne(f.txtPsw.value,'密碼')
	長度(<len)==>最少
============================================================*/
function ChkLenLessOne(objName,intLimitLen,strTitle){	
	if(objName.length < intLimitLen){
		return(strTitle+"　長度錯誤(最少需輸入"+ intLimitLen + "個字)!!<br>")
	}
	return"";
}

function isEmpty(mString){return /^[\s]*$/.test(mString.toString());}
/*============================================================
 // 檢查資料是否有值
 　　* onAction需使用分號區分function
	y+=ChkEmpty('txtBgnDate','開始日期','ChkDate(document.frmUG.txtBgnDate.value,\'開始日期\');','必須選擇資料');
	y+=ChkEmpty('txtEndDate','結束日期','ChkDate(document.frmUG.txtEndDate.value,\'結束日期\');','必須選擇資料');
============================================================*/
function ChkEmpty(objName,strTitle,onAction,strRtnTxt) {
	var intCnt=0;
	var strReturnTxt = '';
	var objName = document.getElementsByName(objName);
	if(objName != null && objName.length > 0){		
		var strObjType = objName[0].type.toLowerCase();
		var isEmpty = true;
	
		switch(strObjType){
		case "checkbox":
		case "radio":
			isEmpty = true;
			for(intCnt=0;intCnt<objName.length;intCnt++){
				if(objName[intCnt].checked){
					isEmpty = false;
					break;
				}
			}
			
			if(isEmpty == true){
				if(strObjType == 'checkbox'){						
					strReturnTxt = strRtnTxt ? strRtnTxt : '請至少選擇一項';
				}else{
					strReturnTxt = strRtnTxt ? strRtnTxt : '必須選擇資料';
				}
				
                return strTitle + '　' + strReturnTxt + '!!<br>';
			}
			break;
		default:	//text or select
			if(objName[0].value.replace(/^[\s　]+|[\s　]+$/g,'').replace(/<br \/>/g, '').replace(/<p>&nbsp;<\/p>/g, '')==''){
				if(strObjType == "select-one"){
					strReturnTxt = strRtnTxt ? strRtnTxt : '必須選擇資料';
				}else{
					strReturnTxt = strRtnTxt ? strRtnTxt : '必須輸入資料';
				}
				
                return strTitle + '　' + strReturnTxt + '!!<br>';
            } else {
				if(onAction != '' && typeof(onAction)!='undefined')
                {
					var arrAction = onAction.split(";");
					for(intCnt=0;intCnt<arrAction.length-1;intCnt++)
					{
						if(eval(arrAction[intCnt])!=""){return eval(arrAction[intCnt]);}
					}
				}
			}
		}
	}
	return "";
}
/*============================================================
 // 檢查資料格式
	ChkBlock('code','txtCatCode','編號')
============================================================*/
//function ChkBlock(strType,objName,strTitle){
//	var objName = document.getElementsByName(objName);
//	var strMsg = '';
	
//	if(objName != null && objName.length > 0){	
//		var objReg = GetReg(strType);
//		switch(strType){
//			case "num":				//僅限數字0~9
//				strMsg = '　格式錯誤(請輸入數字)';
//				break;
//			case "numdot":			//僅限數字0~9及小數點(無)
//				strMsg = '　格式錯誤(請輸入數字或 \'.\' )';
//				break;
//			case "anum":			//僅限小寫英文或數字
//				objName[0].value = objName[0].value.toLowerCase();
//				strMsg = '　格式錯誤(請輸入小寫字母或數字)';					
//				break;
//			case "Anum":			//僅限大寫英文或數字(無)
//				objName[0].value = objName[0].value.toUpperCase();
//				strMsg = '　格式錯誤(請輸入大寫字母或數字)';					
//				break;
//			case "Aanum":			//僅限大寫英文或小寫英文或數字
//				strMsg = '　格式錯誤(請輸入英文字母或數字)';					
//				break;
//			case "useracct":		//會員帳號（無）
//				objName[0].value = objName[0].value.toLowerCase();
//				strMsg = '　格式錯誤(請輸入英文字母或數字或_)';					
//				break;
//			case "code":			//編號
//				strMsg = '　格式錯誤(請輸入英文字母或數字或\'_\'或\'-\')';
//				break;
//			case "car":				//車牌(無)
//				objName[0].value = objName[0].value.toUpperCase();
//				strMsg = '　格式錯誤(請輸入英文字母或數字或-)';
//				break;
//			case "Aa":				//僅限大寫英文或小寫英文
//				objName[0].value = objName[0].value.toLowerCase();
//				strMsg = '　格式錯誤(請輸入英文字母)';					
//				break;
//			case "email":
//				strMsg = '　格式錯誤';
//				break;
//			case "PW6-16AanumSC":	//Minimum 6 and maximum 16 characters, at least one uppercase letter, one lowercase letter, one number and one special character
//				strMsg = '　格式錯誤';
//				break;
//			case "tel":				//電話
//				strMsg = '　格式錯誤(請輸入數字或\'#\'或\'(\'或\')\'或\'-\')';					
//				break;
//			case "ctel":			//Ctel
//				strMsg = '　格式錯誤(請輸入數字或\'-\')';
//				break;
//			default:
//				break;
//		}
		
//		if(objReg.test(objName[0].value)==false){return(strTitle + strMsg + '!!<br>');}	//如果為true,則回傳錯誤
//	}
//	return "";
//}

function ChkBlock(strType, ObjName, strTitle) {
    var objName = document.getElementById(ObjName);
    var strMsg = '';

    if (objName != null && objName.value.length > 0) {
        var objReg = GetReg(strType);   //驗證正規話格式
        switch (strType) {
            case "num":				//僅限數字0~9
                strMsg = '　格式錯誤(請輸入數字)';
                break;
            case "numdot":			//僅限數字0~9及小數點(無)
                strMsg = '　格式錯誤(請輸入數字或 \'.\' )';
                break;
            case "anum":			//僅限小寫英文或數字
                objName.value = objName.value.toLowerCase();
                strMsg = '　格式錯誤(請輸入小寫字母或數字)';
                break;
            case "Anum":			//僅限大寫英文或數字(無)
                objName.value = objName.value.toUpperCase();
                strMsg = '　格式錯誤(請輸入大寫字母或數字)';
                break;
            case "Aanum":			//僅限大寫英文或小寫英文或數字
                strMsg = '　格式錯誤(請輸入英文字母或數字)';
                break;
            case "useracct":		//會員帳號（無）
                objName.value = objName.value.toLowerCase();
                strMsg = '　格式錯誤(請輸入英文字母或數字或_)';
                break;
            case "code":			//編號
                strMsg = '　格式錯誤(請輸入英文字母或數字或\'_\'或\'-\')';
                break;
            case "car":				//車牌(無)
                objName.value = objName.value.toUpperCase();
                strMsg = '　格式錯誤(請輸入英文字母或數字或-)';
                break;
            case "Aa":				//僅限大寫英文或小寫英文
                objName.value = objName.value.toLowerCase();
                strMsg = '　格式錯誤(請輸入英文字母)';
                break;
            case "email":
                strMsg = '　格式錯誤';
                break;
            case "PW6-16AanumSC":	//Minimum 6 and maximum 16 characters, at least one uppercase letter, one lowercase letter, one number and one special character
                strMsg = '　格式錯誤';
                break;
            case "tel":				//電話
                strMsg = '　格式錯誤(請輸入數字或\'#\'或\'(\'或\')\'或\'-\')';
                break;
            case "ctel":			//Ctel
                strMsg = '　格式錯誤(請輸入數字或\'-\')';
                break;
            default:
                break;
               
        }
 
        if (objReg.test(objName.value) == false) { return (strTitle + strMsg + '!!<br>'); }	//如果為true,則回傳錯誤
    }
    return "";
}

/*============================================================
 // 檢查輸入的資料格式
	KeyPressBlock(event,12);
============================================================*/
function KeyPressBlock(e,strType){
	var key = window.event ? e.keyCode : e.which;	//IE : Netscape/Firefox/Opera 
	
	if(key == 8 || key == 0){						//Backspace鍵,左右鍵
	
	}else{
		var keychar = String.fromCharCode(key);
		switch(strType){
			case "email":
				var objReg = /[A-Za-z0-9-_@.]/;
				break;
			case "PW6-16AanumSC":
				var objReg = /[A-Za-z0-9_#?!@$%^&*-]/;
				break;
			default:
				var objReg = GetReg(strType);
				break;
		}
		
		switch(strType){
			case "anum":			//僅限小寫英文或數字
				if(window.event){
					keychar = keychar.toLowerCase();
					event.keyCode = keychar.charCodeAt();
				}
				break;
			case "Anum":			//僅限大寫英文或數字
				if(window.event){
					keychar = keychar.toUpperCase();
					event.keyCode = keychar.charCodeAt();
				}
				break;
			case "a":				//僅限小寫英文(目前無使用)
				if(window.event){
					keychar = keychar.toLowerCase();
					event.keyCode = keychar.charCodeAt();
				}
				break;
			case "A":				//僅限大寫英文(目前無使用)
				if(window.event){
					keychar = keychar.toUpperCase();
					event.keyCode = keychar.charCodeAt();
				}
				break;
			case "useracct":		//for 會員帳號使用
				if(window.event){
					keychar = keychar.toLowerCase();
					event.keyCode = keychar.charCodeAt();
				}
				break;
			case "car":		//for 車牌 使用
				if(window.event){
					keychar = keychar.toUpperCase();
					event.keyCode = keychar.charCodeAt();
				}
				break;
		}
		return objReg.test(keychar);
	}	
}

function GetReg(strValue){
	switch(strValue){
		case "num":				//僅限數字0~9
			return eval("/^[0-9]+$/");
			break;			
		case "numdot"	:		//僅限數字0~9及小數點
			return eval("/^[0-9.]+$/");
			break;
		case "a":				//僅限小寫英文
			return eval("/^[a-z]+$/");
			break;
		case "A":				//僅限大寫英文
			return eval("/^[A-Z]+$/");
			break;
		case "anum":			//僅限小寫英文或數字
			return eval("/^[a-z0-9]+$/");
			break;	
		case "Anum":			//僅限大寫英文或數字
			return eval("/^[A-Z0-9]+$/");
			break;		
		case "Aanum":			//僅限大寫英文或小寫英文或數字
			return eval("/^[A-Za-z0-9]+$/");
			break;	
		case "Aa":				//僅限大寫英文或小寫英文
			return eval("/^[A-Za-z]+$/");
			break;	
		case "email":			//E-Mail
			return eval("/^([a-zA-Z0-9_\\.\\-\\+])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$/;");
			break;		
		case "PW6-16AanumSC":	//Minimum 6 and maximum 16 characters, at least one uppercase letter, one lowercase letter, one number and one special character
			return eval("/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[_#?!@$%^&*-]).{6,16}$/;");
			break;
		case "date":			//日期
			return eval("/^[0-9/]+$/");
			break;
		case "tel":				//電話
			return eval("/^[0-9#()-]+$/");
			break;
		case "ctel":			//Ctel
			return eval("/^[0-9-]+$/");
			break;
		case "dashnum":			//僅限正負數字
			return eval("/^[0-9-]+$/");
			break;
		case "useracct":		//會員帳號使用
			return eval("/^[a-z0-9_]+$/");
			break;
		case "code":			//編號
			return eval("/^[A-Za-z0-9-_]+$/");
			break;
		case "car":				//車牌
			return eval("/^[A-Za-z0-9-]+$/");
			break;
	}
}
/*============================================================
 // 從右取幾位數
	CutRight(f.txtSubject.value,2)
============================================================*/
function CutRight(strValue, intCutLen){
	if (intCutLen <= 0)
		return "";
	else if (intCutLen > String(strValue).length)
		return strValue;
	else {
		var iLen = String(strValue).length;
		return String(strValue).substring(iLen, iLen - intCutLen);
    }
}
/*============================================================
 // 刷新圖形驗證碼
============================================================*/
function RefreshImage(valImageId) {
	var objImage = document.images[valImageId];
	if (objImage == undefined) {return;}
	var now = new Date();
	objImage.src = objImage.src.split('?')[0] + '?x=' + now.toUTCString();
}

function ReloadCaptcha(id) {
    var src = $("#" + id).attr('src');
    var url = src + "?DataTime=" + Date.now();
    $.ajax({
        type: "GET",
        url: url
    }).done(function () {
        $("#" + id).attr("src", url);
    });
}
/*============================================================
// 文字方塊裡面顯示提示文字
onfocusState(object ID,提示文字)
============================================================*/
function onfocusState(obj,InitTxt){
	if(document.getElementById(obj).value==InitTxt){
		document.getElementById(obj).value="";
	}else if(document.getElementById(obj).value==""){
		document.getElementById(obj).value=InitTxt;
	}else{
	}
}



