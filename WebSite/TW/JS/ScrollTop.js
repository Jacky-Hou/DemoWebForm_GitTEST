/*START : 滑動置頂*/
$(function(){
	$("#goTop").click(function(){
		$("html,body").animate({scrollTop:0},900);
		return false;
	});
});
//偵測menu是否碰到螢幕頂端
$(window).scroll(function () {
	var $scrollToMenu = $('#scrollToMenu');
	var $scrollToBuy = $('.ShopCart');
	var $Wrapper = $('.Wrapper');
	if($scrollToMenu.length > 0){
		var ScreenTop = $(window).scrollTop(); //螢幕頂端的座標
		var MenuTop = $scrollToMenu.offset().top; //Menu的座標
		
		if (ScreenTop >= MenuTop){
			$scrollToMenu.addClass("NavFixed");
			$Wrapper.addClass("WrapperFixed");
			$scrollToBuy.addClass("BuyFixed");
		}else{
			$scrollToMenu.removeClass("NavFixed");
			$Wrapper.removeClass("WrapperFixed");
			$scrollToBuy.removeClass("BuyFixed");
		}
	}
});
/*END : 滑動置頂*/
