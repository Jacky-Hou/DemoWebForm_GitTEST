<%@ Page Language="C#" MasterPageFile="~/TW/Inc/Basic.Master" AutoEventWireup="true" CodeBehind="ugC_Member_Login.aspx.cs" Inherits="WebSite.TW.Member.ugC_Member_Login" %>

<%@ Register Src="~/TW/Member/ugC_incPageMenuTop.ascx" TagPrefix="uc1" TagName="ugC_incPageMenuTop" %>
<%@ Register Src="~/TW/Member/ugC_incMember.ascx" TagPrefix="uc1" TagName="ugC_incMember" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../oAuthLine/lineOAuth.js"></script>
    <script>
        $(function () {
            //Top選單目前位置
            $("#SlideMenu a").removeClass('Active');
            $("#TopVipLogin").addClass('Active');
        })

        //叫用ugC_incMember
        function ReloadCaptcha(id) {
            var src = $("#" + id).attr('src');
            var url = src + "?DataTime=" + Date.now();
            $.ajax({
                type: "GET",
                url: url
            }).done(function () {
               $("#" + id).attr("src",url)
            })
        }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    	<!--內頁版頭開始-->
	<div class="PageTitleWrapper">
		<header class="PageTitle">
			<p class="BreadCrumbs"> <a href="" title="回首頁">首頁</a> <a href="" title=""></a> 會員登入</p>
			<h1>會員登入</h1>
		</header>
	</div>
	<!--內頁版頭結束-->

      	<!--內頁內容開始-->
    <section class="PageMenuTop">
        <uc1:ugC_incPageMenuTop runat="server" id="ugC_incPageMenuTop" />
    </section>
    <section class="PageContent">
		<article class="PageArticle">
            <uc1:ugC_incMember runat="server" id="ugC_incMember" />
		</article>
	</section>
  	<!--內頁內容結束-->

</asp:Content>