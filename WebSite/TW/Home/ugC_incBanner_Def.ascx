<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ugC_incBanner_Def.ascx.cs" Inherits="WebSite.TW.Home.ugC_incBanner_Def" %>

<script src='<%=ResolveUrl("../JS/Swiper/is/swiper.min.js")%>'></script>
<script src='<%=ResolveUrl("../JS/Swiper/is/classList.min.js")%>'></script>
<link href="../JS/Swiper/Css/swiper.min.css" rel="stylesheet" />

<div class="swiper-container swiper-container-DefBanner swiper-container-horizontal">
    <div class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px);">
        <div class="swiper-slide def-banner-swiper-slide swiper-slide-active" style="width: 1663px;">
            <a target="_blank" href="/tw/ugC_Redirect.asp?hidID=27" title="網站設計系統開發1000家(新視窗開啟)">
                <img class="m768-hide" src="/tw/ImgsRWD/20181112151002.jpg" alt="網站設計系統開發1000家">
                <img class="m768-show" src="/tw/ImgsRWD/20181112151002.jpg" alt="網站設計系統開發1000家">
            </a>
        </div>

        <div class="swiper-slide def-banner-swiper-slide swiper-slide-next" style="width: 1663px;">
            <a target="_blank" href="/tw/ugC_Redirect.asp?hidID=38" title="創造無限可能的網站服務(新視窗開啟)">
                <img class="m768-hide" src="/tw/ImgsRWD/20190529162942.jpg" alt="創造無限可能的網站服務">
                <img class="m768-show" src="/tw/ImgsRWD/20190529162942.jpg" alt="創造無限可能的網站服務">
            </a>
        </div>

        <div class="swiper-slide def-banner-swiper-slide" style="width: 1663px;">
            <a target="_blank" href="/tw/ugC_Redirect.asp?hidID=37" title="AAA無障礙網站檢測-響應式網站設計作品1000家(新視窗開啟)">
                <img class="m768-hide" src="/tw/ImgsRWD/20190529162930.jpg" alt="AAA無障礙網站檢測-響應式網站設計作品1000家">
                <img class="m768-show" src="/tw/ImgsRWD/20190529162930.jpg" alt="AAA無障礙網站檢測-響應式網站設計作品1000家">
            </a>
        </div>

        <div class="swiper-slide def-banner-swiper-slide" style="width: 1663px;">
            <a target="_blank" href="/tw/ugC_Redirect.asp?hidID=34" title="政府網站即時檢核 - 滿分 100分 - 響應瀏覽 暢遊無阻(新視窗開啟)">
                <img class="m768-hide" src="/tw/ImgsRWD/20190527174137.jpg" alt="政府網站即時檢核 - 滿分 100分 - 響應瀏覽 暢遊無阻">
                <img class="m768-show" src="/tw/ImgsRWD/20190527174137.jpg" alt="政府網站即時檢核 - 滿分 100分 - 響應瀏覽 暢遊無阻">
            </a>
        </div>

        <div class="swiper-slide def-banner-swiper-slide" style="width: 1663px;">
            <a target="_blank" href="/tw/ugC_Redirect.asp?hidID=35" title="AA無障礙響應式網頁貼近你我生活(新視窗開啟)">
                <img class="m768-hide" src="/tw/ImgsRWD/20190527174201.jpg" alt="AA無障礙響應式網頁貼近你我生活">
                <img class="m768-show" src="/tw/ImgsRWD/20190527174201.jpg" alt="AA無障礙響應式網頁貼近你我生活">
            </a>
        </div>

        <div class="swiper-slide def-banner-swiper-slide" style="width: 1663px;">
            <a target="_blank" href="/tw/ugC_Redirect.asp?hidID=33" title="響應式網站設計-電腦、平板、手機一次到位(新視窗開啟)">
                <img class="m768-hide" src="/tw/ImgsRWD/20190527173100.jpg" alt="響應式網站設計-電腦、平板、手機一次到位">
                <img class="m768-show" src="/tw/ImgsRWD/20190527173100.jpg" alt="響應式網站設計-電腦、平板、手機一次到位">
            </a>
        </div>

        <div class="swiper-slide def-banner-swiper-slide" style="width: 1663px;">
            <a target="_blank" href="/tw/ugC_Redirect.asp?hidID=36" title="全方位網站整合能力(新視窗開啟)">
                <img class="m768-hide" src="/tw/ImgsRWD/20190529162915.jpg" alt="全方位網站整合能力">
                <img class="m768-show" src="/tw/ImgsRWD/20190529162915.jpg" alt="全方位網站整合能力">
            </a>
        </div>

    </div>
    <div class="swiper-pagination def-banner-pagination swiper-pagination-clickable swiper-pagination-bullets"><span class="swiper-pagination-bullet swiper-pagination-bullet-active" tabindex="0" role="button" aria-label="Go to slide 1"></span><span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 2"></span><span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 3"></span><span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 4"></span><span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 5"></span><span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 6"></span><span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 7"></span></div>
    <div class="swiper-button-next swiper-button-white def-banner-button-next" tabindex="0" role="button" aria-label="Next slide" aria-disabled="false"></div>
    <div class="swiper-button-prev swiper-button-white def-banner-button-prev swiper-button-disabled" tabindex="0" role="button" aria-label="Previous slide" aria-disabled="true"></div>

    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
</div>

<!--2015.10.15 Jay 解決Swiper IE9 無法使用 Addlist 的問題-->
<script type="text/javascript">
		//$(document).ready(function () {
		//	var swiper_DefBanner = new Swiper('.swiper-container-DefBanner', {
		//		pagination: {
		//		   el: '.def-banner-pagination',
		//		   clickable: true,
		//		},											  
				
		//			navigation: {
		//		  nextEl: '.def-banner-button-next',
		//		  prevEl: '.def-banner-button-prev',
		//		},
				
		//		slideClass : 'def-banner-swiper-slide',
		//		slidesPerView: 1,
		//		spaceBetween: 0,
		//		//effect:'fade',
		//		loop: false
		//		, speed: 1000
		//		, autoplay:(5000)
		//	});
		//});
    </script>
