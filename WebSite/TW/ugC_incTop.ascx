<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ugC_incTop.ascx.cs" Inherits="WebSite.TW.ugC_incTop" %>

<!--頂端選單設定開始-->
<nav class="TopMenu">
    <ul>
        <li><a href="/tw/home/" title="回首頁">回首頁</a></li>
        <li><a href="/tw/Sitemap" title="網站導覽">網站導覽</a></li>

        <li><a href="/tw/Contact-Us" title="聯絡我們">聯絡我們</a></li>

        <li class="ShopCart">
            <a href="/tw/Showroom/Shop/List" title="購物車"><i class="fa fa-shopping-cart"></i><span>(<span id="spnShopCartCnt">0</span>)</span></a>
        </li>

    </ul>
</nav>
<div class="Div-W1000">

    <div class="Logo">
        <a href="/tw/home/" title="回首頁">
            <img src="" alt="uGear 優吉兒網站設計"></a>
    </div>

    <div class="Search">
        <script language="javascript">
<!--
    function t_setCmd(mCmd, mID) {
        var f = document.t_frmUG;
        var y = '';
        if (mCmd == 'f') {	//Detail
            if (f.txtIncSrhData.value.replace(/^\s+|\s+$/g, '').replace(/<br \/>/g, '').replace(/<p>&nbsp;<\/p>/g, '') == '') y += '請輸入搜尋條件!!';

            f.action = '/tw/Search/';

        }

        if (y == '') f.submit();
        else alert(y.replace(/<br>/ig, "\n"));
    }
//-->
        </script>
        <form method="post" name="t_frmUG" onsubmit="javascrit:return false;">
            <label for="txtIncSrhData" style="display: none;">關鍵字搜尋</label>
            <input type="text" name="txtIncSrhData" id="txtIncSrhData" size="17" placeholder="關鍵字搜尋" onkeypress="if(window.event.keyCode==13){t_setCmd('f','');}">
            <a class="SearchBtn" href="#" onclick="t_setCmd('f','');return false;" title="送出關鍵字查詢"><i class="fa fa-search"></i></a>
        </form>



    </div>

