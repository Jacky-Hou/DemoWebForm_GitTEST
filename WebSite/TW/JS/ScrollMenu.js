/*START : Menu 滑動*/
$(window).load(function(){   
	$(document).on("scroll", onScroll);
	
	$(".bookmark").click(function(){
		var id = $(this).attr('id');
		var myTop = $("#" + id + "Bookmark").offset().top;
		$("html, body").animate({scrollTop:myTop},450);
		return false;
	});
	$(".bookmark").hover(
		function() {
			$(".bookmark").addClass( "none" );
		}, function() {
			$(".bookmark").removeClass("none");
		}
	);
  
  	onScroll();
});

/*滾輪監聽事件 (更改Menu顏色)*/
function onScroll(event){
	var windowWidth = $(window).width();
	if(windowWidth >1024){
	   var scrollPos = $(document).scrollTop();
	  	$('.RightMenuWrapper ul.RightMenu li.bookmark').each(function () {
		  	var currLink = $(this);
		  	var refElement = $("#" + currLink.attr("id") + "Bookmark");
		  	if (refElement.offset().top <= scrollPos +1 && refElement.offset().top + refElement.outerHeight() > scrollPos +1) {
			  	$('.RightMenuWrapper ul.RightMenu li.bookmark').removeClass("active");
			  	currLink.addClass("active");
		  	}else{
			  	currLink.removeClass("active");
		  	}
	  });
	}else{
	   var scrollPos = $(document).scrollTop();
	  	$('.RightMenuWrapper ul.RightMenu li.bookmark').each(function () {
		  var currLink = $(this);
		  var refElement = $("#" + currLink.attr("id") + "Bookmark");
		  if (refElement.offset().top <= scrollPos +1 && refElement.offset().top + refElement.outerHeight() > scrollPos +1) {
			  $('.RightMenuWrapper ul.RightMenu li.bookmark').removeClass("active2");
			  currLink.addClass("active2");
		  }else{
			  currLink.removeClass("active2");
		  }
	  	});	
	}
}
/*END : Menu 滑動*/
