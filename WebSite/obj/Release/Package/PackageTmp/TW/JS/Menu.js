/*============================================================
 //  array function (會影響 jquery.plugins)
============================================================*/
/*
Array.prototype.insert = function(index) {this.splice.apply(this, [index, 0].concat(Array.prototype.slice.call(arguments, 1)));return this;};
Array.prototype.clean = function(deleteValue) {for (var i = 0; i < this.length; i++) {if (this[i] == deleteValue) {this.splice(i, 1);i--;}}return this;};
*/
/*============================================================
 //  滑鼠滑入滑出效果 
============================================================*/
function MM_swapImgRestore(){var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;}
function MM_preloadImages(){var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}}
function MM_findObj(n, d){var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);if(!x && d.getElementById) x=d.getElementById(n); return x;}
function MM_swapImage(){var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}}
function MM_showHideLayers(){var i,p,v,obj,args=MM_showHideLayers.arguments;for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }obj.visibility=v; }}

/*============================================================
 //  開新視窗(前台 > 網站系統訊息,亦需使用)
============================================================*/
function PopWnd(strURL, strWndName, intWidth, intHeight, blnCentered, blnToolbar, blnScrollbar, blnResizable) {
	var m_objWnd=null;
	var m_strSettings = "";

	if (blnCentered && window.screen) {
		m_intXPos = (screen.availwidth) ? (screen.availwidth-intWidth)/2 : 0;
		m_intYPos = (screen.availheight) ? (screen.availheight-intHeight)/2 : 0;
		m_strSettings = 'top='+m_intYPos+',left='+m_intXPos+',';
	}
	
	m_strSettings += 'height='+intHeight+',width='+intWidth+',scrollbars='+blnScrollbar+',resizable='+blnResizable+',toolbar='+blnToolbar;

	m_objWnd = window.open(strURL,strWndName,m_strSettings);
	m_objWnd.resizeTo(intWidth,intHeight);
	//if(strURL != '') m_objWnd.location.href = strURL;
	m_objWnd.focus();
}

/*============================================================
 //  預覽圖片
============================================================*/
function ViewPic(f,txtN){
	if(f!='' && txtN!=''){
		var m_obj = document.getElementById(txtN);
		if(m_obj!=null){
			if(m_obj.value==""){
				alert('請先上傳檔案');
			}
			else{
				PopWnd('', 'wndShowPic', 500, 500, 1, 0, 1, 1);
				if(document.location.pathname.toLowerCase().indexOf('admin') >= 0){
					f.action='../ugA_showpic.asp';
				}
				else{
					f.action='ugC_showpic.asp';
				}
				
				f.txtN.value = txtN;
				f.target='wndShowPic';
				f.submit();
				f.target='';
			}
		}
	}
}

/*============================================================
 //  瀏覽檔案
============================================================*/
function ViewFile(strFileName){
	var f = document.frmUG;
	var m_obj = document.getElementById(strFileName);
	if(m_obj!=null){
		if(m_obj.value==""){
			alert('請先上傳檔案');
		}
		else{
			if(document.location.pathname.toLowerCase().indexOf('admin') >= 0){
				window.open('../../' + f.ImgP.value + '/' + m_obj.value,'_blank');
			}
			else{
				window.open(f.ImgP.value + '/' + m_obj.value,'_blank');
			}
		}
	}	
}

/*============================================================
 //  鎖右鎖(支援FireFox)
============================================================*/
var isRightKeySts = false;	//(true or false)
if(isRightKeySts){RightKey();}

function RightKey()
{
	if (document.layers){
		document.captureEvents(Event.MOUSEDOWN);
		document.onmousedown=clickNS4;
		document.onkeydown=OnDeny();
	}
	else if (document.all&&!document.getElementById){
		document.onmousedown=clickIE4;
		document.onkeydown=OnDeny();
	}
	
	document.oncontextmenu=new Function("return false");	
}

function clickIE4(){	
	if (event.button==2) return false;
}

function clickNS4(e){
	if (document.layers||document.getElementById&&!document.all){
		if (e.which==2||e.which==3) return false;
	}
}

function OnDeny(){
	if(event.ctrlKey || event.keyCode==78 && event.ctrlKey || event.altKey || event.altKey && event.keyCode==115) return false;
}

function GetElementsByName_iefix(tag,id) {
	var elem = document.getElementsByTagName(tag);
	var arr = new Array();
	var iarr = 0
	
	for(i=0;i<elem.length;i++){
		att = elem[i].getAttribute("id");
		
		if(att == id){
			arr[iarr] = elem[i];
			iarr++;
		}
	}
	
	return arr;
}