</div>
<!--頂端選單設定結束-->
<!--網站全域選單設定開始-->
<nav class="Nav" id="scrollToMenu">
    <ul class="MainMenu">

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/About">關於我們</a>

            <ul class="MainMenuSub">

                <li>
                    <a href="/tw/About/公司簡介/rwd-3" title="公司簡介">公司簡介</a>
                </li>

            </ul>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/Link/Catalog">友站連結(分類多筆)</a>

            <ul class="MainMenuSub">

                <li>
                    <a href="/tw/Link/Catalog/RWD(自適應式)企業形象官網/rwd-12" title="RWD(自適應式)企業形象官網">RWD(自適應式)企業形象官網</a>
                </li>

                <li>
                    <a href="/tw/Link/Catalog/協會教育-and-sign文創類/rwd-13" title="協會教育&amp;文創類">協會教育&amp;文創類</a>
                </li>

                <li>
                    <a href="/tw/Link/Catalog/百貨類-and-sign食品衣服飾品/rwd-14" title="百貨類&amp;食品衣服飾品">百貨類&amp;食品衣服飾品</a>
                </li>

                <li>
                    <a href="/tw/Link/Catalog/3C電腦科技-and-sign精品類/rwd-15" title="3C電腦科技&amp;精品類">3C電腦科技&amp;精品類</a>
                </li>

                <li>
                    <a href="/tw/Link/Catalog/醫療美容-and-sign護理類/rwd-16" title="醫療美容&amp;護理類">醫療美容&amp;護理類</a>
                </li>

                <li>
                    <a href="/tw/Link/Catalog/旅遊休閒類/rwd-17" title="旅遊休閒類">旅遊休閒類</a>
                </li>

                <li>
                    <a href="/tw/Link/Catalog/其他(寵物-and-sign古玩-and-sign婚禮)/rwd-18" title="其他(寵物&amp;古玩&amp;婚禮)">其他(寵物&amp;古玩&amp;婚禮)</a>
                </li>

            </ul>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/Link02/Catalog">友站連結(二層式)</a>

            <ul class="MainMenuSub">

                <li>
                    <a href="/tw/Link02/Catalog/網站設計/rwd-1" title="網站設計">網站設計</a>
                </li>

            </ul>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/Showroom">產品介紹</a>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/News">新聞中心</a>

            <ul class="MainMenuSub">

                <li>
                    <a href="/tw/News/企業公告/rwd-4" title="企業公告">企業公告</a>
                </li>

                <li>
                    <a href="/tw/News/網路新訊/rwd-3" title="網路新訊">網路新訊</a>
                </li>

                <li>
                    <a href="/tw/News/與你分享/rwd-5" title="與你分享">與你分享</a>
                </li>

                <li>
                    <a href="/tw/News/組織管理/rwd-6" title="組織管理">組織管理</a>
                </li>

                <li>
                    <a href="/tw/News/電腦技能/rwd-7" title="電腦技能">電腦技能</a>
                </li>

            </ul>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/Faq">常見問題</a>

            <ul class="MainMenuSub">

                <li>
                    <a href="/tw/Faq/網站常見問題/rwd-3" title="網站常見問題">網站常見問題</a>
                </li>

                <li>
                    <a href="/tw/Faq/會員相關問題/rwd-4" title="會員相關問題">會員相關問題</a>
                </li>

                <li>
                    <a href="/tw/Faq/購物相關問題/rwd-5" title="購物相關問題">購物相關問題</a>
                </li>

                <li>
                    <a href="/tw/Faq/退換貨及退款/rwd-6" title="退換貨及退款">退換貨及退款</a>
                </li>

            </ul>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/Down">檔案下載</a>

            <ul class="MainMenuSub">

                <li>
                    <a href="/tw/Down/技術文件/rwd-10" title="技術文件">技術文件</a>
                </li>

                <li>
                    <a href="/tw/Down/繳款方式/rwd-11" title="繳款方式">繳款方式</a>
                </li>

            </ul>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/Operation">操作手冊</a>

            <ul class="MainMenuSub">

                <li>
                    <a href="/tw/Operation/一般網頁/rwd-10" title="一般網頁">一般網頁</a>
                </li>

                <li>
                    <a href="/tw/Operation/網站功能/rwd-11" title="網站功能">網站功能</a>
                </li>

                <li>
                    <a href="/tw/Operation/後台功能/rwd-13" title="後台功能">後台功能</a>
                </li>

            </ul>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/Album">相簿</a>

            <ul class="MainMenuSub">

                <li>
                    <a href="/tw/Album/活動花絮/rwd-4" title="活動花絮">活動花絮</a>
                </li>

                <li>
                    <a href="/tw/Album/環境介紹/rwd-3" title="環境介紹">環境介紹</a>
                </li>

            </ul>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/Member/ugC_Member_Login.aspx">會員專區</a>

            <!--START : 會員專區選單-->
            <ul class="MainMenuSub">

                <!--START : 未登入-->
                <li><a href="/tw/Member/ugC_Member.aspx" title="加入會員">加入會員</a></li>
                <li><a href="/tw/Member/Login" title="會員登入">會員登入</a></li>
                <li><a href="/tw/Member/Forgot-Password" title="忘記密碼">忘記密碼</a></li>

                <li><a href="/tw/Member/Epaper" title="電子報訂閱">電子報訂閱</a></li>

                <!--END : 未登入-->

            </ul>
            <!--END : 會員專區選單-->

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/People">經營團隊</a>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/Retail">服務據點</a>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/Member/Epaper">電子報訂閱</a>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/About-Us">品牌故事</a>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/About-Us01">公司簡介</a>

            <ul class="MainMenuSub">

                <li>
                    <a href="/tw/About-Us01/公司簡介/rwd-5" title="公司簡介">公司簡介</a>
                </li>

                <li>
                    <a href="/tw/About-Us01/人才優勢/rwd-4" title="人才優勢">人才優勢</a>
                </li>

                <li>
                    <a href="/tw/About-Us01/服務優勢/rwd-16" title="服務優勢">服務優勢</a>
                </li>

            </ul>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/News-Gallery">新聞牆</a>

            <ul class="MainMenuSub">

                <li>
                    <a href="/tw/News-Gallery/企業公告/rwd-3" title="企業公告">企業公告</a>
                </li>

                <li>
                    <a href="/tw/News-Gallery/最新消息/rwd-4" title="最新消息">最新消息</a>
                </li>

            </ul>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/Down-Member">會員檔案下載</a>

            <ul class="MainMenuSub">

                <li>
                    <a href="/tw/Down-Member/test/rwd-5" title="test">test</a>
                </li>

                <li>
                    <a href="/tw/Down-Member/會員下載分類一/rwd-1" title="會員下載分類一">會員下載分類一</a>
                </li>

                <li>
                    <a href="/tw/Down-Member/會員下載分類二/rwd-2" title="會員下載分類二">會員下載分類二</a>
                </li>

                <li>
                    <a href="/tw/Down-Member/喝蜂蜜檸檬水歐趴/rwd-4" title="喝蜂蜜檸檬水歐趴">喝蜂蜜檸檬水歐趴</a>
                </li>

            </ul>

        </li>

        <li class="MainMenuLi" style="width: 5.55556%;">
            <a href="/tw/Album-Member">會員相簿</a>

            <ul class="MainMenuSub">

                <li>
                    <a href="/tw/Album-Member/test/rwd-8" title="test">test</a>
                </li>

                <li>
                    <a href="/tw/Album-Member/測試分類/rwd-1" title="測試分類">測試分類</a>
                </li>

                <li>
                    <a href="/tw/Album-Member/四神湯/rwd-5" title="四神湯">四神湯</a>
                </li>

                <li>
                    <a href="/tw/Album-Member/1206/rwd-9" title="1206">1206</a>
                </li>

            </ul>

        </li>

    </ul>
</nav>
<!--網站全域選單設定結束-->

<!--視窗寬度大於768時；選單寬度等於百分比除以數量 START-->
<script>
    if ($(window).width() > 768) {
        var num = $(".MainMenu .MainMenuLi").length;
        $(".Nav .MainMenu").children(".MainMenuLi").css("width", 100 / num + "%");
    }
    $(document).ready(function () {
        //無障礙Tab選單
        $('.Header .Nav .MainMenuLi').keyup(function () {
            console.log("keyup");
            $(this).addClass("keyup")
            $(this).siblings().focus(function () {
                $(this).removeClass("keyup");
            });
            $(this).siblings().removeClass("keyup");
        });

        $('.Header .Nav .MainMenuLi .MainMenuSub li:last>a').focusout(function () {
            $('.Header .Nav .MainMenuLi').removeClass("keyup");
        });
    });
</script>
<!--視窗寬度大於768時；選單寬度等於百分比除以數量 END-->
