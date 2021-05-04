$(function(){
	$(document).ready(function(){
		$(".Div01").hide();
	});
	
	$(".SliderDiv").click(function(){
		//$(this).parent().parent().prev().eq(0).find("div").eq(2).stop(true,true).slideToggle(500);
		$(this).parent().stop(true,true).toggleClass("selected");
		$(this).next().stop(true,true).slideToggle(500);
		return false;
	});
});