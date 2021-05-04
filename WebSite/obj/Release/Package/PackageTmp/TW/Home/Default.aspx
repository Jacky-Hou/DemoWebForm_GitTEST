<%@ Page Language="C#" MasterPageFile="~/TW/Inc/Basic.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebSite.TW.Home.Default" %>

<%@ Register Src="~/TW/ugC_incTop.ascx" TagPrefix="uc1" TagName="ugC_incTop" %>
<%@ Register Src="~/TW/Home/ugC_incBanner_Def.ascx" TagPrefix="uc1" TagName="ugC_incBanner_Def" %>
<%@ Register Src="~/TW/Home/ugC_incBannerText_Def.ascx" TagPrefix="uc1" TagName="ugC_incBannerText_Def" %>
<%@ Register Src="~/TW/Home/ugC_incProducts_Def.ascx" TagPrefix="uc1" TagName="ugC_incProducts_Def" %>
<%@ Register Src="~/TW/Home/ugC_incLink_Def.ascx" TagPrefix="uc1" TagName="ugC_incLink_Def" %>
<%@ Register Src="~/TW/Home/ugC_incBannerButton_Def.ascx" TagPrefix="uc1" TagName="ugC_incBannerButton_Def" %>
<%@ Register Src="~/TW/Home/ugC_incLink02_Def.ascx" TagPrefix="uc1" TagName="ugC_incLink02_Def" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>$(window).scroll(function () { var $scrollToMenu = $('#scrollToMenu'); if ($scrollToMenu.length > 0) { var ScreenTop = $(window).scrollTop(); var MenuTop = $scrollToMenu.offset().top; if (ScreenTop >= MenuTop) { $('.GoTop').addClass("GoTopActive"); } else { $('.GoTop').removeClass("GoTopActive"); } } });</script>
    <script>function initialize(){ $(".TopSearchOpen").click(function () { $(".TopSearch").addClass("TopSearchActive"); }); $(".TopSearchClose").click(function () { $(".TopSearch").removeClass("TopSearchActive"); }); });</script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<%--    <div id="fb-root">
    </div>
    <!--Wrapper START-->
    <div class="Wrapper">
        <!--Header START-->
        <header class="Header">
            <uc1:ugC_incTop runat="server" ID="ugC_incTop" />
        </header>
        <!--Header END-->

        <div class="DefBanner">
            <uc1:ugC_incBanner_Def runat="server" ID="ugC_incBanner_Def" />
        </div>

        <!--DefContent START-->
        <section class="DefContent">
            <section class="DefAD">
                <uc1:ugC_incBannerText_Def runat="server" ID="ugC_incBannerText_Def" />
            </section>
            <section class="DefProduct">
                <uc1:ugC_incProducts_Def runat="server" ID="ugC_incProducts_Def" />
            </section>
            <section class="DefLink">
                <uc1:ugC_incLink_Def runat="server" ID="ugC_incLink_Def" />
            </section>
            <section class="DefAD">
                <uc1:ugC_incBannerButton_Def runat="server" ID="ugC_incBannerButton_Def" />
            </section>
            <section class="DefLink2">
                <uc1:ugC_incLink02_Def runat="server" ID="ugC_incLink02_Def" />
            </section>
        </section>
        <!--DefContent END-->

        <!--Wrapper END-->
    </div>--%>
</asp:Content>

