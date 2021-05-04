$(function(){
	$(".Menu").find(".SubMenu").slideUp(1);
	$(".MenuLiA").click(function(){
		$(this).parent().find(".SubMenu").stop(true,true).slideToggle(900);
		return false;
	});
});